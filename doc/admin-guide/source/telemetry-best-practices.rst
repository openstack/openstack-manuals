Telemetry best practices
~~~~~~~~~~~~~~~~~~~~~~~~

The following are some suggested best practices to follow when deploying
and configuring the Telemetry service. The best practices are divided
into data collection and storage.

Data collection
---------------

#. The Telemetry service collects a continuously growing set of data. Not
   all the data will be relevant for an administrator to monitor.

   -  Based on your needs, you can edit the ``pipeline.yaml`` configuration
      file to include a selected number of meters while disregarding the
      rest.

   -  By default, Telemetry service polls the service APIs every 10
      minutes. You can change the polling interval on a per meter basis by
      editing the ``pipeline.yaml`` configuration file.

      .. warning::

         If the polling interval is too short, it will likely cause
         increase of stored data and the stress on the service APIs.

   -  Expand the configuration to have greater control over different meter
      intervals.

      .. note::

         For more information, see the
         :ref:`telemetry-pipeline-configuration`.

#. If you are using the Kilo version of Telemetry, you can delay or adjust
   polling requests by enabling the jitter support. This adds a random
   delay on how the polling agents send requests to the service APIs. To
   enable jitter, set ``shuffle_time_before_polling_task`` in the
   ``ceilometer.conf`` configuration file to an integer greater
   than 0.

#. If you are using Juno or later releases, based on the number of
   resources that will be polled, you can add additional central and
   compute agents as necessary. The agents are designed to scale
   horizontally.

   .. note::

      For more information see, :ref:`ha-deploy-services`.

#. If you are using Juno or later releases, use the ``notifier://``
   publisher rather than ``rpc://`` as there is a certain level of overhead
   that comes with RPC.

   .. note::

      For more information on RPC overhead, see `RPC overhead
      info <https://www.rabbitmq.com/tutorials/tutorial-six-python.html>`__.


Data storage
------------

#. We recommend that you avoid open-ended queries. In order to get better
   performance you can use reasonable time ranges and/or other query
   constraints for retrieving measurements.

   For example, this open-ended query might return an unpredictable amount
   of data:

   .. code-block:: console

      $ ceilometer sample-list --meter cpu -q 'resource_id=INSTANCE_ID_1'

   Whereas, this well-formed query returns a more reasonable amount of
   data, hence better performance:

   .. code-block:: console

      $ ceilometer sample-list --meter cpu -q 'resource_id=INSTANCE_ID_1;timestamp > 2015-05-01T00:00:00;timestamp < 2015-06-01T00:00:00'

   .. note::

      As of the Liberty release, the number of items returned will be
      restricted to the value defined by ``default_api_return_limit`` in the
      ``ceilometer.conf`` configuration file. Alternatively, the value can
      be set per query by passing ``limit`` option in request.

#. You can install the API behind ``mod_wsgi``, as it provides more
   settings to tweak, like ``threads`` and ``processes`` in case of
   ``WSGIDaemon``.

   .. note::

      For more information on how to configure ``mod_wsgi``, see the
      `Telemetry Install Documentation
      <https://docs.openstack.org/developer/ceilometer/install/mod_wsgi.html>`__.

#. The collection service provided by the Telemetry project is not intended
   to be an archival service. Set a Time to Live (TTL) value to expire data
   and minimize the database size. If you would like to keep your data for
   longer time period, you may consider storing it in a data warehouse
   outside of Telemetry.

   .. note::

      For more information on how to set the TTL, see
      :ref:`telemetry-storing-samples`.

#. We recommend that you do not use SQLAlchemy back end prior to the Juno
   release, as it previously contained extraneous relationships to handle
   deprecated data models. This resulted in extremely poor query
   performance.

#. We recommend that you do not run MongoDB on the same node as the
   controller. Keep it on a separate node optimized for fast storage for
   better performance. Also it is advisable for the MongoDB node to have a
   lot of memory.

   .. note::

      For more information on how much memory you need, see `MongoDB
      FAQ <http://docs.mongodb.org/manual/faq/diagnostics/#how-do-i-calculate-how-much-ram-i-need-for-my-application>`__.

#. Use replica sets in MongoDB. Replica sets provide high availability
   through automatic failover. If your primary node fails, MongoDB will
   elect a secondary node to replace the primary node, and your cluster
   will remain functional.

   For more information on replica sets, see the `MongoDB replica sets
   docs <http://docs.mongodb.org/manual/tutorial/deploy-replica-set/>`__.

#. Use sharding in MongoDB. Sharding helps in storing data records across
   multiple machines and is the MongoDB’s approach to meet the demands of
   data growth.

   For more information on sharding, see the `MongoDB sharding
   docs <http://docs.mongodb.org/manual/sharding/>`__.
