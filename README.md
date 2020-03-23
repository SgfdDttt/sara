# sara
Statutory Reasoning Assessment: dataset and code

# installing
TODO

# running the Prolog program

## Prolog program
Run `prolog statutes/prolog/init.pl`. This will load into memory the entirety of the Prolog version of the statutes, and open an interactive Prolog shell. From there, you can enter facts and call predicates.

## Test cases
Each case can be run individually, via e.g. `prolog cases/s3306_a_2_B_neg.pl`. The final `:- halt` statement ensures that no interactive shell remains open. If you want the shell to remain open, e.g. to try out other predicates with the facts of the case, comment that halt statement out.

You may run all the cases one after the other with `bash code/run_cases_prolog.sh`. This is a good initial check to do to see whether the Prolog program is being interpreted and run correctly.

# running experiments

Scripts for experiments are under `exp`. For each experiment, we provide the hyperparameters that lead to the best binary score, and those that led to the best numerical score.

## BERT models
All scripts involving BERT assume access to a GPU by default. You might need to modify the scripts accordingly, either to tell it which GPU to use, or to tell it not to use a GPU.

### Regular BERT
Scripts for BERT-based models will automatically download BERT-uncased and run the model. Run, for example, the command `./exp/bert_statutes_binary/script.sh`

### Legal BERT
To run the experiment with Legal BERT, I'm providing the scripts as well. They are similar to the BERT scripts, except that they point to the Legal BERT model and tokenizer instead of ordinary BERT.

## Feedforward neural models and nonneural models
Scripts can be found under `exp/{neural,nonneural}_word2vec_{statutes,context,question}_{binary,numerical}`, and run like the above. You will need to specify which word embedding file you want to use. The word embeddings need to be specified one word per line, followed by its vectors entries. The first line is the number of vectors followed by the dimensionality.

For convenience, I'm providing a filtered word2vec file under `dataset/word2vec.txt`

# todo
* [ ] create requirement file for pip (run pip freeze on my repo and figure out swi-prolog version)
* [x] add scripts for BERT
    * [x] BERT statutes
    * [x] BERT context
    * [x] BERT question
    * [x] BERT statutes thaw
* [ ] add scripts + README explanations for legal BERT
    * [ ] BERT statutes
    * [ ] BERT context
    * [ ] BERT question
    * [ ] BERT statutes thaw
* [ ] add scripts + README explanations for non-neural taxvectors
    * [ ] statutes
    * [ ] context
    * [ ] question
* [x] add scripts + README explanations for non-neural word2vec
    * [x] statutes
    * [x] context
    * [x] question
* [ ] add scripts + README explanations for neural taxvectors
    * [ ] statutes
    * [ ] context
    * [ ] question
* [x] add scripts + README explanations for neural word2vec
    * [x] statutes
    * [x] context
    * [x] question
* [ ] get someone from the lab to try this out
* [x] write section about Prolog
* [ ] add license
