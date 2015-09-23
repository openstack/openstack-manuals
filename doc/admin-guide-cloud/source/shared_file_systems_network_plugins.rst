.. _shared_file_systems_network_plugins:

================
Network plug-ins
================

The Shared File Systems service architecture defines an abstraction layer for
network resource provisioning and allowing administrators to choose from a
different options for how network resources are assigned to their tenants’
networked storage. There are a set of network plugins that provide a variety
of integration approaches with the network services that are available with
OpenStack.

The Shared File Systems service may need a network resource provisioning if
share service with specified driver works in mode, when share driver manage
life cycle of share servers on its own. This behavior defines by flag
``driver_handles_share_servers`` in share service configuration.  When
``driver_handles_share_servers`` is set to ``True``, a share driver will be
called to create share servers for shares using information provided within a
share network. This information will be provided to one of the enabled network
plugins that will handle reservation, creation and deletion of network
resources including IP addresses and network interfaces.

What network plugins are available?
-----------------------------------

There are three different network plugins and five python classes in Manila:

1. Network plugin for using the OpenStack networking project `Neutron`. It
   allows one to use any network segmentation that Neutron supports. It is up
   to each share driver to support at least one network segmentation type.

   a) ``manila.network.neutron.neutron_network_plugin.NeutronNetworkPlugin``.
      This is the default network plugin. It requires that ``neutron_net_id``
      and ``neutron_subnet_id`` are provided when defining the share network
      that will be used for the creation of share servers.  The user may
      define any number of share networks corresponding to the various
      physical network segments in a tenant environment.

   b) ``manila.network.neutron.neutron_network_plugin.NeutronSingleNetworkPlug
      in``. This is a simplification of the previous case. It accepts values
      for ``neutron_net_id`` and ``neutron_subnet_id`` from the Manila
      configuration file and uses one network for all shares.

   When only a single network is needed, the NeutronSingleNetworkPlugin (1.b)
   is a simple solution. Otherwise NeutronNetworkPlugin (1.a) should be chosen.

2. Network plugin for working with OpenStack networking from `Nova`. It
   supports either flat networks or VLAN-segmented networks.

   a) ``manila.network.nova_network_plugin.NovaNetworkPlugin``. This plugin
      serves the networking needs when ``Nova networking`` is configured in
      the cloud instead of Neutron. It requires a single parameter,
      ``nova_net_id``.

   b) ``manila.network.nova_network_plugin.NovaSingleNetworkPlugin``. This one
      works in the same way as the previous one with one difference. It takes
      nova_net_id from the Shared File Systems service configuration file and
      creates share servers using only one network.

   When only a single network is needed, the NovaSingleNetworkPlugin (2.b) is a
   simple solution. Otherwise NovaNetworkPlugin (1.a) should be chosen.

3. Network plugin for specifying networks independently from OpenStack
   networking services.

   a) ``manila.network.standalone_network_plugin.StandaloneNetworkPlugin``.
      This plug-in uses a pre-existing network that is available to the
      manila-share host. This network may be handled either by OpenStack or be
      created independently by any other means. The plugin supports any type of
      network - flat and segmented. As above, it is completely up to the driver
      to support the network type for which the network plugin is configured.

.. note::

    These network plugins were introduced in the OpenStack Kilo release. In
    the OpenStack Juno version, only NeutronNetworkPlugin is available.

More information about network plugins can be found in `Manila developer documentation <http://docs.openstack.org/developer/manila/adminref/network_plugins.html>`_
