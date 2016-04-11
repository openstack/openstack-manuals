==================
MTU considerations
==================

Network MTU calculation
~~~~~~~~~~~~~~~~~~~~~~~

Neutron calculates network MTU value on resource creation. The default value is
1500 (standard Ethernet frame size), but core plug-ins may influence it. For
example, they may need to make additional room for encapsulation protocol that
will be used to realize tenant networks. Alternatively, the default value may
need an increase. For example, an operator may need to do it to utilize Jumbo
frames that her underlying physical infrastructure supports.

Updating instances
~~~~~~~~~~~~~~~~~~

Neutron provides multiple ways to update instances about the desired MTU values
to be used for their ports.

DHCP agent
----------

DHCP agent can update its IPv4 clients about the desired MTU value for instance
ports using DHCP Interface MTU Option (RFC 2132, section 5.1). This feature is
controlled by the following option in ``/etc/neutron/neutron.conf``:

.. code-block:: ini

   [DEFAULT]
   advertise_mtu = True

.. note::

    The feature is enabled by default.

L3 agent
--------

L3 agent uses Router Advertisements to update IPv6 aware clients about the
desired MTU value to be used by instances.

Jumbo frames
~~~~~~~~~~~~

The purpose of this section is to describe how to set up Neutron services for
physical infrastructure capable of :term:`Jumbo frames <jumbo frame>`.

neutron-server
--------------

To enable Neutron for Jumbo frames, the following option should be set in the
``/etc/neutron/neutron.conf`` file:

.. code-block:: ini

   [DEFAULT]
   global_physnet_mtu = <maximum MTU supported by your infrastructure>

If you have multiple underlying networks, you may want to use separate MTU
values for each of those networks. In that case, you can set one of the
following options (currently works for ML2 plug-in only).

In case of flat and vlan network types:

.. code-block:: ini

   [DEFAULT]
   physical_network_mtus = physnet1:<max-mtu1>,physnet2:<max-mtu2>[,...]

For network types that use tunneling for tenant traffic encapsulation:

.. code-block:: ini

   [ml2]
   path_mtu = <max-mtu>

.. note::

   New configuration only affects new network resources.
