#!/bin/bash
batch=32
expdir=exp/nonneural_taxvectors_statutes_numerical
learning_rate=0.001
smoothing_parameter=0.001
weight_decay=0
word_embeddings=/export/b01/nholzen/tax_law/ablai_tax_vectors.txt
date
python -u code/train.py --datadir dataset/ --batch $batch --expdir $expdir --epochs 500 --learning_rate $learning_rate --word_embeddings $word_embeddings --smoothing_parameter $smoothing_parameter --weight_decay $weight_decay --context --statutes
date