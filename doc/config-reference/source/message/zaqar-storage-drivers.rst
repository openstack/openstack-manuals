=======================
Storage drivers options
=======================

Storage back ends
~~~~~~~~~~~~~~~~~

The Message service supports several different storage back ends (storage
drivers) for storing management information, messages and their metadata. The
recommended storage back end is MongoDB. For information on how to specify the
storage back ends, see :doc:`zaqar-drivers`.

When the storage back end is chosen, the corresponding back-end options become
active. For example, if Redis is chosen as the management storage back end, the
options in ``[drivers:management_store:redis]`` section become active.

Storage layer pipelines
~~~~~~~~~~~~~~~~~~~~~~~

A pipeline is a set of stages needed to process a request. When a new request
comes to the Message service, first it goes through the transport layer
pipeline and then through one of the storage layer pipelines depending on the
type of operation of each particular request. For example, if the Message
service receives a request to make a queue-related operation, the storage
layer pipeline will be ``queue pipeline``. The Message service always has the
actual storage controller as the final storage layer pipeline stage.

By setting the options in the ``[storage]`` section of ``zaqar.conf``,
you can add additional stages to these storage layer pipelines:

* **Claim pipeline**
* **Message pipeline** with built-in stage available to use:

  * ``zaqar.notification.notifier`` - sends notifications to the queue
    subscribers on each incoming message to the queue, in other words, enables
    notifications functionality.
* **Queue pipeline**
* **Subscription pipeline**

The storage layer pipelines options are empty by default, because additional
stages can affect the performance of the Message service. Depending on the
stages, the sequence in which the option values are listed does matter or not.

You can add external stages to the storage layer pipelines. For information how
to write and add your own external stages, see
`Writing stages for the storage pipelines
<https://docs.openstack.org/developer/zaqar/writing_pipeline_stages.html>`_
tutorial.

Options
~~~~~~~

The following tables detail the available options:

.. include:: ../tables/zaqar-storage.rst
.. include:: ../tables/zaqar-mongodb.rst
.. include:: ../tables/zaqar-redis.rst
.. include:: ../tables/zaqar-sqlalchemy.rst
.. include:: ../tables/zaqar-swift.rst

