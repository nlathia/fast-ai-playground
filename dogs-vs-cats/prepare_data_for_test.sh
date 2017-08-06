#!/usr/bin/env bash
set -e

echo 'Merging train/validation data...'

source=data/valid/cat
target=data/train/cat
ls $source | xargs -I '{}' mv "$source/{}" $target

source=data/valid/dog
target=data/train/dog
ls $source | xargs -I '{}' mv "$source/{}" $target
