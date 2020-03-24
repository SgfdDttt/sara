#!/bin/bash
batch=4
update_period=8
expdir=exp/legal_bert_statutes_thaw_binary
warmup=0.1
learning_rate=5e-05
bert_model=/export/b02/ablai/dec12_t1_dir9
date
CUDA_VISIBLE_DEVICES=`free-gpu` python -u code/train.py --datadir dataset/ --batch $batch --max_length 512 --gpu --expdir $expdir --epochs 100 --warmup $warmup --learning_rate $learning_rate --update_period $update_period --statutes --bert_model $bert_model --bert_tokenizer bert-base-cased --thaw_top_layer
date
