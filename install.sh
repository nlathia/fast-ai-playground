#!/usr/bin/env bash
set -e

export CONFIGURE_OPTS="OPT=\"-fPIC\""
pyenv install
pip install --upgrade virtualenv

virtualenv --setuptools --no-site-packages --prompt="(fast.ai)" .venv
source .venv/bin/activate

pip install --upgrade pip
pip install -r requirements.txt
