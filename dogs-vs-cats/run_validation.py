import os

from fastai.vgg.vgg16 import Vgg16
from fastai.vgg.utils import get_batches

BATCH_SIZE = 64

DATA_ROOT = 'data'
TRAINING = os.path.join(DATA_ROOT, 'train')
VALIDATION = os.path.join(DATA_ROOT, 'valid')

MODELS_ROOT = 'models'
if not os.path.exists(MODELS_ROOT):
    os.makedirs(MODELS_ROOT)

vgg = Vgg16()

batches = get_batches(TRAINING, batch_size=BATCH_SIZE)
val_batches = get_batches(VALIDATION, batch_size=BATCH_SIZE*2)

vgg.fine_tune(batches)
vgg.fit(batches, val_batches, nb_epoch=1)
vgg.model.save_weights(os.path.join(MODELS_ROOT, 'ft1.h5'))


# A few correct labels at random
# A few incorrect labels at random
# The most correct labels of each class (ie those with highest probability that are correct)
# The most incorrect labels of each class (ie those with highest probability that are incorrect)
# The most uncertain labels (ie those with probability closest to 0.5).

