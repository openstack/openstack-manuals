.. _launch-instance-networks-public:

Public provider network
~~~~~~~~~~~~~~~~~~~~~~~

Before launching an instance, you must create the necessary virtual network
infrastructure. For networking option 1, an instance uses a public provider
virtual network that connects to the physical network infrastructure
via layer-2 (bridging/switching). This network includes a DHCP server that
provides IP addresses to instances.

The ``admin`` or other privileged user must create this network because it
connects directly to the physical network infrastructure.

.. note::

   The following instructions and diagrams use example IP address ranges. You
   must adjust them for your particular environment.

.. figure:: figures/network1-overview.png
   :alt: Networking Option 1: Provider networks - Overview

   **Networking Option 1: Provider networks - Overview**

.. figure:: figures/network1-connectivity.png
   :alt: Networking Option 1: Provider networks - Connectivity

   **Networking Option 1: Provider networks - Connectivity**

Create the public network
-------------------------

#. On the controller node, source the ``admin`` credentials to gain access to
   admin-only CLI commands:

   .. code-block:: console

      $ source admin-openrc.sh

#. Create the network:

   .. code-block:: console

      $ neutron net-create public --shared --provider:physical_network public \
        --provider:network_type flat
      Created a new network:
      +---------------------------+--------------------------------------+
      | Field                     | Value                                |
      +---------------------------+--------------------------------------+
      | admin_state_up            | True                                 |
      | id                        | 0e62efcd-8cee-46c7-b163-d8df05c3c5ad |
      | mtu                       | 0                                    |
      | name                      | public                               |
      | port_security_enabled     | True                                 |
      | provider:network_type     | flat                                 |
      | provider:physical_network | public                               |
      | provider:segmentation_id  |                                      |
      | router:external           | False                                |
      | shared                    | True                                 |
      | status                    | ACTIVE                               |
      | subnets                   |                                      |
      | tenant_id                 | d84313397390425c8ed50b2f6e18d092     |
      +---------------------------+--------------------------------------+

   The ``--shared`` option allows all projects to use the virtual network.

   The ``--provider:physical_network public`` and
   ``--provider:network_type flat`` options connect the flat virtual network
   to the flat (native/untagged) public physical network on the ``eth1``
   interface on the host using information from the following files:

   ``ml2_conf.ini``:

   .. code-block:: ini

      [ml2_type_flat]
      flat_networks = public

   ``linuxbridge_agent.ini``:

   .. code-block:: ini

      [linux_bridge]
      physical_interface_mappings = public:eth1

#. Create a subnet on the network:

   .. code-block:: console

      $ neutron subnet-create public PUBLIC_NETWORK_CIDR --name public \
        --allocation-pool start=START_IP_ADDRESS,end=END_IP_ADDRESS\
        --dns-nameserver DNS_RESOLVER --gateway PUBLIC_NETWORK_GATEWAY

   Replace ``PUBLIC_NETWORK_CIDR`` with the subnet on the public physical
   network in CIDR notation.

   Replace ``START_IP_ADDRESS`` and ``END_IP_ADDRESS`` with the first and
   last IP address of the range within the subnet that you want to allocate
   for instances. This range must not include any existing active IP
   addresses.

   Replace ``DNS_RESOLVER`` with the IP address of a DNS resolver. In
   most cases, you can use one from the ``/etc/resolv.conf`` file on
   the host.

   Replace ``PUBLIC_NETWORK_GATEWAY`` with the gateway IP address on the
   public physical network, typically the ".1" IP address.

   **Example**

   The public network uses 203.0.113.0/24 with a gateway on 203.0.113.1.
   A DHCP server assigns each instance an IP address from 203.0.113.101
   to 203.0.113.200. All instances use 8.8.4.4 as a DNS resolver.

   .. code-block:: console

      $ neutron subnet-create public 203.0.113.0/24 --name public \
        --allocation-pool start=203.0.113.101,end=203.0.113.200 \
        --dns-nameserver 8.8.4.4 --gateway 203.0.113.1
      Created a new subnet:
      +-------------------+----------------------------------------------------+
      | Field             | Value                                              |
      +-------------------+----------------------------------------------------+
      | allocation_pools  | {"start": "203.0.113.101", "end": "203.0.113.200"} |
      | cidr              | 203.0.113.0/24                                     |
      | dns_nameservers   | 8.8.4.4                                            |
      | enable_dhcp       | True                                               |
      | gateway_ip        | 203.0.113.1                                        |
      | host_routes       |                                                    |
      | id                | 5cc70da8-4ee7-4565-be53-b9c011fca011               |
      | ip_version        | 4                                                  |
      | ipv6_address_mode |                                                    |
      | ipv6_ra_mode      |                                                    |
      | name              | public                                             |
      | network_id        | 0e62efcd-8cee-46c7-b163-d8df05c3c5ad               |
      | subnetpool_id     |                                                    |
      | tenant_id         | d84313397390425c8ed50b2f6e18d092                   |
      +-------------------+----------------------------------------------------+

Return to :ref:`Launch an instance - Create virtual networks
<launch-instance-networks>`.
