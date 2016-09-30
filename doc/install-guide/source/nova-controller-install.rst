Install and configure controller node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section describes how to install and configure the
Compute service, code-named nova, on the controller node.

Prerequisites
-------------

Before you install and configure the Compute service, you must
create databases, service credentials, and API endpoints.

#. To create the databases, complete these steps:

   * Use the database access client to connect to
     the database server as the ``root`` user:

     .. code-block:: console

        $ mysql -u root -p

     .. end

   * Create the ``nova_api`` and ``nova`` databases:

     .. code-block:: console

        mysql> CREATE DATABASE nova_api;
        mysql> CREATE DATABASE nova;

     .. end

   * Grant proper access to the databases:

     .. code-block:: console

        mysql> GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'localhost' \
          IDENTIFIED BY 'NOVA_DBPASS';
        mysql> GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'%' \
          IDENTIFIED BY 'NOVA_DBPASS';
        mysql> GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'localhost' \
          IDENTIFIED BY 'NOVA_DBPASS';
        mysql> GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'%' \
          IDENTIFIED BY 'NOVA_DBPASS';

     .. end

     Replace ``NOVA_DBPASS`` with a suitable password.

   * Exit the database access client.

#. Source the ``admin`` credentials to gain access to
   admin-only CLI commands:

   .. code-block:: console

      $ . admin-openrc

   .. end

#. To create the service credentials, complete these steps:

   * Create the ``nova`` user:

     .. code-block:: console

        $ openstack user create --domain default \
          --password-prompt nova

        User Password:
        Repeat User Password:
        +---------------------+----------------------------------+
        | Field               | Value                            |
        +---------------------+----------------------------------+
        | domain_id           | default                          |
        | enabled             | True                             |
        | id                  | 8a7dbf5279404537b1c7b86c033620fe |
        | name                | nova                             |
        | password_expires_at | None                             |
        +---------------------+----------------------------------+

     .. end

   * Add the ``admin`` role to the ``nova`` user:

     .. code-block:: console

        $ openstack role add --project service --user nova admin

     .. end

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

     .. end

#. Create the Compute service API endpoints:

   .. code-block:: console

      $ openstack endpoint create --region RegionOne \
        compute public http://controller:8774/v2.1/%\(tenant_id\)s

      +--------------+-------------------------------------------+
      | Field        | Value                                     |
      +--------------+-------------------------------------------+
      | enabled      | True                                      |
      | id           | 3c1caa473bfe4390a11e7177894bcc7b          |
      | interface    | public                                    |
      | region       | RegionOne                                 |
      | region_id    | RegionOne                                 |
      | service_id   | 060d59eac51b4594815603d75a00aba2          |
      | service_name | nova                                      |
      | service_type | compute                                   |
      | url          | http://controller:8774/v2.1/%(tenant_id)s |
      +--------------+-------------------------------------------+

      $ openstack endpoint create --region RegionOne \
        compute internal http://controller:8774/v2.1/%\(tenant_id\)s

      +--------------+-------------------------------------------+
      | Field        | Value                                     |
      +--------------+-------------------------------------------+
      | enabled      | True                                      |
      | id           | e3c918de680746a586eac1f2d9bc10ab          |
      | interface    | internal                                  |
      | region       | RegionOne                                 |
      | region_id    | RegionOne                                 |
      | service_id   | 060d59eac51b4594815603d75a00aba2          |
      | service_name | nova                                      |
      | service_type | compute                                   |
      | url          | http://controller:8774/v2.1/%(tenant_id)s |
      +--------------+-------------------------------------------+

      $ openstack endpoint create --region RegionOne \
        compute admin http://controller:8774/v2.1/%\(tenant_id\)s

      +--------------+-------------------------------------------+
      | Field        | Value                                     |
      +--------------+-------------------------------------------+
      | enabled      | True                                      |
      | id           | 38f7af91666a47cfb97b4dc790b94424          |
      | interface    | admin                                     |
      | region       | RegionOne                                 |
      | region_id    | RegionOne                                 |
      | service_id   | 060d59eac51b4594815603d75a00aba2          |
      | service_name | nova                                      |
      | service_type | compute                                   |
      | url          | http://controller:8774/v2.1/%(tenant_id)s |
      +--------------+-------------------------------------------+

   .. end

Install and configure components
--------------------------------

.. include:: shared/note_configuration_vary_by_distribution.rst

.. only:: obs

   #. Install the packages:

      .. code-block:: console

         # zypper install openstack-nova-api openstack-nova-scheduler \
           openstack-nova-conductor openstack-nova-consoleauth \
           openstack-nova-novncproxy iptables

      .. end

.. endonly

.. only:: rdo

   #. Install the packages:

      .. code-block:: console

         # yum install openstack-nova-api openstack-nova-conductor \
           openstack-nova-console openstack-nova-novncproxy \
           openstack-nova-scheduler

      .. end

.. endonly

.. only:: ubuntu

   #. Install the packages:

      .. code-block:: console

         # apt-get install nova-api nova-conductor nova-consoleauth \
           nova-novncproxy nova-scheduler

      .. end

.. endonly

.. only:: debian

   #. Install the packages:

      .. code-block:: console

         # apt-get install nova-api nova-conductor nova-consoleauth \
           nova-consoleproxy nova-scheduler

      .. end

      .. note::

         ``nova-api-metadata`` is included in the ``nova-api`` package,
         and can be selected through debconf.

      .. note::

         A unique ``nova-consoleproxy`` package provides the
         ``nova-novncproxy``, ``nova-spicehtml5proxy``, and
         ``nova-xvpvncproxy`` packages. To select packages, edit the
         ``/etc/default/nova-consoleproxy`` file or use the debconf interface.
         You can also manually edit the ``/etc/default/nova-consoleproxy``
         file, and stop and start the console daemons.

.. endonly

2. Edit the ``/etc/nova/nova.conf`` file and
   complete the following actions:

   * In the ``[DEFAULT]`` section, enable only the compute and metadata
     APIs:

     .. path /etc/nova/nova.conf
     .. code-block:: ini

        [DEFAULT]
        ...
        enabled_apis = osapi_compute,metadata

     .. end

   * In the ``[api_database]`` and ``[database]`` sections, configure
     database access:

     .. path /etc/nova/nova.conf
     .. code-block:: ini

        [api_database]
        ...
        connection = mysql+pymysql://nova:NOVA_DBPASS@controller/nova_api

        [database]
        ...
        connection = mysql+pymysql://nova:NOVA_DBPASS@controller/nova

     .. end

     Replace ``NOVA_DBPASS`` with the password you chose for
     the Compute databases.

   * In the ``[DEFAULT]`` and ``[oslo_messaging_rabbit]`` sections,
     configure ``RabbitMQ`` message queue access:

     .. path /etc/nova/nova.conf
     .. code-block:: ini

        [DEFAULT]
        ...
        rpc_backend = rabbit

        [oslo_messaging_rabbit]
        ...
        rabbit_host = controller
        rabbit_userid = openstack
        rabbit_password = RABBIT_PASS

     .. end

     Replace ``RABBIT_PASS`` with the password you chose for the
     ``openstack`` account in ``RabbitMQ``.

   * In the ``[DEFAULT]`` and ``[keystone_authtoken]`` sections,
     configure Identity service access:

     .. path /etc/nova/nova.conf
     .. code-block:: ini

        [DEFAULT]
        ...
        auth_strategy = keystone

        [keystone_authtoken]
        ...
        auth_uri = http://controller:5000
        auth_url = http://controller:35357
        memcached_servers = controller:11211
        auth_type = password
        project_domain_name = default
        user_domain_name = default
        project_name = service
        username = nova
        password = NOVA_PASS

     .. end

     Replace ``NOVA_PASS`` with the password you chose for the
     ``nova`` user in the Identity service.

     .. note::

        Comment out or remove any other options in the
        ``[keystone_authtoken]`` section.

   * In the ``[DEFAULT]`` section, configure the ``my_ip`` option to
     use the management interface IP address of the controller node:

     .. path /etc/nova/nova.conf
     .. code-block:: ini

        [DEFAULT]
        ...
        my_ip = 10.0.0.11

     .. end

   .. only:: debian

      * The ``.config`` and ``.postinst`` maintainer scripts of the
        ``nova-common`` package detect automatically the IP address which
        goes in the ``my_ip`` directive of the ``[DEFAULT]`` section. This
        value will normally still be prompted, and you can check that it
        is correct in the nova.conf after ``nova-common`` is installed:

        .. path /etc/nova/nova.conf
        .. code-block:: ini

           [DEFAULT]
           ...
           my_ip = 10.0.0.11

        .. end

   .. endonly

* In the ``[DEFAULT]`` section, enable support for the Networking service:

  .. path /etc/nova/nova.conf
  .. code-block:: ini

     [DEFAULT]
     ...
     use_neutron = True
     firewall_driver = nova.virt.firewall.NoopFirewallDriver

  .. end

  .. note::

     By default, Compute uses an internal firewall driver. Since the
     Networking service includes a firewall driver, you must disable the
     Compute firewall driver by using the
     ``nova.virt.firewall.NoopFirewallDriver`` firewall driver.

* In the ``[vnc]`` section, configure the VNC proxy to use the management
  interface IP address of the controller node:

  .. path /etc/nova/nova.conf
  .. code-block:: ini

     [vnc]
     ...
     vncserver_listen = $my_ip
     vncserver_proxyclient_address = $my_ip

  .. end

* In the ``[glance]`` section, configure the location of the
  Image service API:

  .. path /etc/nova/nova.conf
  .. code-block:: ini

     [glance]
     ...
     api_servers = http://controller:9292

  .. end

.. only:: obs

   * In the ``[oslo_concurrency]`` section, configure the lock path:

     .. path /etc/nova/nova.conf
     .. code-block:: ini

        [oslo_concurrency]
        ...
        lock_path = /var/run/nova

     .. end

.. endonly

.. only:: rdo

   * In the ``[oslo_concurrency]`` section, configure the lock path:

     .. path /etc/nova/nova.conf
     .. code-block:: ini

        [oslo_concurrency]
        ...
        lock_path = /var/lib/nova/tmp

     .. end

.. endonly

.. only:: ubuntu

   * In the ``[oslo_concurrency]`` section, configure the lock path:

     .. path /etc/nova/nova.conf
     .. code-block:: ini

        [oslo_concurrency]
        ...
        lock_path = /var/lib/nova/tmp

     .. end

.. endonly

.. only:: ubuntu

   .. todo:

      https://bugs.launchpad.net/ubuntu/+source/nova/+bug/1506667

   * Due to a packaging bug, remove the ``logdir`` option from the
     ``[DEFAULT]`` section.

.. endonly

.. only:: rdo or ubuntu or debian

   3. Populate the Compute databases:

      .. code-block:: console

         # su -s /bin/sh -c "nova-manage api_db sync" nova
         # su -s /bin/sh -c "nova-manage db sync" nova

      .. end

      .. note::

         Ignore any deprecation messages in this output.

.. endonly

Finalize installation
---------------------

.. only:: obs

   * Start the Compute services and configure them to start
     when the system boots:

     .. code-block:: console

        # systemctl enable openstack-nova-api.service \
          openstack-nova-consoleauth.service openstack-nova-scheduler.service \
          openstack-nova-conductor.service openstack-nova-novncproxy.service
        # systemctl start openstack-nova-api.service \
          openstack-nova-consoleauth.service openstack-nova-scheduler.service \
          openstack-nova-conductor.service openstack-nova-novncproxy.service

     .. end

.. endonly

.. only:: rdo

   * Start the Compute services and configure them to start
     when the system boots:

     .. code-block:: console

        # systemctl enable openstack-nova-api.service \
          openstack-nova-consoleauth.service openstack-nova-scheduler.service \
          openstack-nova-conductor.service openstack-nova-novncproxy.service
        # systemctl start openstack-nova-api.service \
          openstack-nova-consoleauth.service openstack-nova-scheduler.service \
          openstack-nova-conductor.service openstack-nova-novncproxy.service

     .. end

.. endonly

.. only:: ubuntu or debian

   * Restart the Compute services:

     .. code-block:: console

        # service nova-api restart
        # service nova-consoleauth restart
        # service nova-scheduler restart
        # service nova-conductor restart
        # service nova-novncproxy restart

     .. end

.. endonly
