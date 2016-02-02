.. _manila-storage:

Install and configure a share node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section describes how to install and configure a share node for the
Shared File Systems service. For simplicity, this configuration references one
storage node with the generic driver managing the share servers. The
generic backend manages share servers using compute, networking and block
services for provisioning shares.

.. Note::
   The manila-share process can run in two modes, with and without handling of
   share servers. In general it depends of the driver support.

Install and configure components
--------------------------------

#. Install the packages:

   .. only:: obs

      .. code-block:: console

         # zypper install openstack-manila python-PyMySQL

   .. only:: rdo

      .. code-block:: console

         # yum install openstack-manila targetcli python-oslo-policy

   .. only:: ubuntu

      .. code-block:: console

         # apt-get install manila-common python-pymysql

#. Install neutron agent packages needed for generic driver:

   .. only:: obs

      .. code-block:: console

         # zypper install --no-recommends openstack-neutron-linuxbridge-agent ipset

   .. only:: rdo

      .. code-block:: console

         # yum install openstack-neutron openstack-neutron-linuxbridge ebtables ipset

   .. only:: ubuntu

      .. code-block:: console

         # apt-get install neutron-plugin-linuxbridge-agent conntrack

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
        share_name_template = share-%s
        rootwrap_config = /etc/manila/rootwrap.conf
        api_paste_config = /etc/manila/api-paste.ini

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

   * Edit the ``/etc/manila/manila.conf`` file, configure nova, cinder and
     neutron credentials:

     .. code-block:: ini

        [DEFAULT]
        ...
        nova_admin_auth_url=http://controller:5000/v2.0
        nova_admin_tenant_name=service
        nova_admin_username=nova
        nova_admin_password=NOVA_PASS

        cinder_admin_auth_url=http://controller:5000/v2.0
        cinder_admin_tenant_name=service
        cinder_admin_username=cinder
        cinder_admin_password=CINDER_PASS

        neutron_admin_auth_url=http://controller:5000/v2.0
        neutron_url=http://controller:9696
        neutron_admin_project_name=service
        neutron_admin_username=neutron
        neutron_admin_password=NEUTRON_PASS

   * In the ``[generic]`` section, configure the generic share driver:

     .. code-block:: ini

        [generic]
        share_backend_name = GENERIC
        share_driver = manila.share.drivers.generic.GenericShareDriver

   * In the ``[generic]`` section, enable driver handles share servers (DHSS),
     setup flavor (m1.small has id=2) and image configurations:

     .. code-block:: ini

        driver_handles_share_servers = True

        service_instance_flavor_id = 2

        service_image_name = manila-service-image
        service_instance_user = manila
        service_instance_password = manila

   * In the ``[generic]`` section, configure linux bridge for interface
     driver:

     .. code-block:: ini

        interface_driver = manila.network.linux.interface.BridgeInterfaceDriver

   * In the ``[DEFAULT]`` section, enable the generic back end:

     .. note::

        Back-end names are arbitrary. As an example, this guide
        uses the name of the driver as the name of the back end.

     .. code-block:: ini

        [DEFAULT]
        ...
        enabled_share_backends = generic
        enabled_share_protocols = NFS,CIFS

   * In the ``[oslo_concurrency]`` section, configure the lock path:

     .. code-block:: ini

        [oslo_concurrency]
        ...
        lock_path = /var/lib/manila/tmp

Finalize installation
---------------------
#. Prepare manila-share as start/stop service:

   .. only:: obs

     * Start the Share File System service including its dependencies
       and configure them to start when the system boots:

       .. code-block:: console

          # systemctl enable openstack-manila-volume.service tgtd.service
          # systemctl start openstack-manila-volume.service tgtd.service

   .. only:: rdo

     * Start the Share File System service including its dependencies
       and configure them to start when the system boots:

       .. code-block:: console

          # systemctl enable openstack-manila-share.service target.service
          # systemctl start openstack-manila-share.service target.service

   .. only:: ubuntu

      * Start the Share File System service including its dependencies:

        .. code-block:: console

           # service manila-share restart

      * By default, the Ubuntu packages create an SQLite database.
        Because this configuration uses an SQL database server,
        remove the SQLite database file:

        .. code-block:: console

           # rm -f /var/lib/manila/manila.sqlite
