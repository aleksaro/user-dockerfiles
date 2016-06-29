=========
dnn-basic
=========

Basic Dockerfile for deep learning with `Keras`_, `Lasagne`_, and `ml-pyxis`_
with `Jupyter`_. There are two different flavours to select from:

* ``root`` : the container will start as root
* ``user`` : the container will start as a user


Usage
=====

This Dockerfile should be built locally on the machine you want to run the
final image on. Use the following command to build an image from this
Dockerfile:

.. code-block:: bash

  docker build -t dnn-basic[:tag] -f ./Dockerfile .

With the image built, ``nvidia-docker run`` can be used to create a Docker
container with access to your GPU devices - ``docker run`` can also be used but
is slightly more cumbersome. A container with Jupyter and Tensorboard, with
HTTPS and password protection enabled for Jupyter, can be set up using this
command:

.. code-block:: bash

  nvidia-docker run -p <local>:8888 -p <local>:6006 -e "PASSWORD=<password>" -e "USE_HTTPS=1" -d -it dnn-basic[:tag]

The ``-d`` option detaches the container and ``-it`` ensures that the detached
container is correctly daemonized. 8888 and 6006 are the internal ports for
Jupyter and TensorBoard, respectively. Make sure to set your Jupyter notebook
password by modifying ``<password>``. HTTPS for Jupyter can be disabled by
removing ``-e "USE_HTTPS=1"``.

A daemonized Docker container (``-d``) can be run by issuing
``nvidia-docker attach`` like this:

.. code-block:: bash

  nvidia-docker attach <container id>

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

  nvidia-docker run -v <local volume>:/root/shared ...


-------------
GPU isolation
-------------

GPUs can be isolated by using the environment variable ``NV_GPU`` in front of
``nvidia-docker``. For example, the command below isolates GPU 3, 5, and 6 with
the Docker container:

.. code-block:: bash

  NV_GPU=3,5,6 nvidia-docker run ...

Use ``nvidia-smi`` to see your GPU device minor numbers.


.. Links

.. _Keras: https://github.com/fchollet/keras
.. _Lasagne: https://github.com/Lasagne/Lasagne
.. _ml-pyxis: https://github.com/vicolab/ml-pyxis
.. _Jupyter: http://jupyter.org/
.. _Docker attach documentation: https://docs.docker.com/engine/reference/commandline/attach/
