============
data-science
============

The Docker Compose configuration file in this directory provides a generic way
to set up the image ``aleksaro/data-science:latest`` (`source`_).

By default the configuration file will:

* run the terminal multiplexer Byobu on startup;
* make the GPU numbered ``0`` available inside the container;
* open up default ports for `Jupyter`_ (``8888``) and `TensorBoard`_ (``6006``);
* and set up a shared volume between ``~/shared`` in your ``$HOME`` directory
  and ``/root/shared`` inside the container.

Please alter the above and more to your liking!


.. Links

.. _source: https://github.com/aleksaro/dockerfiles/tree/master/data-science
.. _Jupyter: http://jupyter.org/
.. _TensorBoard: https://github.com/tensorflow/tensorboard
