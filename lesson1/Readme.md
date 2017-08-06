# Lesson 1: Cats vs. Dogs

## Download the data

If you're on a mac, the following assumes that you have `coreutils` installed. If you do not:
```bash
brew install coreutils
```

If your on Ubuntu, the following assumes that you have `unzip` installed. If you do not:
```bash
sudo apt-get install unzip
```

Run this:
```bash
(fast.ai)$ ./download_data.sh <your-kaggle-username> <your-kaggle-pwd>
```

This will:
1. Download and unzip the competition data from kaggle.
2. Split the training data into directories per class (cat and dog).
4. Move everything into a `data/` directory.

## Experiment with a validation set

Run this:
```bash
(fast.ai)$ ./prepare_data_for_validation.sh
```

This will:
1. Randomly sample 2000 cats and dogs to create a validation set.
2. Move all the validation set into a `valid/` directory.

You will end up with:
```
data
  |- train
       |- cat (training set cat images)
       |- dog (training set dog images)
  |- valid
       |- cat (2,000 validation set cat images)
       |- dog (2,000 validation set dog images)
  |- test1 (test set)
```

Now, you can run:

```bash
(fast.ai)$ python run_validation.py
```

## Create a submission with the test set

```bash
(fast.ai)$ python run_predict.py
```

Will generate a `submission.csv` with class predictions. Note: this competition does not appear to be accepting submissions.

```bash
(fast.ai)$ ./submit_predictions.sh <your-kaggle-username> <your-kaggle-pwd>
```

Will submit them using the kaggle-cli.