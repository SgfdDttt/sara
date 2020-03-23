import sys, os, argparse, torch, random, logging, math
from transformers import *
import numpy as np
from models import QuestionModel,StatuteModel, RelationalModel

random.seed(0)
torch.manual_seed(0)

parser = argparse.ArgumentParser(description='Process some integers.')
parser.add_argument('--datadir', type=str,
                    help='path to data directory')
parser.add_argument('--expdir', type=str,
                    help='path to experiment directory')
parser.add_argument('--context', action='store_true',
                    help='whether to use the context')
parser.add_argument('--statutes', action='store_true',
                    help='whether to use the statutes')
parser.add_argument('--thaw_top_layer', action='store_true',
                    help="whether to thaw BERT's top layer")
parser.add_argument('--debug', action='store_true',
                    help='whether to set the logging level to debug')
parser.add_argument('--epochs', type=int, default=25,
                    help='number of epochs to train for')
parser.add_argument('--batch', type=int, default=8,
                    help='size of batch')
parser.add_argument('--update_period', type=int, default=1,
                    help='how many batches to process before updating parameters')
parser.add_argument('--max_length', type=int, default=512,
                    help='max length of input string')
parser.add_argument('--smoothing_parameter', type=float, default=1e-3,
                    help='smoothing parameter for Arora+17 method')
parser.add_argument('--pretrained_model', type=str, default='bert-base-uncased',
                    help='path to pretrained model')
parser.add_argument('--learning_rate', type=float, default=1e-5,
                    help='initial learning rate')
parser.add_argument('--warmup', type=float, default=0,
                    help='proportion of warmup steps')
parser.add_argument('--word_embeddings', type=str, default=None,
                    help='path to word embeddings')
parser.add_argument('--unigram_counts', type=str, default=None,
                    help='path to unigram counts')
parser.add_argument('--num_layers', type=int, default=None,
                    help='number of layers of feedforward network')
parser.add_argument('--num_units', type=int, default=None,
                    help='number of units of feedforward network')
parser.add_argument('--weight_decay', type=float, default=0.,
                    help='weight of L2 regularization')
parser.add_argument('--numerical_task_weight', type=float, default=1.,
                    help='weight of loss for numerical tax prediction')
parser.add_argument('--bert_model', type=str, default='bert-base-cased',
                    help='which bert model to use')
parser.add_argument('--bert_tokenizer', type=str, default='bert-base-cased',
                    help='which bert tokenizer to use')
parser.add_argument('--gpu', action='store_true',
                    help='whether to use GPU')
args = parser.parse_args()

# set up logging
logging.basicConfig(level=logging.DEBUG)
logging.basicConfig(level=logging.INFO)
if args.debug:
    logging.basicConfig(level=logging.DEBUG)
logging.info('arguments:\n'+str(args))

# occupy gpu
if args.gpu:
    logging.info('using gpu')
    a = torch.FloatTensor(1).to('cuda')

# load data
logging.info('load data')
data_files={'statutes': args.datadir.rstrip('/')+'/statutes.txt',
        'train': args.datadir.rstrip('/')+'/train.tsv',
        'test': args.datadir.rstrip('/')+'/test.tsv'}
data={}
data['statutes']=[line.strip('\n') for line in \
        open(data_files['statutes'],'r')]
for split in ['train','test']:
    stuff=[line.strip('\n') for line in \
        open(data_files[split],'r')]
    def parse_dataset(line):
        context,question,answer=line.split('\t')
        if answer.lower() in ['entailment','contradiction']:
            answer=1 if answer.lower()=='entailment' else 0
        else:
            answer=int(answer.strip('$'))
        output=(context,question,answer)
        return output
    data[split]=list(map(parse_dataset,stuff))

# compute mean and stddev on train set
numerical_outputs=filter(lambda x: x[1].lower().startswith('how much tax'), data['train'])
numerical_outputs=list(map(lambda x: x[2], numerical_outputs))
mean_tax_amount=sum(numerical_outputs)/float(len(numerical_outputs))
stddev_tax_amount=sum([(x-mean_tax_amount)**2 for x in numerical_outputs])/float(len(numerical_outputs))
stddev_tax_amount=stddev_tax_amount**0.5

# create a dev set: 10% of numerical tests and 10% of binary tests
numerical_tests=sorted(list(filter(lambda x: x[1].lower().startswith('how much tax'), data['train'])))
binary_tests=sorted(list(filter(lambda x: not x[1].lower().startswith('how much tax'), data['train'])))
sec2case={}
for case in binary_tests:
    if 'section' in case[1]: # regular text
        section_key='section '
    elif 'Section' in case[1]: # regular text
        section_key='Section '
    elif 'sec_' in case[1]: # tokenized with Andrew's tokenizer
        section_key='sec_'
    else:
        assert False, 'Problem with ' + str(case)
    section=case[1].split(section_key)[1].split(' ')[0].strip('?, ')
    sec2case.setdefault(section,[])
    sec2case[section].append(case)
for k,v in sec2case.items():
    num_pos=sum(int(x[-1]) for x in v)
    num_neg=sum(1-int(x[-1]) for x in v)
    assert num_pos==num_neg, str(k) + ': ' + str(v)
section_keys=sorted(sec2case.keys())
train_size=len(data['train'])
assert len(numerical_tests)+len(binary_tests)==train_size
dev_index_numerical=int(round(0.1*len(numerical_tests)))
dev_index_binary=int(round(0.1*len(binary_tests)))
random.shuffle(numerical_tests)
random.shuffle(section_keys)
data['dev'],data['train']=[],[]
while len(data['dev'])<dev_index_binary:
    key=section_keys.pop(0)
    data['dev'].extend(sec2case[key])
data['dev']=data['dev']+numerical_tests[:dev_index_numerical]
for key in section_keys:
    data['train'].extend(sec2case[key])
data['train']=data['train']+numerical_tests[dev_index_numerical:]
assert len(data['dev'])+len(data['train'])==train_size, str((len(data['dev']),len(data['train']),train_size))

# load model
model_savedir=args.expdir.rstrip('/')
try:
    os.mkdir(model_savedir)
except:
    pass
model_checkpoint_file=model_savedir+'/checkpoint.pt'
best_binary_model_savefile=model_savedir+'/best_binary_model.pt'
best_numerical_model_savefile=model_savedir+'/best_numerical_model.pt'
if args.word_embeddings is None:
    if not args.statutes:
        model=QuestionModel(pretrained_model=args.bert_model, tokenizer=args.bert_tokenizer,
                use_context=args.context, tax_statistics=(mean_tax_amount,stddev_tax_amount),
                max_length=args.max_length)
    else:
        model=StatuteModel(pretrained_model=args.bert_model, tokenizer=args.bert_tokenizer,
                sample_size=args.sample_size, pooling_function=args.pooling_function,
                tax_statistics=(mean_tax_amount,stddev_tax_amount), max_length=args.max_length)
    model.freeze_bert(thaw_top_layer=args.thaw_top_layer)
    model_file=None
    if os.path.isfile(model_checkpoint_file):
        model_file=model_checkpoint_file
    elif os.path.isfile(best_binary_model_savefile):
        model_file=best_model_binary_savefile
    if model_file is not None:
        logging.info('load saved model from '+model_file)
        model.load_state_dict(torch.load(model_file))
    optimizer=AdamW(model.parameters(),lr=args.learning_rate,weight_decay=args.weight_decay)
    scheduler=get_constant_schedule_with_warmup(optimizer, \
        int(args.epochs*math.ceil(len(data['train'])/(args.batch*args.update_period))*args.warmup))

else:
    model=RelationalModel(word_embeddings_file=args.word_embeddings, unigram_counts_file=args.unigram_counts,
            num_layers=args.num_layers,
            num_units=args.num_units, use_statutes=args.statutes, use_context=args.context,
            smoothing_param=args.smoothing_parameter,
            tax_statistics=(mean_tax_amount,stddev_tax_amount))
    model.learn_representation(data['statutes'], [x[0] for x in data['train']], [x[1] for x in data['train']])
    optimizer=torch.optim.Adam(model.parameters(),lr=args.learning_rate,weight_decay=args.weight_decay)
    scheduler=None

loss_functions=(torch.nn.BCEWithLogitsLoss(reduction='none'), torch.nn.MSELoss(reduction='none'))
logging.info('model:\n'+str(model))
if args.gpu:
    model.cuda()

# TRAIN
logging.debug('start train')
best_binary_model_metrics,best_numerical_model_metrics=None,None
for ep in range(args.epochs):
    # begin define forward pass over data
    def forward_pass(split):
        metrics={'num_correct_binary': 0, 'total_loss_binary':0, 'num_examples_binary':0,
                'num_correct_numerical': 0, 'total_loss_numerical':0, 'num_examples_numerical':0}
        model.eval()
        if split=='train':
            model.train()
            optimizer.zero_grad()
        for position in range(0,len(data[split]),args.batch):
            logging.debug('position: ' + str(position) + '/' + str(len(data[split])))
            batch=data[split][position:position+args.batch]
            labels = [x[-1] for x in batch]
            context = [x[0] for x in batch]
            questions = [x[1] for x in batch]
            output_is_numerical=[ 1 if q.lower().startswith('how much tax') else 0 for q in questions ]
            input_args={'question': questions, 'grad': split=='train', 'output_is_numerical': output_is_numerical}
            if args.statutes:
                input_args.update({'statutes': data['statutes'], 'context': context})
            elif args.context:
                input_args.update({'context': context})
            if split=='train':
                logits=model.forward(**input_args)
            else:
                with torch.no_grad():
                    logits=model.forward(**input_args)
            long_label_tensor=torch.LongTensor(labels)
            float_label_tensor=torch.FloatTensor(labels)
            output_is_numerical_tensor=torch.FloatTensor(output_is_numerical)
            if args.gpu:
                long_label_tensor=long_label_tensor.to('cuda')
                float_label_tensor=float_label_tensor.to('cuda')
                output_is_numerical_tensor=output_is_numerical_tensor.to('cuda')
            loss_binary=loss_functions[0](logits,float_label_tensor)*(1-output_is_numerical_tensor)
            loss_numerical=loss_functions[1](logits,float_label_tensor)*output_is_numerical_tensor/(stddev_tax_amount**2)
            predictions=[ (logits[ii]>0).cpu().float() if output_is_numerical[ii]==0 else logits[ii].cpu()
                    for ii in range(logits.size(0)) ]
            predictions=torch.stack(predictions,dim=0)
            predictions=torch.max(torch.round(predictions),torch.zeros_like(predictions))
            metrics['num_correct_binary']+=sum([ 1 if ((int(p)==l) and (o==0)) else 0 for p,l,o in zip(predictions,labels,output_is_numerical) ])
            metrics['total_loss_binary']+=sum([ l if o==0 else 0 for l,o in zip(loss_binary.cpu().tolist(),output_is_numerical) ])
            metrics['num_examples_binary']+=sum([ 1-x for x in output_is_numerical ])
            metrics['num_correct_numerical']+=sum([ 1 if ((int(p)==l) and (o==1)) else 0 for p,l,o in zip(predictions,labels,output_is_numerical) ])
            metrics['total_loss_numerical']+=sum([ l if o==1 else 0 for l,o in zip(loss_numerical.cpu().tolist(),output_is_numerical) ])
            metrics['num_examples_numerical']+=sum(output_is_numerical)
            logging.debug('\t'.join([str(k)+': '+str(v) for k,v in metrics.items()]))
            if split=='train':
                loss_binary=torch.sum(loss_binary)/max(1,sum([ 1-x for x in output_is_numerical ]))/args.update_period
                loss_numerical=torch.sum(loss_numerical)/max(1,sum(output_is_numerical))/args.update_period
                loss=loss_binary+args.numerical_task_weight*loss_numerical
                loss.backward()
                if (metrics['num_examples_binary']+metrics['num_examples_numerical'])%(args.batch*args.update_period)==0:
                    if scheduler is not None:
                        scheduler.step()
                    optimizer.step()
                    optimizer.zero_grad()
        metrics['num_examples_numerical']=max(1,metrics['num_examples_numerical'])
        metrics['num_examples_binary']=max(1,metrics['num_examples_binary'])
        metrics['average_loss_binary']=metrics['total_loss_binary']/metrics['num_examples_binary']
        metrics['accuracy_binary']=metrics['num_correct_binary']/metrics['num_examples_binary']
        metrics['average_loss_numerical']=metrics['total_loss_numerical']/metrics['num_examples_numerical']
        metrics['accuracy_numerical']=metrics['num_correct_numerical']/metrics['num_examples_numerical']
        if ((metrics['num_examples_binary']+metrics['num_examples_numerical'])%(args.batch*args.update_period)!=0) and (split=='train'):
            if scheduler is not None:
                scheduler.step()
            optimizer.step()
            optimizer.zero_grad()
        return metrics
    # end define forward pass over data
    logging.info('epoch ' + str(ep) + '/' + str(args.epochs))
    random.shuffle(data['train'])
    logging.info('train')
    train_metrics=forward_pass('train')
    logging.debug('train metrics: ' + str(train_metrics))
    logging.info('dev')
    dev_metrics=forward_pass('dev')
    logging.debug('dev metrics: ' + str(dev_metrics))
    logging_message='metrics epoch ' + str(ep) \
            + ': train loss binary ' + "{0:.5f}".format(train_metrics['average_loss_binary']) + ';' \
            + ' dev loss binary ' + "{0:.5f}".format(dev_metrics['average_loss_binary']) + ';' \
            + ' train accuracy binary ' + "{0:.5f}".format(train_metrics['accuracy_binary']) + ';' \
            + ' dev accuracy binary ' + "{0:.5f}".format(dev_metrics['accuracy_binary']) + ';' \
            + ' train loss numerical ' + "{0:.5f}".format(train_metrics['average_loss_numerical']) + ';' \
            + ' dev loss numerical ' + "{0:.5f}".format(dev_metrics['average_loss_numerical']) + ';' \
            + ' train accuracy numerical ' + "{0:.5f}".format(train_metrics['accuracy_numerical']) + ';' \
            + ' dev accuracy numerical ' + "{0:.5f}".format(dev_metrics['accuracy_numerical'])
    logging.info(logging_message)
    # save model
    logger.info('save model to ' + model_checkpoint_file)
    torch.save(model.state_dict(), model_checkpoint_file)
    save_binary_model=False # whether to save as best model
    if best_binary_model_metrics is None:
        best_binary_model_metrics=dict(dev_metrics)
        save_binary_model=True
    if (best_binary_model_metrics['accuracy_binary'],-best_binary_model_metrics['average_loss_binary'])\
            <(dev_metrics['accuracy_binary'],-dev_metrics['average_loss_binary']):
        best_binary_model_metrics=dict(dev_metrics)
        save_binary_model=True
    if save_binary_model:
        # save model
        logger.info('save model to ' + best_binary_model_savefile)
        torch.save(model.state_dict(), best_binary_model_savefile)
        with open(model_savedir+'/best_binary_model_info','w') as f:
            f.write(logging_message+'\n')
    # same for best numerical model
    save_numerical_model=False
    if best_numerical_model_metrics is None:
        best_numerical_model_metrics=dict(dev_metrics)
        save_numerical_model=True
    if best_numerical_model_metrics['average_loss_numerical']>dev_metrics['average_loss_numerical']:
        best_numerical_model_metrics=dict(dev_metrics)
        save_numerical_model=True
    if save_numerical_model:
        # save model
        logger.info('save model to ' + best_numerical_model_savefile)
        torch.save(model.state_dict(), best_numerical_model_savefile)
        with open(model_savedir+'/best_numerical_model_info','w') as f:
            f.write(logging_message+'\n')

# TEST
logging.debug('compute outputs on test set')
def t_test(samples):
    # compute confidence intervals for average of samples
    # values for n degrees of freedom and x confidence, two-sided.
    T_VALUES={(100,90): 1.660, (20,90): 1.725, (100,95): 1.984, (20,95): 2.086}
    n=len(samples)
    mean=sum(samples)/n
    S=sum([(x-mean)**2 for x in samples])/(n-1)
    S=S**0.5
    dev={'90': T_VALUES[(n,90)]*S/(n**0.5), '95': T_VALUES[(n,95)]*S/(n**0.5)}
    return dev
# run on test data
# begin define forward pass over data
def test_forward_pass(model_file):
    model.load_state_dict(torch.load(model_file))
    model.eval()
    metrics={'num_correct_binary': 0, 'total_loss_binary':0, 'num_examples_binary':0,
            'num_correct_numerical': 0, 'total_loss_numerical':0, 'num_examples_numerical':0,
            'accuracy_samples':[], 'mse_samples':[]} # samples are for t-test
    metrics['confusion_matrix']={(0,0): 0, (0,1): 0, (1,0): 0, (1,1): 0}
    optimizer.zero_grad()
    for position in range(0,len(data['test']),args.batch):
        logging.debug(str(position) + '/' + str(len(data['test'])))
        batch=data['test'][position:position+args.batch]
        labels = [x[-1] for x in batch]
        context = [x[0] for x in batch]
        questions = [x[1] for x in batch]
        output_is_numerical=[ 1 if q.lower().startswith('how much tax') else 0 for q in questions ]
        input_args={'question': questions, 'grad': False, 'output_is_numerical': output_is_numerical}
        if args.statutes:
            input_args.update({'statutes': data['statutes'], 'context': context})
        elif args.context:
            input_args.update({'context': context})
        with torch.no_grad():
            logits=model.forward(**input_args)
        long_label_tensor=torch.LongTensor(labels)
        float_label_tensor=torch.FloatTensor(labels)
        output_is_numerical_tensor=torch.FloatTensor(output_is_numerical)
        if args.gpu:
            long_label_tensor=long_label_tensor.to('cuda')
            float_label_tensor=float_label_tensor.to('cuda')
            output_is_numerical_tensor=output_is_numerical_tensor.to('cuda')
        loss_binary=loss_functions[0](logits,float_label_tensor)*(1-output_is_numerical_tensor)
        loss_numerical=loss_functions[1](logits,float_label_tensor)*output_is_numerical_tensor/(stddev_tax_amount**2)
        predictions=[ (logits[ii]>0).cpu().float() if output_is_numerical[ii]==0 else logits[ii].cpu()
                for ii in range(logits.size(0)) ]
        predictions=torch.stack(predictions,dim=0)
        predictions=torch.max(torch.round(predictions),torch.zeros_like(predictions))
        for p,l,o in zip(predictions,labels,output_is_numerical):
            if o==0:
                metrics['accuracy_samples'].append( 1 if (int(p)==l) else 0 )
                metrics['confusion_matrix'][(int(l),int(p))]+=1
        metrics['num_correct_binary']+=sum([ 1 if ((int(p)==l) and (o==0)) else 0 for p,l,o in zip(predictions,labels,output_is_numerical) ])
        metrics['total_loss_binary']+=sum([ l if o==0 else 0 for l,o in zip(loss_binary.cpu().tolist(),output_is_numerical) ])
        metrics['num_examples_binary']+=sum([ 1-x for x in output_is_numerical ])
        metrics['num_correct_numerical']+=sum([ 1 if ((int(p)==l) and (o==1)) else 0 for p,l,o in zip(predictions,labels,output_is_numerical) ])
        for l,o in zip(loss_numerical.cpu().tolist(),output_is_numerical):
            if o==1:
                metrics['mse_samples'].append( l )
        metrics['total_loss_numerical']+=sum([ l if o==1 else 0 for l,o in zip(loss_numerical.cpu().tolist(),output_is_numerical) ])
        metrics['num_examples_numerical']+=sum(output_is_numerical)
        logging.debug('\t'.join([str(k)+': '+str(v) for k,v in metrics.items()]))
    metrics['average_loss_binary']=metrics['total_loss_binary']/metrics['num_examples_binary']
    metrics['accuracy_binary']=metrics['num_correct_binary']/metrics['num_examples_binary']
    metrics['average_loss_numerical']=metrics['total_loss_numerical']/metrics['num_examples_numerical']
    metrics['accuracy_numerical']=metrics['num_correct_numerical']/metrics['num_examples_numerical']
    metrics['confidence_interval']={'accuracy': t_test(metrics['accuracy_samples']),
            'mse': t_test(metrics['mse_samples'])}
    return metrics
# end define forward pass over data
# print results
logging.debug('testing best binary model: ' + str(best_binary_model_savefile))
binary_metrics=test_forward_pass(best_binary_model_savefile)
logging.debug('best_binary_model metrics: ' + str(binary_metrics))
logging_message='metrics test best binary model ' \
        + ': loss binary ' + "{0:.5f}".format(binary_metrics['average_loss_binary']) + ';' \
        + ' accuracy binary ' + "{0:.5f}".format(binary_metrics['accuracy_binary']) + ';' \
        + ' loss numerical ' + "{0:.5f}".format(binary_metrics['average_loss_numerical']) + ';' \
        + ' accuracy numerical ' + "{0:.5f}".format(binary_metrics['accuracy_numerical']) + ';' \
        + ' confidence intervals (+/-) ' + str(binary_metrics['confidence_interval']) + ';' \
        + ' confusion matrix (label,prediction) ' + str(binary_metrics['confusion_matrix'])
logging.info(logging_message)
with open(model_savedir+'/best_binary_model_test_results','w') as f:
    f.write(logging_message+'\n')
logging.debug('testing best numerical model: ' + str(best_numerical_model_savefile))
numerical_metrics=test_forward_pass(best_numerical_model_savefile)
logging.debug('best_numerical_model metrics: ' + str(numerical_metrics))
logging_message='metrics test best numerical model ' \
        + ': loss binary ' + "{0:.5f}".format(numerical_metrics['average_loss_binary']) + ';' \
        + ' accuracy binary ' + "{0:.5f}".format(numerical_metrics['accuracy_binary']) + ';' \
        + ' loss numerical ' + "{0:.5f}".format(numerical_metrics['average_loss_numerical']) + ';' \
        + ' accuracy numerical ' + "{0:.5f}".format(numerical_metrics['accuracy_numerical']) + ';' \
        + ' confidence intervals (+/-) ' + str(numerical_metrics['confidence_interval']) + ';' \
        + ' confusion matrix (label,prediction) ' + str(binary_metrics['confusion_matrix'])
logging.info(logging_message)
with open(model_savedir+'/best_numerical_model_test_results','w') as f:
    f.write(logging_message+'\n')
