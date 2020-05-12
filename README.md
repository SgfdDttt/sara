# Statutory Reasoning Assessment
The dataset and Prolog program can be found [here](https://nlp.jhu.edu/law/). The paper can be found [here](https://arxiv.org/abs/2005.05257).

# Installing
Install the required Python packages with `pip install -r requirements.txt`. To run the Prolog program, you need SWI-Prolog version 7.2.3 for amd64.

# The dataset
Download and format the dataset by running `bash code/make_dataset.sh`. You will need the tokenizer for legal text, and update the path in `code/tokenize_text_dataset.py`. Without the tokenizer, you can still run the script, which will nonetheless download the dataset and format it under `dataset/`.

# Running experiments
The data files should be stored under `dataset/` and `tokenized_dataset/`.

Scripts for experiments are under `exp/`. For each experiment, we provide the hyperparameters that led to the best binary score, and those that led to the best numerical score.

## BERT models
All scripts involving BERT assume access to a GPU by default. You might need to modify the scripts accordingly, either to
* tell it which GPU to use (modify `CUDA_VISIBLE_DEVICES=...`), or to 
* tell it not to use a GPU (remove the `--gpu` argument)

### BERT-base-cased
Scripts for BERT-based models will automatically download BERT-base-cased and run the model. Run, for example, the command `./exp/bert_statutes_binary/script.sh`.

### Legal BERT
To run the experiment with Legal BERT, the scripts are provided as well. They are similar to the BERT scripts, except that they point to the Legal BERT model and tokenizer instead of ordinary BERT. You need to modify the value of the variable `bert_model` to point to Legal BERT.

## Feedforward neural models and nonneural models
Scripts can be found under `exp/{neural,nonneural}_word2vec_{statutes,context,question}_{binary,numerical}/`, and run like the above. You will need to specify which word embedding file you want to use, by modifying the `word_embeddings` file in the bash script. The word embeddings need to be specified one word per line, followed by its vectors entries. The first line is the number of vectors followed by the dimensionality.

For convenience, we're providing a filtered word2vec file under `dataset/word2vec.txt`.
