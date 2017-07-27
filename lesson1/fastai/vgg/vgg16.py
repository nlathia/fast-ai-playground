from __future__ import division, print_function
import numpy as np

from keras.optimizers import Adam
from keras.layers.core import (
    Dense
)

from .network import create_network
from .utils import (
    get_classes,
    get_batches
)

from keras import backend as K
K.set_image_dim_ordering('th')


class Vgg16(object):
    """
    The VGG 16 Imagenet model
    """

    def __init__(self):
        self.model = create_network()
        self.classes = get_classes()

    def predict(self, imgs):
        """
        :param imgs: (ndarray) An array of N images (size: N x width x height x channels).
        :return:
            preds (np.array): Highest confidence value of the predictions for each image.
            idxs (np.ndarray): Class index of the predictions with the max confidence.
            classes (list): Class labels of the predictions with the max confidence.

        1. predict probability of each class for each image
        2. for each image get the index of the class with max probability
        3. get the values of the highest probability for each image
        4. get the label of the class with the highest probability for each image
        """
        all_preds = self.model.predict(imgs)
        idxs = np.argmax(all_preds, axis=1)
        preds = [all_preds[i, idxs[i]] for i in range(len(idxs))]
        classes = [self.classes[idx] for idx in idxs]
        return np.array(preds), idxs, classes

    def freeze_and_add_layer(self, num):
        """
        Replace the last layer of the model with a Dense (fully connected) layer of num neurons.
        Will also lock the weights of all layers except the new layer so that we only learn
        weights for the last layer in subsequent training.

        Args:
            num (int) : Number of neurons in the Dense layer
        """
        self.model.pop()
        for layer in self.model.layers:
            layer.trainable = False
        self.model.add(Dense(num, activation='softmax'))
        self.compile()

    def fine_tune(self, batches):
        """
        :param batches: A keras.preprocessing.image.ImageDataGenerator object.
        :return:

        Modifies the original VGG16 network architecture and updates self.classes for new training data.
        """
        self.freeze_and_add_layer(batches.nb_class)
        classes = list(iter(batches.class_indices))  # get a list of all the class labels
        
        # batches.class_indices is a dict with the class name as key and an index as value
        # eg. {'cats': 0, 'dogs': 1}

        # sort the class labels by index according to batches.class_indices and update model.classes
        for c in batches.class_indices:
            classes[batches.class_indices[c]] = c
        self.classes = classes

    def compile(self, lr=0.001):
        """
        Configures the model for training.
        See Keras documentation: https://keras.io/models/model/
        """
        self.model.compile(optimizer=Adam(lr=lr),
                           loss='categorical_crossentropy',
                           metrics=['accuracy'])

    def fit_data(self, trn, labels,  val, val_labels,  nb_epoch=1, batch_size=64):
        """
        Trains the model for a fixed number of epochs (iterations on a dataset).
        See Keras documentation: https://keras.io/models/model/
        """
        self.model.fit(trn,
                       labels,
                       nb_epoch=nb_epoch,
                       validation_data=(val, val_labels),
                       batch_size=batch_size)

    def fit(self, batches, val_batches, nb_epoch=1):
        """
        Fits the model on data yielded batch-by-batch by a Python generator.
        See Keras documentation: https://keras.io/models/model/
        """
        self.model.fit_generator(batches,
                                 samples_per_epoch=batches.nb_sample,
                                 nb_epoch=nb_epoch,
                                 validation_data=val_batches,
                                 nb_val_samples=val_batches.nb_sample)

    def test(self, path, batch_size=8):
        """
        :param path: (string) Path to the target directory. It should contain one subdirectory  per class.
        :param batch_size: The number of images to be considered in each batch.
        :return: test_batches, numpy array(s) of predictions for the test_batches.

        Predicts the classes using the trained model on data yielded batch-by-batch.
        """

        test_batches = get_batches(path,
                                   shuffle=False,
                                   batch_size=batch_size,
                                   class_mode=None)
        return test_batches, self.model.predict_generator(test_batches, test_batches.nb_sample)

