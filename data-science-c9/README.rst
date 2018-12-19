===============
data-science-c9
===============

The Docker Compose configuration file in this directory provides a generic way
to set up the image ``aleksaro/data-science-c9:latest`` (`source`_).

By default the configuration file will:

* run the terminal multiplexer Byobu on startup;
* make the GPU numbered ``0`` available inside the container;
* open up default ports for `Jupyter`_ (``8888``), `TensorBoard`_ (``6006``),
  and `Cloud9`_ (``8080``);
* and set up a shared volume between ``~/shared`` in your ``$HOME`` directory
  and ``/root/shared`` inside the container.

Please alter the above and more to your liking!

`Cloud9`_ can be started by issuing the command ``runc9``. This is simply an
alias for the following:

.. code-block:: bash

  nodejs c9/server.js --port 8080 --listen 0.0.0.0

Example usage of ``runc9``:

.. code-block:: bash

  runc9 --auth <username>:<password> -w /root/shared/

The ``--auth`` option is required and will let you set up a username and
password for logging in to the Cloud9 server. The ``-w`` is the location of
the workspace directory inside the docker environment. We recommend to let this
be one of your shared container volumes so that you can edit files on your local
machine.


.. Links

.. _source: https://github.com/aleksaro/dockerfiles/tree/master/data-science-cloud9
.. _Jupyter: http://jupyter.org/
.. _TensorBoard: https://github.com/tensorflow/tensorboard
.. _Cloud9: https://github.com/c9/core
