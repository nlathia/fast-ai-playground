from keras.utils.data_utils import get_file
from keras.preprocessing import image

import numpy as np
import json
import os

FILE_PATH = 'http://files.fast.ai/models/'
VGG_MEAN = np.array([123.68, 116.779, 103.939], dtype=np.float32).reshape((3, 1, 1))


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
                                   target_size=(224, 224),
                                   class_mode=class_mode,
                                   shuffle=shuffle,
                                   batch_size=batch_size)
