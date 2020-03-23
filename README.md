# sara
Statutory Reasoning Assessment: dataset and code

# installing
TODO

# running experiments

Scripts for experiments are under `exp`

## BERT
Scripts for BERT-based models will automatically download BERT-uncased and run the model. Just run, for example `./exp/bert_statutes_binary/script.sh`

## Legal BERT
To run the experiment with Legal BERT, I'm providing the scripts as well. They are similar to the BERT scripts, except that they point to the Legal BERT model and tokenizer instead of ordinary BERT.

## Feedforward neural models
Scripts can be found under `exp/???` and run like the above. You will need to specify which word embedding file you want to use. The word embeddings need to be specified one word per line, followed by its vectors entries. The first line is the number of vectors followed by the dimensionality.

For convenience, I'm providing a filtered word2vec file under `dataset/word2vec.txt`

# todo
* [] create requirement file for pip (run pip freeze on my repo)
* [] add scripts for BERT
    * [] BERT statutes
    * [] BERT context
    * [] BERT question
* [] add scripts + README explanations for legal BERT
* [] add scripts + README explanations for non-neural taxvectors
* [] add scripts + README explanations for non-neural word2vec
* [] add scripts + README explanations for neural taxvectors
* [] add scripts + README explanations for neural word2vec
* [] get someone from the lab to try this out
