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

#. Install the packages:

   .. code-block:: console

      # apt-get install nova-compute

   Respond to prompts for
   :doc:`database management <debconf/debconf-dbconfig-common>`,
   :doc:`Identity service credentials <debconf/debconf-keystone-authtoken>`,
   and :doc:`message broker credentials <debconf/debconf-rabbitmq>`. Make
   sure that you do not activate database management handling by debconf,
   as a compute node should not access the central database.

#. Edit the ``/etc/nova/nova.conf`` file and
   complete the following actions:

   * In the ``[DEFAULT]`` section, check that the ``my_ip`` option
     is correctly set (this value is handled by the config and postinst
     scripts of the ``nova-common`` package using debconf):

     .. code-block:: ini

        [DEFAULT]
        ...
        my_ip = MANAGEMENT_INTERFACE_IP_ADDRESS

     Replace ``MANAGEMENT_INTERFACE_IP_ADDRESS`` with the IP address
     of the management network interface on your compute node,
     typically 10.0.0.31 for the first node in the
     :ref:`example architecture <overview-example-architectures>`.

   * In the ``[DEFAULT]`` section, enable support for the Networking service:

     .. code-block:: ini

        [DEFAULT]
        ...
        use_neutron = True
        firewall_driver = nova.virt.firewall.NoopFirewallDriver

     .. note::

        By default, Compute uses an internal firewall service. Since
        Networking includes a firewall service, you must disable the Compute
        firewall service by using the
        ``nova.virt.firewall.NoopFirewallDriver`` firewall driver.

   * In the ``[vnc]`` section, enable and configure remote console access:

     .. code-block:: ini

        [vnc]
        ...
        enabled = True
        vncserver_listen = 0.0.0.0
        vncserver_proxyclient_address = $my_ip
        novncproxy_base_url = http://controller:6080/vnc_auto.html

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

     .. code-block:: ini

        [glance]
        ...
        api_servers = http://controller:9292

#. Ensure the kernel module ``nbd`` is loaded.

   .. code-block:: console

      # modprobe nbd

#. Ensure the module loads on every boot by adding ``nbd``
   to the ``/etc/modules-load.d/nbd.conf`` file.

Finalize installation
---------------------

#. Determine whether your compute node supports hardware acceleration
   for virtual machines:

   .. code-block:: console

      $ egrep -c '(vmx|svm)' /proc/cpuinfo

   If this command returns a value of ``one or greater``, your compute
   node supports hardware acceleration which typically requires no
   additional configuration.

   If this command returns a value of ``zero``, your compute node does
   not support hardware acceleration and you must configure ``libvirt``
   to use QEMU instead of KVM.

   * Replace the ``nova-compute-kvm`` package with ``nova-compute-qemu``
     which automatically changes the ``/etc/nova/nova-compute.conf``
     file and installs the necessary dependencies:

     .. code-block:: console

        # apt-get install nova-compute-qemu

#. Restart the Compute service:

   .. code-block:: console

      # service nova-compute restart
