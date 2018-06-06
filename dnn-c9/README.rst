======
dnn-c9
======

Dockerfile for deep learning with `Cloud9`_.


Usage
=====

This Dockerfile should be built locally on the machine you want to run the
final image on. The Dockerfile uses the root version of ``dnn-basic`` as a
parent image. See the ``dnn-basic`` directory in this repository for information
on how to build that Dockerfile.

Assuming an image of the root version of ``dnn-basic`` called
``dnn-basic-root:latest`` exists, then the following command can be used to
build an image from this Dockerfile:

.. code-block:: bash

  cd root
  docker build -t dnn-c9[:tag] -f Dockerfile .

With the image built, `nvidia-docker`_ can be used to create a Docker
container with access to your GPU devices. This Dockerfile inherits all
features of ``dnn-basic``, such as Jupyter and Tensorboard. The setup of these
features have been omitted for brevity.

Issue the following command to correctly containerise the docker image:

.. code-block:: bash

  docker run --runtime=nvidia -p <Cloud9 port>:8181 -d -it dnn-c9[:tag]

The ``-d`` option detaches the container and ``-it`` ensures that the detached
container is correctly daemonized. A daemonized Docker container (``-d``) can
be run by issuing ``docker attach`` like this:

.. code-block:: bash

  docker attach <container id>

The Docker container ID can be found by running ``docker ps``.

With the container attached Cloud9 can be started by running the following
command:

.. code-block:: bash

  run_c9 --auth <username>:<password> -w /root/shared/

The ``--auth`` option is required and will let you set up a username and
password for logging in to the Cloud9 server. The ``-w`` is the location of
the workspace directory inside the docker environment. We recommend to let this
be one of your shared container volumes so that you can edit files on your local
machine.

To detach from a container without stopping it you can type the escape sequence
``Ctrl-p`` + ``Ctrl-q`` (see `Docker attach documentation`_).


--------------
Shared volumes
--------------

It is recommended to set up shared volumes with the local machine using the
``-v`` option, i.e. ``-v <local volume>:<container volume>``. The root user
comes with a ``/shared`` directory that can be used for this:

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

.. _Cloud9: https://github.com/c9/core
.. nvidia-docker: https://github.com/NVIDIA/nvidia-docker
