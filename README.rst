================
user-dockerfiles
================


This repository contains a set of miscellaneous high-level Dockerfiles.

* dnn-basic : basic Dockerfile for deep learning with Keras and PyTorch with Jupyter.
* dnn-vnc: extension of ``dnn-basic`` with VNC (Virtual Network Computing) capabilities.


Useful links
============

* `Docker Docs`_
* `NVIDIA Docker wiki`_
* `Docker shared volumes`_


Acknowledgements
================

Parts of the code is borrowed from the following repositories:

* `Jupyter dockerstacks`_ : see ``/base-notebook``
* `TensorFlow`_ : see ``/tensorflow/tools/docker``

A copy of the relevant licenses can be found in the ``/3rd-part-licenses``
directory.


.. Links

.. _Docker Docs: https://docs.docker.com/
.. _NVIDIA Docker wiki: https://github.com/NVIDIA/nvidia-docker/wiki
.. _Docker shared volumes: https://docs.docker.com/engine/tutorials/dockervolumes/
.. _Jupyter dockerstacks: https://github.com/jupyter/docker-stacks
.. _TensorFlow: https://github.com/tensorflow/tensorflow
