from keras.utils.data_utils import get_file
from keras.preprocessing import image

import numpy as np
import cv2
import json
import os

FILE_PATH = 'http://files.fast.ai/models/'
VGG_MEAN = np.array([123.68, 116.779, 103.939], dtype=np.float32).reshape((3, 1, 1))
CHANNELS = 3
ROWS = 224
COLS = 224


def get_classes():
    """
    Downloads the Imagenet classes index file and loads it to self.classes.
    The file is downloaded only if it not already in the cache.
    """
    file_name = 'imagenet_class_index.json'
    file_origin = os.path.join(FILE_PATH, file_name)
    file_path = get_file(file_name, file_origin, cache_subdir='models')
    with open(file_path) as f:
        class_dict = json.load(f)
    return [class_dict[str(i)][1] for i in range(len(class_dict))]


def get_batches(path, gen=image.ImageDataGenerator(), shuffle=True, batch_size=8, class_mode='categorical'):
    """
    Takes the path to a directory, and generates batches of augmented/normalized data.
    Yields batches indefinitely, in an infinite loop.

    See Keras documentation: https://keras.io/preprocessing/image/
    """
    return gen.flow_from_directory(path,
                                   target_size=(ROWS, COLS),
                                   class_mode=class_mode,
                                   shuffle=shuffle,
                                   batch_size=batch_size)


def get_images(path):

    def read_image(file_path):
        img = cv2.imread(file_path, cv2.IMREAD_COLOR)
        return cv2.resize(img, (ROWS, COLS), interpolation=cv2.INTER_CUBIC)

    image_files = [f for f in os.listdir(path) if '.jpg' in f]
    for image_file in image_files:
        image_id = image_file.split('.')[0]
        data = np.ndarray((1, CHANNELS, ROWS, COLS), dtype=np.uint8)
        data[0] = read_image(os.path.join(path, image_file)).T
        yield image_id, data
