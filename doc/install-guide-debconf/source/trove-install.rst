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

Install and configure components
--------------------------------

.. include:: shared/note_configuration_vary_by_distribution.rst

#. Install the packages:

   .. code-block:: console

      # apt-get update

      # apt-get install python-trove python-troveclient \
        python-glanceclient trove-common trove-api trove-taskmanager \
        trove-conductor

#. In ``/etc/trove``, edit the following configuration files,
   taking the below actions for each file:

   ``trove.conf``

   ``trove-taskmanager.conf``

   ``trove-conductor.conf``

   * Provide appropriate
     values for the following settings:

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

   * Configure the Database module to use the ``RabbitMQ`` message broker
     by setting the following options in the ``[DEFAULT]`` configuration
     group of each file:

     .. code-block:: ini

        [DEFAULT]
        ...
        rpc_backend = rabbit

        [oslo_messaging_rabbit]
        ...
        rabbit_host = controller
        rabbit_userid = openstack
        rabbit_password = RABBIT_PASS

#. Verify that the ``api-paste.ini``
   file is present in ``/etc/trove``.

   If the file is not present, you can get it from this
   `location <http://git.openstack.org/cgit/openstack/trove/plain/etc/trove/api-paste.ini?h=stable/mitaka>`__.

#. Edit the ``trove.conf`` file so it includes appropriate values for the
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

#. Edit the ``trove-taskmanager.conf`` file so it includes the required
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

#. In ``etc/trove``, edit the ``trove-guestagent.conf`` file
   so that future trove guests can connect to your OpenStack environment:

   .. code-block:: ini

      rabbit_host = controller
      rabbit_password = RABBIT_PASS
      nova_proxy_admin_user = admin
      nova_proxy_admin_pass = ADMIN_PASS
      nova_proxy_admin_tenant_name = service
      trove_auth_url = http://controller:35357/v2.0

#. Populate the trove database you created earlier in this procedure:

   .. code-block:: console

      # su -s /bin/sh -c "trove-manage db_sync" trove
        ...
        2016-04-06 22:00:17.771 10706 INFO trove.db.sqlalchemy.migration [-]
        Upgrading mysql://trove:dbaasdb@controller/trove to version latest

   .. note::

      Ignore any deprecation messages in this output.


Finalize installation
---------------------

#. Restart the Database services:

   .. code-block:: console

      # service trove-api restart
      # service trove-taskmanager restart
      # service trove-conductor restart
