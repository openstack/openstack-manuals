.. _launch-instance:

==================
Launch an instance
==================

This section creates the necessary virtual networks to support launching
one more instances. Networking option 1 includes one public virtual
network and one instance that uses it. Networking option 2 includes one
public virtual network, one private virtual network, and one instance
that uses each network. The instructions in this section use command-line
interface (CLI) tools on the controller node. For more information on the
CLI tools, see the `OpenStack User Guide
<http://docs.openstack.org/user-guide/cli_launch_instances.html>`__.
To use the dashboard, see the
`OpenStack User Guide
<http://docs.openstack.org/user-guide/dashboard.html>`__.

.. _launch-instance-networks:

Create virtual networks
-----------------------

Create virtual networks for the networking option that you chose
in :ref:`networking`. If you chose option 1, create only the public
virtual network. If you chose option 2, create the public and private
virtual networks.

.. toctree::
   :maxdepth: 1

   launch-instance-networks-public.rst
   launch-instance-networks-private.rst

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
      $ nova keypair-add --pub-key .ssh/id_rsa.pub mykey

   .. note::

      Alternatively, you can skip the ``ssh-keygen`` command and use an
      existing public key.

#. Verify addition of the key pair:

   .. code-block:: console

      $ nova keypair-list
      +-------+-------------------------------------------------+
      | Name  | Fingerprint                                     |
      +-------+-------------------------------------------------+
      | mykey | 6c:74:ec:3a:08:05:4e:9e:21:22:a6:dd:b2:62:b8:28 |
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

       $ nova secgroup-add-rule default icmp -1 -1 0.0.0.0/0
       +-------------+-----------+---------+-----------+--------------+
       | IP Protocol | From Port | To Port | IP Range  | Source Group |
       +-------------+-----------+---------+-----------+--------------+
       | icmp        | -1        | -1      | 0.0.0.0/0 |              |
       +-------------+-----------+---------+-----------+--------------+

  * Permit secure shell (SSH) access:

    .. code-block:: console

       $ nova secgroup-add-rule default tcp 22 22 0.0.0.0/0
       +-------------+-----------+---------+-----------+--------------+
       | IP Protocol | From Port | To Port | IP Range  | Source Group |
       +-------------+-----------+---------+-----------+--------------+
       | tcp         | 22        | 22      | 0.0.0.0/0 |              |
       +-------------+-----------+---------+-----------+--------------+

Launch an instance
------------------

If you chose networking option 1, you can only launch an instance on the
public network. If you chose networking option 2, you can launch an instance
on the public network and the private network.

.. toctree::
   :maxdepth: 1

   launch-instance-public.rst
   launch-instance-private.rst

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
