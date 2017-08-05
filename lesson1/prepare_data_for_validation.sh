#!/usr/bin/env bash
set -e

unamestr=`uname -a`
if [[ $unamestr == *"Ubuntu"* ]]; then
  echo 'Using shuf on Ubuntu'
  command="shuf"
elif [[ $unamestr == *"Darwin"* ]]; then
  echo 'Using gshuf on Darwin.'
  brew update
  brew install coreutils
  command="gshuf"
else
  echo "Aborting: Installing shuf not implemented for: $unametr"
  exit 1
fi

echo 'Split training data into train/validation...'

source=data/train/cat
target=data/valid/cat
mkdir -p $target
ls $source | $command -n 2000 | xargs -I '{}' mv "$source/{}" $target

source=data/train/dog
target=data/valid/dog
mkdir -p $target
ls $source | $command -n 2000 | xargs -I '{}' mv "$source/{}" $target
