Enable Object Storage meters
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Telemetry uses a combination of polling and notifications to collect
Object Storage meters.

.. note::

   Your environment must include the Object Storage service.

Prerequisites
-------------

The Telemetry service requires access to the Object Storage service
using the ``ResellerAdmin`` role. Perform these steps on the controller
node.

#. Source the ``admin`` credentials to gain access to admin-only
   CLI commands.

   .. code-block:: console

      $ source admin-openrc.sh

#. Create the ``ResellerAdmin`` role:

   .. code-block:: console

      $ openstack role create ResellerAdmin
      +-------+----------------------------------+
      | Field | Value                            |
      +-------+----------------------------------+
      | id    | 462fa46c13fd4798a95a3bfbe27b5e54 |
      | name  | ResellerAdmin                    |
      +-------+----------------------------------+

#. Add the ``ResellerAdmin`` role to the ``ceilometer`` user:

   .. code-block:: console

      $ openstack role add --project service --user ceilometer ResellerAdmin

   .. note::

      This command provides no output.

Install components
------------------

* Install the packages:

  .. only:: ubuntu or debian

     .. code-block:: console

        # apt-get install python-ceilometermiddleware

  .. only:: rdo

     .. code-block:: console

        # yum install python-ceilometermiddleware

  .. only:: obs

     .. code-block:: console

        # zypper install python-ceilometermiddleware

Configure Object Storage to use Telemetry
-----------------------------------------

Perform these steps on the controller and any other nodes that
run the Object Storage proxy service.

* Edit the ``/etc/swift/proxy-server.conf`` file
  and complete the following actions:

  * In the ``[filter:keystoneauth]`` section, add the
    ``ResellerAdmin`` role:

    .. code-block:: ini

       [filter:keystoneauth]
       ...
       operator_roles = admin, user, ResellerAdmin

  * In the ``[pipeline:main]`` section, add ``ceilometer``:

    .. code-block:: ini

       [pipeline:main]
       pipeline = catch_errors gatekeeper healthcheck proxy-logging cache
       container_sync bulk ratelimit authtoken keystoneauth container-quotas
       account-quotas slo dlo versioned_writes proxy-logging ceilometer
       proxy-server

  * In the ``[filter:ceilometer]`` section, configure notifications:

    .. code-block:: ini

       [filter:ceilometer]
       paste.filter_factory = ceilometermiddleware.swift:filter_factory
       ...
       control_exchange = swift
       url = rabbit://openstack:RABBIT_PASS@controller:5672/
       driver = messagingv2
       topic = notifications
       log_level = WARN

    Replace ``RABBIT_PASS`` with the password you chose for the
    ``openstack`` account in ``RabbitMQ``.

Finalize installation
---------------------

.. only:: rdo or obs

   * Restart the Object Storage proxy service:

     .. code-block:: console

        # systemctl restart openstack-swift-proxy.service

.. only:: ubuntu

   * Restart the Object Storage proxy service:

     .. code-block:: console

        # service swift-proxy restart
