Install and configure controller node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section describes how to install and configure the
Compute service, code-named nova, on the controller node.

Install and configure components
--------------------------------

.. include:: shared/note_configuration_vary_by_distribution.rst

#. Install the packages:

   .. code-block:: console

      # apt-get install nova-api nova-conductor nova-consoleauth \
        nova-consoleproxy nova-scheduler python-novaclient

   Respond to prompts for
   :doc:`database management <debconf/debconf-dbconfig-common>`,
   :doc:`Identity service credentials <debconf/debconf-keystone-authtoken>`,
   :doc:`service endpoint registration <debconf/debconf-api-endpoints>`,
   and :doc:`message broker credentials <debconf/debconf-rabbitmq>`.

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

#. Edit the ``/etc/nova/nova.conf`` file and
   complete the following actions:

   * In the ``[DEFAULT]`` section, enable only the compute and metadata
     APIs:

     .. code-block:: ini

        [DEFAULT]
        ...
        enabled_apis = osapi_compute,metadata

   * The ``.config`` and ``.postinst`` maintainer scripts of the
     ``nova-common`` package detect automatically the IP address which
     goes in the ``my_ip`` directive of the ``[DEFAULT]`` section. This
     value will normally still be prompted, and you can check that it
     is correct in the nova.conf after ``nova-common`` is installed:

     .. code-block:: ini

        [DEFAULT]
        ...
        my_ip = 10.0.0.11

   * In the ``[DEFAULT]`` section, enable support for the Networking service:

     .. code-block:: ini

        [DEFAULT]
        ...
        use_neutron = True
        firewall_driver = nova.virt.firewall.NoopFirewallDriver

     .. note::

        By default, Compute uses an internal firewall driver. Since the
        Networking service includes a firewall driver, you must disable the
        Compute firewall driver by using the
        ``nova.virt.firewall.NoopFirewallDriver`` firewall driver.

   * In the ``[vnc]`` section, configure the VNC proxy to use the management
     interface IP address of the controller node:

     .. code-block:: ini

        [vnc]
        ...
        vncserver_listen = $my_ip
        vncserver_proxyclient_address = $my_ip

   * In the ``[glance]`` section, configure the location of the
     Image service API:

     .. code-block:: ini

        [glance]
        ...
        api_servers = http://controller:9292

Finalize installation
---------------------

* Restart the Compute services:

  .. code-block:: console

     # service nova-api restart
     # service nova-consoleauth restart
     # service nova-scheduler restart
     # service nova-conductor restart
     # service nova-novncproxy restart
