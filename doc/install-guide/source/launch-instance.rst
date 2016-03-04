.. _launch-instance:

==================
Launch an instance
==================

This section creates the necessary virtual networks to support launching
instances. Networking option 1 includes one provider (external) network
with one instance that uses it. Networking option 2 includes one provider
network with one instance that uses it and one self-service (private)
network with one instance that uses it. The instructions in this
section use command-line interface (CLI) tools on the controller
node. For more information on the CLI tools, see the
`OpenStack User Guide
<http://docs.openstack.org/user-guide/cli_launch_instances.html>`__.
To use the dashboard, see the
`OpenStack User Guide
<http://docs.openstack.org/user-guide/dashboard.html>`__.

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

Generate a key pair
-------------------

Most cloud images support :term:`public key authentication` rather than
conventional password authentication. Before launching an instance, you
must add a public key to the Compute service.

#. Source the ``demo`` tenant credentials:

   .. code-block:: console

      $ source demo-openrc.sh

#. Generate and add a key pair:

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

Add security group rules
------------------------

By default, the ``default`` security group applies to all instances and
includes firewall rules that deny remote access to instances. For Linux
images such as CirrOS, we recommend allowing at least ICMP (ping) and
secure shell (SSH).

* Add rules to the ``default`` security group:

  * Permit :term:`ICMP` (ping):

    .. code-block:: console

       $ openstack security group rule create --proto icmp default
       +-----------------------+--------------------------------------+
       | Field                 | Value                                |
       +-----------------------+--------------------------------------+
       | id                    | a1876c06-7f30-4a67-a324-b6b5d1309546 |
       | ip_protocol           | icmp                                 |
       | ip_range              | 0.0.0.0/0                            |
       | parent_group_id       | b0d53786-5ebb-4729-9e4a-4b675016a958 |
       | port_range            |                                      |
       | remote_security_group |                                      |
       +-----------------------+--------------------------------------+

  * Permit secure shell (SSH) access:

    .. code-block:: console

       $ openstack security group rule create --proto tcp --dst-port 22 default
       +-----------------------+--------------------------------------+
       | Field                 | Value                                |
       +-----------------------+--------------------------------------+
       | id                    | 3d95e59c-e98d-45f1-af04-c750af914f14 |
       | ip_protocol           | tcp                                  |
       | ip_range              | 0.0.0.0/0                            |
       | parent_group_id       | b0d53786-5ebb-4729-9e4a-4b675016a958 |
       | port_range            | 22:22                                |
       | remote_security_group |                                      |
       +-----------------------+--------------------------------------+

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

.. toctree::
   :maxdepth: 1

   launch-instance-heat.rst

Shared File Systems
-------------------

If your environment includes the Shared File Systems service, you can create
a share.

.. toctree::
   :maxdepth: 1

   launch-instance-manila.rst
