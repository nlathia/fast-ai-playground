# fast.ai's deep learning, without Jupyter

## Setup AWS

Refer to the [AWS install wiki page](http://wiki.fast.ai/index.php/AWS_install). I have also made step-by-step setup guide [here](AWS.md).

## Project setup

First, install [pyenv](https://github.com/pyenv/pyenv).

Now, set up your environmment:

```
$ ./install.sh
```

This will:
* Install Python 3.6.1 (using `pyenv`) and use it for this project.
* Create a virtualenv called `(fast.ai)`
* Install all the dependencies listed in `requirements.txt`

You're ready!

To activate this virtualenv:

```bash
$ source .venv/bin/activate
```

Now, just `cd` into each lesson and get started:

```bash
(fast-ai) $ cd lesson1/
```

Each lesson directory has its own `Readme.md`
