#!/bin/bash
batch=4
expdir=exp/legal_bert_context_numerical
warmup=0.7
learning_rate=2e-06
update_period=4
bert_model=/export/b02/ablai/dec12_t1_dir9
date
CUDA_VISIBLE_DEVICES=`free-gpu` python -u code/train.py --datadir dataset/ --batch $batch --max_length 512 --gpu --expdir $expdir --epochs 100 --warmup $warmup --learning_rate $learning_rate --update_period $update_period --context --bert_model $bert_model --bert_tokenizer bert-base-cased
date
