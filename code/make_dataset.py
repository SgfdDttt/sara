# -*- coding: utf-8 -*-
import sys, glob, random, math, os

RANDOM_SEED=0
SPLITS={'train': 88, # splits for binary questions
        'test': 50}
SPLIT_PROPORTIONS={'train': .8, # splits for numerical questions
        'test': .2} 
assert sum(SPLIT_PROPORTIONS.values())==1
PATHNAME_STATUTES='statutes/source'
PATHNAME_CASES='cases'
PATHNAME_DATASET='dataset'
try:
    os.mkdir(PATHNAME_DATASET)
except:
    pass

# 1. collect statutes
all_statutes=[]
for name in glob.glob(PATHNAME_STATUTES+'/*'):
    all_statutes.extend([line.strip('\n').replace('§','Section ') \
            for line in open(name,'r')])
all_statutes=list(map(lambda x: x.split('#')[0], all_statutes))
all_statutes=list(filter(lambda x: len(x)>0, all_statutes))
# group things by section heading
statutes=all_statutes
while '' in statutes:
    statutes.remove('')

all_cases={'train':[], 'test':[]}
# 2.1. collect test cases (context + question + answers) into tsv and splits
# 2.1.1. load cases
binary_cases={}
for filename in sorted(list(glob.glob(PATHNAME_CASES+'/s*.pl'))):
    stuff=[line.strip('\n') for line in open(filename,'r')]
    text_index=stuff.index('% Text')+1
    question_index=stuff.index('% Question')+1
    text=' '.join([ x.strip('%').strip(' ') for x in 
            stuff[text_index:question_index-1] ]).strip(' ')
    question_and_answer=stuff[question_index].strip(' ')
    question=' '.join(
            question_and_answer.split(' ')[:-1]
            ).strip('%').strip(' ')
    answer=question_and_answer.split(' ')[-1]
    binary_cases[filename]=text+'\t'+question+'\t'+answer
# 2.1.2. split cases
filenames=glob.glob(PATHNAME_CASES+'/s*.pl')
filenames=map(lambda x: x.replace('_pos','').replace('_neg',''), filenames)
filenames=sorted(list(set(filenames)))
sections={}
for fname in filenames:
    section_name=fname.split('/')[-1].replace('.pl','').split('_')[0][1:]
    sections.setdefault(section_name,set())
    sections[section_name].add(fname)
for x in sections:
    sections[x]=sorted(list(sections[x]))
random.seed(RANDOM_SEED)
test_proportion=float(SPLITS['test'])/(SPLITS['train']+SPLITS['test'])
train_proportion=float(SPLITS['train'])/(SPLITS['train']+SPLITS['test'])
for section_name in sorted(sections.keys()):
    train_num=int(round(len(sections[section_name])*train_proportion))
    test_num=int(round(len(sections[section_name])*test_proportion))
    if section_name=='3301':
        train_num-=1
        test_num+=1
    if section_name in ['3306','1']:
        train_num+=1
        test_num-=1
    assert train_num+test_num==len(sections[section_name])
    relevant_cases=sections[section_name]
    random.shuffle(relevant_cases)
    train_cases=relevant_cases[:train_num]
    test_cases=relevant_cases[train_num:train_num+test_num]
    for split,cases in zip(['train','test'],[train_cases,test_cases]):
        for casename in cases:
            for suffix in ['pos','neg']:
                key=casename[:-3]+'_'+suffix+'.pl'
                all_cases[split].append(binary_cases[key])
assert len(all_cases['train'])==SPLITS['train']*2, str(len(all_cases['train'])) + ' vs ' + str(SPLITS['train']*2)
assert len(all_cases['test'])==SPLITS['test']*2, str(len(all_cases['test'])) + ' vs ' + str(SPLITS['test']*2)

# 2.2. collect numerical cases (context + question + numerical answers) into tsv and splits
# 2.2.1. load cases
numerical_cases={}
for filename in sorted(list(glob.glob(PATHNAME_CASES+'/tax_case_*.pl'))):
    stuff=[line.strip('\n') for line in open(filename,'r')]
    text_index=stuff.index('% Text')+1
    question_index=stuff.index('% Question')+1
    text=' '.join([ x.strip('%').strip(' ') for x in 
            stuff[text_index:question_index-1] ]).strip(' ')
    question_and_answer=stuff[question_index].strip(' ')
    question=' '.join(
            question_and_answer.split(' ')[:-1]
            ).strip('%').strip(' ')
    answer=question_and_answer.split(' ')[-1]
    numerical_cases[filename]=text+'\t'+question+'\t'+answer
# 2.2.2. split cases into train and test
filenames=sorted(list(glob.glob(PATHNAME_CASES+'/tax_case_*.pl')))
random.seed(RANDOM_SEED)
random.shuffle(filenames)
split_num={}
for split, p in SPLIT_PROPORTIONS.items():
    split_num[split]=int(round(p*len(filenames)))
assert sum(split_num.values())==len(filenames)
train=filenames[:split_num['train']]
test=filenames[split_num['train']:split_num['train']+split_num['test']]
assert len(filenames)==len(train)+len(test)
for filename in sorted(list(numerical_cases.keys())):
    if filename in train:
        all_cases['train'].append(numerical_cases[filename])
        train.remove(filename)
    elif filename in test:
        all_cases['test'].append(numerical_cases[filename])
        test.remove(filename)
    else:
        assert False, "problem with " + filename

# 3. write to files
for split in all_cases:
    with open(PATHNAME_DATASET+'/'+split+'.tsv','w') as f:
        f.write('\n'.join(all_cases[split])+'\n')
with open(PATHNAME_DATASET+'/statutes.txt','w') as f:
    f.write('\n'.join(statutes)+'\n')
