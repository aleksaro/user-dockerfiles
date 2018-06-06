=========
dnn-basic
=========

Basic Dockerfile for deep learning with `Keras`_, `PyTorch`_, `ml-pyxis`_, and
`scikit-image`_ with `Jupyter`_. There are two different flavours to select
from:

* ``root`` : the container will start as root
* ``user`` : the container will start as a user


Usage
=====

This Dockerfile should be built locally on the machine you want to run the
final image on. Use the following command to build an image from this
Dockerfile:

.. code-block:: bash

  cd <root/user>
  docker build -t dnn-basic[:tag] -f Dockerfile .

With the image built, `nvidia-docker`_ can be used to create a Docker
container with access to your GPU devices. A container with Jupyter and
Tensorboard, with HTTPS enabled for Jupyter, can be set up using this command:

.. code-block:: bash

  docker run --runtime=nvidia -p <local>:8888 -p <local>:6006 -e "USE_HTTPS=1" -d -it dnn-basic[:tag]

The ``-d`` option detaches the container and ``-it`` ensures that the detached
container is correctly daemonized. 8888 and 6006 are the internal ports for
Jupyter and TensorBoard, respectively. HTTPS for Jupyter can be disabled by
removing ``-e "USE_HTTPS=1"``.

A daemonized Docker container (``-d``) can be run by issuing
``docker attach`` like this:

.. code-block:: bash

  docker attach <container id>

The Docker container ID can be found by running ``docker ps``.

To detach from a container without stopping it you can type the escape sequence
``Ctrl-p`` + ``Ctrl-q`` (see `Docker attach documentation`_).


--------------
Shared volumes
--------------

It is recommended to set up shared volumes with the local machine using the
``-v`` option, i.e. ``-v <local volume>:<container volume>``. Both the ``root``
and ``user`` version of ``dnn-basic`` comes with a ``/shared`` directory that
can be used for this, e.g. for ``root``:

.. code-block:: bash

  docker run -v <local volume>:/root/shared ...


-------------
GPU isolation
-------------

GPUs can be isolated by using the environment variable
``NVIDIA_VISIBLE_DEVICES`` when executing the ``run`` command. For example, the
command below isolates GPU 3, 5, and 6 with the Docker container:

.. code-block:: bash

  docker run  --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=3,5,6 ...

Use ``nvidia-smi`` to see your GPU device minor numbers.


.. Links

.. _scikit-image: http://scikit-image.org/
.. _Keras: https://github.com/fchollet/keras
.. _PyTorch: http://pytorch.org/
.. _ml-pyxis: https://github.com/vicolab/ml-pyxis
.. _Jupyter: http://jupyter.org/
.. _Docker attach documentation: https://docs.docker.com/engine/reference/commandline/attach/
.. nvidia-docker: https://github.com/NVIDIA/nvidia-docker
