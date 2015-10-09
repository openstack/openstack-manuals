===================================
Install and configure Orchestration
===================================

This section describes how to install and configure the
Orchestration module, code-named heat, on the controller node.

.. only:: obs or rdo or ubuntu

   To configure prerequisites
   ~~~~~~~~~~~~~~~~~~~~~~~~~~

   Before you install and configure Orchestration, you must create a
   database, service credentials, and API endpoints.

   #. To create the database, complete these steps:

      * Use the database access client to connect to the database
        server as the ``root`` user:

        .. code-block:: console

           $ mysql -u root -p

      * Create the ``heat`` database::

          CREATE DATABASE heat;

      * Grant proper access to the ``heat`` database::

          GRANT ALL PRIVILEGES ON heat.* TO 'heat'@'localhost' \
            IDENTIFIED BY 'HEAT_DBPASS';
          GRANT ALL PRIVILEGES ON heat.* TO 'heat'@'%' \
            IDENTIFIED BY 'HEAT_DBPASS';

        Replace ``HEAT_DBPASS`` with a suitable password.

      * Exit the database access client.

   #. Source the ``admin`` credentials to gain access to
      admin-only CLI commands:

      .. code-block:: console

         $ source admin-openrc.sh

   #. To create the service credentials, complete these steps:

      * Create the ``heat`` user:

        .. code-block:: console

           $ openstack user create --password-prompt heat
           User Password:
           Repeat User Password:
           +----------+----------------------------------+
           | Field    | Value                            |
           +----------+----------------------------------+
           | email    | None                             |
           | enabled  | True                             |
           | id       | 7fd67878dcd04d0393469ef825a7e005 |
           | name     | heat                             |
           | username | heat                             |
           +----------+----------------------------------+

      * Add the ``admin`` role to the ``heat`` user:

        .. code-block:: console

           $ openstack role add --project service --user heat admin
           +-------+----------------------------------+
           | Field | Value                            |
           +-------+----------------------------------+
           | id    | cd2cb9a39e874ea69e5d4b896eb16128 |
           | name  | admin                            |
           +-------+----------------------------------+

      * Create the ``heat_stack_owner`` role:

        .. code-block:: console

           $ openstack role create heat_stack_owner
           +-------+----------------------------------+
           | Field | Value                            |
           +-------+----------------------------------+
           | id    | c0a1cbee7261446abc873392f616de87 |
           | name  | heat_stack_owner                 |
           +-------+----------------------------------+

      * Add the ``heat_stack_owner`` role to the ``demo`` tenant and user:

        .. code-block:: console

           $ openstack role add --project demo --user demo heat_stack_owner
           +-------+----------------------------------+
           | Field | Value                            |
           +-------+----------------------------------+
           | id    | c0a1cbee7261446abc873392f616de87 |
           | name  | heat_stack_owner                 |
           +-------+----------------------------------+

        .. note::

           You must add the ``heat_stack_owner`` role to users
           that manage stacks.

      * Create the ``heat_stack_user`` role:

        .. code-block:: console

           $ openstack role create heat_stack_user
           +-------+----------------------------------+
           | Field | Value                            |
           +-------+----------------------------------+
           | id    | e01546b1a81c4e32a6d14a9259e60154 |
           | name  | heat_stack_user                  |
           +-------+----------------------------------+

        .. note::

           The Orchestration service automatically assigns the
           ``heat_stack_user`` role to users that it creates
           during stack deployment. By default, this role restricts
           :term:`API` operations. To avoid conflicts, do not add
           this role to users with the ``heat_stack_owner`` role.

      * Create the ``heat`` and ``heat-cfn`` service entities:

        .. code-block:: console

           $ openstack service create --name heat \
             --description "Orchestration" orchestration
           +-------------+----------------------------------+
           | Field       | Value                            |
           +-------------+----------------------------------+
           | description | Orchestration                    |
           | enabled     | True                             |
           | id          | 031112165cad4c2bb23e84603957de29 |
           | name        | heat                             |
           | type        | orchestration                    |
           +-------------+----------------------------------+
           $ openstack service create --name heat-cfn \
             --description "Orchestration"  cloudformation
           +-------------+----------------------------------+
           | Field       | Value                            |
           +-------------+----------------------------------+
           | description | Orchestration                    |
           | enabled     | True                             |
           | id          | 297740d74c0a446bbff867acdccb33fa |
           | name        | heat-cfn                         |
           | type        | cloudformation                   |
           +-------------+----------------------------------+

   #. Create the Orchestration service API endpoints:

      .. code-block:: console

         $ openstack endpoint create --region RegionOne \
           orchestration public http://controller:8004/v1/%\(tenant_id\)s
           +--------------+----------------------------------+
           | Field        | Value                            |
           +--------------+----------------------------------+
           | enabled      | True                             |
           | id           | 340be3625e9b4239a6415d034e98aace |
           | interface    | public                           |
           | region       | RegionOne                        |
           | region_id    | RegionOne                        |
           | service_id   | 8c2c7f1b9b5049ea9e63757b5533e6d2 |
           | service_name | heat                             |
           | service_type | orchestration                    |
           | url          | http://controller:8004           |
           +--------------+----------------------------------+
         $ openstack endpoint create --region RegionOne \
           orchestration internal http://controller:8004/v1/%\(tenant_id\)s
           +--------------+----------------------------------+
           | Field        | Value                            |
           +--------------+----------------------------------+
           | enabled      | True                             |
           | id           | 340be3625e9b4239a6415d034e98aace |
           | interface    | internal                         |
           | region       | RegionOne                        |
           | region_id    | RegionOne                        |
           | service_id   | 8c2c7f1b9b5049ea9e63757b5533e6d2 |
           | service_name | heat                             |
           | service_type | orchestration                    |
           | url          | http://controller:8004           |
           +--------------+----------------------------------+
         $ openstack endpoint create --region RegionOne \
           orchestration admin http://controller:8004/v1/%\(tenant_id\)s
           +--------------+----------------------------------+
           | Field        | Value                            |
           +--------------+----------------------------------+
           | enabled      | True                             |
           | id           | 340be3625e9b4239a6415d034e98aace |
           | interface    | admin                            |
           | region       | RegionOne                        |
           | region_id    | RegionOne                        |
           | service_id   | 8c2c7f1b9b5049ea9e63757b5533e6d2 |
           | service_name | heat                             |
           | service_type | orchestration                    |
           | url          | http://controller:8004           |
           +--------------+----------------------------------+

         $ openstack endpoint create --region RegionOne \
           cloudformation public http://controller:8000/v1
           +--------------+----------------------------------+
           | Field        | Value                            |
           +--------------+----------------------------------+
           | enabled      | True                             |
           | id           | 340be3625e9b4239a6415d034e98aace |
           | interface    | public                           |
           | region       | RegionOne                        |
           | region_id    | RegionOne                        |
           | service_id   | 8c2c7f1b9b5049ea9e63757b5533e6d2 |
           | service_name | heat-cfn                         |
           | service_type | cloudformation                   |
           | url          | http://controller:8000           |
           +--------------+----------------------------------+

         $ openstack endpoint create --region RegionOne \
           cloudformation internal http://controller:8000/v1
           +--------------+----------------------------------+
           | Field        | Value                            |
           +--------------+----------------------------------+
           | enabled      | True                             |
           | id           | 340be3625e9b4239a6415d034e98aace |
           | interface    | internal                         |
           | region       | RegionOne                        |
           | region_id    | RegionOne                        |
           | service_id   | 8c2c7f1b9b5049ea9e63757b5533e6d2 |
           | service_name | heat-cfn                         |
           | service_type | cloudformation                   |
           | url          | http://controller:8000           |
           +--------------+----------------------------------+

         $ openstack endpoint create --region RegionOne \
           cloudformation admin http://controller:8000/v1
           +--------------+----------------------------------+
           | Field        | Value                            |
           +--------------+----------------------------------+
           | enabled      | True                             |
           | id           | 340be3625e9b4239a6415d034e98aace |
           | interface    | admin                            |
           | region       | RegionOne                        |
           | region_id    | RegionOne                        |
           | service_id   | 8c2c7f1b9b5049ea9e63757b5533e6d2 |
           | service_name | heat-cfn                         |
           | service_type | cloudformation                   |
           | url          | http://controller:8000           |
           +--------------+----------------------------------+

To install and configure the Orchestration components
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. only:: obs

   #. Run the following commands to install the packages:

      .. code-block:: console

         # zypper install openstack-heat-api openstack-heat-api-cfn \
           openstack-heat-engine python-heatclient

.. only:: rdo

   #. Run the following commands to install the packages:

      .. code-block:: console

         # yum install openstack-heat-api openstack-heat-api-cfn \
           openstack-heat-engine python-heatclient

.. only:: ubuntu

   #. Run the following commands to install the packages:

      .. code-block:: console

         # apt-get install heat-api heat-api-cfn heat-enginea \
           python-heatclient

.. only:: obs or rdo or ubuntu

   2.

      .. only:: rdo

         .. Workaround for https://bugzilla.redhat.com/show_bug.cgi?id=1213476.

         Copy the ``/usr/share/heat/heat-dist.conf`` file
         to ``/etc/heat/heat.conf``.

         .. code-block:: console

            # cp /usr/share/heat/heat-dist.conf /etc/heat/heat.conf
            # chown -R heat:heat /etc/heat/heat.conf

      Edit the ``/etc/heat/heat.conf`` file and complete the following
      actions:

      * In the ``[database]`` section, configure database access:

        .. code-block:: ini

           [database]
           ...
           connection = mysql+pymysql://heat:HEAT_DBPASS@controller/heat

        Replace ``HEAT_DBPASS`` with the password you chose for the
        Orchestration database.

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

      * In the ``[keystone_authtoken]`` and ``[ec2authtoken]`` sections,
        configure Identity service access:

        .. code-block:: ini

           [keystone_authtoken]
           ...
           auth_uri = http://controller:5000/v2.0
           identity_uri = http://controller:35357
           admin_tenant_name = service
           admin_user = heat
           admin_password = HEAT_PASS

           [ec2authtoken]
           ...
           auth_uri = http://controller:5000/v2.0

        Replace ``HEAT_PASS`` with the password you chose for the
        ``heat`` user in the Identity service.

        .. note::

           Comment out any ``auth_host``, ``auth_port``, and
           ``auth_protocol`` options because the
           ``identity_uri`` option replaces them.

      * In the ``[DEFAULT]`` section, configure the metadata and
        wait condition URLs:

        .. code-block:: ini

           [DEFAULT]
           ...
           heat_metadata_server_url = http://controller:8000
           heat_waitcondition_server_url = http://controller:8000/v1/waitcondition

      * In the ``[DEFAULT]`` section, configure information about the heat
        Identity service domain:

        .. code-block:: ini

           [DEFAULT]
           ...
           stack_domain_admin = heat_domain_admin
           stack_domain_admin_password = HEAT_DOMAIN_PASS
           stack_user_domain_name = heat_user_domain

        Replace ``HEAT_DOMAIN_PASS`` with the password you chose for the admin
        user of the ``heat`` user domain in the Identity service.

      * (Optional) To assist with troubleshooting, enable verbose
        logging in the ``[DEFAULT]`` section:

        .. code-block:: ini

           [DEFAULT]
           ...
           verbose = True</programlisting>

   3.

      * Source the ``admin`` credentials to gain access to
        admin-only CLI commands:

        .. code-block:: console

           $ source admin-openrc.sh

      * Create the heat domain in Identity service:

        .. code-block:: console

           $ heat-keystone-setup-domain \
             --stack-user-domain-name heat_user_domain \
             --stack-domain-admin heat_domain_admin \
             --stack-domain-admin-password HEAT_DOMAIN_PASS

        Replace ``HEAT_DOMAIN_PASS`` with a suitable password.

   4. Populate the Orchestration database:

      .. code-block:: console

         # su -s /bin/sh -c "heat-manage db_sync" heat

.. only:: debian

   #. Run the following commands to install the packages:

      .. code-block:: console

         # apt-get install heat-api heat-api-cfn heat-engine python-heat-client

   #. Respond to prompts for
      :doc:`database management <debconf/debconf-dbconfig-common>`,
      :doc:`Identity service credentials <debconf/debconf-keystone-authtoken>`,
      :doc:`service endpoint registration <debconf/debconf-api-endpoints>`,
      and :doc:`message broker credentials <debconf/debconf-rabbitmq>`.

   #. Edit the ``/etc/heat/heat.conf`` file and complete the following
      actions:

      * In the ``[ec2authtoken]`` section, configure Identity service access:

        .. code-block:: ini

           [ec2authtoken]
           ...
           auth_uri = http://controller:5000/v2.0

To finalize installation
~~~~~~~~~~~~~~~~~~~~~~~~

.. only:: obs or rdo

   #. Start the Orchestration services and configure them to start
      when the system boots:

      .. code-block:: console

         # systemctl enable openstack-heat-api.service \
           openstack-heat-api-cfn.service openstack-heat-engine.service
         # systemctl start openstack-heat-api.service \
           openstack-heat-api-cfn.service openstack-heat-engine.service

.. only:: ubuntu or debian

   #. Restart the Orchestration services:

      .. code-block:: console

         # service heat-api restart
         # service heat-api-cfn restart
         # service heat-engine restart

.. only:: ubuntu

   2. By default, the Ubuntu packages create an SQLite database.

      Because this configuration uses an SQL database server, you
      can remove the SQLite database file:

      .. code-block:: console

         # rm -f /var/lib/heat/heat.sqlite
