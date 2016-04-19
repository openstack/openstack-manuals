.. _manila-storage:

Install and configure a share node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section describes how to install and configure a share node for the
Shared File Systems service.

Install and configure components
--------------------------------

.. include:: shared/note_configuration_vary_by_distribution.rst

#. Install the packages:

   .. only:: obs

      .. code-block:: console

         # zypper install openstack-manila-share python-PyMySQL

   .. only:: rdo

      .. code-block:: console

         # yum install openstack-manila-share python2-PyMySQL

   .. only:: ubuntu

      .. code-block:: console

         # apt-get install manila-share python-pymysql

#. Edit the ``/etc/manila/manila.conf`` file and complete the following
   actions:

   * In the ``[database]`` section, configure database access:

     .. only:: ubuntu or obs

        .. code-block:: ini

           [database]
           ...
           connection = mysql+pymysql://manila:MANILA_DBPASS@controller/manila

     .. only:: rdo

        .. code-block:: ini

           [database]
           ...
           connection = mysql://manila:MANILA_DBPASS@controller/manila

     Replace ``MANILA_DBPASS`` with the password you chose for
     the Share File System database.

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

   * In the ``[DEFAULT]`` section, set the following config values:

     .. code-block:: ini

        [DEFAULT]
        ...
        default_share_type = default_share_type
        rootwrap_config = /etc/manila/rootwrap.conf

   * In the ``[DEFAULT]`` and ``[keystone_authtoken]`` sections,
     configure Identity service access:

     .. code-block:: ini

        [DEFAULT]
        ...
        auth_strategy = keystone

        [keystone_authtoken]
        ...
        memcached_servers = controller:11211
        auth_uri = http://controller:5000
        auth_url = http://controller:35357
        auth_plugin = password
        project_domain_name = default
        user_domain_name = default
        project_name = service
        username = manila
        password = MANILA_PASS

     Replace ``MANILA_PASS`` with the password you chose for the ``manila``
     user in the Identity service.

   * In the ``[DEFAULT]`` section, configure the ``my_ip`` option:

     .. code-block:: ini

        [DEFAULT]
        ...
        my_ip = MANAGEMENT_INTERFACE_IP_ADDRESS

     Replace ``MANAGEMENT_INTERFACE_IP_ADDRESS`` with the IP address
     of the management network interface on your share node,
     typically 10.0.0.41 for the first node in the
     :ref:`example architecture <overview-example-architectures>`.

   * In the ``[oslo_concurrency]`` section, configure the lock path:

     .. code-block:: ini

        [oslo_concurrency]
        ...
        lock_path = /var/lib/manila/tmp

Configure share server management support options
-------------------------------------------------

The share node can support two modes, with and without the handling of
share servers. The mode depends on driver support.

Option 1 deploys the service without driver support for share management. In
this mode, the service does not do anything related to networking. The operator
must ensure network connectivity between instances and the NFS server. This
option uses LVM driver that requires LVM and NFS packages as well as an
additional disk for the ``manila-share`` LVM volume group.

Option 2 deploys the service with driver support for share management. In this
mode, the service requires Compute (nova), Networking (neutron) and Block
storage (cinder) services for managing share servers. The information used for
creating share servers is configured as share networks. This option uses the
generic driver with the handling of share servers capacity and requires
attaching the ``selfservice`` network to a router.

.. warning::

   A bug prevents using both driver options on the same share node.
   For more information, see LVM Driver section at the
   `Configuration Reference <http://docs.openstack.org/mitaka/config-reference/content/section_share-drivers.html>`__.

Choose one of the following options to configure the share driver.
Afterwards, return here and proceed to
:ref:`manila-share-finalize-install`.

.. toctree::
   :maxdepth: 1

   manila-share-install-dhss-false-option1.rst
   manila-share-install-dhss-true-option2.rst

.. _manila-share-finalize-install:

Finalize installation
---------------------

.. only:: obs

   * Start the Share File Systems service including its dependencies
     and configure them to start when the system boots:

     .. code-block:: console

        # systemctl enable openstack-manila-share.service
        # systemctl start openstack-manila-share.service

.. only:: rdo

   * Start the Share File Systems service including its dependencies
     and configure them to start when the system boots:

     .. code-block:: console

        # systemctl enable openstack-manila-share.service
        # systemctl start openstack-manila-share.service

.. only:: ubuntu

   * Start the Share File Systems service including its dependencies:

     .. code-block:: console

        # service manila-share restart
