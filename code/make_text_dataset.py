# -*- coding: utf-8 -*-
import sys, glob, random, math

PATHNAME_STATUTES='statutes/source'
PATHNAME_CASES='cases'
PATHNAME_DATASET='dataset'
PATHNAME_SPLITS='splits'

# 1. collect statutes
all_statutes=[]
for name in glob.glob(PATHNAME_STATUTES+'/*'):
    all_statutes.extend([line.strip('\n').strip(' ').replace('§','Section ') \
            for line in open(name,'r')])
all_statutes=list(map(lambda x: x.split('#')[0], all_statutes))
all_statutes=list(filter(lambda x: len(x)>0, all_statutes))
# group things by section heading
statutes=all_statutes
while '' in statutes:
    statutes.remove('')

# 2 collect cases
# 2.1 load train/test split
split={'train': [line.strip('\n') for line in open(PATHNAME_SPLITS+'/train')],
        'test': [line.strip('\n') for line in open(PATHNAME_SPLITS+'/test')]}
all_cases={'train':[], 'test':[]}
# 2.1. collect test cases (context + question + answers) into tsv and splits
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
    casename=filename.split('/')[-1][:-3]
    casetext=text+'\t'+question+'\t'+answer
    if casename in split['train']:
        assert casename not in split['test']
        assert casetext not in all_cases['train']
        all_cases['train'].append(casetext)
    else:
        assert casename in split['test']
        assert casetext not in all_cases['test']
        all_cases['test'].append(casetext)

# 2.2. collect numerical cases (context + question + numerical answers) into tsv and splits
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
    casename=filename.split('/')[-1][:-3]
    casetext=text+'\t'+question+'\t'+answer
    if casename in split['train']:
        assert casename not in split['test']
        assert casetext not in all_cases['train']
        all_cases['train'].append(casetext)
    else:
        assert casename in split['test']
        assert casetext not in all_cases['test']
        all_cases['test'].append(casetext)

# 3. write to files
for split in all_cases:
    with open(PATHNAME_DATASET+'/'+split+'.tsv','w') as f:
        f.write('\n'.join(all_cases[split])+'\n')
with open(PATHNAME_DATASET+'/statutes.txt','w') as f:
    #f.write('\n'.join(all_statutes)+'\n')
    f.write('\n'.join(statutes)+'\n')
