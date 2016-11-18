=======
dnn-vnc
=======

Dockerfile for deep learning with `Keras`_, `Lasagne`_, `ml-pyxis`_, and
`scikit-image`_ using `VNC`_ (Virtual Network Computing).


Usage
=====

This Dockerfile should be built locally on the machine you want to run the
final image on. The Dockerfile uses the root version of ``dnn-basic`` as a
parent image. See the ``dnn-basic`` directory in this repository for information
on how to build that Dockerfile.

Àssuming an image of the root version of ``dnn-basic`` called
``dnn-basic-root:latest`` exists, then the following command can be used to
build an image from this Dockerfile:

.. code-block:: bash

  cd root
  docker build -t dnn-vnc[:tag] -f Dockerfile .

With the image built, ``nvidia-docker run`` can be used to create a Docker
container with access to your GPU devices - ``docker run`` can also be used but
is slightly more cumbersome. This Dockerfile inherits all features of
``dnn-basic``, such as Jupyter and Tensorboard. The setup of these features have
been omitted for brevity.

Issue the following command to correctly containerise the docker image:

.. code-block:: bash

  nvidia-docker run -p <VNC port>:5900 -d -it dnn-vnc[:tag]

The ``-d`` option detaches the container and ``-it`` ensures that the detached
container is correctly daemonized. A daemonized Docker container (``-d``) can
be run by issuing ``nvidia-docker attach`` like this:

.. code-block:: bash

  nvidia-docker attach <container id>

The Docker container ID can be found by running ``docker ps``.

With the container attached a VNC server can be started by running ``run_vnc``.
Be sure to note down the password generated and exported to ``$VNC_PASSWORD``.

To detach from a container without stopping it you can type the escape sequence
``Ctrl-p`` + ``Ctrl-q`` (see `Docker attach documentation`_).


-----------
VNC viewers
-----------

VNC viewers are used to connect to VNC servers. We recommend using one of the
following:

* `TightVNC`_
* `RealVNC`_

To connect to your VNC server, simply input the server IP address followed by
the user specified port that was set up when running the docker image, i.e.
``<VNC port>``.


--------------
Shared volumes
--------------

It is recommended to set up shared volumes with the local machine using the
``-v`` option, i.e. ``-v <local volume>:<container volume>``. The root user
comes with a ``/shared`` directory that can be used for this:

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

.. _scikit-image: http://scikit-image.org/
.. _Keras: https://github.com/fchollet/keras
.. _Lasagne: https://github.com/Lasagne/Lasagne
.. _ml-pyxis: https://github.com/vicolab/ml-pyxis
.. _VNC: https://en.wikipedia.org/wiki/Virtual_Network_Computing
.. _Docker attach documentation: https://docs.docker.com/engine/reference/commandline/attach/
.. _TightVNC: http://www.tightvnc.com/
.. _RealVNC: https://www.realvnc.com/download/viewer/
