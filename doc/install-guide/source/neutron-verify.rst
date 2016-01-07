Verify operation
~~~~~~~~~~~~~~~~

#. Source the ``admin`` credentials to gain access to admin-only CLI
   commands:

   .. code-block:: console

      $ source admin-openrc.sh

#. List loaded extensions to verify successful launch of the
   ``neutron-server`` process:

   .. code-block:: console

      $ neutron ext-list
      +-----------------------+-----------------------------------------------+
      | alias                 | name                                          |
      +-----------------------+-----------------------------------------------+
      | dns-integration       | DNS Integration                               |
      | ext-gw-mode           | Neutron L3 Configurable external gateway mode |
      | binding               | Port Binding                                  |
      | agent                 | agent                                         |
      | subnet_allocation     | Subnet Allocation                             |
      | l3_agent_scheduler    | L3 Agent Scheduler                            |
      | external-net          | Neutron external network                      |
      | flavors               | Neutron Service Flavors                       |
      | net-mtu               | Network MTU                                   |
      | quotas                | Quota management support                      |
      | l3-ha                 | HA Router extension                           |
      | provider              | Provider Network                              |
      | multi-provider        | Multi Provider Network                        |
      | extraroute            | Neutron Extra Route                           |
      | router                | Neutron L3 Router                             |
      | extra_dhcp_opt        | Neutron Extra DHCP opts                       |
      | security-group        | security-group                                |
      | dhcp_agent_scheduler  | DHCP Agent Scheduler                          |
      | rbac-policies         | RBAC Policies                                 |
      | port-security         | Port Security                                 |
      | allowed-address-pairs | Allowed Address Pairs                         |
      | dvr                   | Distributed Virtual Router                    |
      +-----------------------+-----------------------------------------------+

Use the verification section for the networking option that you chose to
deploy.

.. toctree::

   neutron-verify-option1.rst
   neutron-verify-option2.rst
