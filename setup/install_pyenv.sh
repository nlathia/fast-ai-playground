#!/usr/bin/env bash

# Install pyenv on Ubuntu
# TODO compare with http://opencafe.readthedocs.io/en/latest/getting_started/pyenv/

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
source ~/.bashrc