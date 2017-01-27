.. _baremetal_multitenancy:

========================================
Use multitenancy with Bare Metal service
========================================

Multitenancy allows creating a dedicated project network that extends the
current Bare Metal (ironic) service capabilities of providing ``flat``
networks. Multitenancy works in conjunction with Networking (neutron)
service to allow provisioning of a bare metal server onto the project network.
Therefore, multiple projects can get isolated instances after deployment.

Bare Metal service provides the ``local_link_connection`` information to the
Networking service ML2 driver. The ML2 driver uses that information to plug the
specified port to the project network.

.. list-table:: ``local_link_connection`` fields
   :header-rows: 1

   * - Field
     - Description
   * - ``switch_id``
     - Required. Identifies a switch and can be an LLDP-based MAC address or
       an OpenFlow-based ``datapath_id``.
   * - ``port_id``
     - Required. Port ID on the switch, for example, Gig0/1.
   * - ``switch_info``
     - Optional. Used to distinguish different switch models or other
       vendor specific-identifier.

Configure Networking service ML2 driver
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To enable the Networking service ML2 driver, edit the
``/etc/neutron/plugins/ml2/ml2_conf.ini`` file:

#. Add the name of your ML2 driver.
#. Add the vendor ML2 plugin configuration options.

.. code-block:: ini

   [ml2]
   # ...
   mechanism_drivers = my_mechanism_driver

   [my_vendor]
   param_1 = ...
   param_2 = ...
   param_3 = ...

For more details, see
`Networking service mechanism drivers <https://docs.openstack.org/newton/networking-guide/config-ml2.html#mechanism-drivers>`__.

Configure Bare Metal service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

After you configure the Networking service ML2 driver, configure Bare Metal
service:

#. Edit the ``/etc/ironic/ironic.conf`` for the ``ironic-conductor`` service.
   Set the ``network_interface`` node field to a valid network driver that is
   used to switch, clean, and provision networks.

   .. code-block:: ini

      [DEFAULT]
      # ...
      enabled_network_interfaces=flat,neutron

      [neutron]
      # ...
      cleaning_network_uuid=$UUID
      provisioning_network_uuid=$UUID

   .. warning:: The ``cleaning_network_uuid`` and ``provisioning_network_uuid``
    parameters are required for the ``neutron`` network interface. If they are
    not set, ``ironic-conductor`` fails to start.

#. Set ``neutron`` to use Networking service ML2 driver:

   .. code-block:: console

      $ ironic node-create -n $NAME --network-interface neutron --driver agent_ipmitool

#. Create a port with appropriate ``local_link_connection`` information. Set
   the ``pxe_enabled`` port attribute to ``True`` to create network ports for
   for the ``pxe_enabled`` ports only:

   .. code-block:: console

      $ ironic --ironic-api-version latest port-create -a $HW_MAC_ADDRESS \
        -n $NODE_UUID -l switch_id=$SWITCH_MAC_ADDRESS \
        -l switch_info=$SWITCH_HOSTNAME -l port_id=$SWITCH_PORT --pxe-enabled true
