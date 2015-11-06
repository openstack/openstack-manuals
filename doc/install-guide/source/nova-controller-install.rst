Install and configure controller node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section describes how to install and configure the
Compute service, code-named nova, on the controller node.

.. only:: obs or rdo or ubuntu

   Prerequisites
   -------------

   Before you install and configure the Compute service, you must
   create a database, service credentials, and API endpoints.

   #. To create the database, complete these steps:

      * Use the database access client to connect to
        the database server as the ``root`` user:

        .. code-block:: console

           $ mysql -u root -p

      * Create the ``nova`` database:

        .. code-block:: console

           CREATE DATABASE nova;

      * Grant proper access to the ``nova`` database:

        .. code-block:: console

           GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'localhost' \
             IDENTIFIED BY 'NOVA_DBPASS';
           GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'%' \
             IDENTIFIED BY 'NOVA_DBPASS';

        Replace ``NOVA_DBPASS`` with a suitable password.

      * Exit the database access client.

   #. Source the ``admin`` credentials to gain access to
      admin-only CLI commands:

      .. code-block:: console

         $ source admin-openrc.sh

   #. To create the service credentials, complete these steps:

      * Create the ``nova`` user:

        .. code-block:: console

           $ openstack user create --domain default --password-prompt nova
           User Password:
           Repeat User Password:
           +-----------+----------------------------------+
           | Field     | Value                            |
           +-----------+----------------------------------+
           | domain_id | default                          |
           | enabled   | True                             |
           | id        | 8c46e4760902464b889293a74a0c90a8 |
           | name      | nova                             |
           +-----------+----------------------------------+

      * Add the ``admin`` role to the ``nova`` user:

        .. code-block:: console

           $ openstack role add --project service --user nova admin

        .. note::

           This command provides no output.

      * Create the ``nova`` service entity:

        .. code-block:: console

           $ openstack service create --name nova \
             --description "OpenStack Compute" compute
           +-------------+----------------------------------+
           | Field       | Value                            |
           +-------------+----------------------------------+
           | description | OpenStack Compute                |
           | enabled     | True                             |
           | id          | 060d59eac51b4594815603d75a00aba2 |
           | name        | nova                             |
           | type        | compute                          |
           +-------------+----------------------------------+

   #. Create the Compute service API endpoints:

      .. code-block:: console

         $ openstack endpoint create --region RegionOne \
           compute public http://controller:8774/v2/%\(tenant_id\)s
         +--------------+-----------------------------------------+
         | Field        | Value                                   |
         +--------------+-----------------------------------------+
         | enabled      | True                                    |
         | id           | 3c1caa473bfe4390a11e7177894bcc7b        |
         | interface    | public                                  |
         | region       | RegionOne                               |
         | region_id    | RegionOne                               |
         | service_id   | e702f6f497ed42e6a8ae3ba2e5871c78        |
         | service_name | nova                                    |
         | service_type | compute                                 |
         | url          | http://controller:8774/v2/%(tenant_id)s |
         +--------------+-----------------------------------------+

         $ openstack endpoint create --region RegionOne \
           compute internal http://controller:8774/v2/%\(tenant_id\)s
         +--------------+-----------------------------------------+
         | Field        | Value                                   |
         +--------------+-----------------------------------------+
         | enabled      | True                                    |
         | id           | e3c918de680746a586eac1f2d9bc10ab        |
         | interface    | internal                                |
         | region       | RegionOne                               |
         | region_id    | RegionOne                               |
         | service_id   | e702f6f497ed42e6a8ae3ba2e5871c78        |
         | service_name | nova                                    |
         | service_type | compute                                 |
         | url          | http://controller:8774/v2/%(tenant_id)s |
         +--------------+-----------------------------------------+

         $ openstack endpoint create --region RegionOne \
           compute admin http://controller:8774/v2/%\(tenant_id\)s
         +--------------+-----------------------------------------+
         | Field        | Value                                   |
         +--------------+-----------------------------------------+
         | enabled      | True                                    |
         | id           | 38f7af91666a47cfb97b4dc790b94424        |
         | interface    | admin                                   |
         | region       | RegionOne                               |
         | region_id    | RegionOne                               |
         | service_id   | e702f6f497ed42e6a8ae3ba2e5871c78        |
         | service_name | nova                                    |
         | service_type | compute                                 |
         | url          | http://controller:8774/v2/%(tenant_id)s |
         +--------------+-----------------------------------------+

Install and configure components
--------------------------------

.. include:: shared/note_configuration_vary_by_distribution.rst

.. only:: obs

   #. Install the packages:

      .. code-block:: console

         # zypper install openstack-nova-api openstack-nova-scheduler \
           openstack-nova-cert openstack-nova-conductor \
           openstack-nova-consoleauth openstack-nova-novncproxy \
           python-novaclient iptables

.. only:: rdo

   #. Install the packages:

      .. code-block:: console

         # yum install openstack-nova-api openstack-nova-cert \
           openstack-nova-conductor openstack-nova-console \
           openstack-nova-novncproxy openstack-nova-scheduler \
           python-novaclient

.. only:: ubuntu

   #. Install the packages:

      .. code-block:: console

         # apt-get install nova-api nova-cert nova-conductor \
           nova-consoleauth nova-novncproxy nova-scheduler \
           python-novaclient

.. only:: debian

   #. Install the packages:

      .. code-block:: console

         # apt-get install nova-api nova-cert nova-conductor \
           nova-consoleauth nova-consoleproxy nova-scheduler \
           python-novaclient

      Respond to prompts for
      :doc:`database management <debconf/debconf-dbconfig-common>`,
      :doc:`Identity service credentials <debconf/debconf-keystone-authtoken>`,
      :doc:`service endpoint registration <debconf/debconf-api-endpoints>`,
      and :doc:`message broker credentials <debconf/debconf-rabbitmq>`.

2. Edit the ``/etc/nova/nova.conf`` file and
   complete the following actions:

   .. only:: obs or rdo or ubuntu

      * In the ``[database]`` section, configure database access:

        .. only:: ubuntu or obs

           .. code-block:: ini

              [database]
              ...
              connection = mysql+pymysql://nova:NOVA_DBPASS@controller/nova

        .. only:: rdo

           .. code-block:: ini

              [database]
              ...
              connection = mysql://nova:NOVA_DBPASS@controller/nova

        Replace ``NOVA_DBPASS`` with the password you chose for
        the Compute database.

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
           auth_uri = http://controller:5000
           auth_url = http://controller:35357
           auth_plugin = password
           project_domain_id = default
           user_domain_id = default
           project_name = service
           username = nova
           password = NOVA_PASS

        Replace ``NOVA_PASS`` with the password you chose for the
        ``nova`` user in the Identity service.

        .. note::

           Comment out or remove any other options in the
           ``[keystone_authtoken]`` section.

      * In the ``[DEFAULT]`` section, configure the ``my_ip`` option to
        use the management interface IP address of the controller node:

        .. code-block:: ini

           [DEFAULT]
           ...
           my_ip = 10.0.0.11

   .. only:: debian

      * The ``.config`` and ``.postinst`` maintainer scripts of the
        ``nova-common`` package detect automatically the IP address which
        goes in the ``my_ip`` directive of the ``[DEFAULT]`` section. This
        value will normally still be prompted, and you can check that it
        is correct in the nova.conf after ``nova-common`` is installed:

        .. code-block:: ini

           [DEFAULT]
           ...
           my_ip = 10.0.0.11

   * In the ``[DEFAULT]`` section, enable support for the Networking service:

     .. code-block:: ini

        [DEFAULT]
        ...
        network_api_class = nova.network.neutronv2.api.API
        security_group_api = neutron
        linuxnet_interface_driver = nova.network.linux_net.NeutronLinuxBridgeInterfaceDriver
        firewall_driver = nova.virt.firewall.NoopFirewallDriver

     .. note::

        By default, Compute uses an internal firewall service. Since
        Networking includes a firewall service, you must disable the Compute
        firewall service by using the
        ``nova.virt.firewall.NoopFirewallDriver`` firewall driver.

   * In the ``[vnc]`` section, configure the VNC proxy to use the management
     interface IP address of the controller node:

     .. code-block:: ini

        [vnc]
        ...
        vncserver_listen = $my_ip
        vncserver_proxyclient_address = $my_ip

   * In the ``[glance]`` section, configure the location of the
     Image service:

     .. code-block:: ini

        [glance]
        ...
        host = controller

   .. only:: obs

      * In the ``[oslo_concurrency]`` section, configure the lock path:

        .. code-block:: ini

           [oslo_concurrency]
           ...
           lock_path = /var/run/nova

   .. only:: rdo

      * In the ``[oslo_concurrency]`` section, configure the lock path:

        .. code-block:: ini

           [oslo_concurrency]
           ...
           lock_path = /var/lib/nova/tmp

   .. only:: ubuntu

      * In the ``[oslo_concurrency]`` section, configure the lock path:

        .. code-block:: ini

           [oslo_concurrency]
           ...
           lock_path = /var/lib/nova/tmp

   * In the ``[DEFAULT]`` section, disable the EC2 API:

     .. code-block:: ini

        [DEFAULT]
        ...
        enabled_apis=osapi_compute,metadata

   * (Optional) To assist with troubleshooting, enable verbose
     logging in the ``[DEFAULT]`` section:

     .. code-block:: ini

        [DEFAULT]
        ...
        verbose = True

.. only:: rdo

   3. Populate the Compute database:

      .. code-block:: console

         # su -s /bin/sh -c "nova-manage db sync" nova

.. only:: ubuntu

   3. Populate the Compute database:

      .. code-block:: console

         # su -s /bin/sh -c "nova-manage db sync" nova

Finalize installation
---------------------

.. only:: obs

   * Start the Compute services and configure them to start
     when the system boots:

     .. code-block:: console

        # systemctl enable openstack-nova-api.service \
          openstack-nova-cert.service openstack-nova-consoleauth.service \
          openstack-nova-scheduler.service openstack-nova-conductor.service \
          openstack-nova-novncproxy.service
        # systemctl start openstack-nova-api.service \
          openstack-nova-cert.service openstack-nova-consoleauth.service \
          openstack-nova-scheduler.service openstack-nova-conductor.service \
          openstack-nova-novncproxy.service

.. only:: rdo

   * Start the Compute services and configure them to start
     when the system boots:

     .. code-block:: console

        # systemctl enable openstack-nova-api.service \
          openstack-nova-cert.service openstack-nova-consoleauth.service \
          openstack-nova-scheduler.service openstack-nova-conductor.service \
          openstack-nova-novncproxy.service
        # systemctl start openstack-nova-api.service \
          openstack-nova-cert.service openstack-nova-consoleauth.service \
          openstack-nova-scheduler.service openstack-nova-conductor.service \
          openstack-nova-novncproxy.service

.. only:: ubuntu or debian

   * Restart the Compute services:

     .. code-block:: console

        # service nova-api restart
        # service nova-cert restart
        # service nova-consoleauth restart
        # service nova-scheduler restart
        # service nova-conductor restart
        # service nova-novncproxy restart

   .. only:: ubuntu

      * By default, the Ubuntu packages create an SQLite database.

        Because this configuration uses an SQL database server,
        you can remove the SQLite database file:

        .. code-block:: console

           # rm -f /var/lib/nova/nova.sqlite
