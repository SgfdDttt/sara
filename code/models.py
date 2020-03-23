import logging
import torch
from torch import nn
import numpy as np
from transformers import *

KEYS=[
        ['a','b','c','d','e','f','g'],
        [str(ii) for ii in range(1,22)],
        ['A','B','C','D','E','F','G','H'],
        ['i','ii','iii','iv','v'],
        ['I','II']
    ]

def find_statutes(statutes,questions):
    # 1. tag statues with their section ids
    all_keys=[]
    current_keys=[]
    for s in statutes:
        if s.startswith('Section '):
            current_keys=[(s.lstrip('Section ').split('.')[0],-1)]
        elif s.startswith('('):
            subsection_id=s.lstrip('(').split(')')[0]
            key_level=0
            while subsection_id not in KEYS[key_level]:
                key_level+=1
            cutoff_index=0
            while True:
                if cutoff_index==len(current_keys):
                    break
                if current_keys[cutoff_index][1]>=key_level:
                    break
                cutoff_index+=1
            current_keys=current_keys[:cutoff_index]
            current_keys.append((subsection_id,key_level))
        all_keys.append(list(current_keys))
    for ii,s in enumerate(statutes):
        if ii==0:
            continue
        if not s.startswith('('):
            if statutes[ii-1].endswith(','):
                all_keys[ii].pop()
    for ii,_ in enumerate(all_keys):
        all_keys[ii]=[x[0] for x in all_keys[ii]]
    # 2. for each question, compile relevant statutes
    relevant_statutes=[None for _ in questions]
    for ii,q in enumerate(questions):
        if q.lower().startswith('how much tax'):
            relevant_statutes[ii]='all'
            continue
        if 'section' in q: # regular text
            section_key='section '
        elif 'Section' in q: # regular text
            section_key='Section '
        elif 'sec_' in q: # text tokenized using Andrew's tokenizer
            section_key='sec_'
        else:
            assert False, 'Problem with ' + str(q)
        relevant_section=q.split(section_key)[1].split(' ')[0].strip('?, ')
        keys=relevant_section.replace('(',' ').replace(')','').split(' ')
        rel_stat=''
        for k,s in zip(all_keys,statutes):
            l=min(len(k),len(keys))
            if k[:l]==keys[:l]:
                rel_stat=rel_stat+' '+s
        relevant_statutes[ii]=rel_stat.strip(' ')
    return relevant_statutes

class RelationalModel(nn.Module):
    def __init__(self,word_embeddings_file=None,unigram_counts_file=None,num_layers=None,num_units=None,
            use_statutes=True, use_context=True, smoothing_param=1e-3, tax_statistics=None):
        # model that computes Arora+17 representation, which is then fed to neural net
        super(RelationalModel,self).__init__()
        if use_statutes:
            assert use_context
        logging.debug('load word embeddings')
        self.unigram_counts_file=unigram_counts_file
        self.word_embeddings={}
        for line in open(word_embeddings_file,'r'):
            if len(line.split(' '))==2:
                self.vector_dim=int(line.split(' ')[1])
                continue
            word=line.split(' ')[0]
            vector=filter(lambda x: len(x)>0, line.strip('\n').split(' ')[1:])
            vector=list(map(float,vector))
            assert word not in self.word_embeddings, word + ' ' + str(list(self.word_embeddings.keys()))
            self.word_embeddings[word]=torch.FloatTensor(vector)
        for w in self.word_embeddings:
            assert self.vector_dim==self.word_embeddings[w].size(0)
        all_vectors=torch.stack([v for _,v in self.word_embeddings.items()],dim=0)
        mean_vector=torch.sum(all_vectors,dim=0)/all_vectors.size(0)
        assert '<UNK>' not in self.word_embeddings
        self.word_embeddings['<UNK>']=mean_vector # assign any UNKs to mean of embeddings
        self.tax_statistics=tax_statistics
        self.use_statutes,self.use_context=use_statutes,use_context
        self.smoothing_param=smoothing_param # 'a' in Arora et al
        self.use_neural_net=(num_layers is not None) and (num_units is not None) and self.use_statutes
        if self.use_neural_net:
            self.num_layers,self.num_units=num_layers,num_units
            architecture=[4*self.vector_dim]+[num_units]*num_layers+[num_units+1] # last layer computes representation and gate
            self.neural_net=[]
            for size_in,size_out in zip(architecture[:-1],architecture[1:]):
                self.neural_net.append(nn.BatchNorm1d(size_in))
                self.neural_net.append(nn.Linear(size_in,size_out))
                torch.nn.init.xavier_uniform_(self.neural_net[-1].weight)
                torch.nn.init.zeros_(self.neural_net[-1].bias)
                self.neural_net.append(nn.Tanh())
            self.neural_net=nn.Sequential(*self.neural_net[:-1]) # remove last non-linearity
        if self.use_neural_net:
            input_size=num_units
        elif self.use_statutes:
            input_size=4*self.vector_dim
        else:
            input_size=self.vector_dim
        linear_predictor=nn.Linear(input_size, 2)
        torch.nn.init.xavier_uniform_(linear_predictor.weight)
        torch.nn.init.zeros_(linear_predictor.bias)
        self.predictor=nn.Sequential(nn.BatchNorm1d(input_size),linear_predictor)
        self.projection_cache={} # to avoid projecting the same sentences over and over again

    def cuda(self):
        self.gpu=True
        self.predictor.to('cuda')
        if self.use_neural_net:
            self.neural_net.to('cuda')

    def learn_representation(self,statutes,context,questions):
        self.estimate_unigram_counts(statutes,context,questions)
        all_sentences=statutes+[a+' '+b for a,b in zip(context,questions)]
        self.compute_projection(all_sentences)

    def estimate_unigram_counts(self,statutes,contexts,questions):
        if self.unigram_counts_file is not None:
            logging.debug('read unigram counts from ' + self.unigram_counts_file)
            word_counts={}
            total_count=None
            for line in open(self.unigram_counts_file,'r'):
                if total_count is None:
                    total_count=int(line.strip('\n').split(' ')[1])
                else:
                    word,count=line.strip('\n').split(' ')
                    word_counts[word]=int(count)
        else:
            logging.debug('estimate unigram counts')
            word_counts={}
            total_count=0
            for thing in [statutes,contexts,questions]:
                for line in statutes:
                    for word in line.split(' '):
                        if word in self.word_embeddings:
                            _w=word
                        else:
                            _w='<UNK>'
                        word_counts.setdefault(_w,0)
                        word_counts[_w]+=1
                        total_count+=1
        self.word_weights={}
        for word in word_counts:
            self.word_weights[word]=self.smoothing_param*total_count\
                    /(self.smoothing_param*total_count+word_counts[word])

    def compute_projection(self,all_sentences):
        sentence_vectors=[torch.zeros(self.vector_dim) for _ in all_sentences]
        for ii,sentence in enumerate(all_sentences):
            for word in sentence.split(' '):
                sentence_vectors[ii]+=self.word_weights.get(word,self.word_weights['<UNK>'])\
                        *self.word_embeddings.get(word,self.word_embeddings['<UNK>'])
            sentence_vectors[ii]/=len(sentence.split(' '))
        sentence_vectors=torch.stack(sentence_vectors,dim=1)
        U,_,_=torch.svd(sentence_vectors)
        u=U[:,0]
        self.projection_matrix=torch.eye(self.vector_dim)-torch.ger(u,u)

    def embed_sentence(self,sentence):
        if sentence in self.projection_cache:
            return self.projection_cache[sentence]
        output=torch.zeros(self.vector_dim)
        sentence_removed=sentence
        REMOVE=['?','.',',','(',')',';','-','"',':',"'s"]
        for x in REMOVE:
            sentence_removed=sentence_removed.replace(x,'')
        while '  ' in sentence_removed:
            sentence_removed=sentence_removed.replace('  ',' ')
        for word in sentence_removed.split(' '):
            output+=self.word_weights.get(word,self.word_weights['<UNK>'])\
                    *self.word_embeddings.get(word,self.word_embeddings['<UNK>'])
            output/=len(sentence.split(' '))
        output=torch.matmul(self.projection_matrix,output)
        self.projection_cache[sentence]=output
        return output

    def forward(self,statutes=None,question=None,context=None,grad=False,output_is_numerical=None,**kwargs):
        input_question=question
        if context is not None:
            input_question=[a+' '+b for a,b in zip(context,question)] 
        question_embeddings=torch.stack([self.embed_sentence(iq) for iq in input_question],
                dim=0) # batch_size x dim
        batch_size=question_embeddings.size(0)
        if self.use_statutes:
            relevant_statutes=find_statutes(statutes,question)
            input_question=[]
            for q in question:
                if 'how much tax' in q.lower():
                    new_question=q
                else:
                    if 'section' in q:
                        split_key='section '
                    elif 'Section' in q:
                        split_key='Section '
                    elif 'sec_' in q:
                        split_key='sec_'
                    new_question=q.split(split_key)[0] + 'this ' \
                            + ' '.join(q.split(split_key)[1].split(' ')[1:])
                    new_question=new_question.strip(' ')
                input_question.append(q)
            if context is not None:
                input_question=[a+' '+b for a,b in zip(context,input_question)] 
            question_embeddings=torch.stack([self.embed_sentence(iq) for iq in input_question],
                    dim=0) # batch_size x dim
            statute_embeddings=torch.stack([self.embed_sentence(x) for x in relevant_statutes],
                    dim=0) # num_statutes x dim
            question_x_statute=torch.cat([question_embeddings,statute_embeddings, \
                    question_embeddings*statute_embeddings, \
                    torch.abs(question_embeddings-statute_embeddings)], \
                    dim=1) # batch_size x num_statutes x 4*dim
            if self.use_neural_net:
                neural_net_output=self.neural_net(question_x_statute)
                representations=neural_net_output[:,:-1]
            else:
                representations=question_x_statute
            statute_representation=representations
            logits=self.predictor(statute_representation)
        else:
            logits=self.predictor(question_embeddings)
        logits=[ logits[ii,output_is_numerical[ii]]*self.tax_statistics[1]+self.tax_statistics[0]
            if output_is_numerical[ii]==1 else logits[ii,output_is_numerical[ii]]
            for ii in range(logits.size(0)) ]
        logits=torch.stack(logits,dim=0)
        return logits

class QuestionModel(nn.Module):
    def __init__(self,pretrained_model='bert-base-uncased',
            tokenizer='bert-base-uncased',max_length=512,use_context=True,tax_statistics=None):
        super(QuestionModel, self).__init__()
        self.pretrained_model=pretrained_model
        try:
            self.bert=AutoModel.from_pretrained(pretrained_model)
        except:
            self.bert=BertModel.from_pretrained(pretrained_model)
        # lighten the load of the computation
        self.bert.config.output_hidden_states=False
        self.bert.config.output_attentions=False
        # linear layer to predict output (0: binary, 1: numerical)
        self.predictor=torch.nn.Linear(self.bert.config.hidden_size,2)
        torch.nn.init.xavier_uniform_(self.predictor.weight)
        torch.nn.init.zeros_(self.predictor.bias)
        if isinstance(tokenizer,str):
            #self.tokenizer=BertTokenizer.from_pretrained(tokenizer)
            self.tokenizer=AutoTokenizer.from_pretrained(tokenizer)
        else:
            self.tokenizer=tokenizer
        self.use_context=use_context
        self.max_length=max_length
        self.tax_statistics=tax_statistics
        self.gpu=False

    def cuda(self):
        self.gpu=True
        self.bert.to('cuda')
        self.predictor.to('cuda')

    def freeze_bert(self, thaw_top_layer=False):
        for param in self.bert.parameters():
            param.requires_grad=False
        if thaw_top_layer:
            for param in self.bert.encoder.layer[-1].parameters():
                param.requires_grad=True

    def forward(self,question=None,context=None,grad=False,output_is_numerical=None):
        if grad:
            self.train()
        else:
            self.eval()
        token_type_ids=None
        if self.use_context:
            assert context is not None
            input_dicts = [\
                self.tokenizer.encode_plus(x, text_pair=y, add_special_tokens=True, \
                max_length=self.max_length) \
                for x,y in zip(context,question)]
        else:
            assert context is None
            input_dicts = [\
                self.tokenizer.encode_plus(x, add_special_tokens=True, \
                max_length=self.max_length) \
                for x in question]
        input_ids=[x['input_ids'] for x in input_dicts]
        token_type_ids=[x['token_type_ids'] for x in input_dicts]
        input_mask = [[1]*len(x) for x in input_ids]
        # pad
        input_ids = list(map(lambda x: x+[0]*(self.max_length-len(x)) \
            if len(x)<self.max_length else x, input_ids))
        token_type_ids = list(map(lambda x: x+[0]*(self.max_length-len(x)) \
            if len(x)<self.max_length else x, token_type_ids))
        input_mask = list(map(lambda x: x+[0]*(self.max_length-len(x)) \
            if len(x)<self.max_length else x, input_mask))
        # turn into tensor + move to gpu
        input_tensor=torch.LongTensor(input_ids)
        token_type_ids_tensor=torch.LongTensor(token_type_ids)
        mask_tensor=torch.FloatTensor(input_mask)
        #assert torch.equal(torch.gt(input_tensor,0).byte(),mask_tensor.byte())
        if self.gpu:
            input_tensor=input_tensor.to('cuda')
            mask_tensor=mask_tensor.to('cuda')
            token_type_ids_tensor=token_type_ids_tensor.to('cuda')
        # feed through model
        last_hidden_state,_=self.bert(input_tensor,\
                token_type_ids=token_type_ids_tensor, attention_mask=mask_tensor)
        logits=self.predictor(last_hidden_state[:,0,:])
        logits=[ logits[ii,output_is_numerical[ii]]*self.tax_statistics[1]+self.tax_statistics[0]
                if output_is_numerical[ii]==1 else logits[ii,output_is_numerical[ii]]
                for ii in range(logits.size(0)) ]
        logits=torch.stack(logits,dim=0)
        return logits
    
class StatuteModel(nn.Module):
    def __init__(self,pretrained_model='bert-base-uncased',
            tokenizer='bert-base-uncased',max_length=512,sample_size=16,
            annealing_rate=None,pooling_function='sigmoid',tax_statistics=None):
        super(StatuteModel, self).__init__()
        self.pretrained_model=pretrained_model
        # BERT base
        try:
            self.bert=AutoModel.from_pretrained(pretrained_model)
        except:
            self.bert=BertModel.from_pretrained(pretrained_model)
        # lighten the load of the computation
        self.bert.config.output_hidden_states=False
        self.bert.config.output_attentions=False
        # layer to predict pooling weights
        self.pooler=torch.nn.Linear(self.bert.config.hidden_size,1)
        torch.nn.init.xavier_uniform_(self.pooler.weight)
        torch.nn.init.zeros_(self.pooler.bias)
        # final layer to predict output
        self.predictor=torch.nn.Linear(self.bert.config.hidden_size,2)
        self.tax_statistics=tax_statistics
        torch.nn.init.xavier_uniform_(self.predictor.weight)
        torch.nn.init.zeros_(self.predictor.bias)
        # number of statutes in the softmax
        self.sample_size=1
        if isinstance(tokenizer,str):
            self.tokenizer=BertTokenizer.from_pretrained(tokenizer)
        else:
            self.tokenizer=tokenizer
        self.max_length=max_length
        if pooling_function=='sigmoid':
            self.pooling_function=nn.Sigmoid()
        elif pooling_function=='softmax':
            self.pooling_function=nn.Softmax(dim=-1)
        self.gpu=False

    def cuda(self):
        self.gpu=True
        self.bert.to('cuda')
        self.predictor.to('cuda')
        self.pooler.to('cuda')

    def freeze_bert(self, thaw_top_layer=False):
        for param in self.bert.parameters():
            param.requires_grad=False
        if thaw_top_layer:
            for param in self.bert.encoder.layer[-1].parameters():
                param.requires_grad=True

    def preprocess(self,statutes,question,context):
        logging.debug('calling self.preprocess')
        # compute the pooling activation for each statute
        # context and question are batches, going through
        # statutes batch_size at a time
        self.eval()
        activations=[ [] for _ in context ] # batch x num_statutes
        batch_size=128//len(question) # keep a constant batch size regardless of actual batch size
        for position in range(0,len(statutes),batch_size):
            logging.debug('position: ' + str(position) + '/' + str(len(statutes)))
            stats=statutes[position:position+batch_size]
            triples=[]
            for s in stats:
                for c,q in zip(context,question):
                    triples.append((s,c,q))
            input_dicts = [\
                self.tokenizer.encode_plus(s, text_pair=c+' '+q, add_special_tokens=True, \
                max_length=self.max_length) for s,c,q in triples]
            input_ids=[x['input_ids'] for x in input_dicts]
            token_type_ids=[x['token_type_ids'] for x in input_dicts]
            input_mask = [[1]*len(x) for x in input_ids]
            # pad
            input_ids = list(map(lambda x: x+[0]*(self.max_length-len(x)) \
                if len(x)<self.max_length else x, input_ids))
            token_type_ids = list(map(lambda x: x+[0]*(self.max_length-len(x)) \
                if len(x)<self.max_length else x, token_type_ids))
            input_mask = list(map(lambda x: x+[0]*(self.max_length-len(x)) \
                if len(x)<self.max_length else x, input_mask))
            # turn into tensor + move to gpu
            input_tensor=torch.LongTensor(input_ids)
            token_type_ids_tensor=torch.LongTensor(token_type_ids)
            mask_tensor=torch.FloatTensor(input_mask)
            #assert torch.equal(torch.gt(input_tensor,0).byte(),mask_tensor.byte())
            if self.gpu:
                input_tensor=input_tensor.to('cuda')
                mask_tensor=mask_tensor.to('cuda')
                token_type_ids_tensor=token_type_ids_tensor.to('cuda')
            # feed through model
            with torch.no_grad():
                last_hidden_state,_=self.bert(input_tensor,\
                        token_type_ids=token_type_ids_tensor, attention_mask=mask_tensor)
                weights=self.pooler(last_hidden_state[:,0,:])
            weights=torch.squeeze(weights,dim=-1).cpu().tolist()
            # insert in right place into list
            ii=0
            for _ in stats:
                for jj,_ in enumerate(context):
                    activations[jj].append(weights[ii])
                    ii+=1
            assert ii==len(weights)
        for a in activations:
            assert len(a)==len(statutes)
        return activations

    def sample(self,activations,temperature=0):
        logging.debug('calling self.sample')
        # activations has size batch x num_statutes
        # output has size batch x sample_size and is just indices of statutes
        # epoch is 0-based indexing
        assert temperature>=0
        output=[ [] for _ in activations ]
        for ii,a in enumerate(activations):
            if temperature>0:
                act=torch.FloatTensor(a)/temperature
                with torch.no_grad():
                    act=self.pooling_function(act)
                act=act+1e-8/act.size(0) # avoid zero probs
                probs=act/act.sum()
                samples=np.random.choice(len(a),size=self.sample_size,replace=False,p=probs.numpy())
            else:
                samples=np.argsort(a)[-self.sample_size:]
            output[ii]=samples
        return output

    def forward(self,statutes=None,question=None,context=None,grad=False,output_is_numerical=None,temperature=0):
        samples=find_statutes(statutes,question)
        assert len(samples)==len(question)
        assert len(question)==len(context) # batch
        assert len(question)==len(samples) # batch
        if grad:
            self.train()
        else:
            self.eval()
        logging.debug('prepare model input')
        token_type_ids=None
        assert context is not None
        triples=[]
        for samp,c,q in zip(samples,context,question):
            if 'how much tax' in q.lower():
                new_question=q
            else:
                if 'section' in q:
                    split_key='section '
                elif 'Section' in q:
                    split_key='Section '
                elif 'sec_' in q:
                    split_key='sec_'
                new_question=q.split(split_key)[0] + 'this ' \
                        + ' '.join(q.split(split_key)[1].split(' ')[1:])
                new_question=new_question.strip(' ')
            triples.append((samp,c,new_question))
        input_dicts = [\
            self.tokenizer.encode_plus(s, text_pair=c+' '+q, add_special_tokens=True, max_length=self.max_length) \
            for s,c,q in triples]
        input_ids=[x['input_ids'] for x in input_dicts]
        token_type_ids=[x['token_type_ids'] for x in input_dicts]
        input_mask = [[1]*len(x) for x in input_ids]
        # pad
        input_ids = list(map(lambda x: x+[0]*(self.max_length-len(x)) \
            if len(x)<self.max_length else x, input_ids))
        token_type_ids = list(map(lambda x: x+[0]*(self.max_length-len(x)) \
            if len(x)<self.max_length else x, token_type_ids))
        input_mask = list(map(lambda x: x+[0]*(self.max_length-len(x)) \
            if len(x)<self.max_length else x, input_mask))
        # turn into tensor + move to gpu
        input_tensor=torch.LongTensor(input_ids)
        token_type_ids_tensor=torch.LongTensor(token_type_ids)
        mask_tensor=torch.FloatTensor(input_mask)
        assert torch.equal(torch.gt(input_tensor,0).byte(),mask_tensor.byte())
        if self.gpu:
            input_tensor=input_tensor.to('cuda')
            mask_tensor=mask_tensor.to('cuda')
            token_type_ids_tensor=token_type_ids_tensor.to('cuda')
        # feed through model
        logging.debug('feed through model')
        last_hidden_state,_=self.bert(input_tensor,\
                token_type_ids=token_type_ids_tensor, attention_mask=mask_tensor)
        representations=last_hidden_state[:,0,:]
        logits=self.predictor(representations)
        logits=[ logits[ii,output_is_numerical[ii]]*self.tax_statistics[1]+self.tax_statistics[0]
            if output_is_numerical[ii]==1 else logits[ii,output_is_numerical[ii]]
            for ii in range(logits.size(0)) ]
        logits=torch.stack(logits,dim=0)
        return logits
