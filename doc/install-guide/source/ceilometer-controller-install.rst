=====================================
Install and configure controller node
=====================================

This section describes how to install and configure the Telemetry
module, code-named ceilometer, on the controller node. The Telemetry
module uses separate agents to collect measurements from each OpenStack
service in your environment.

To configure prerequisites
~~~~~~~~~~~~~~~~~~~~~~~~~~

Before you install and configure Telemetry, you must install ``MongoDB``,
create a MongoDB database, service credentials, and API endpoint.

.. only:: obs

   1. Enable the Open Build Service repositories for MongoDB based on
      your openSUSE or SLES version:

      On openSUSE:

      .. code-block:: console

         # zypper addrepo -f obs://server:database/openSUSE_13.2 Database

      On SLES:

      .. code-block:: console

         # zypper addrepo -f obs://server:database/SLE_12 Database

      .. note::

         The packages are signed by GPG key ``562111AC05905EA8``.
         You should verify the fingerprint of the imported GPG key before
         using it.

         ::

            Key Name: server:database OBS Project &lt;server:database@build.opensuse.org&gt;
            Key Fingerprint: 116EB86331583E47E63CDF4D562111AC05905EA8
            Key Created: Thu Oct 11 20:08:39 2012
            Key Expires: Sat Dec 20 20:08:39 2014

      Install the MongoDB package:

      .. code-block:: console

         # zypper install mongodb

.. only:: rdo

   1. Install the MongoDB package:

      .. code-block:: console

         # yum install mongodb-server mongodb

.. only:: ubuntu

   1. Install the MongoDB package:

      .. code-block:: console

         # apt-get install mongodb-server mongodb-clients python-pymongo

.. only:: obs

   2. Edit the :file:`/etc/mongodb.conf` file and complete the following
      actions:

      a. Configure the ``bind_ip`` key to use the management interface
         IP address of the controller node.

         .. code-block:: ini
            :linenos:

            bind_ip = 10.0.0.11

      b. By default, MongoDB creates several 1 GB journal files
         in the :file:`/var/lib/mongodb/journal` directory.
         If you want to reduce the size of each journal file to
         128 MB and limit total journal space consumption to 512 MB,
         assert the ``smallfiles`` key:

         .. code-block:: ini
            :linenos:

            smallfiles = true

         You can also disable journaling. For more information, see the
         `MongoDB manual <http://docs.mongodb.org/manual/>`__.

      c. Start the MongoDB services and configure them to start when
         the system boots:

         .. code-block:: console

            # systemctl enable mongodb.service
            # systemctl start mongodb.service

.. only:: rdo

   .. The use of mongod, and not mongodb, in the below screen is intentional.

   2. Edit the :file:`/etc/mongod.conf` file and complete the following
      actions:

      a. Configure the ``bind_ip`` key to use the management interface
         IP address of the controller node.

         .. code-block:: ini
            :linenos:

            bind_ip = 10.0.0.11

      b. By default, MongoDB creates several 1 GB journal files
         in the :file:`/var/lib/mongodb/journal` directory.
         If you want to reduce the size of each journal file to
         128 MB and limit total journal space consumption to 512 MB,
         assert the ``smallfiles`` key:

         .. code-block:: ini
            :linenos:

            smallfiles = true

         You can also disable journaling. For more information, see the
         `MongoDB manual <http://docs.mongodb.org/manual/>`__.

      c. Start the MongoDB services and configure them to start when
         the system boots:

         .. code-block:: console

            # systemctl enable mongod.service
            # systemctl start mongod.service

.. only:: ubuntu

   2. Edit the :file:`/etc/mongodb.conf` file and complete the following
      actions:

      a. Configure the ``bind_ip`` key to use the management interface
         IP address of the controller node.

         .. code-block:: ini
            :linenos:

            bind_ip = 10.0.0.11

      b. By default, MongoDB creates several 1 GB journal files
         in the :file:`/var/lib/mongodb/journal` directory.
         If you want to reduce the size of each journal file to
         128 MB and limit total journal space consumption to 512 MB,
         assert the ``smallfiles`` key:

         .. code-block:: ini
            :linenos:

            smallfiles = true

         If you change the journaling configuration, stop the MongoDB
         service, remove the initial journal files, and start the service:

         .. code-block:: console

            # service mongodb stop
            # rm /var/lib/mongodb/journal/prealloc.*
            # service mongodb start

         You can also disable journaling. For more information, see the
         `MongoDB manual <http://docs.mongodb.org/manual/>`__.

.. only:: obs or ubuntu

   3. Create the ``ceilometer`` database:

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

   3. Create the ``ceilometer`` database:

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


4. Source the ``admin`` credentials to gain access to admin-only
   CLI commands:

   .. code-block:: console

      $ source admin-openrc.sh

5. To create the service credentials, complete these steps:

   a. Create the ``ceilometer`` user:

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

   b. Add the ``admin`` role to the ``ceilometer`` user.

      .. code-block:: console

         $ openstack role add --project service --user ceilometer admin
         +-------+----------------------------------+
         | Field | Value                            |
         +-------+----------------------------------+
         | id    | cd2cb9a39e874ea69e5d4b896eb16128 |
         | name  | admin                            |
         +-------+----------------------------------+

   c. Create the ``ceilometer`` service entity:

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

6. Create the Telemetry module API endpoint:

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

To install and configure the Telemetry module components
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. only:: obs

   1. Install the packages:

      .. code-block:: console

         # zypper install openstack-ceilometer-api \
           openstack-ceilometer-collector \
           openstack-ceilometer-agent-notification \
           openstack-ceilometer-agent-central python-ceilometerclient \
           openstack-ceilometer-alarm-evaluator \
           openstack-ceilometer-alarm-notifier

.. only:: rdo

   1. Install the packages:

      .. code-block:: console

         # yum install openstack-ceilometer-api \
           openstack-ceilometer-collector openstack-ceilometer-notification \
           openstack-ceilometer-central openstack-ceilometer-alarm \
           python-ceilometerclient

.. only:: ubuntu

   1. Install the packages:

      .. code-block:: console

         # apt-get install ceilometer-api ceilometer-collector \
           ceilometer-agent-central ceilometer-agent-notification \
           ceilometer-alarm-evaluator ceilometer-alarm-notifier \
           python-ceilometerclient

2. Generate a random value to use as the telemetry secret:

   .. code-block:: console

      $ openssl rand -hex 10

3. Edit the :file:`/etc/ceilometer/ceilometer.conf` file and complete
   the following actions:

   a. In the ``[database]`` section, configure database access:

      .. code-block:: ini
         :linenos:

         [database]
         ...
         connection = mongodb://ceilometer:CEILOMETER_DBPASS@controller:27017/ceilometer

      Replace ``CEILOMETER_DBPASS`` with the password you chose for the
      Telemetry module database. You must escape special characters such
      as ':', '/', '+', and '@' in the connection string in accordance
      with RFC2396.

   b. In the ``[DEFAULT]`` and ``[oslo_messaging_rabbit]`` sections,
      configure ``RabbitMQ`` message queue access:

      .. code-block:: ini
         :linenos:

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

   c. In the ``[DEFAULT]`` and ``[keystone_authtoken]`` sections,
      configure Identity service access:

      .. code-block:: ini
         :linenos:

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

   d. In the ``[service_credentials]`` section, configure service credentials:

      .. code-block:: ini
         :linenos:

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

   e. In the ``[publisher]`` section, configure the telemetry secret:

      .. code-block:: ini
         :linenos:

         [publisher]
         ...
         telemetry_secret = TELEMETRY_SECRET

      Replace TELEMETRY_SECRET with the telemetry secret
      that you generated in a previous step.

   .. only:: obs

      f. In the ``[collector]`` section, configure the dispatcher:

         .. code-block:: ini
            :linenos:

            [collector]
            ...
            dispatcher = database

      g. (Optional) To assist with troubleshooting, enable verbose
         logging in the ``[DEFAULT]`` section:

         .. code-block:: ini
            :linenos:

            [DEFAULT]
            ...
            verbose = True

   .. only:: rdo or ubuntu

      f. (Optional) To assist with troubleshooting, enable verbose
         logging in the ``[DEFAULT]`` section:

         .. code-block:: ini
            :linenos:

            [DEFAULT]
            ...
            verbose = True

To finalize installation
~~~~~~~~~~~~~~~~~~~~~~~~
.. only:: obs

   1. Start the Telemetry services and configure them to start when the
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

   1. Start the Telemetry services and configure them to start when the
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

   1. Restart the Telemetry services:

      .. code-block:: console

         # service ceilometer-agent-central restart
         # service ceilometer-agent-notification restart
         # service ceilometer-api restart
         # service ceilometer-collector restart
         # service ceilometer-alarm-evaluator restart
         # service ceilometer-alarm-notifier restart
