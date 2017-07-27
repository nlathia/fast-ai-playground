import os

from keras.utils.data_utils import get_file
from keras.models import Sequential
from keras.layers.convolutional import (
    Convolution2D,
    MaxPooling2D,
    ZeroPadding2D
)
from keras.layers.core import (
    Flatten,
    Dense,
    Dropout,
    Lambda
)

from .utils import (
    FILE_PATH,
    VGG_MEAN
)


def _vgg_preprocess(x):
    """
    :param x: Image array (height x width x channels)
    :return: Image array (height x width x transposed_channels)

    Subtracts the mean RGB value, and transposes RGB to BGR.
    The mean RGB was computed on the image set used to train the VGG model.
    """
    x = x - VGG_MEAN
    return x[:, ::-1]  # reverse axis rgb->bgr


def _add_conv_block(m, layers, filters):
    """
    :param m: The model
    :param layers: The number of zero padded convolution layers to be added to the model.
    :param filters: The number of convolution filters to be created for each layer.
    :return:

    Adds a specified number of ZeroPadding and Convolution layers
    to the model, and a MaxPooling layer at the very end.
    """
    for i in range(layers):
        m.add(ZeroPadding2D((1, 1)))
        m.add(Convolution2D(filters, 3, 3, activation='relu'))
    m.add(MaxPooling2D((2, 2), strides=(2, 2)))
    return m


def _add_fc_block(m):
    """
    :param m: The model
    :return:

    Adds a fully connected layer of 4096 neurons to the model with a Dropout of 0.5
    """
    m.add(Dense(4096, activation='relu'))
    m.add(Dropout(0.5))
    return m


def _load_weights_to(m):
    """
    :param m: The VGG16 network
    :return: Loads the pre-trained weights
    """
    file_name = 'vgg16.h5'
    file_origin = os.path.join(FILE_PATH, file_name)
    m.load_weights(get_file(file_name, file_origin, cache_subdir='models'))
    return m


def create_network():
    """
    :return:

    Creates the VGG16 network architecture.
    """
    model = Sequential()
    model.add(Lambda(_vgg_preprocess,
                     input_shape=(3, 224, 224),
                     output_shape=(3, 224, 224)))
    model = _add_conv_block(model, 2, 64)
    model = _add_conv_block(model, 2, 128)
    model = _add_conv_block(model, 3, 256)
    model = _add_conv_block(model, 3, 512)
    model = _add_conv_block(model, 3, 512)

    model.add(Flatten())
    model = _add_fc_block(model)
    model = _add_fc_block(model)
    model.add(Dense(1000, activation='softmax'))
    return _load_weights_to(model)
