=====================================
Install and configure controller node
=====================================

This section describes how to install and configure the Telemetry
service, code-named ceilometer, on the controller node. The Telemetry
service uses separate agents to collect measurements from each OpenStack
service in your environment.

To configure prerequisites
~~~~~~~~~~~~~~~~~~~~~~~~~~

Before you install and configure the Telemetry service, you must
create a database, service credentials, and API endpoints. However,
unlike other services, the Telemetry service uses a NoSQL database.
See :ref:`environment-nosql-database` to install and configure
MongoDB before proceeding further.

.. only:: obs or ubuntu

   1. Create the ``ceilometer`` database:

      .. code-block:: console

         # mongo --host controller --eval '
           db = db.getSiblingDB("ceilometer");
           db.addUser({user: "ceilometer",
           pwd: "CEILOMETER_DBPASS",
           roles: [ "readWrite", "dbAdmin" ]})'

         MongoDB shell version: 2.4.x
         connecting to: controller:27017/test
         {
          "user" : "ceilometer",
          "pwd" : "72f25aeee7ad4be52437d7cd3fc60f6f",
          "roles" : [
           "readWrite",
           "dbAdmin"
          ],
          "_id" : ObjectId("5489c22270d7fad1ba631dc3")
         }

      Replace ``CEILOMETER_DBPASS`` with a suitable password.

.. only:: rdo

   1. Create the ``ceilometer`` database:

      .. code-block:: console

         # mongo --host controller --eval '
           db = db.getSiblingDB("ceilometer");
           db.createUser({user: "ceilometer",
           pwd: "CEILOMETER_DBPASS",
           roles: [ "readWrite", "dbAdmin" ]})'

         MongoDB shell version: 2.6.x
         connecting to: controller:27017/test
         Successfully added user: { "user" : "ceilometer", "roles" : [ "readWrite", "dbAdmin" ] }

      Replace ``CEILOMETER_DBPASS`` with a suitable password.

2. Source the ``admin`` credentials to gain access to admin-only
   CLI commands:

   .. code-block:: console

      $ source admin-openrc.sh

3. To create the service credentials, complete these steps:

   * Create the ``ceilometer`` user:

     .. code-block:: console

        $ openstack user create --password-prompt ceilometer
        User Password:
        Repeat User Password:
        +----------+----------------------------------+
        | Field    | Value                            |
        +----------+----------------------------------+
        | email    | None                             |
        | enabled  | True                             |
        | id       | b7657c9ea07a4556aef5d34cf70713a3 |
        | name     | ceilometer                       |
        | username | ceilometer                       |
        +----------+----------------------------------+

   * Add the ``admin`` role to the ``ceilometer`` user.

     .. code-block:: console

        $ openstack role add --project service --user ceilometer admin
        +-------+----------------------------------+
        | Field | Value                            |
        +-------+----------------------------------+
        | id    | cd2cb9a39e874ea69e5d4b896eb16128 |
        | name  | admin                            |
        +-------+----------------------------------+

   * Create the ``ceilometer`` service entity:

     .. code-block:: console

        $ openstack service create --name ceilometer \
          --description "Telemetry" metering
        +-------------+----------------------------------+
        | Field       | Value                            |
        +-------------+----------------------------------+
        | description | Telemetry                        |
        | enabled     | True                             |
        | id          | 3405453b14da441ebb258edfeba96d83 |
        | name        | ceilometer                       |
        | type        | metering                         |
        +-------------+----------------------------------+

6. Create the Telemetry service API endpoint:

   .. code-block:: console

      $ openstack endpoint create --region RegionOne \
        metering public http://controller:8777
        +--------------+----------------------------------+
        | Field        | Value                            |
        +--------------+----------------------------------+
        | enabled      | True                             |
        | id           | 340be3625e9b4239a6415d034e98aace |
        | interface    | public                           |
        | region       | RegionOne                        |
        | region_id    | RegionOne                        |
        | service_id   | 8c2c7f1b9b5049ea9e63757b5533e6d2 |
        | service_name | celiometer                       |
        | service_type | metering                         |
        | url          | http://controller:8777           |
        +--------------+----------------------------------+

      $ openstack endpoint create --region RegionOne \
        metering internal http://controller:8777
        +--------------+----------------------------------+
        | Field        | Value                            |
        +--------------+----------------------------------+
        | enabled      | True                             |
        | id           | 340be3625e9b4239a6415d034e98aace |
        | interface    | internal                         |
        | region       | RegionOne                        |
        | region_id    | RegionOne                        |
        | service_id   | 8c2c7f1b9b5049ea9e63757b5533e6d2 |
        | service_name | celiometer                       |
        | service_type | metering                         |
        | url          | http://controller:8777           |
        +--------------+----------------------------------+

      $ openstack endpoint create --region RegionOne \
        metering admin http://controller:8777
        +--------------+----------------------------------+
        | Field        | Value                            |
        +--------------+----------------------------------+
        | enabled      | True                             |
        | id           | 340be3625e9b4239a6415d034e98aace |
        | interface    | admin                            |
        | region       | RegionOne                        |
        | region_id    | RegionOne                        |
        | service_id   | 8c2c7f1b9b5049ea9e63757b5533e6d2 |
        | service_name | celiometer                       |
        | service_type | metering                         |
        | url          | http://controller:8777           |
        +--------------+----------------------------------+

To install and configure the Telemetry service components
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. only:: obs

   #. Install the packages:

      .. code-block:: console

         # zypper install openstack-ceilometer-api \
           openstack-ceilometer-collector \
           openstack-ceilometer-agent-notification \
           openstack-ceilometer-agent-central python-ceilometerclient \
           openstack-ceilometer-alarm-evaluator \
           openstack-ceilometer-alarm-notifier

.. only:: rdo

   #. Install the packages:

      .. code-block:: console

         # yum install openstack-ceilometer-api \
           openstack-ceilometer-collector openstack-ceilometer-notification \
           openstack-ceilometer-central openstack-ceilometer-alarm \
           python-ceilometerclient

.. only:: ubuntu

   #. Install the packages:

      .. code-block:: console

         # apt-get install ceilometer-api ceilometer-collector \
           ceilometer-agent-central ceilometer-agent-notification \
           ceilometer-alarm-evaluator ceilometer-alarm-notifier \
           python-ceilometerclient

2. Generate a random value to use as the telemetry secret:

   .. code-block:: console

      $ openssl rand -hex 10

3. Edit the ``/etc/ceilometer/ceilometer.conf`` file and complete
   the following actions:

   * In the ``[database]`` section, configure database access:

     .. code-block:: ini

        [database]
        ...
        connection = mongodb://ceilometer:CEILOMETER_DBPASS@controller:27017/ceilometer

     Replace ``CEILOMETER_DBPASS`` with the password you chose for the
     Telemetry service database. You must escape special characters such
     as ':', '/', '+', and '@' in the connection string in accordance
     with RFC2396.

   * In the ``[DEFAULT]`` and ``[oslo_messaging_rabbit]`` sections,
     configure ``RabbitMQ`` message queue access:

     .. code-block:: ini

        [DEFAULT]
        ...
        rpc_backend = rabbit

        [oslo_messaging_rabbit]
        ...
        rabbit_host = controller
        rabbit_userid = openstack
        rabbit_password = RABBIT_PASS

     Replace ``RABBIT_PASS`` with the password you chose for the
     ``openstack`` account in ``RabbitMQ``.

   * In the ``[DEFAULT]`` and ``[keystone_authtoken]`` sections,
     configure Identity service access:

     .. code-block:: ini

        [DEFAULT]
        ...
        auth_strategy = keystone

        [keystone_authtoken]
        ...
        auth_uri = http://controller:5000/v2.0
        identity_uri = http://controller:35357
        admin_tenant_name = service
        admin_user = ceilometer
        admin_password = CEILOMETER_PASS

     Replace ``CEILOMETER_PASS`` with the password you chose for
     the ``ceilometer`` user in the Identity service.

     .. note::

        Comment out any ``auth_host``, ``auth_port``, and ``auth_protocol``
        options because the ``identity_uri`` option replaces them.

   * In the ``[service_credentials]`` section, configure service credentials:

     .. code-block:: ini

        [service_credentials]
        ...
        os_auth_url = http://controller:5000/v2.0
        os_username = ceilometer
        os_tenant_name = service
        os_password = CEILOMETER_PASS
        os_endpoint_type = internalURL
        os_region_name = RegionOne

     Replace ``CEILOMETER_PASS`` with the password you chose for
     the ``ceilometer`` user in the Identity service.

   * In the ``[publisher]`` section, configure the telemetry secret:

     .. code-block:: ini

        [publisher]
        ...
        telemetry_secret = TELEMETRY_SECRET

     Replace TELEMETRY_SECRET with the telemetry secret
     that you generated in a previous step.

   .. only:: obs

      * In the ``[collector]`` section, configure the dispatcher:

        .. code-block:: ini

           [collector]
           ...
           dispatcher = database

      * (Optional) To assist with troubleshooting, enable verbose
        logging in the ``[DEFAULT]`` section:

        .. code-block:: ini

           [DEFAULT]
           ...
           verbose = True

   .. only:: rdo or ubuntu

      * (Optional) To assist with troubleshooting, enable verbose
        logging in the ``[DEFAULT]`` section:

        .. code-block:: ini

           [DEFAULT]
           ...
           verbose = True

To finalize installation
~~~~~~~~~~~~~~~~~~~~~~~~
.. only:: obs

   #. Start the Telemetry services and configure them to start when the
      system boots:

      .. code-block:: console

         # systemctl enable openstack-ceilometer-api.service \
           openstack-ceilometer-agent-notification.service \
           openstack-ceilometer-agent-central.service \
           openstack-ceilometer-collector.service \
           openstack-ceilometer-alarm-evaluator.service \
           openstack-ceilometer-alarm-notifier.service
         # systemctl start openstack-ceilometer-api.service \
           openstack-ceilometer-agent-notification.service \
           openstack-ceilometer-agent-central.service \
           openstack-ceilometer-collector.service \
           openstack-ceilometer-alarm-evaluator.service \
           openstack-ceilometer-alarm-notifier.service

.. only:: rdo

   #. Start the Telemetry services and configure them to start when the
      system boots:

      .. code-block:: console

         # systemctl enable openstack-ceilometer-api.service \
           openstack-ceilometer-notification.service \
           openstack-ceilometer-central.service \
           openstack-ceilometer-collector.service \
           openstack-ceilometer-alarm-evaluator.service \
           openstack-ceilometer-alarm-notifier.service
         # systemctl start openstack-ceilometer-api.service \
           openstack-ceilometer-notification.service \
           openstack-ceilometer-central.service \
           openstack-ceilometer-collector.service \
           openstack-ceilometer-alarm-evaluator.service \
           openstack-ceilometer-alarm-notifier.service

.. only:: ubuntu

   #. Restart the Telemetry services:

      .. code-block:: console

         # service ceilometer-agent-central restart
         # service ceilometer-agent-notification restart
         # service ceilometer-api restart
         # service ceilometer-collector restart
         # service ceilometer-alarm-evaluator restart
         # service ceilometer-alarm-notifier restart
