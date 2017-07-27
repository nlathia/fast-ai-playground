# Lesson 1: Cats vs. Dogs

### 1: Download and prepare the data

If you're on a mac, the following assumes that you have `coreutils` installed. If you do not:
```bash
brew install coreutils
```

Run this:
```bash
(fast-ai) $ ./prepare_data.sh <your-kaggle-username> <your-kaggle-pwd>
```

This will:
1. Download and unzip the competition data from kaggle.
2. Split the training data into directories per class (cat and dog).
3. Randomly sample 2000 cats and dogs to create a validation set.
4. Move everything into a `data/` directory.

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

### 2: Run the pre-trained model

Run this:

```bash
(fast-ai) $ python run_pre_trained.py
```