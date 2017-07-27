#!/usr/bin/env bash

echo 'Download data from Kaggle...'

kg download -u $1 -p $2 -c 'dogs-vs-cats'

echo 'Unzip training data...'

unzip train.zip

echo 'Split data by class...'

mkdir train/cat
find train -type f -name 'cat*jpg' -exec mv {} train/cat/ \;

mkdir train/dog
find train -type f -name 'dog*jpg' -exec mv {} train/dog/ \;

echo 'Split training data into train/validation...'

mkdir -p valid/cat
ls train/cat/ | gshuf -n 2000 | while read file; do mv train/cat/$file valid/cat/; done

mkdir -p valid/dog
ls train/dog/ | gshuf -n 2000 | while read file; do mv train/dog/$file valid/dog/; done

echo 'Unzip test set...'

unzip test1.zip

echo 'Move everything into a data/ directory...'

mkdir data
mv train data
mv valid data
mv test1 data

# Clean up

#rm train.zip
#rm test.zip
