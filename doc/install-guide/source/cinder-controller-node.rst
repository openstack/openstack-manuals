=====================================
Install and configure controller node
=====================================

This section describes how to install and configure the Block
Storage service, code-named cinder, on the controller node. This
service requires at least one additional storage node that provides
volumes to instances.

To configure prerequisites
~~~~~~~~~~~~~~~~~~~~~~~~~~

Before you install and configure the Block Storage service, you
must create a database, service credentials, and API endpoint.

#. To create the database, complete these steps:

   * Use the database access client to connect to the database
     server as the ``root`` user:

     .. code-block:: console

        $ mysql -u root -p

   * Create the ``cinder`` database:

     .. code-block:: console

        CREATE DATABASE cinder;

   * Grant proper access to the ``cinder`` database:

     .. code-block:: console

        GRANT ALL PRIVILEGES ON cinder.* TO 'cinder'@'localhost' \
          IDENTIFIED BY 'CINDER_DBPASS';
        GRANT ALL PRIVILEGES ON cinder.* TO 'cinder'@'%' \
          IDENTIFIED BY 'CINDER_DBPASS';

     Replace ``CINDER_DBPASS`` with a suitable password.

   * Exit the database access client.

#. Source the ``admin`` credentials to gain access to admin-only
   CLI commands:

   .. code-block:: console

      $ source admin-openrc.sh

#. To create the service credentials, complete these steps:

   * Create a ``cinder`` user:

     .. code-block:: console

        $ openstack user create --password-prompt cinder
        User Password:
        Repeat User Password:
        +----------+----------------------------------+
        | Field    | Value                            |
        +----------+----------------------------------+
        | email    | None                             |
        | enabled  | True                             |
        | id       | 881ab2de4f7941e79504a759a83308be |
        | name     | cinder                           |
        | username | cinder                           |
        +----------+----------------------------------+

   * Add the ``admin`` role to the ``cinder`` user:

     .. code-block:: console

        $ openstack role add --project service --user cinder admin
        +-------+----------------------------------+
        | Field | Value                            |
        +-------+----------------------------------+
        | id    | cd2cb9a39e874ea69e5d4b896eb16128 |
        | name  | admin                            |
        +-------+----------------------------------+

   * Create the ``cinder`` service entities:

     .. code-block:: console

        $ openstack service create --name cinder \
          --description "OpenStack Block Storage" volume
        +-------------+----------------------------------+
        | Field       | Value                            |
        +-------------+----------------------------------+
        | description | OpenStack Block Storage          |
        | enabled     | True                             |
        | id          | 1e494c3e22a24baaafcaf777d4d467eb |
        | name        | cinder                           |
        | type        | volume                           |
        +-------------+----------------------------------+

     .. code-block:: console

        $ openstack service create --name cinderv2 \
          --description "OpenStack Block Storage" volumev2
        +-------------+----------------------------------+
        | Field       | Value                            |
        +-------------+----------------------------------+
        | description | OpenStack Block Storage          |
        | enabled     | True                             |
        | id          | 16e038e449c94b40868277f1d801edb5 |
        | name        | cinderv2                         |
        | type        | volumev2                         |
        +-------------+----------------------------------+

     .. note::

        The Block Storage service requires both the ``volume`` and
        ``volumev2`` services. However, both services use the same API
        endpoint that references the Block Storage version 2 API.

#. Create the Block Storage service API endpoints:

   .. code-block:: console

      $ openstack endpoint create \
        --publicurl http://controller:8776/v2/%\(tenant_id\)s \
        --internalurl http://controller:8776/v2/%\(tenant_id\)s \
        --adminurl http://controller:8776/v2/%\(tenant_id\)s \
        --region RegionOne \
        volume
      +--------------+-----------------------------------------+
      | Field        | Value                                   |
      +--------------+-----------------------------------------+
      | adminurl     | http://controller:8776/v2/%(tenant_id)s |
      | id           | d1b7291a2d794e26963b322c7f2a55a4        |
      | internalurl  | http://controller:8776/v2/%(tenant_id)s |
      | publicurl    | http://controller:8776/v2/%(tenant_id)s |
      | region       | RegionOne                               |
      | service_id   | 1e494c3e22a24baaafcaf777d4d467eb        |
      | service_name | cinder                                  |
      | service_type | volume                                  |
      +--------------+-----------------------------------------+

   .. code-block:: console

      $ openstack endpoint create \
        --publicurl http://controller:8776/v2/%\(tenant_id\)s \
        --internalurl http://controller:8776/v2/%\(tenant_id\)s \
        --adminurl http://controller:8776/v2/%\(tenant_id\)s \
        --region RegionOne \
        volumev2
      +--------------+-----------------------------------------+
      | Field        | Value                                   |
      +--------------+-----------------------------------------+
      | adminurl     | http://controller:8776/v2/%(tenant_id)s |
      | id           | 097b4a6fc8ba44b4b10d4822d2d9e076        |
      | internalurl  | http://controller:8776/v2/%(tenant_id)s |
      | publicurl    | http://controller:8776/v2/%(tenant_id)s |
      | region       | RegionOne                               |
      | service_id   | 16e038e449c94b40868277f1d801edb5        |
      | service_name | cinderv2                                |
      | service_type | volumev2                                |
      +--------------+-----------------------------------------+

To install and configure Block Storage controller components
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. only:: obs

   #. Install the packages:

      .. code-block:: console

         # zypper install openstack-cinder-api openstack-cinder-scheduler python-cinderclient

.. only:: rdo

   #. Install the packages:

      .. code-block:: console

         # yum install openstack-cinder python-cinderclient python-oslo-db

.. only:: ubuntu

   #. Install the packages:

      .. code-block:: console

         # apt-get install cinder-api cinder-scheduler python-cinderclient

2.

   .. only:: rdo

      .. Workaround for https://bugzilla.redhat.com/show_bug.cgi?id=1212900.

      Copy the ``/usr/share/cinder/cinder-dist.conf`` file
      to ``/etc/cinder/cinder.conf``.

      .. code-block:: console

         # cp /usr/share/cinder/cinder-dist.conf /etc/cinder/cinder.conf
         # chown -R cinder:cinder /etc/cinder/cinder.conf



   Edit the ``/etc/cinder/cinder.conf`` file and complete the
   following actions:

   * In the ``[database]`` section, configure database access:

     .. code-block:: ini

        [database]
        ...
        connection = mysql+pymysql://cinder:CINDER_DBPASS@controller/cinder

     Replace ``CINDER_DBPASS`` with the password you chose for the
     Block Storage database.

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
        username = cinder
        password = CINDER_PASS

     Replace ``CINDER_PASS`` with the password you chose for
     the ``cinder`` user in the Identity service.

     .. note::

        Comment out or remove any other options in the
        ``[keystone_authtoken]`` section.

   * In the ``[DEFAULT]`` section, configure the ``my_ip`` option to
     use the management interface IP address of the controller node:

     .. code-block:: ini

        [DEFAULT]
        ...
        my_ip = 10.0.0.11

   * In the ``[oslo_concurrency]`` section, configure the lock path:

     .. code-block:: ini

        [oslo_concurrency]
        ...
        lock_path = /var/lock/cinder

   * (Optional) To assist with troubleshooting, enable verbose
     logging in the ``[DEFAULT]`` section:

     .. code-block:: ini

        [DEFAULT]
        ...
        verbose = True

3. Populate the Block Storage database:

   .. code-block:: console

      # su -s /bin/sh -c "cinder-manage db sync" cinder

To finalize installation
~~~~~~~~~~~~~~~~~~~~~~~~

.. only:: obs or rdo

   #. Start the Block Storage services and configure them to start when
      the system boots:


      .. code-block:: console

         # systemctl enable openstack-cinder-api.service openstack-cinder-scheduler.service
         # systemctl start openstack-cinder-api.service openstack-cinder-scheduler.service

.. only:: ubuntu

   #. Restart the Block Storage services:

      .. code-block:: console

         # service cinder-scheduler restart
         # service cinder-api restart

   #. By default, the Ubuntu packages create an SQLite database.

      Because this configuration uses an SQL database server,
      you can remove the SQLite database file:

      .. code-block:: console

         # rm -f /var/lib/cinder/cinder.sqlite
