.. _trove-install:

Install and configure
~~~~~~~~~~~~~~~~~~~~~

This section describes how to install and configure the
Database service, code-named trove, on the controller node.

This section assumes that you already have a working OpenStack
environment with at least the following components installed:
Compute, Image Service, Identity.

* If you want to do backup and restore, you also need Object Storage.

* If you want to provision datastores on block-storage volumes, you also
  need Block Storage.


.. only:: obs or rdo or ubuntu

   Prerequisites
   -------------

   Before you install and configure the Database service, you must create a
   database, service credentials, and API endpoints.

   #. To create the database, complete these steps:

      * Use the database access client to connect to the database
        server as the ``root`` user:

        .. code-block:: console

           $ mysql -u root -p

      * Create the ``trove`` database:

        .. code-block:: console

           CREATE DATABASE trove;

      * Grant proper access to the ``trove`` database:

        .. code-block:: console

           GRANT ALL PRIVILEGES ON trove.* TO 'trove'@'localhost' \
             IDENTIFIED BY 'TROVE_DBPASS';
           GRANT ALL PRIVILEGES ON trove.* TO 'trove'@'%' \
             IDENTIFIED BY 'TROVE_DBPASS';

        Replace ``TROVE_DBPASS`` with a suitable password.

      * Exit the database access client.

   #. Source the ``admin`` credentials to gain access to
      admin-only CLI commands:

      .. code-block:: console

         $ source admin-openrc.sh

   #. To create the service credentials, complete these steps:

      * Create the ``trove`` user:

        .. code-block:: console

           $ openstack user create --domain default --password-prompt trove
           User Password:
           Repeat User Password:
           +-----------+-----------------------------------+
           | Field     | Value                             |
           +-----------+-----------------------------------+
           | domain_id | default                           |
           | enabled   | True                              |
           | id        | ca2e175b851943349be29a328cc5e360  |
           | name      | trove                             |
           +-----------+-----------------------------------+

      * Add the ``admin`` role to the ``trove`` user:

        .. code-block:: console

           $ openstack role add --project service --user trove admin

        .. note::

           This command provides no output.

      * Create the ``trove`` service entity:

        .. code-block:: console

           $ openstack service create --name trove \
             --description "Database" database
           +-------------+-----------------------------------+
           | Field       | Value                             |
           +-------------+-----------------------------------+
           | description | Database                          |
           | enabled     | True                              |
           | id          | 727841c6f5df4773baa4e8a5ae7d72eb  |
           | name        | trove                             |
           | type        | database                          |
           +-------------+-----------------------------------+


   #. Create the Database service API endpoints:

      .. code-block:: console

         $ openstack endpoint create --region RegionOne \
           database public http://controller:8779/v1.0/%\(tenant_id\)s
         +--------------+----------------------------------------------+
         | Field        | Value                                        |
         +--------------+----------------------------------------------+
         | enabled      | True                                         |
         | id           | 3f4dab34624e4be7b000265f25049609             |
         | interface    | public                                       |
         | region       | RegionOne                                    |
         | region_id    | RegionOne                                    |
         | service_id   | 727841c6f5df4773baa4e8a5ae7d72eb             |
         | service_name | trove                                        |
         | service_type | database                                     |
         | url          | http://controller:8779/v1.0/%\(tenant_id\)s  |
         +--------------+----------------------------------------------+

         $ openstack endpoint create --region RegionOne \
           database internal http://controller:8779/v1.0/%\(tenant_id\)s
         +--------------+----------------------------------------------+
         | Field        | Value                                        |
         +--------------+----------------------------------------------+
         | enabled      | True                                         |
         | id           | 9489f78e958e45cc85570fec7e836d98             |
         | interface    | internal                                     |
         | region       | RegionOne                                    |
         | region_id    | RegionOne                                    |
         | service_id   | 727841c6f5df4773baa4e8a5ae7d72eb             |
         | service_name | trove                                        |
         | service_type | database                                     |
         | url          | http://controller:8779/v1.0/%\(tenant_id\)s  |
         +--------------+----------------------------------------------+

         $ openstack endpoint create --region RegionOne \
           database admin http://controller:8779/v1.0/%\(tenant_id\)s
         +--------------+----------------------------------------------+
         | Field        | Value                                        |
         +--------------+----------------------------------------------+
         | enabled      | True                                         |
         | id           | 76091559514b40c6b7b38dde790efe99             |
         | interface    | admin                                        |
         | region       | RegionOne                                    |
         | region_id    | RegionOne                                    |
         | service_id   | 727841c6f5df4773baa4e8a5ae7d72eb             |
         | service_name | trove                                        |
         | service_type | database                                     |
         | url          | http://controller:8779/v1.0/%\(tenant_id\)s  |
         +--------------+----------------------------------------------+

Install and configure components
--------------------------------

.. only:: obs or rdo or ubuntu

   .. include:: shared/note_configuration_vary_by_distribution.rst

.. only:: obs

   #. Install the packages:

      .. code-block:: console

         # zypper --quiet --non-interactive install python-oslo.db \
           python-MySQL-python

         # zypper --quiet --non-interactive install openstack-trove-api \
           openstack-trove-taskmanager openstack-trove-conductor \
           openstack-trove-guestagent

.. only:: rdo

   #. Install the packages:

      .. code-block:: console

         # yum install openstack-trove python-troveclient

.. only:: ubuntu

   #. Install the packages:

      .. code-block:: console

         # apt-get update

         # apt-get install python-trove python-troveclient \
           python-glanceclient trove-common trove-api trove-taskmanager \
           trove-conductor

.. only:: obs or rdo or ubuntu

2. In the ``/etc/trove`` directory, edit the ``trove.conf``,
   ``trove-taskmanager.conf`` and ``trove-conductor.conf`` files and
   complete the following steps:

   * Provide appropriate values for the following settings:

     .. code-block:: ini

        [DEFAULT]
        log_dir = /var/log/trove
        trove_auth_url = http://controller:5000/v2.0
        nova_compute_url = http://controller:8774/v2
        cinder_url = http://controller:8776/v1
        swift_url = http://controller:8080/v1/AUTH_
        notifier_queue_hostname = controller
        ...
        [database]
        connection = mysql://trove:TROVE_DBPASS@controller/trove

   * Configure the Database service to use the ``RabbitMQ`` message broker
     by setting the following options in each file:

     .. code-block:: ini

        [DEFAULT]
        ...
        rpc_backend = rabbit

        [oslo_messaging_rabbit]
        ...
        rabbit_host = controller
        rabbit_userid = openstack
        rabbit_password = RABBIT_PASS

3. Verify that the ``api-paste.ini`` file is present in ``/etc/trove``.

   If the file is not present, you can get it from this
   `location <http://git.openstack.org/cgit/openstack/trove/plain/etc/trove/api-paste.ini?h=mitaka-eol>`__.

4. Edit the ``trove.conf`` file so it includes appropriate values for the
   settings shown below:

   .. code-block:: ini

      [DEFAULT]
      auth_strategy = keystone
      ...
      # Config option for showing the IP address that nova doles out
      add_addresses = True
      network_label_regex = ^NETWORK_LABEL$
      ...
      api_paste_config = /etc/trove/api-paste.ini
      ...
      [keystone_authtoken]
      ...
      auth_uri = http://controller:5000
      auth_url = http://controller:35357
      auth_type = password
      project_domain_name = default
      user_domain_name = default
      project_name = service
      username = trove
      password = TROVE_PASS

5. Edit the ``trove-taskmanager.conf`` file so it includes the required
   settings to connect to the OpenStack Compute service as shown below:

   .. code-block:: ini

      [DEFAULT]
      ...
      # Configuration options for talking to nova via the novaclient.
      # These options are for an admin user in your keystone config.
      # It proxy's the token received from the user to send to nova
      # via this admin users creds,
      # basically acting like the client via that proxy token.
      nova_proxy_admin_user = admin
      nova_proxy_admin_pass = ADMIN_PASS
      nova_proxy_admin_tenant_name = service
      taskmanager_manager = trove.taskmanager.manager.Manager

6. Edit the ``/etc/trove/trove-guestagent.conf`` file
   so that future trove guests can connect to your OpenStack environment:

   .. code-block:: ini

      rabbit_host = controller
      rabbit_password = RABBIT_PASS
      nova_proxy_admin_user = admin
      nova_proxy_admin_pass = ADMIN_PASS
      nova_proxy_admin_tenant_name = service
      trove_auth_url = http://controller:35357/v2.0

7. Populate the trove database you created earlier in this procedure:

   .. code-block:: console

      # su -s /bin/sh -c "trove-manage db_sync" trove
        ...
        2016-04-06 22:00:17.771 10706 INFO trove.db.sqlalchemy.migration [-]
        Upgrading mysql://trove:dbaasdb@controller/trove to version latest

   .. note::

      Ignore any deprecation messages in this output.


Finalize installation
---------------------

.. only:: ubuntu

   1. Due to a bug in the Ubuntu packages, edit the service definition files
      to use the correct configuration settings.

      To do this, navigate to ``/etc/init`` and edit the following files
      as described below:

      ``trove-taskmanager.conf``

      ``trove-conductor.conf``

      (Note that, although they have the same names, these files are
      in a different location and have different content than the similarly
      named files you edited earlier in this procedure.)

      In each file, find this line:

      .. code-block:: ini

         exec start-stop-daemon --start --chdir /var/lib/trove \
            --chuid trove:trove --make-pidfile \
            --pidfile /var/run/trove/trove-conductor.pid \
            --exec /usr/bin/trove-conductor -- \
            --config-file=/etc/trove/trove.conf ${DAEMON_ARGS}

      Note that ``--config-file`` incorrectly points to ``trove.conf``.

      In ``trove-taskmanager.conf``, edit ``config-file`` to point to
      ``/etc/trove/trove-taskmanager.conf``.

      In ``trove-conductor.conf``, edit ``config-file`` to point to
      ``/etc/trove/trove-conductor.conf``.

   2. Restart the Database services:

      .. code-block:: console

         # service trove-api restart
         # service trove-taskmanager restart
         # service trove-conductor restart

.. only:: rdo or obs

   1. Start the Database services and configure them to start when
      the system boots:

      .. code-block:: console

         # systemctl enable openstack-trove-api.service \
           openstack-trove-taskmanager.service \
           openstack-trove-conductor.service

         # systemctl start openstack-trove-api.service \
           openstack-trove-taskmanager.service \
           openstack-trove-conductor.service

