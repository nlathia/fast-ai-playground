#!/usr/bin/env bash

echo 'Download data from Kaggle...'

kg download -u $1 -p $2 -c 'dogs-vs-cats'

echo 'Unzip training data...'

unzip -q train.zip

echo 'Split data by class...'

mkdir cat
find train -type f -name 'cat*jpg' -exec mv {} cat/ \;

mkdir dog
find train -type f -name 'dog*jpg' -exec mv {} dog/ \;

mv cat/ train
mv dog/ train

echo 'Split training data into train/validation...'

# TODO gshuf is for Mac, won't work on AWS AMI (Ubuntu)

mkdir -p valid/cat
ls train/cat/ | gshuf -n 2000 | xargs -I '{}' mv 'train/cat/{}' valid/cat/

mkdir -p valid/dog
ls train/dog/ | gshuf -n 2000 | xargs -I '{}' mv 'train/dog/{}' valid/dog/

echo 'Unzip test set...'

unzip -q test1.zip

echo 'Move everything into a data/ directory...'

mkdir data
mv train data
mv valid data
mv test1 data

# Clean up
#rm train.zip
#rm test.zip
