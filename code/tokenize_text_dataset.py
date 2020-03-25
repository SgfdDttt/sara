LAW_TOKENIZER_DIR=""
import sys, re, os
sys.path.append(LAW_TOKENIZER_DIR)
from preprocess import preprocess_text

DATADIR='dataset'
OUTPUT_DIR='tokenized_dataset'
try:
    os.mkdir(OUTPUT_DIR)
except:
    pass

def tokenize_statutes(document):
    current_section=''
    tokenized_document=[]
    for line in document:
        # 1. normalize names of sections
        output=line
        if line.startswith('Section '): # remove leading 'Section XYZ'
            section_name=output.split('.')[0]
            rest='.'.join(output.split('.')[1:])
            new_section_name='sec_'+section_name.split(' ')[1]
            current_section=new_section_name
            output=rest
        things=re.findall('\([\w]+\)', output)
        for thing in things:
            while thing in output:
                output=output.replace(thing,'')
        while '  ' in output:
            output=output.replace('  ',' ')
        output=current_section+' '+output
        # 2. tokenize
        output=preprocess_text(output.strip(' '))
        tokenized_document.append(output.strip('\n'))
    return tokenized_document

def tokenize_cases(document):
    tokenized_document=[]
    for line in document:
        output=line.strip(' ')
        things=re.findall('\([\w]+\)', output)
        for thing in things: # makes the job of the section tokenizer easier
            while thing in output:
                output=output.replace(thing,'')
        while '  ' in output:
            output=output.replace('  ',' ')
        output=output.lower().replace('section 7703','sec_7703') # somehow the tokenizer sometimes fails for this
        output=output.lower().replace('section 68','sec_68') # somehow the tokenizer sometimes fails for this
        output=preprocess_text(output.lower())
        tokenized_document.append(output.strip('\n'))
    return tokenized_document

# 1. statutes
statutes=[line.strip('\n') for line in open(DATADIR+'/statutes.txt','r')]

tokenized_statutes=tokenize_statutes(statutes)

with open(OUTPUT_DIR.rstrip('/')+'/statutes.txt','w') as f:
    f.write('\n'.join(tokenized_statutes))

# 2. context and questions
for split_name in ['train','test']:
    filename=DATADIR+'/'+split_name+'.tsv'
    context_question_answer=[line.strip('\n').split('\t') for line in open(filename,'r')]
    for x in context_question_answer:
        assert len(x)==3
    tokenized_context=tokenize_cases([x[0] for x in context_question_answer])
    for x in tokenized_context:
        assert len(x)>0
    tokenized_question=tokenize_cases([x[1] for x in context_question_answer])
    for ii,x in enumerate(tokenized_question):
        assert len(x)>0, str(context_question_answer[ii]) + '\n'+ str(tokenize([context_question_answer[ii][1]]))
    tokenized_answer=[x[2] for x in context_question_answer]
    for x in tokenized_answer:
        assert len(x)>0
    tokenized_context_question_answer=['\t'.join(truc) for truc
            in zip(tokenized_context,tokenized_question,tokenized_answer)]

    with open(OUTPUT_DIR.rstrip('/')+'/'+split_name+'.tsv','w') as f:
        f.write('\n'.join(tokenized_context_question_answer)+'\n')

