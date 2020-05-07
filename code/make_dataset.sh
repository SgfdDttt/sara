# download data
wget https://nlp.jhu.edu/law/sara.tar.gz
# uncompress data
tar -xzvf sara.tar.gz
# create splits
python code/make_text_dataset.py
# run tokenizer
python code/tokenize_text_dataset.py
