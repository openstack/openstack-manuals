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
   fashion to the first compute node in the :ref:`example architectures
   <overview-example-architectures>` section. Each additional compute node
   requires a unique IP address.

Install and configure components
--------------------------------

.. include:: shared/note_configuration_vary_by_distribution.rst

.. only:: obs

   #. Install the packages:

      .. code-block:: console

         # zypper install openstack-nova-compute genisoimage qemu-kvm libvirt

      .. end

.. endonly

.. only:: rdo

   #. Install the packages:

      .. code-block:: console

         # yum install openstack-nova-compute

      .. end

.. endonly

.. only:: ubuntu or debian

   #. Install the packages:

      .. code-block:: console

         # apt install nova-compute

      .. end

.. endonly

      .. only:: debian

         Respond to prompts for debconf.

         .. :doc:`database management <debconf/debconf-dbconfig-common>`,
            :doc:`Identity service credentials <debconf/debconf-keystone-authtoken>`,
            and :doc:`message broker credentials <debconf/debconf-rabbitmq>`. Make
            sure that you do not activate database management handling by debconf,
            as a compute node should not access the central database.

      .. endonly

2. Edit the ``/etc/nova/nova.conf`` file and
   complete the following actions:

   .. only:: rdo or obs

      * In the ``[DEFAULT]`` section, enable only the compute and
        metadata APIs:

        .. path /etc/nova/nova.conf
        .. code-block:: ini

           [DEFAULT]
           # ...
           enabled_apis = osapi_compute,metadata

        .. end

   .. endonly

   .. only:: obs

      * In the ``[DEFAULT]`` section, set the ``compute_driver``:

        .. path /etc/nova/nova.conf
        .. code-block:: ini

           [DEFAULT]
           # ...
           compute_driver = libvirt.LibvirtDriver

        .. end

   .. endonly

   * In the ``[DEFAULT]`` section, configure ``RabbitMQ``
     message queue access:

     .. path /etc/nova/nova.conf
     .. code-block:: ini

        [DEFAULT]
        # ...
        transport_url = rabbit://openstack:RABBIT_PASS@controller

     .. end

     Replace ``RABBIT_PASS`` with the password you chose for
     the ``openstack`` account in ``RabbitMQ``.

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

   .. only:: debian

      * In the ``[DEFAULT]`` section, check that the ``my_ip`` option
        is correctly set (this value is handled by the config and postinst
        scripts of the ``nova-common`` package using debconf):

        .. path /etc/nova/nova.conf
        .. code-block:: ini

           [DEFAULT]
           # ...
           my_ip = MANAGEMENT_INTERFACE_IP_ADDRESS

        .. end

        Replace ``MANAGEMENT_INTERFACE_IP_ADDRESS`` with the IP address
        of the management network interface on your compute node,
        typically 10.0.0.31 for the first node in the
        :ref:`example architecture <overview-example-architectures>`.

   .. endonly

   .. only:: obs or rdo or ubuntu

      * In the ``[DEFAULT]`` section, configure the ``my_ip`` option:

        .. path /etc/nova/nova.conf
        .. code-block:: ini

           [DEFAULT]
           # ...
           my_ip = MANAGEMENT_INTERFACE_IP_ADDRESS

        .. end

        Replace ``MANAGEMENT_INTERFACE_IP_ADDRESS`` with the IP address
        of the management network interface on your compute node,
        typically 10.0.0.31 for the first node in the
        :ref:`example architecture <overview-example-architectures>`.

      * In the ``[DEFAULT]`` section, enable support for the Networking service:

        .. path /etc/nova/nova.conf
        .. code-block:: ini

           [DEFAULT]
           # ...
           use_neutron = True
           firewall_driver = nova.virt.firewall.NoopFirewallDriver

        .. end

        .. note::

           By default, Compute uses an internal firewall service. Since
           Networking includes a firewall service, you must disable the Compute
           firewall service by using the
           ``nova.virt.firewall.NoopFirewallDriver`` firewall driver.

   .. endonly

   * In the ``[vnc]`` section, enable and configure remote console access:

     .. path /etc/nova/nova.conf
     .. code-block:: ini

        [vnc]
        # ...
        enabled = True
        vncserver_listen = 0.0.0.0
        vncserver_proxyclient_address = $my_ip
        novncproxy_base_url = http://controller:6080/vnc_auto.html

     .. end

     The server component listens on all IP addresses and the proxy
     component only listens on the management interface IP address of
     the compute node. The base URL indicates the location where you
     can use a web browser to access remote consoles of instances
     on this compute node.

     .. note::

        If the web browser to access remote consoles resides on
        a host that cannot resolve the ``controller`` hostname,
        you must replace ``controller`` with the management
        interface IP address of the controller node.

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

   .. only:: rdo or ubuntu

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
      ``placement`` user in the Identity service. Comment out any other options
      in the ``[placement]`` section.

.. only:: obs or debian

   3. Ensure the kernel module ``nbd`` is loaded.

      .. code-block:: console

         # modprobe nbd

      .. end

   4. Ensure the module loads on every boot by adding ``nbd``
      to the ``/etc/modules-load.d/nbd.conf`` file.

.. endonly

Finalize installation
---------------------

#. Determine whether your compute node supports hardware acceleration
   for virtual machines:

   .. code-block:: console

      $ egrep -c '(vmx|svm)' /proc/cpuinfo

   .. end

   If this command returns a value of ``one or greater``, your compute
   node supports hardware acceleration which typically requires no
   additional configuration.

   If this command returns a value of ``zero``, your compute node does
   not support hardware acceleration and you must configure ``libvirt``
   to use QEMU instead of KVM.

   .. only:: obs or rdo

      * Edit the ``[libvirt]`` section in the
        ``/etc/nova/nova.conf`` file as follows:

        .. path /etc/nova/nova.conf
        .. code-block:: ini

           [libvirt]
           # ...
           virt_type = qemu

        .. end

   .. endonly

   .. only:: ubuntu

      * Edit the ``[libvirt]`` section in the
        ``/etc/nova/nova-compute.conf`` file as follows:

        .. path /etc/nova/nova-compute.conf
        .. code-block:: ini

           [libvirt]
           # ...
           virt_type = qemu

        .. end

   .. endonly

   .. only:: debian

      * Replace the ``nova-compute-kvm`` package with ``nova-compute-qemu``
        which automatically changes the ``/etc/nova/nova-compute.conf``
        file and installs the necessary dependencies:

        .. code-block:: console

           # apt install nova-compute-qemu

        .. end

   .. endonly

.. only:: obs or rdo

   2. Start the Compute service including its dependencies and configure
      them to start automatically when the system boots:

      .. code-block:: console

         # systemctl enable libvirtd.service openstack-nova-compute.service
         # systemctl start libvirtd.service openstack-nova-compute.service

      .. end

.. endonly

.. only:: ubuntu or debian

   2. Restart the Compute service:

      .. code-block:: console

         # service nova-compute restart

      .. end

.. endonly

.. note::

   If the ``nova-compute`` service fails to start, check
   ``/var/log/nova/nova-compute.log``. The error message
   ``AMQP server on controller:5672 is unreachable`` likely indicates that
   the firewall on the controller node is preventing access to port 5672.
   Configure the firewall to open port 5672 on the controller node and
   restart ``nova-compute`` service on the compute node.

Add the compute node to the cell database
-----------------------------------------

.. important::

   Run the following commands on the **controller** node.

#. Source the admin credentials to enable admin-only CLI commands, then
   confirm there are compute hosts in the database:

   .. code-block:: console

      $ . admin-openrc

      $ openstack hypervisor list
      +----+---------------------+-----------------+-----------+-------+
      | ID | Hypervisor Hostname | Hypervisor Type | Host IP   | State |
      +----+---------------------+-----------------+-----------+-------+
      |  1 | compute1            | QEMU            | 10.0.0.31 | up    |
      +----+---------------------+-----------------+-----------+-------+

#. Discover compute hosts:

   .. code-block:: console

      # su -s /bin/sh -c "nova-manage cell_v2 discover_hosts --verbose" nova

      Found 2 cell mappings.
      Skipping cell0 since it does not contain hosts.
      Getting compute nodes from cell 'cell1': ad5a5985-a719-4567-98d8-8d148aaae4bc
      Found 1 computes in cell: ad5a5985-a719-4567-98d8-8d148aaae4bc
      Checking host mapping for compute host 'compute': fe58ddc1-1d65-4f87-9456-bc040dc106b3
      Creating host mapping for compute host 'compute': fe58ddc1-1d65-4f87-9456-bc040dc106b3

   .. note::

      When you add new compute nodes, you must run ``nova-manage cell_v2
      discover_hosts`` on the controller node to register those new compute
      nodes. Alternatively, you can set an appropriate interval in
      ``/etc/nova/nova.conf``:

      .. code-block:: ini

         [scheduler]
         discover_hosts_in_cells_interval = 300
