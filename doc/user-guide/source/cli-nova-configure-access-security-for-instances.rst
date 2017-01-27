===========================================
Configure access and security for instances
===========================================

When you launch a virtual machine, you can inject a *key pair*, which
provides SSH access to your instance. For this to work, the image must
contain the ``cloud-init`` package.

You can create at least one key pair for each project. You can use the key
pair for multiple instances that belong to that project. If you generate
a key pair with an external tool, you can import it into OpenStack.

.. note::

   A key pair belongs to an individual user, not to a project.
   To share a key pair across multiple users, each user
   needs to import that key pair.

If an image uses a static root password or a static key set (neither is
recommended), you must not provide a key pair when you launch the
instance.

A *security group* is a named collection of network access rules that
are use to limit the types of traffic that have access to instances.
When you launch an instance, you can assign one or more security groups
to it. If you do not create security groups, new instances are
automatically assigned to the default security group, unless you
explicitly specify a different security group.

The associated *rules* in each security group control the traffic to
instances in the group. Any incoming traffic that is not matched by a
rule is denied access by default. You can add rules to or remove rules
from a security group, and you can modify rules for the default and any
other security group.

You can modify the rules in a security group to allow access to
instances through different ports and protocols. For example, you can
modify rules to allow access to instances through SSH, to ping
instances, or to allow UDP traffic; for example, for a DNS server
running on an instance. You specify the following parameters for rules:

-  **Source of traffic**. Enable traffic to instances from either IP
   addresses inside the cloud from other group members or from all IP
   addresses.

-  **Protocol**. Choose TCP for SSH, ICMP for pings, or UDP.

-  **Destination port on virtual machine**. Define a port range. To open
   a single port only, enter the same value twice. ICMP does not support
   ports; instead, you enter values to define the codes and types of
   ICMP traffic to be allowed.

Rules are automatically enforced as soon as you create or modify them.

.. note::

  Instances that use the default security group cannot, by default, be
  accessed from any IP address outside of the cloud. If you want those
  IP addresses to access the instances, you must modify the rules for
  the default security group. Additionally, security groups will
  automatically drop DHCP responses coming from instances.

  You can also assign a floating IP address to a running instance to
  make it accessible from outside the cloud. See
  :doc:`cli-manage-ip-addresses`.

Add a key pair
~~~~~~~~~~~~~~

You can generate a key pair or upload an existing public key.

#. To generate a key pair, run the following command.

   .. code-block:: console

      $ openstack keypair create KEY_NAME > MY_KEY.pem

   This command generates a key pair with the name that you specify for
   KEY\_NAME, writes the private key to the ``.pem`` file that you specify,
   and registers the public key to the Nova database.

#. To set the permissions of the ``.pem`` file so that only you can read
   and write to it, run the following command.

   .. code-block:: console

      $ chmod 600 MY_KEY.pem

Import a key pair
~~~~~~~~~~~~~~~~~

#. If you have already generated a key pair and the public key is located
   at ``~/.ssh/id_rsa.pub``, run the following command to upload the public
   key.

   .. code-block:: console

      $ openstack keypair create --public-key ~/.ssh/id_rsa.pub KEY_NAME

   This command registers the public key at the Nova database and names the
   key pair the name that you specify for ``KEY_NAME``.

#. To ensure that the key pair has been successfully imported, list key
   pairs as follows:

   .. code-block:: console

      $ openstack keypair list

Create and manage security groups
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. To list the security groups for the current project, including
   descriptions, enter the following command:

   .. code-block:: console

      $ openstack security group list

#. To create a security group with a specified name and description, enter
   the following command:

   .. code-block:: console

      $ openstack security group create SECURITY_GROUP_NAME --description GROUP_DESCRIPTION

#. To delete a specified group, enter the following command:

   .. code-block:: console

      $ openstack security group delete SECURITY_GROUP_NAME

.. note::

   You cannot delete the default security group for a project. Also,
   you cannot delete a security group that is assigned to a running
   instance.

Create and manage security group rules
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Modify security group rules with the :command:`openstack security group rule`
commands. Before you begin, source the OpenStack RC file. For details,
see :doc:`../common/cli-set-environment-variables-using-openstack-rc`.

#. To list the rules for a security group, run the following command:

   .. code-block:: console

      $ openstack security group rule list SECURITY_GROUP_NAME

#. To allow SSH access to the instances, choose one of the following
   options:

   -  Allow access from all IP addresses, specified as IP subnet ``0.0.0.0/0``
      in CIDR notation:

      .. code-block:: console

         $ openstack security group rule create SECURITY_GROUP_NAME \
               --protocol tcp --dst-port 22:22 --remote-ip 0.0.0.0/0

   -  Allow access only from IP addresses from other security groups
      (source groups) to access the specified port:

      .. code-block:: console

         $ openstack security group rule create SECURITY_GROUP_NAME \
               --protocol tcp --dst-port 22:22 --remote-group SOURCE_GROUP_NAME

#. To allow pinging of the instances, choose one of the following options:

   -  Allow pinging from all IP addresses, specified as IP subnet
      ``0.0.0.0/0`` in CIDR notation.

      .. code-block:: console

         $ openstack security group rule create --protocol icmp \
           SECURITY_GROUP_NAME

      This allows access to all codes and all types of ICMP traffic.

   -  Allow only members of other security groups (source groups) to ping
      instances.

      .. code-block:: console

         $ openstack security group rule create --protocol icmp \
           --remote-group SOURCE_GROUP_NAME SECURITY_GROUP

#. To allow access through a UDP port, such as allowing access to a DNS
   server that runs on a VM, choose one of the following options:

   -  Allow UDP access from IP addresses, specified as IP subnet
      ``0.0.0.0/0`` in CIDR notation.

      .. code-block:: console

         $ openstack security group rule create --protocol udp \
           --dst-port 53:53 SECURITY_GROUP

   -  Allow only IP addresses from other security groups (source groups) to
      access the specified port.

      .. code-block:: console

         $ openstack security group rule create --protocol udp \
           --dst-port 53:53 --remote-group SOURCE_GROUP_NAME SECURITY_GROUP

Delete a security group rule
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To delete a security group rule, specify the ID of the rule.

.. code-block:: console

   $ openstack security group rule delete RULE_ID
