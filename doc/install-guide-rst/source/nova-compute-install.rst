Install and configure a compute node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section describes how to install and configure the Compute
service on a compute node. The service supports several
:term:`hypervisors <hypervisor>` to deploy :term:`instances <instance>`
or :term:`VMs <virtual machine (VM)>`. For simplicity, this configuration
uses the :term:`QEMU <Quick EMUlator (QEMU)>` hypervisor with the
:term:`KVM <kernel-based VM (KVM)>` extension
on compute nodes that support hardware acceleration for virtual machines.
On legacy hardware, this configuration uses the generic QEMU hypervisor.
You can follow these instructions with minor modifications to horizontally
scale your environment with additional compute nodes.

.. note::

   This section assumes that you are following the instructions in
   this guide step-by-step to configure the first compute node. If you
   want to configure additional compute nodes, prepare them in a similar
   fashion to the first compute node in the example architectures
   section using the same networking service as your existing
   environment. For either networking service, follow the NTP
   configuration and OpenStack packages instructions.
   For OpenStack Networking (neutron), also follow the OpenStack
   Networking compute node instructions. For legacy networking
   (nova-network), also follow the legacy networking compute node
   instructions. Each additional compute node requires unique IP
   addresses.

.. TODO: add link to each section after migration.

To install and configure the Compute hypervisor components
----------------------------------------------------------

.. note::

   Default configuration files vary by distribution. You might need
   to add these sections and options rather than modifying existing
   sections and options. Also, an ellipsis (...) in the configuration
   snippets indicates potential default configuration options that you
   should retain.

.. only:: obs

   1. Install the packages:

      .. code-block:: console

         # zypper install openstack-nova-compute genisoimage kvm libvirt

.. only:: rdo

   1. Install the packages:

      .. code-block:: console

         # yum install openstack-nova-compute sysfsutils

.. only:: ubuntu

   1. Install the packages:

      .. code-block:: console

         # apt-get install nova-compute sysfsutils

2. Edit the :file:`/etc/nova/nova.conf` file and
   complete the following actions:

   * In the ``[DEFAULT]`` and [oslo_messaging_rabbit]
     sections, configure ``RabbitMQ`` message queue access:

     .. code-block:: ini
        :linenos:

        [DEFAULT]
        ...
        rpc_backend = rabbit

        [oslo_messaging_rabbit]
        ...
        rabbit_host = controller
        rabbit_userid = openstack
        rabbit_password = RABBIT_PASS

     Replace ``RABBIT_PASS`` with the password you chose for
     the ``openstack`` account in ``RabbitMQ``.

   * In the ``[DEFAULT]`` and ``[keystone_authtoken]`` sections,
     configure Identity service access:

     .. code-block:: ini
        :linenos:

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

   * In the ``[DEFAULT]`` section, configure the ``my_ip`` option:

     .. code-block:: ini
        :linenos:

        [DEFAULT]
        ...
        my_ip = MANAGEMENT_INTERFACE_IP_ADDRESS

     Replace ``MANAGEMENT_INTERFACE_IP_ADDRESS`` with the IP address
     of the management network interface on your compute node,
     typically 10.0.0.31 for the first node in the
     example architecture.

     .. TODO: add link to architecture section atfer migration

   * In the ``[DEFAULT]`` section, enable and configure remote console
     access:

     .. code-block:: ini
        :linenos:

        [DEFAULT]
        ...
        vnc_enabled = True
        vncserver_listen = 0.0.0.0
        vncserver_proxyclient_address = MANAGEMENT_INTERFACE_IP_ADDRESS
        novncproxy_base_url = http://controller:6080/vnc_auto.html

     The server component listens on all IP addresses and the proxy
     component only listens on the management interface IP address of
     the compute node. The base URL indicates the location where you
     can use a web browser to access remote consoles of instances
     on this compute node.

     Replace ``MANAGEMENT_INTERFACE_IP_ADDRESS`` with
     the IP address of the management network interface on your
     compute node, typically 10.0.0.31 for the first node in the
     example architecture.

     .. TODO: add link to architecture section atfer migration

     .. note::

        If the web browser to access remote consoles resides on
        a host that cannot resolve the ``controller`` hostname,
        you must replace ``controller`` with the management
        interface IP address of the controller node.

   * In the ``[glance]`` section, configure the location of the
     Image service:

     .. code-block:: ini
        :linenos:

        [glance]
        ...
        host = controller

   .. only:: obs

      * In the ``[oslo_concurrency]`` section, configure the lock path:

        .. code-block:: ini
           :linenos:

           [oslo_concurrency]
           ...
           lock_path = /var/run/nova

   .. only:: rdo or ubuntu

      * In the ``[oslo_concurrency]`` section, configure the lock path:

        .. code-block:: ini
           :linenos:

           [oslo_concurrency]
           ...
           lock_path = /var/lib/nova/tmp

   * (Optional) To assist with troubleshooting,
     enable verbose logging in the ``[DEFAULT]`` section:

     .. code-block:: ini
        :linenos:

        [DEFAULT]
        ...
        verbose = True

.. only:: obs

   3.

      * Ensure the kernel module ``nbd`` is loaded.

        .. code-block:: console

           # modprobe nbd

      * Ensure the module will be loaded on every boot by adding
        ``nbd`` in the :file:`/etc/modules-load.d/nbd.conf` file.

To finalize installation
------------------------

1. Determine whether your compute node supports hardware acceleration
   for virtual machines:

   .. code-block:: console

      $ egrep -c '(vmx|svm)' /proc/cpuinfo

   If this command returns a value of ``one or greater``, your compute
   node supports hardware acceleration which typically requires no
   additional configuration.

   If this command returns a value of ``zero``, your compute node does
   not support hardware acceleration and you must configure ``libvirt``
   to use QEMU instead of KVM.

   .. only:: obs or rdo

      * Edit the ``[libvirt]`` section in the
        :file:`/etc/nova/nova.conf` file as follows:

        .. code-block:: ini
           :linenos:

           [libvirt]
           ...
           virt_type = qemu

   .. only:: ubuntu

      * Edit the ``[libvirt]`` section in the
        :file:`/etc/nova/nova-compute.conf` file as follows:

        .. code-block:: ini
           :linenos:

           [libvirt]
           ...
           virt_type = qemu

.. only:: obs or rdo

   2. Start the Compute service including its dependencies and configure
      them to start automatically when the system boots:

      .. code-block:: console

         # systemctl enable libvirtd.service openstack-nova-compute.service
         # systemctl start libvirtd.service openstack-nova-compute.service

.. only:: ubuntu

   2. Restart the Compute service:

      .. code-block:: console

         # service nova-compute restart

   3. By default, the Ubuntu packages create an SQLite database.

      Because this configuration uses a SQL database server, you can
      remove the SQLite database file:

      .. code-block:: console

         # rm -f /var/lib/nova/nova.sqlite
