#!/usr/bin/env bash

echo 'Split training data into train/validation...'
# TODO gshuf is for Mac, won't work on AWS AMI (Ubuntu)

source=data/train/cat
target=data/valid/cat
mkdir -p $target
ls $source | gshuf -n 2000 | xargs -I '{}' mv '$source/{}' $target

source=data/train/dog
target=data/valid/dog
mkdir -p $target
ls $source | gshuf -n 2000 | xargs -I '{}' mv '$source/{}' $target
