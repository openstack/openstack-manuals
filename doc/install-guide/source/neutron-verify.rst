Verify operation
~~~~~~~~~~~~~~~~

.. note::

   Perform these commands on the controller node.

#. Source the ``admin`` credentials to gain access to admin-only CLI
   commands:

   .. code-block:: console

      $ . admin-openrc

#. List loaded extensions to verify successful launch of the
   ``neutron-server`` process:

   .. code-block:: console

      $ neutron ext-list
      +---------------------------+-----------------------------------------------+
      | alias                     | name                                          |
      +---------------------------+-----------------------------------------------+
      | default-subnetpools       | Default Subnetpools                           |
      | network-ip-availability   | Network IP Availability                       |
      | network_availability_zone | Network Availability Zone                     |
      | auto-allocated-topology   | Auto Allocated Topology Services              |
      | ext-gw-mode               | Neutron L3 Configurable external gateway mode |
      | binding                   | Port Binding                                  |
      | agent                     | agent                                         |
      | subnet_allocation         | Subnet Allocation                             |
      | l3_agent_scheduler        | L3 Agent Scheduler                            |
      | tag                       | Tag support                                   |
      | external-net              | Neutron external network                      |
      | net-mtu                   | Network MTU                                   |
      | availability_zone         | Availability Zone                             |
      | quotas                    | Quota management support                      |
      | l3-ha                     | HA Router extension                           |
      | flavors                   | Neutron Service Flavors                       |
      | provider                  | Provider Network                              |
      | multi-provider            | Multi Provider Network                        |
      | address-scope             | Address scope                                 |
      | extraroute                | Neutron Extra Route                           |
      | timestamp_core            | Time Stamp Fields addition for core resources |
      | router                    | Neutron L3 Router                             |
      | extra_dhcp_opt            | Neutron Extra DHCP opts                       |
      | dns-integration           | DNS Integration                               |
      | security-group            | security-group                                |
      | dhcp_agent_scheduler      | DHCP Agent Scheduler                          |
      | router_availability_zone  | Router Availability Zone                      |
      | rbac-policies             | RBAC Policies                                 |
      | standard-attr-description | standard-attr-description                     |
      | port-security             | Port Security                                 |
      | allowed-address-pairs     | Allowed Address Pairs                         |
      | dvr                       | Distributed Virtual Router                    |
      +---------------------------+-----------------------------------------------+

   .. note::

      Actual output may differ slightly from this example.

Use the verification section for the networking option that you chose to
deploy.

.. toctree::

   neutron-verify-option1.rst
   neutron-verify-option2.rst
