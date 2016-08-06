=======================
Manage project security
=======================

Security groups are sets of IP filter rules that are applied to all
project instances, which define networking access to the instance. Group
rules are project specific; project members can edit the default rules
for their group and add new rule sets.

All projects have a ``default`` security group which is applied to any
instance that has no other defined security group. Unless you change the
default, this security group denies all incoming traffic and allows only
outgoing traffic to your instance.

You can use the ``allow_same_net_traffic`` option in the
``/etc/nova/nova.conf`` file to globally control whether the rules apply
to hosts which share a network.

If set to:

-  ``True`` (default), hosts on the same subnet are not filtered and are
   allowed to pass all types of traffic between them. On a flat network,
   this allows all instances from all projects unfiltered communication.
   With VLAN networking, this allows access between instances within the
   same project. You can also simulate this setting by configuring the
   default security group to allow all traffic from the subnet.

-  ``False``, security groups are enforced for all connections.

Additionally, the number of maximum rules per security group is
controlled by the ``security_group_rules`` and the number of allowed
security groups per project is controlled by the ``security_groups``
quota (see :ref:`manage-quotas`).

List and view current security groups
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

From the command-line you can get a list of security groups for the
project, using the :command:`nova` command:

#. Ensure your system variables are set for the user and tenant for
   which you are checking security group rules. For example:

   .. code-block:: console

      export OS_USERNAME=demo00
      export OS_TENANT_NAME=tenant01

#. Output security groups, as follows:

   .. code-block:: console

      $ nova secgroup-list
      +---------+-------------+
      | Name    | Description |
      +---------+-------------+
      | default | default     |
      | open    | all ports   |
      +---------+-------------+

#. View the details of a group, as follows:

   .. code-block:: console

      $ nova secgroup-list-rules groupName

   For example:

   .. code-block:: console

      $ nova secgroup-list-rules open
      +-------------+-----------+---------+-----------+--------------+
      | IP Protocol | From Port | To Port | IP Range  | Source Group |
      +-------------+-----------+---------+-----------+--------------+
      | icmp        | -1        | 255     | 0.0.0.0/0 |              |
      | tcp         | 1         | 65535   | 0.0.0.0/0 |              |
      | udp         | 1         | 65535   | 0.0.0.0/0 |              |
      +-------------+-----------+---------+-----------+--------------+

   These rules are allow type rules as the default is deny. The first
   column is the IP protocol (one of icmp, tcp, or udp). The second and
   third columns specify the affected port range. The third column
   specifies the IP range in CIDR format. This example shows the full
   port range for all protocols allowed from all IPs.

Create a security group
~~~~~~~~~~~~~~~~~~~~~~~

When adding a new security group, you should pick a descriptive but
brief name. This name shows up in brief descriptions of the instances
that use it where the longer description field often does not. For
example, seeing that an instance is using security group "http" is much
easier to understand than "bobs\_group" or "secgrp1".

#. Ensure your system variables are set for the user and tenant for
   which you are creating security group rules.

#. Add the new security group, as follows:

   .. code-block:: console

      $ nova secgroup-create GroupName Description

   For example:

   .. code-block:: console

      $ nova secgroup-create global_http "Allows Web traffic anywhere on the Internet."
      +--------------------------------------+-------------+----------------------------------------------+
      | Id                                   | Name        | Description                                  |
      +--------------------------------------+-------------+----------------------------------------------+
      | 1578a08c-5139-4f3e-9012-86bd9dd9f23b | global_http | Allows Web traffic anywhere on the Internet. |
      +--------------------------------------+-------------+----------------------------------------------+

#. Add a new group rule, as follows:

   .. code-block:: console

      $ nova secgroup-add-rule secGroupName ip-protocol from-port to-port CIDR

   The arguments are positional, and the ``from-port`` and ``to-port``
   arguments specify the local port range connections are allowed to
   access, not the source and destination ports of the connection. For
   example:

   .. code-block:: console

      $ nova secgroup-add-rule global_http tcp 80 80 0.0.0.0/0
      +-------------+-----------+---------+-----------+--------------+
      | IP Protocol | From Port | To Port | IP Range  | Source Group |
      +-------------+-----------+---------+-----------+--------------+
      | tcp         | 80        | 80      | 0.0.0.0/0 |              |
      +-------------+-----------+---------+-----------+--------------+

   You can create complex rule sets by creating additional rules. For
   example, if you want to pass both HTTP and HTTPS traffic, run:

   .. code-block:: console

      $ nova secgroup-add-rule global_http tcp 443 443 0.0.0.0/0
      +-------------+-----------+---------+-----------+--------------+
      | IP Protocol | From Port | To Port | IP Range  | Source Group |
      +-------------+-----------+---------+-----------+--------------+
      | tcp         | 443       | 443     | 0.0.0.0/0 |              |
      +-------------+-----------+---------+-----------+--------------+

   Despite only outputting the newly added rule, this operation is
   additive (both rules are created and enforced).

#. View all rules for the new security group, as follows:

   .. code-block:: console

      $ nova secgroup-list-rules global_http
      +-------------+-----------+---------+-----------+--------------+
      | IP Protocol | From Port | To Port | IP Range  | Source Group |
      +-------------+-----------+---------+-----------+--------------+
      | tcp         | 80        | 80      | 0.0.0.0/0 |              |
      | tcp         | 443       | 443     | 0.0.0.0/0 |              |
      +-------------+-----------+---------+-----------+--------------+

Delete a security group
~~~~~~~~~~~~~~~~~~~~~~~

#. Ensure your system variables are set for the user and tenant for
   which you are deleting a security group.

#. Delete the new security group, as follows:

   .. code-block:: console

      $ nova secgroup-delete GroupName

   For example:

   .. code-block:: console

      $ nova secgroup-delete global_http

Create security group rules for a cluster of instances
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Source Groups are a special, dynamic way of defining the CIDR of allowed
sources. The user specifies a Source Group (Security Group name), and
all the user's other Instances using the specified Source Group are
selected dynamically. This alleviates the need for individual rules to
allow each new member of the cluster.

#. Make sure to set the system variables for the user and tenant for
   which you are creating a security group rule.

#. Add a source group, as follows:

   .. code-block:: console

      $ nova secgroup-add-group-rule secGroupName source-group ip-protocol from-port to-port

   For example:

   .. code-block:: console

      $ nova secgroup-add-group-rule cluster global_http tcp 22 22

   The ``cluster`` rule allows SSH access from any other instance that
   uses the ``global_http`` group.
