#!/usr/bin/env bash

kg download -u $1 -p $2 -c 'dogs-vs-cats'

unzip train.zip

# Split data by class

mkdir train/cat
find train -type f -name 'cat*jpg' -exec mv {} train/cat/ \;

mkdir train/dog
find train -type f -name 'dog*jpg' -exec mv {} train/dog/ \;

# Split training data into train/validation

mkdir -p valid/cat
mkdir -p valid/dog

# Unzip test set

unzip test1.zip

# Move everything into a data/ directory

mkdir data
mv train data
mv valid data
mv test1 data

# Clean up

#rm train.zip
#rm test.zip
