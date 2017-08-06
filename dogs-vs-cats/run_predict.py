import numpy as np
import os

from fastai.vgg.vgg16 import Vgg16
from fastai.vgg.utils import (
    get_batches
)

BATCH_SIZE = 64
DATA_ROOT = 'data'
TRAINING = os.path.join(DATA_ROOT, 'train')
TEST = os.path.join(DATA_ROOT, 'test')

vgg = Vgg16()

batches = get_batches(TRAINING, batch_size=BATCH_SIZE)
vgg.fine_tune(batches)

batches, probabilities = vgg.test(TEST)

image_ids = [int(f[f.rindex('/')+1:f.index('.')]) for f in batches.filenames]
is_dog_probability = probabilities[:, 1]

submission = np.stack([image_ids, is_dog_probability], axis=1)
np.savetext('submission.csv', submission, fmt='%d,%.5f', header='id,label')
