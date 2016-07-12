.. _baremetal:

==========
Bare Metal
==========

The Bare Metal service provides physical hardware management features.

Introduction
~~~~~~~~~~~~

The Bare Metal service provides physical hardware as opposed to
virtual machines. It also provides several reference drivers, which
leverage common technologies like PXE and IPMI, to cover a wide range
of hardware. The pluggable driver architecture also allows
vendor-specific drivers to be added for improved performance or
functionality not provided by reference drivers. The Bare Metal
service makes physical servers as easy to provision as virtual
machines in a cloud, which in turn will open up new avenues for
enterprises and service providers.

System architecture
~~~~~~~~~~~~~~~~~~~

The Bare Metal service is composed of the following components:

#. An admin-only RESTful API service, by which privileged users, such
   as operators and other services within the cloud control
   plane, may interact with the managed bare-metal servers.

#. A conductor service, which conducts all activity related to
   bare-metal deployments. Functionality is exposed via the API
   service. The Bare Metal service conductor and API service
   communicate via RPC.

#. Various drivers that support heterogeneous hardware, which enable
   features specific to unique hardware platforms and leverage
   divergent capabilities via a common API.

#. A message queue, which is a central hub for passing messages, such
   as RabbitMQ. It should use the same implementation as that of the
   Compute service.

#. A database for storing information about the resources. Among other
   things, this includes the state of the conductors, nodes (physical
   servers), and drivers.

When a user requests to boot an instance, the request is passed to the
Compute service via the Compute service API and scheduler. The Compute
service hands over this request to the Bare Metal service, where the
request passes from the Bare Metal service API, to the conductor which
will invoke a driver to successfully provision a physical server for
the user.

Bare Metal deployment
~~~~~~~~~~~~~~~~~~~~~

#. PXE deploy process

#. Agent deploy process

.. TODO Add the detail about the process of Bare Metal deployment.

Use Bare Metal
~~~~~~~~~~~~~~

#. Install the Bare Metal service.

#. Setup the Bare Metal driver in the compute node's ``nova.conf`` file.

#. Setup TFTP folder and prepare PXE boot loader file.

#. Prepare the bare metal flavor.

#. Register the nodes with correct drivers.

#. Configure the driver information.

#. Register the ports information.

#. Use nova boot to kick off the bare metal provision.

#. Check nodes' provision state and power state.

.. TODO Add the detail command line later on.

Use multitenancy with Bare Metal service
----------------------------------------

.. toctree::

    baremetal-multitenancy.rst

.. TODO Add guides for other features.

Troubleshooting
~~~~~~~~~~~~~~~

No valid host found error
-------------------------

Problem
-------

Sometimes ``/var/log/nova/nova-conductor.log`` contains the following error:

.. code-block:: console

   NoValidHost: No valid host was found. There are not enough hosts available.

The message ``No valid host was found`` means that the Compute service
scheduler could not find a bare metal node suitable for booting the new
instance.

This means there will be some mismatch between resources that the Compute
service expects to find and resources that Bare Metal service advertised to
the Compute service.

Solution
--------

If you get this message, check the following:

#. Introspection should have succeeded for you before, or you should have
   entered the required bare-metal node properties manually.
   For each node in the :command:`ironic node-list` command, use:

   .. code-block:: console

      $ ironic node-show <IRONIC-NODE-UUID>

   and make sure that ``properties`` JSON field has valid values for keys
   ``cpus``, ``cpu_arch``, ``memory_mb`` and ``local_gb``.

#. The flavor in the Compute service that you are using does not exceed the
   bare-metal node properties above for a required number of nodes. Use:

   .. code-block:: console

      $ openstack flavor show FLAVOR

#. Make sure that enough nodes are in ``available`` state according to the
   :command:`ironic node-list` command. Nodes in ``manageable`` state usually
   mean they have failed introspection.

#. Make sure nodes you are going to deploy to are not in maintenance mode.
   Use the :command:`ironic node-list` command to check. A node automatically
   going to maintenance mode usually means the incorrect credentials for
   this node. Check them and then remove maintenance mode:

   .. code-block:: console

      $ ironic node-set-maintenance <IRONIC-NODE-UUID> off

#. It takes some time for nodes information to propagate from the Bare Metal
   service to the Compute service after introspection. Our tooling usually
   accounts for it, but if you did some steps manually there may be a period
   of time when nodes are not available to the Compute service yet. Check that
   the :command:`nova hypervisor-stats` command correctly shows total amount
   of resources in your system.
