==================
Clustering service
==================

The Clustering service implements clustering services and libraries for
managing groups of homogeneous objects exposed by other OpenStack services.
The configuration file for this service is ``/etc/senlin/senlin.conf``.

.. note::

   The common configurations for shared services and libraries,
   such as database connections and RPC messaging,
   are described at :doc:`common-configurations`.

The following tables provide a comprehensive list of the Clustering
service configuration options.

.. include:: tables/senlin-amqp.rst
.. include:: tables/senlin-api.rst
.. include:: tables/senlin-auth_token.rst
.. include:: tables/senlin-common.rst
.. include:: tables/senlin-cors.rst
.. include:: tables/senlin-database.rst
.. include:: tables/senlin-logging.rst
.. include:: tables/senlin-rabbitmq.rst
.. include:: tables/senlin-redis.rst
.. include:: tables/senlin-rpc.rst
.. include:: tables/senlin-zeromq.rst
