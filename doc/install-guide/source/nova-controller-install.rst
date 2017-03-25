Install and configure controller node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section describes how to install and configure the
Compute service, code-named nova, on the controller node.

Prerequisites
-------------

Before you install and configure the Compute service, you must
create databases, service credentials, and API endpoints.

#. To create the databases, complete these steps:

   .. only:: ubuntu

      * Use the database access client to connect to the database
        server as the ``root`` user:

        .. code-block:: console

           # mysql

        .. end

   .. endonly

   .. only:: rdo or debian or obs

      * Use the database access client to connect to the database
        server as the ``root`` user:

        .. code-block:: console

           $ mysql -u root -p

        .. end

   .. endonly

   * Create the ``nova_api``, ``nova``, and ``nova_cell0`` databases:

     .. code-block:: console

        MariaDB [(none)]> CREATE DATABASE nova_api;
        MariaDB [(none)]> CREATE DATABASE nova;
        MariaDB [(none)]> CREATE DATABASE nova_cell0;

     .. end

   * Grant proper access to the databases:

     .. code-block:: console

        MariaDB [(none)]> GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'localhost' \
          IDENTIFIED BY 'NOVA_DBPASS';
        MariaDB [(none)]> GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'%' \
          IDENTIFIED BY 'NOVA_DBPASS';

        MariaDB [(none)]> GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'localhost' \
          IDENTIFIED BY 'NOVA_DBPASS';
        MariaDB [(none)]> GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'%' \
          IDENTIFIED BY 'NOVA_DBPASS';

        MariaDB [(none)]> GRANT ALL PRIVILEGES ON nova_cell0.* TO 'nova'@'localhost' \
          IDENTIFIED BY 'NOVA_DBPASS';
        MariaDB [(none)]> GRANT ALL PRIVILEGES ON nova_cell0.* TO 'nova'@'%' \
          IDENTIFIED BY 'NOVA_DBPASS';

     .. end

     Replace ``NOVA_DBPASS`` with a suitable password.

   * Exit the database access client.

#. Source the ``admin`` credentials to gain access to
   admin-only CLI commands:

   .. code-block:: console

      $ . admin-openrc

   .. end

#. Create the Compute service credentials:

   * Create the ``nova`` user:

     .. code-block:: console

        $ openstack user create --domain default --password-prompt nova

        User Password:
        Repeat User Password:
        +---------------------+----------------------------------+
        | Field               | Value                            |
        +---------------------+----------------------------------+
        | domain_id           | default                          |
        | enabled             | True                             |
        | id                  | 8a7dbf5279404537b1c7b86c033620fe |
        | name                | nova                             |
        | options             | {}                               |
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

#. Create the Compute API service endpoints:

   .. code-block:: console

      $ openstack endpoint create --region RegionOne \
        compute public http://controller:8774/v2.1

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
      | url          | http://controller:8774/v2.1               |
      +--------------+-------------------------------------------+

      $ openstack endpoint create --region RegionOne \
        compute internal http://controller:8774/v2.1

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
      | url          | http://controller:8774/v2.1               |
      +--------------+-------------------------------------------+

      $ openstack endpoint create --region RegionOne \
        compute admin http://controller:8774/v2.1

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
      | url          | http://controller:8774/v2.1               |
      +--------------+-------------------------------------------+

   .. end

#. Create a Placement service user using your chosen ``PLACEMENT_PASS``:

   .. code-block:: console

      $ openstack user create --domain default --password-prompt placement

      User Password:
      Repeat User Password:
      +---------------------+----------------------------------+
      | Field               | Value                            |
      +---------------------+----------------------------------+
      | domain_id           | default                          |
      | enabled             | True                             |
      | id                  | fa742015a6494a949f67629884fc7ec8 |
      | name                | placement                        |
      | options             | {}                               |
      | password_expires_at | None                             |
      +---------------------+----------------------------------+

#. Add the Placement user to the service project with the admin role:

   .. code-block:: console

      $ openstack role add --project service --user placement admin

   .. note::

      This command provides no output.

#. Create the Placement API entry in the service catalog:

   .. code-block:: console

      $ openstack service create --name placement --description "Placement API" placement
      +-------------+----------------------------------+
      | Field       | Value                            |
      +-------------+----------------------------------+
      | description | Placement API                    |
      | enabled     | True                             |
      | id          | 2d1a27022e6e4185b86adac4444c495f |
      | name        | placement                        |
      | type        | placement                        |
      +-------------+----------------------------------+

#. Create the Placement API service endpoints:

   .. code-block:: console

      $ openstack endpoint create --region RegionOne placement public http://controller:8778
      +--------------+----------------------------------+
      | Field        | Value                            |
      +--------------+----------------------------------+
      | enabled      | True                             |
      | id           | 2b1b2637908b4137a9c2e0470487cbc0 |
      | interface    | public                           |
      | region       | RegionOne                        |
      | region_id    | RegionOne                        |
      | service_id   | 2d1a27022e6e4185b86adac4444c495f |
      | service_name | placement                        |
      | service_type | placement                        |
      | url          | http://controller:8778           |
      +--------------+----------------------------------+

      $ openstack endpoint create --region RegionOne placement internal http://controller:8778
      +--------------+----------------------------------+
      | Field        | Value                            |
      +--------------+----------------------------------+
      | enabled      | True                             |
      | id           | 02bcda9a150a4bd7993ff4879df971ab |
      | interface    | internal                         |
      | region       | RegionOne                        |
      | region_id    | RegionOne                        |
      | service_id   | 2d1a27022e6e4185b86adac4444c495f |
      | service_name | placement                        |
      | service_type | placement                        |
      | url          | http://controller:8778           |
      +--------------+----------------------------------+

      $ openstack endpoint create --region RegionOne placement admin http://controller:8778
      +--------------+----------------------------------+
      | Field        | Value                            |
      +--------------+----------------------------------+
      | enabled      | True                             |
      | id           | 3d71177b9e0f406f98cbff198d74b182 |
      | interface    | admin                            |
      | region       | RegionOne                        |
      | region_id    | RegionOne                        |
      | service_id   | 2d1a27022e6e4185b86adac4444c495f |
      | service_name | placement                        |
      | service_type | placement                        |
      | url          | http://controller:8778           |
      +--------------+----------------------------------+

Install and configure components
--------------------------------

.. include:: shared/note_configuration_vary_by_distribution.rst

.. only:: obs

    .. note::

        As of the Newton release, SUSE OpenStack packages are shipped
        with the upstream default configuration files. For example,
        ``/etc/nova/nova.conf`` has customizations in
        ``/etc/nova/nova.conf.d/010-nova.conf``. While the following
        instructions modify the default configuration file, adding a new file
        in ``/etc/nova/nova.conf.d`` achieves the same result.

.. endonly

.. only:: obs

   #. Install the packages:

      .. code-block:: console

         # zypper install openstack-nova-api openstack-nova-scheduler \
           openstack-nova-conductor openstack-nova-consoleauth \
           openstack-nova-novncproxy openstack-nova-placement-api \
           iptables

      .. end

.. endonly

.. only:: rdo

   #. Install the packages:

      .. code-block:: console

         # yum install openstack-nova-api openstack-nova-conductor \
           openstack-nova-console openstack-nova-novncproxy \
           openstack-nova-scheduler openstack-nova-placement-api

      .. end

.. endonly

.. only:: ubuntu

   #. Install the packages:

      .. code-block:: console

         # apt install nova-api nova-conductor nova-consoleauth \
           nova-novncproxy nova-scheduler nova-placement-api

      .. end

.. endonly

.. only:: debian

   #. Install the packages:

      .. code-block:: console

         # apt install nova-api nova-conductor nova-consoleauth \
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

   .. only:: rdo or obs

      * In the ``[DEFAULT]`` section, enable only the compute and metadata
        APIs:

        .. path /etc/nova/nova.conf
        .. code-block:: ini

           [DEFAULT]
           # ...
           enabled_apis = osapi_compute,metadata

        .. end

   .. endonly

   * In the ``[api_database]`` and ``[database]`` sections, configure
     database access:

     .. path /etc/nova/nova.conf
     .. code-block:: ini

        [api_database]
        # ...
        connection = mysql+pymysql://nova:NOVA_DBPASS@controller/nova_api

        [database]
        # ...
        connection = mysql+pymysql://nova:NOVA_DBPASS@controller/nova

     .. end

     Replace ``NOVA_DBPASS`` with the password you chose for
     the Compute databases.

   * In the ``[DEFAULT]`` section, configure ``RabbitMQ``
     message queue access:

     .. path /etc/nova/nova.conf
     .. code-block:: ini

        [DEFAULT]
        # ...
        transport_url = rabbit://openstack:RABBIT_PASS@controller

     .. end

     Replace ``RABBIT_PASS`` with the password you chose for the
     ``openstack`` account in ``RabbitMQ``.

   * In the ``[api]`` and ``[keystone_authtoken]`` sections,
     configure Identity service access:

     .. path /etc/nova/nova.conf
     .. code-block:: ini

        [api]
        # ...
        auth_strategy = keystone

        [keystone_authtoken]
        # ...
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
        # ...
        my_ip = 10.0.0.11

     .. end

.. only:: obs or rdo or ubuntu

   * In the ``[DEFAULT]`` section, enable support for the Networking service:

     .. path /etc/nova/nova.conf
     .. code-block:: ini

        [DEFAULT]
        # ...
        use_neutron = True
        firewall_driver = nova.virt.firewall.NoopFirewallDriver

     .. end

     .. note::

        By default, Compute uses an internal firewall driver. Since the
        Networking service includes a firewall driver, you must disable the
        Compute firewall driver by using the
        ``nova.virt.firewall.NoopFirewallDriver`` firewall driver.

.. endonly

* In the ``[vnc]`` section, configure the VNC proxy to use the management
  interface IP address of the controller node:

  .. path /etc/nova/nova.conf
  .. code-block:: ini

     [vnc]
     enabled = true
     # ...
     vncserver_listen = $my_ip
     vncserver_proxyclient_address = $my_ip

  .. end

.. only:: debian

   * In the ``[spice]`` section, disable spice:

     .. path /etc/nova/nova.conf
     .. code-block:: ini

        [spice]
        enabled = false

     .. end

.. endonly

* In the ``[glance]`` section, configure the location of the
  Image service API:

  .. path /etc/nova/nova.conf
  .. code-block:: ini

     [glance]
     # ...
     api_servers = http://controller:9292

  .. end

.. only:: obs

   * In the ``[oslo_concurrency]`` section, configure the lock path:

   .. path /etc/nova/nova.conf
   .. code-block:: ini

      [oslo_concurrency]
      # ...
      lock_path = /var/run/nova

   .. end

.. endonly

.. only:: rdo

   * In the ``[oslo_concurrency]`` section, configure the lock path:

     .. path /etc/nova/nova.conf
     .. code-block:: ini

        [oslo_concurrency]
        # ...
        lock_path = /var/lib/nova/tmp

     .. end

.. endonly

.. only:: ubuntu

   * In the ``[oslo_concurrency]`` section, configure the lock path:

     .. path /etc/nova/nova.conf
     .. code-block:: ini

        [oslo_concurrency]
        # ...
        lock_path = /var/lib/nova/tmp

     .. end

.. endonly

.. only:: ubuntu

   .. todo:

      https://bugs.launchpad.net/ubuntu/+source/nova/+bug/1506667

   * Due to a packaging bug, remove the ``log_dir`` option from the
     ``[DEFAULT]`` section.

.. endonly

*  In the ``[placement]`` section, configure the Placement API:

   .. path /etc/nova/nova.conf
   .. code-block:: ini

      [placement]
      # ...
      os_region_name = RegionOne
      project_domain_name = Default
      project_name = service
      auth_type = password
      user_domain_name = Default
      auth_url = http://controller:35357/v3
      username = placement
      password = PLACEMENT_PASS

   Replace ``PLACEMENT_PASS`` with the password you choose for the
   ``placement`` user in the Identity service. Comment out any other options in
   the ``[placement]`` section.

.. only:: rdo

   *  Due to a `packaging bug
      <https://bugzilla.redhat.com/show_bug.cgi?id=1430540>`_, you must enable
      access to the Placement API by adding the following configuration to
      ``/etc/httpd/conf.d/00-nova-placement-api.conf``:

      .. path /etc/httpd/conf.d/00-nova-placement-api.conf
      .. code-block:: ini

         <Directory /usr/bin>
            <IfVersion >= 2.4>
               Require all granted
            </IfVersion>
            <IfVersion < 2.4>
               Order allow,deny
               Allow from all
            </IfVersion>
         </Directory>

.. endonly

.. only:: rdo or ubuntu or debian or obs

   3. Populate the nova-api database:

      .. code-block:: console

         # su -s /bin/sh -c "nova-manage api_db sync" nova

      .. end

      .. note::

         Ignore any deprecation messages in this output.

   4. Register the ``cell0`` database:

      .. code-block:: console

         # su -s /bin/sh -c "nova-manage cell_v2 map_cell0" nova

      .. end

   5. Create the ``cell1`` cell:

      .. code-block:: console

         # su -s /bin/sh -c "nova-manage cell_v2 create_cell --name=cell1 --verbose" nova
         109e1d4b-536a-40d0-83c6-5f121b82b650

      .. end

   6. Populate the nova database:

      .. code-block:: console

         # su -s /bin/sh -c "nova-manage db sync" nova

   7. Verify nova cell0 and cell1 are registered correctly:

      .. code-block:: console

         # nova-manage cell_v2 list_cells
         +-------+--------------------------------------+
         | Name  | UUID                                 |
         +-------+--------------------------------------+
         | cell1 | 109e1d4b-536a-40d0-83c6-5f121b82b650 |
         | cell0 | 00000000-0000-0000-0000-000000000000 |
         +-------+--------------------------------------+

      .. end

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

.. only:: debian

   * Shutdown ``nova-spicehtml5proxy``:

     .. code-block:: console

        # service nova-spicehtml5proxy stop

     .. end

   * Select novnc startup in ``/etc/default/nova-consoleproxy``:

     .. path /etc/default/nova-consoleproxy
     .. code-block:: ini

        NOVA_CONSOLE_PROXY_TYPE=novnc

     .. end

   * Add a systemd service file for nova-novncproxy in
     ``/lib/systemd/system/nova-novncproxy.service``:

     .. path /lib/systemd/system/nova-novncproxy.service:
     .. code-block:: ini

        [Unit]
        Description=OpenStack Compute NoVNC proxy
        After=postgresql.service mysql.service keystone.service rabbitmq-server.service ntp.service

        Documentation=man:nova-novncproxy(1)

        [Service]
        User=nova
        Group=nova
        Type=simple
        WorkingDirectory=/var/lib/nova
        PermissionsStartOnly=true
        ExecStartPre=/bin/mkdir -p /var/lock/nova /var/log/nova /var/lib/nova
        ExecStartPre=/bin/chown nova:nova /var/lock/nova /var/lib/nova
        ExecStartPre=/bin/chown nova:adm /var/log/nova
        ExecStart=/etc/init.d/nova-novncproxy systemd-start
        Restart=on-failure
        LimitNOFILE=65535
        TimeoutStopSec=65

        [Install]
        WantedBy=multi-user.target

     .. end

   * Start the noVNC proxy:

     .. code-block:: console

        # systemctl daemon-reload
        # systemctl enable nova-novncproxy
        # service start nova-novncproxy

     .. end

   * Restart the other Compute services:

     .. code-block:: console

        # service nova-api restart
        # service nova-consoleauth restart
        # service nova-scheduler restart
        # service nova-conductor restart

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
