Verify operation
~~~~~~~~~~~~~~~~

.. note::

   Perform these commands on the controller node.

#. Source the ``admin`` credentials to gain access to admin-only CLI
   commands:

   .. code-block:: console

      $ . admin-openrc

   .. end

#. List loaded extensions to verify successful launch of the
   ``neutron-server`` process:

   .. code-block:: console

      $ neutron ext-list

      +---------------------------+---------------------------------+
      | alias                     | name                            |
      +---------------------------+---------------------------------+
      | default-subnetpools       | Default Subnetpools             |
      | availability_zone         | Availability Zone               |
      | network_availability_zone | Network Availability Zone       |
      | binding                   | Port Binding                    |
      | agent                     | agent                           |
      | subnet_allocation         | Subnet Allocation               |
      | dhcp_agent_scheduler      | DHCP Agent Scheduler            |
      | tag                       | Tag support                     |
      | external-net              | Neutron external network        |
      | flavors                   | Neutron Service Flavors         |
      | net-mtu                   | Network MTU                     |
      | network-ip-availability   | Network IP Availability         |
      | quotas                    | Quota management support        |
      | provider                  | Provider Network                |
      | multi-provider            | Multi Provider Network          |
      | address-scope             | Address scope                   |
      | subnet-service-types      | Subnet service types            |
      | standard-attr-timestamp   | Resource timestamps             |
      | service-type              | Neutron Service Type Management |
      | extra_dhcp_opt            | Neutron Extra DHCP opts         |
      | standard-attr-revisions   | Resource revision numbers       |
      | pagination                | Pagination support              |
      | sorting                   | Sorting support                 |
      | security-group            | security-group                  |
      | rbac-policies             | RBAC Policies                   |
      | standard-attr-description | standard-attr-description       |
      | port-security             | Port Security                   |
      | allowed-address-pairs     | Allowed Address Pairs           |
      | project-id                | project_id field enabled        |
      +---------------------------+---------------------------------+

   .. end

   .. note::

      Actual output may differ slightly from this example.

Use the verification section for the networking option that you chose to
deploy.

.. toctree::

   neutron-verify-option1.rst
   neutron-verify-option2.rst
