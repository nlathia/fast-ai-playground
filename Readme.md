# Another fast.ai Deep Learning Playground

## Why another repo?

Here are the main differences:
* No Jupyter! Instead, this project:
    * Uses pyenv
    * Uses Python 3.6.1 and a virtual environment.
* Setup CLI:
    * Operations are idempotent (they do not recreate things if they already exist).
    * Setup everything using an AWS `--profile`
    * Create/restore volume snapshots, to save a bit of money
* Lesson 1: Cats vs Dogs.
    * Added `prepare_data.sh` to download, split, format images from Kaggle.
    * Refactored the python code from the notebooks into modules.

## Setup AWS

Refer to the [AWS install wiki page](http://wiki.fast.ai/index.php/AWS_install).

I have made step-by-step setup guide [here](setup/Readme.md). This setup has a number of differences:
* Setup instructions using the AWS console interface as of July 2017.
* Using an AWS `profile` argument instead of using the `default` profile.
* Commands to start/stop/reboot instances are split up into `.sh` files (instead of a single `commands.txt`).
* Does not open up instance ports (needed for Jupyter)


## Project setup

First, install [pyenv](https://github.com/pyenv/pyenv). To do this on Ubuntu, you can run [this](setup/install_pyenv.sh).

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
