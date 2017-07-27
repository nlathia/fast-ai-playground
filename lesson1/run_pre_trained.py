import os

from lesson1.fastai.vgg.vgg16 import Vgg16
from lesson1.fastai.vgg.utils import get_batches

BATCH_SIZE = 64

DATA_ROOT = 'data'
TRAINING = os.path.join(DATA_ROOT, 'train')
VALIDATION = os.path.join(DATA_ROOT, 'valid')

vgg = Vgg16()

batches = get_batches(TRAINING, batch_size=BATCH_SIZE)
vgg.fine_tune(batches)

val_batches = get_batches(VALIDATION, batch_size=BATCH_SIZE*2)
vgg.fit(batches, val_batches, nb_epoch=1)
