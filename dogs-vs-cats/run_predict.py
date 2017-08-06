import csv
import os

from fastai.vgg.vgg16 import Vgg16
from fastai.vgg.utils import (
    get_batches,
    get_images
)

BATCH_SIZE = 64
DATA_ROOT = 'data'
TRAINING = os.path.join(DATA_ROOT, 'train')
TEST = os.path.join(DATA_ROOT, 'test1')

vgg = Vgg16()

batches = get_batches(TRAINING, batch_size=BATCH_SIZE)
vgg.fine_tune(batches)

with open('submission.csv', 'w') as out:
    rows = csv.writer(out)
    rows.writerow(['id', 'label'])
    for image_id, image in get_images(TEST):
        _, class_labels, _ = vgg.predict([image])
        rows.writerow([image_id, class_labels[0]])
