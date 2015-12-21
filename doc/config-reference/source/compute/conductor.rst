=========
Conductor
=========

The ``nova-conductor`` service enables OpenStack to function
without compute nodes accessing the database.
Conceptually, it implements a new layer on top of ``nova-compute``.
It should not be deployed on compute nodes, or else the security
benefits of removing database access from ``nova-compute`` are negated.
Just like other nova services such as ``nova-api`` or
``nova-scheduler``, it can be scaled horizontally.
You can run multiple instances of ``nova-conductor`` on
different machines as needed for scaling purposes.

The methods exposed by ``nova-conductor`` are relatively simple
methods used by ``nova-compute`` to offload its database operations.
Places where ``nova-compute`` previously performed database
access are now talking to ``nova-conductor``.
However, we have plans in the medium to long term to move more and more of
what is currently in ``nova-compute`` up to the ``nova-conductor`` layer.
The Compute service will start to look like a less intelligent
slave service to ``nova-conductor``.
The conductor service will implement long running complex operations,
ensuring forward progress and graceful error handling.
This will be especially beneficial for operations that cross multiple
compute nodes, such as migrations or resizes.

To customize the ``Conductor``, use the configuration option settings
documented in the table :ref:`nova-conductor`.
