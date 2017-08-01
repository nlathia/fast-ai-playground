# fast.ai's deep learning, without Jupyter

## Setup AWS

Refer to the [AWS install wiki page](http://wiki.fast.ai/index.php/AWS_install).

Alternatively, I have made step-by-step setup guide [here](setup/Readme.md). This setup has the following differences:
* Setup instructions using the AWS console interface as of July 2017.
* Using an AWS `profile` argument instead of using the `default` profile.
* Operations are idempotent (they do not recreate things if they already exist).
* Does not open up instance ports (needed for Jupyter)


## Project setup

First, install [pyenv](https://github.com/pyenv/pyenv).

Now, set up your environment using [install.sh](install.sh):

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
