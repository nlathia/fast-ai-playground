#!/usr/bin/env bash
# set -e

pyenv install

pyenv virtualenv anaconda2-4.4.0 fast.ai
source activate fast.ai

pip install --upgrade pip
pip install -r requirements.txt
pip install -r dev_requirements.txt

brew install coreutils  # Needed for gshuf
