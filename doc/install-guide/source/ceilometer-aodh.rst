.. _aodh-install:

==========================================
Install and configure the alarming service
==========================================

The Telemetry module contains a stand-alone alarming service,
code-named Aodh. This chapter guides you through the installation
steps of this alarm management module that will work together with
the other services of Telemetry.

.. only:: ubuntu

   .. warning::

      In the Liberty release of OpenStack, the services of the new Telemetry
      Alarming module are not officially supported on Ubuntu-based
      deployments.

Configure prerequisites
~~~~~~~~~~~~~~~~~~~~~~~

The alarming service requires database access to store alarm definitions and
history. You must install a database back end and create a database
for Aodh. You also need to create service credentials, and API endpoint. If
you already installed a database back end for the base services of the
Telemetry module, you can choose to use that for the alarming service also.
If you need to install a back end, see :ref:`environment-nosql-database` to
install and configure MongoDB before proceeding further.

.. only:: ubuntu

   #. Create the ``aodh`` database:

      .. code-block:: console

         # mongo --host controller --eval '
           db = db.getSiblingDB("aodh");
           db.addUser({user: "aodh",
           pwd: "AODH_DBPASS",
           roles: [ "readWrite", "dbAdmin" ]})'

         MongoDB shell version: 2.4.x
         connecting to: controller:27017/test
         {
          "user" : "aodh",
          "pwd" : "72f25aeee7ad4be52437d7cd3fc60f6f",
          "roles" : [
           "readWrite",
           "dbAdmin"
          ],
          "_id" : ObjectId("5489c22270d7fad1ba631dc3")
         }


      Replace ``AODH_DBPASS`` with a suitable password.

.. only:: rdo

   #. Create the ``aodh`` database:

      .. code-block:: console

         # mongo --host controller --eval '
           db = db.getSiblingDB("aodh");
           db.createUser({user: "aodh",
           pwd: "AODH_DBPASS",
           roles: [ "readWrite", "dbAdmin" ]})'

         MongoDB shell version: 2.6.x
         connecting to: controller:27017/test
         Successfully added user: { "user" : "aodh", "roles" : [ "readWrite", "dbAdmin" ] }

      Replace ``AODH_DBPASS`` with a suitable password.


#. Source the ``admin`` credentials to gain access to admin-only
   CLI commands:

   .. code-block:: console

      $ source admin-openrc.sh

#. Create the service credentials:

   * Create the ``aodh`` user:

      .. code-block:: console

         $ openstack user create --password-prompt aodh
         User Password:
         Repeat User Password:
         +----------+----------------------------------+
         | Field    | Value                            |
         +----------+----------------------------------+
         | email    | None                             |
         | enabled  | True                             |
         | id       | b7657c9ea07a4556aef5d34cf70713a3 |
         | name     | aodh                             |
         | username | aodh                             |
         +----------+----------------------------------+

   * Add the ``admin`` role to the ``aodh`` user:

      .. code-block:: console

         $ openstack role add --project service --user aodh admin

      .. note::

        This command provides no output.

   * Create the ``aodh`` service entity:

      .. code-block:: console

         $ openstack service create --name aodh \
           --description "Telemetry" alarming
         +-------------+----------------------------------+
         | Field       | Value                            |
         +-------------+----------------------------------+
         | description | Telemetry                        |
         | enabled     | True                             |
         | id          | 3405453b14da441ebb258edfeba96d83 |
         | name        | aodh                             |
         | type        | alarming                         |
         +-------------+----------------------------------+

#. Create the Telemetry Alarming service API endpoints:

   .. code-block:: console

      $ openstack endpoint create --region RegionOne \
        alarming public http://controller:8042
        +--------------+----------------------------------+
        | Field        | Value                            |
        +--------------+----------------------------------+
        | enabled      | True                             |
        | id           | 340be3625e9b4239a6415d034e98aace |
        | interface    | public                           |
        | region       | RegionOne                        |
        | region_id    | RegionOne                        |
        | service_id   | 8c2c7f1b9b5049ea9e63757b5533e6d2 |
        | service_name | aodh                             |
        | service_type | alarming                         |
        | url          | http://controller:8042           |
        +--------------+----------------------------------+

      $ openstack endpoint create --region RegionOne \
        alarming internal http://controller:8042
        +--------------+----------------------------------+
        | Field        | Value                            |
        +--------------+----------------------------------+
        | enabled      | True                             |
        | id           | 340be3625e9b4239a6415d034e98aace |
        | interface    | internal                         |
        | region       | RegionOne                        |
        | region_id    | RegionOne                        |
        | service_id   | 8c2c7f1b9b5049ea9e63757b5533e6d2 |
        | service_name | aodh                             |
        | service_type | alarming                         |
        | url          | http://controller:8042           |
        +--------------+----------------------------------+

      $ openstack endpoint create --region RegionOne \
        alarming admin http://controller:8042
        +--------------+----------------------------------+
        | Field        | Value                            |
        +--------------+----------------------------------+
        | enabled      | True                             |
        | id           | 340be3625e9b4239a6415d034e98aace |
        | interface    | admin                            |
        | region       | RegionOne                        |
        | region_id    | RegionOne                        |
        | service_id   | 8c2c7f1b9b5049ea9e63757b5533e6d2 |
        | service_name | aodh                             |
        | service_type | alarming                         |
        | url          | http://controller:8042           |
        +--------------+----------------------------------+

Install and configure the Telemetry Alarming service components
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. note::

   Default configuration files vary by distribution. You might need to add
   these sections and options rather than modifying existing sections and
   options. Also, an ellipsis (...) in the configuration snippets indicates
   potential default configuration options that you should retain.

.. only:: rdo

   #. Install the packages:

      .. code-block:: console

         # yum install openstack-aodh-api \
           openstack-aodh-evaluator openstack-aodh-notifier \
           openstack-aodh-listener openstack-aodh-expirer \
           python-ceilometerclient

.. only:: ubuntu

   #. Install the packages:

      .. code-block:: console

         # apt-get install aodh-api aodh-evaluator aodh-notifier \
           aodh-listener aodh-expirer python-ceilometerclient

#. Edit the ``/etc/aodh/aodh.conf`` file and perform these steps:

   * In the ``[database]`` section, configure database access:

      .. code-block:: ini

         [database]
         ...
         connection = mongodb://aodh:AODH_DBPASS@controller:27017/aodh

      Replace ``AODH_DBPASS`` with the password you chose for the
      Telemetry Alarming module database. You must escape special characters
      such as ':', '/', '+', and '@' in the connection string. For further
      information see the Reserved Characters section of
      :ref:`RFC2396 <https://www.ietf.org/rfc/rfc2396.txt>`.

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
         admin_user = aodh
         admin_password = AODH_PASS

      Replace ``AODH_PASS`` with the password you chose for
      the ``aodh`` user in the Identity service.

   * In the ``[service_credentials]`` section, configure service credentials:

      .. code-block:: ini

         [service_credentials]
         ...
         os_auth_url = http://controller:5000/v2.0
         os_username = aodh
         os_tenant_name = service
         os_password = AODH_PASS
         os_endpoint_type = internalURL
         os_region_name = RegionOne

      Replace ``AODH_PASS`` with the password you chose for
      the ``aodh`` user in the Identity service.

   * (Optional) To assist with troubleshooting, enable verbose
      logging in the ``[DEFAULT]`` section:

      .. code-block:: ini

         [DEFAULT]
         ...
         verbose = True

.. only:: ubuntu

   #. Edit the api_paste.ini file and add or modify the
      ``[filter:authtoken]`` section:

      .. code-block:: ini

         [filter:authtoken]
         ...
         oslo_config_project = aodh

Finalize installation
~~~~~~~~~~~~~~~~~~~~~

.. only:: rdo

   #. Start the Telemetry Alarming services and configure them to start
      when the system boots:

      .. code-block:: console

         # systemctl enable openstack-aodh-api.service \
           openstack-aodh-evaluator.service \
           openstack-aodh-notifier.service \
           openstack-aodh-listener.service
         # systemctl start openstack-aodh-api.service \
           openstack-aodh-evaluator.service \
           openstack-aodh-notifier.service \
           openstack-aodh-listener.service

.. only:: ubuntu

   #. Restart the Telemetry Alarming services:

      .. code-block:: console

         # service aodh-api restart
         # service aodh-evaluator restart
         # service aodh-notifier restart
         # service aodh-listener restart
