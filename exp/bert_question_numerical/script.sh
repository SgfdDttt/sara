#!/bin/bash
batch=4
expdir=exp/bert_question_numerical
warmup=0.5
learning_rate=5e-05
update_period=8
date
CUDA_VISIBLE_DEVICES=`free-gpu` python -u code/train.py --datadir dataset/ --batch $batch --max_length 512 --gpu --expdir $expdir --epochs 100 --warmup $warmup --learning_rate $learning_rate --update_period $update_period
date
