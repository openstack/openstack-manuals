.. _launch-instance:

==================
Launch an instance
==================

This section creates the necessary virtual networks to support launching
instances. Networking option 1 includes one provider (external) network
with one instance that uses it. Networking option 2 includes one provider
network with one instance that uses it and one self-service (private)
network with one instance that uses it.
The instructions in this section use command-line interface (CLI)
tools on the controller node. However, you can follow the instructions
on any host that the tools are installed.
For more information on the CLI tools, see the
`OpenStackClient documentation for Pike
<https://docs.openstack.org/python-openstackclient/pike/cli/command-objects/server.html#server-create>`_
or the
`OpenStackClient documentation for Queens
<https://docs.openstack.org/python-openstackclient/queens/cli/command-objects/server.html#server-create>`_.
To use the dashboard, see the
`Dashboard User Documentation for Pike
<https://docs.openstack.org/horizon/pike/user/>`_
or the
`Dashboard User Documentation for Queens
<https://docs.openstack.org/horizon/queens/user/>`_.

.. _launch-instance-networks:

Create virtual networks
-----------------------

Create virtual networks for the networking option that you chose
when configuring Neutron. If you chose option 1, create only the provider
network. If you chose option 2, create the provider and self-service
networks.

.. toctree::
   :maxdepth: 1

   launch-instance-networks-provider.rst
   launch-instance-networks-selfservice.rst

After creating the appropriate networks for your environment, you can
continue preparing the environment to launch an instance.

Create m1.nano flavor
---------------------

The smallest default flavor consumes 512 MB memory per instance. For
environments with compute nodes containing less than 4 GB memory, we
recommend creating the ``m1.nano`` flavor that only requires 64 MB per
instance. Only use this flavor with the CirrOS image for testing
purposes.

.. code-block:: console

   $ openstack flavor create --id 0 --vcpus 1 --ram 64 --disk 1 m1.nano

   +----------------------------+---------+
   | Field                      | Value   |
   +----------------------------+---------+
   | OS-FLV-DISABLED:disabled   | False   |
   | OS-FLV-EXT-DATA:ephemeral  | 0       |
   | disk                       | 1       |
   | id                         | 0       |
   | name                       | m1.nano |
   | os-flavor-access:is_public | True    |
   | properties                 |         |
   | ram                        | 64      |
   | rxtx_factor                | 1.0     |
   | swap                       |         |
   | vcpus                      | 1       |
   +----------------------------+---------+

.. end

Generate a key pair
-------------------

Most cloud images support :term:`public key authentication` rather than
conventional password authentication. Before launching an instance, you
must add a public key to the Compute service.

#. Source the ``demo`` project credentials:

   .. code-block:: console

      $ . demo-openrc

   .. end

#. Generate a key pair and add a public key:

   .. code-block:: console

      $ ssh-keygen -q -N ""
      $ openstack keypair create --public-key ~/.ssh/id_rsa.pub mykey

      +-------------+-------------------------------------------------+
      | Field       | Value                                           |
      +-------------+-------------------------------------------------+
      | fingerprint | ee:3d:2e:97:d4:e2:6a:54:6d:0d:ce:43:39:2c:ba:4d |
      | name        | mykey                                           |
      | user_id     | 58126687cbcc4888bfa9ab73a2256f27                |
      +-------------+-------------------------------------------------+

   .. end

   .. note::

      Alternatively, you can skip the ``ssh-keygen`` command and use an
      existing public key.

#. Verify addition of the key pair:

   .. code-block:: console

      $ openstack keypair list

      +-------+-------------------------------------------------+
      | Name  | Fingerprint                                     |
      +-------+-------------------------------------------------+
      | mykey | ee:3d:2e:97:d4:e2:6a:54:6d:0d:ce:43:39:2c:ba:4d |
      +-------+-------------------------------------------------+

   .. end

Add security group rules
------------------------

By default, the ``default`` security group applies to all instances and
includes firewall rules that deny remote access to instances. For Linux
images such as CirrOS, we recommend allowing at least ICMP (ping) and
secure shell (SSH).

* Add rules to the ``default`` security group:

  * Permit :term:`ICMP <Internet Control Message Protocol (ICMP)>` (ping):

    .. code-block:: console

       $ openstack security group rule create --proto icmp default

       +-------------------+--------------------------------------+
       | Field             | Value                                |
       +-------------------+--------------------------------------+
       | created_at        | 2017-03-30T00:46:43Z                 |
       | description       |                                      |
       | direction         | ingress                              |
       | ether_type        | IPv4                                 |
       | id                | 1946be19-54ab-4056-90fb-4ba606f19e66 |
       | name              | None                                 |
       | port_range_max    | None                                 |
       | port_range_min    | None                                 |
       | project_id        | 3f714c72aed7442681cbfa895f4a68d3     |
       | protocol          | icmp                                 |
       | remote_group_id   | None                                 |
       | remote_ip_prefix  | 0.0.0.0/0                            |
       | revision_number   | 1                                    |
       | security_group_id | 89ff5c84-e3d1-46bb-b149-e621689f0696 |
       | updated_at        | 2017-03-30T00:46:43Z                 |
       +-------------------+--------------------------------------+

    .. end

  * Permit secure shell (SSH) access:

    .. code-block:: console

       $ openstack security group rule create --proto tcp --dst-port 22 default

       +-------------------+--------------------------------------+
       | Field             | Value                                |
       +-------------------+--------------------------------------+
       | created_at        | 2017-03-30T00:43:35Z                 |
       | description       |                                      |
       | direction         | ingress                              |
       | ether_type        | IPv4                                 |
       | id                | 42bc2388-ae1a-4208-919b-10cf0f92bc1c |
       | name              | None                                 |
       | port_range_max    | 22                                   |
       | port_range_min    | 22                                   |
       | project_id        | 3f714c72aed7442681cbfa895f4a68d3     |
       | protocol          | tcp                                  |
       | remote_group_id   | None                                 |
       | remote_ip_prefix  | 0.0.0.0/0                            |
       | revision_number   | 1                                    |
       | security_group_id | 89ff5c84-e3d1-46bb-b149-e621689f0696 |
       | updated_at        | 2017-03-30T00:43:35Z                 |
       +-------------------+--------------------------------------+

    .. end

Launch an instance
------------------

If you chose networking option 1, you can only launch an instance on the
provider network. If you chose networking option 2, you can launch an instance
on the provider network and the self-service network.

.. toctree::
   :maxdepth: 1

   launch-instance-provider.rst
   launch-instance-selfservice.rst

.. _launch-instance-complete:

Block Storage
-------------

If your environment includes the Block Storage service, you can create a
volume and attach it to an instance.

.. toctree::
   :maxdepth: 1

   launch-instance-cinder.rst

Orchestration
-------------

If your environment includes the Orchestration service, you can create
a stack that launches an instance.

For more information, see the
`Orchestration installation guide for Pike
<https://docs.openstack.org/heat/pike/install/>`_
or the
`Orchestration installation guide for Queens
<https://docs.openstack.org/heat/queens/install/>`_.

Shared File Systems
-------------------

If your environment includes the Shared File Systems service, you can create
a share and mount it in an instance.

For more information, see the
`Shared File Systems installation guide for Pike
<https://docs.openstack.org/manila/pike/install/>`_
or the
`Shared File Systems installation guide for Queens
<https://docs.openstack.org/manila/queens/install/>`_.
