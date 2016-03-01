=============
Neutron purge
=============

From the Mitaka release onwards, the OpenStack Networking command-line
interface (CLI) supports the deletion of multiple resources for a given tenant
with a single command.

The resources currently supported by this feature are:

* Networks
* Subnets
* Ports
* Router Interfaces
* Routers
* Floating IPs
* Security Groups

Usage
~~~~~

To delete all supported resources owned by a tenant, use the
:command:`neutron purge` command as follows:

.. code-block:: console

    $ neutron purge <tenant_id>

An admin can provide the ID of any tenant that they have access to. A tenant
must provide their own ID.

While the command is running, feedback is provided in the form of completion
percentage. On completion, the command returns a list of resources that were
and/or could not be deleted:

.. code-block:: console

    Purging resources: 100% complete.
    Deleted 1 security_group, 2 ports, 1 router, 1 floatingip, 2 networks.
    The following resouces could not be deleted: 1 network.

A resource being in use by another tenant (for example, a shared network) can
prevent it from being deleted.
