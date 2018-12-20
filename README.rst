.. image:: https://img.shields.io/badge/license-MIT-blue.svg
    :target: https://github.com/aleksaro/user-dockerfiles/blob/master/LICENSE

================
user-dockerfiles
================

This repository contains a set of miscellaneous high-level Dockerfiles and
Docker Compose configuration files.


Docker Compose
==============

Installation instructions for Docker Compose can be found in the
`official documentation`_.

What is Docker Compose?

    Compose is a tool for defining and running multi-container Docker
    applications. With Compose, you use a YAML file to configure your
    application’s services. Then, with a single command, you create and start
    all the services from your configuration `[1]`_.

Docker Compose is used by following a three-step process:

1. define a Dockerfile;
2. create a configuration file named ``docker-compose.yml``;
3. and run the ``docker-compose up`` command in the directory of the YAML file.


Docker Compose configuration file
---------------------------------

*Important*: While the Compose file format have surpassed version ``3``, we are
currently required to use version ``2.3`` in order to gain access to the
``runtime`` configuration key (see `NVIDIA Docker FAQ`_).

In general, a Compose configuration file is a listing of named services, each
with their own set of configuration keys. Below is a typical configuration
file used by this repository:

.. code-block:: bash

  version: '2.3'

  services:
    myservice:
      image: myimage
      command: ["/bin/bash"]
      environment:
        - NVIDIA_VISIBLE_DEVICES=0
      ports:
        - "<local port>:<container port>"
      restart: always
      runtime: nvidia
      stdin_open: true
      tty: true
      volumes:
        - "<local volume>:<container volume>"

The list if services is found under the top-level key ``services``; here we have
a single service called ``myservice``. Inside the individual service,
configuration keys are used to define what a service is. Here is an
explanation of the keys we have used:

* ``image`` : name of the Docker image that should run for this service.
* ``command`` : startup command. Here, the Unix shell Bash will run.
* ``environment`` : a list of environment variables. ``NVIDIA_VISIBLE_DEVICES``
  is used to isolate GPUs with the help of GPU device minor numbers. In our
  case the GPU numbered 0 will be made available in the Docker container formed
  by this service.
* ``ports`` : a list of exposed ports.
* ``restart`` : restart policy, where ``no`` is the default policy. ``always``
  ensures that Compose *always* attempts to restart the service(s), for example,
  after a reboot. Please refer to the `restart documentation`_.
* ``runtime`` : key available in version ``2.3`` that enables us to specify the
  NVIDIA runtime.
* ``stdin_open`` and ``tty``: must be set to ``true`` to use an interactive
  shell (similar to ``-it`` with ``docker run``).
* ``volumes`` : a list of shared volumes.

Do note that Compose YAML files can either have the ``.yml`` or ``.yaml``
extension.


Running Docker Compose
----------------------

With a ``docker-compose.yml`` file ready, Docker Compose can be run using the
``docker-compose up`` command in the directory of the configuration file.

In many situations it is useful to run the ``docker-compose up`` command in
"detached" mode with the ``-d`` option, so that the services are correctly
daemonized.

A daemonized Docker container (``-d``) can be accessed by issuing
``docker attach`` like so:

.. code-block:: bash

  docker attach <container id>

The Docker container ID can be found by running ``docker ps`` or
``docker-compose ps``.

To detach from a container without stopping it you can type the escape sequence
``Ctrl-p`` + ``Ctrl-q`` (see `Docker attach documentation`_).

Running containers can be stopped without removal by running
``docker-compose stop [SERVICE...]``, and stopped containers can be started by
running ``docker-compose start [SERVICE...]`` (see `stop documentation`_).

Stopping containers and removing containers, networks, volumes, and images
created by ``docker-compose up`` can be done by running ``docker-compose down``
(see `down documentation`_).

See the `full list of command-line references`_ for more information.

.. Links

.. _official documentation: https://docs.docker.com/compose/
.. _[1]: https://docs.docker.com/compose/overview/
.. _NVIDIA Docker FAQ: https://github.com/NVIDIA/nvidia-docker/wiki/Frequently-Asked-Questions#do-you-support-docker-compose
.. _restart documentation: https://docs.docker.com/compose/compose-file/#restart
.. _Docker attach documentation: https://docs.docker.com/engine/reference/commandline/attach/
.. _stop documentation: https://docs.docker.com/compose/reference/stop/
.. _down documentation: https://docs.docker.com/compose/reference/down/
.. _full list of command-line references: https://docs.docker.com/compose/reference/
