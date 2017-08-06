#!/usr/bin/env bash

echo 'Download data from Kaggle...'
kg download

echo 'Unzip training data...'
unzip -q train.zip

echo 'Split data by class...'
mkdir cat
find train -type f -name 'cat*jpg' -exec mv {} cat/ \;

mkdir dog
find train -type f -name 'dog*jpg' -exec mv {} dog/ \;

mv cat/ train
mv dog/ train

echo 'Unzip test set...'
unzip -q test1.zip

echo 'Move everything into a data/ directory...'

mkdir data
mv train data
mv test1 data

# Clean up
#rm train.zip
#rm test.zip
#rm sampleSubmission.csv
