import os

from fastai.vgg.vgg16 import Vgg16
from fastai.vgg.utils import get_batches

BATCH_SIZE = 64

DATA_ROOT = 'data'
TRAINING = os.path.join(DATA_ROOT, 'train')
VALIDATION = os.path.join(DATA_ROOT, 'valid')

vgg = Vgg16()

batches = get_batches(TRAINING, batch_size=BATCH_SIZE)
val_batches = get_batches(VALIDATION, batch_size=BATCH_SIZE*2)

vgg.fine_tune(batches)
vgg.fit(batches, val_batches, nb_epoch=1)
