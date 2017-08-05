#!/usr/bin/env bash
set -e

hash pyenv 2>/dev/null
if [ $? -ne 0 ]; then
    echo Installing pyenv...
    unamestr=`uname -a`
    if [[ $unamestr == *"Ubuntu"* ]]; then
      sudo apt-get install git python-pip make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev
      git clone https://github.com/pyenv/pyenv.git ~/.pyenv
      echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
      echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
      echo 'eval "$(pyenv init -)"' >> ~/.bashrc
      source ~/.bashrc
    elif [[ $unamestr == *"Darwin"* ]]; then
      brew update
      brew install pyenv
      echo 'eval "$(pyenv init -)"' >> ~/.bash_profile
      source ~/.bash_profile
    else
      echo "Aborting: Installing pyenv not implemented for: $unametr"
      exit 1
    fi
fi

pyenv install
pip install --upgrade virtualenv

virtualenv --setuptools --no-site-packages --prompt="(fast.ai)" .venv
source .venv/bin/activate

pip install --upgrade pip
pip install -r requirements.txt
