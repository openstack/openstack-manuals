Install and configure
~~~~~~~~~~~~~~~~~~~~~

This section describes how to install and configure the Telemetry
service, code-named ceilometer, on the controller node. The Telemetry
service collects measurements from most OpenStack services and
optionally triggers alarms.

Prerequisites
-------------

Before you install and configure the Telemetry service, you must
create a database, service credentials, and API endpoints. However,
unlike other services, the Telemetry service uses a NoSQL database.
See :ref:`environment-nosql-database` to install and configure
MongoDB before proceeding further.

#. Create the ``ceilometer`` database:

   .. code-block:: console

      # mongo --host controller --eval '
        db = db.getSiblingDB("ceilometer");
        db.createUser({user: "ceilometer",
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

   .. note::

      If the command fails saying you are not authorized to insert a user,
      you may need to temporarily comment out the ``auth`` option in
      the ``/etc/mongodb.conf`` file, restart the MongoDB service using
      ``systemctl restart mongodb``, and try calling the command again.

#. Source the ``admin`` credentials to gain access to admin-only
   CLI commands:

   .. code-block:: console

      $ . admin-openrc

#. To create the service credentials, complete these steps:

   * Create the ``ceilometer`` user:

     .. code-block:: console

        $ openstack user create --domain default --password-prompt ceilometer
        User Password:
        Repeat User Password:
        +-----------+----------------------------------+
        | Field     | Value                            |
        +-----------+----------------------------------+
        | domain_id | e0353a670a9e496da891347c589539e9 |
        | enabled   | True                             |
        | id        | c859c96f57bd4989a8ea1a0b1d8ff7cd |
        | name      | ceilometer                       |
        +-----------+----------------------------------+

   * Add the ``admin`` role to the ``ceilometer`` user.

     .. code-block:: console

        $ openstack role add --project service --user ceilometer admin

     .. note::

        This command provides no output.

   * Create the ``ceilometer`` service entity:

     .. code-block:: console

        $ openstack service create --name ceilometer \
          --description "Telemetry" metering
        +-------------+----------------------------------+
        | Field       | Value                            |
        +-------------+----------------------------------+
        | description | Telemetry                        |
        | enabled     | True                             |
        | id          | 5fb7fd1bb2954fddb378d4031c28c0e4 |
        | name        | ceilometer                       |
        | type        | metering                         |
        +-------------+----------------------------------+

#. Create the Telemetry service API endpoints:

   .. code-block:: console

      $ openstack endpoint create --region RegionOne \
        metering public http://controller:8777
      +--------------+----------------------------------+
      | Field        | Value                            |
      +--------------+----------------------------------+
      | enabled      | True                             |
      | id           | b808b67b848d443e9eaaa5e5d796970c |
      | interface    | public                           |
      | region       | RegionOne                        |
      | region_id    | RegionOne                        |
      | service_id   | 5fb7fd1bb2954fddb378d4031c28c0e4 |
      | service_name | ceilometer                       |
      | service_type | metering                         |
      | url          | http://controller:8777           |
      +--------------+----------------------------------+

      $ openstack endpoint create --region RegionOne \
        metering internal http://controller:8777
      +--------------+----------------------------------+
      | Field        | Value                            |
      +--------------+----------------------------------+
      | enabled      | True                             |
      | id           | c7009b1c2ee54b71b771fa3d0ae4f948 |
      | interface    | internal                         |
      | region       | RegionOne                        |
      | region_id    | RegionOne                        |
      | service_id   | 5fb7fd1bb2954fddb378d4031c28c0e4 |
      | service_name | ceilometer                       |
      | service_type | metering                         |
      | url          | http://controller:8777           |
      +--------------+----------------------------------+

      $ openstack endpoint create --region RegionOne \
        metering admin http://controller:8777
      +--------------+----------------------------------+
      | Field        | Value                            |
      +--------------+----------------------------------+
      | enabled      | True                             |
      | id           | b2c00566d0604551b5fe1540c699db3d |
      | interface    | admin                            |
      | region       | RegionOne                        |
      | region_id    | RegionOne                        |
      | service_id   | 5fb7fd1bb2954fddb378d4031c28c0e4 |
      | service_name | ceilometer                       |
      | service_type | metering                         |
      | url          | http://controller:8777           |
      +--------------+----------------------------------+

Install and configure components
--------------------------------

#. Install the packages:

   .. code-block:: console

      # apt-get install ceilometer-api ceilometer-collector \
        ceilometer-agent-central ceilometer-agent-notification
        python-ceilometerclient

      Respond to prompts for
      :doc:`Identity service credentials <debconf/debconf-keystone-authtoken>`,
      :doc:`service endpoint registration <debconf/debconf-api-endpoints>`,
      and :doc:`message broker credentials <debconf/debconf-rabbitmq>`.

#. Edit the ``/etc/ceilometer/ceilometer.conf`` file and complete
   the following actions:

   * In the ``[database]`` section, configure database access:

     .. code-block:: ini

        [database]
        ...
        connection = mongodb://ceilometer:CEILOMETER_DBPASS@controller:27017/ceilometer

     Replace ``CEILOMETER_DBPASS`` with the password you chose for the
     Telemetry service database. You must escape special characters such
     as ':', '/', '+', and '@' in the connection string in accordance
     with `RFC2396 <https://www.ietf.org/rfc/rfc2396.txt>`_.

   * In the ``[service_credentials]`` section, configure service credentials:

     .. code-block:: ini

        [service_credentials]
        ...
        os_auth_url = http://controller:5000/v2.0
        os_username = ceilometer
        os_tenant_name = service
        os_password = CEILOMETER_PASS
        interface = internalURL
        region_name = RegionOne

     Replace ``CEILOMETER_PASS`` with the password you chose for
     the ``ceilometer`` user in the Identity service.

Finalize installation
---------------------

#. Restart the Telemetry services:

   .. code-block:: console

      # service ceilometer-agent-central restart
      # service ceilometer-agent-notification restart
      # service ceilometer-api restart
      # service ceilometer-collector restart
