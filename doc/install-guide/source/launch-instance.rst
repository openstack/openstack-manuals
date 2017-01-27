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
`OpenStack End User Guide
<https://docs.openstack.org/user-guide/cli-launch-instances.html>`__.
To use the dashboard, see the
`OpenStack End User Guide
<https://docs.openstack.org/user-guide/dashboard.html>`__.

.. _launch-instance-networks:

Create virtual networks
-----------------------

Create virtual networks for the networking option that you chose
in :ref:`networking`. If you chose option 1, create only the provider
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
       | created_at        | 2016-10-05T09:52:31Z                 |
       | description       |                                      |
       | direction         | ingress                              |
       | ethertype         | IPv4                                 |
       | headers           |                                      |
       | id                | 6ee8d630-9803-4d3d-9aea-8c795abbedc2 |
       | port_range_max    | None                                 |
       | port_range_min    | None                                 |
       | project_id        | 77ae8d7104024123af342ffb0a6f1d88     |
       | project_id        | 77ae8d7104024123af342ffb0a6f1d88     |
       | protocol          | icmp                                 |
       | remote_group_id   | None                                 |
       | remote_ip_prefix  | 0.0.0.0/0                            |
       | revision_number   | 1                                    |
       | security_group_id | 4ceee3d4-d2fe-46c1-895c-382033e87b0d |
       | updated_at        | 2016-10-05T09:52:31Z                 |
       +-------------------+--------------------------------------+

    .. end

  * Permit secure shell (SSH) access:

    .. code-block:: console

       $ openstack security group rule create --proto tcp --dst-port 22 default

       +-------------------+--------------------------------------+
       | Field             | Value                                |
       +-------------------+--------------------------------------+
       | created_at        | 2016-10-05T09:54:50Z                 |
       | description       |                                      |
       | direction         | ingress                              |
       | ethertype         | IPv4                                 |
       | headers           |                                      |
       | id                | 3cd0a406-43df-4741-ab29-b5e7dcb7469d |
       | port_range_max    | 22                                   |
       | port_range_min    | 22                                   |
       | project_id        | 77ae8d7104024123af342ffb0a6f1d88     |
       | project_id        | 77ae8d7104024123af342ffb0a6f1d88     |
       | protocol          | tcp                                  |
       | remote_group_id   | None                                 |
       | remote_ip_prefix  | 0.0.0.0/0                            |
       | revision_number   | 1                                    |
       | security_group_id | 4ceee3d4-d2fe-46c1-895c-382033e87b0d |
       | updated_at        | 2016-10-05T09:54:50Z                 |
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
`Orchestration installation guide <https://docs.openstack.org/project-install-guide/orchestration/newton/launch-instance.html>`_.

Shared File Systems
-------------------

If your environment includes the Shared File Systems service, you can create
a share and mount it in an instance.

For more information, see the
`Shared File Systems installation guide
<https://docs.openstack.org/project-install-guide/shared-file-systems/newton>`_.
