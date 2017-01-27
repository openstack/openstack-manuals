======================================
Launch and manage stacks using the CLI
======================================

The Orchestration service provides a template-based
orchestration engine. Administrators can use the orchestration engine
to create and manage OpenStack cloud infrastructure resources. For
example, an administrator can define storage, networking, instances,
and applications to use as a repeatable running environment.

Templates are used to create stacks, which are collections
of resources. For example, a stack might include instances,
floating IPs, volumes, security groups, or users.
The Orchestration service offers access to all OpenStack
core services through a single modular template, with additional
orchestration capabilities such as auto-scaling and basic
high availability.

For information about:

-  basic creation and deletion of Orchestration stacks, refer
   to the `OpenStack End User Guide
   <https://docs.openstack.org/user-guide/dashboard-stacks.html>`_

-  **openstack** CLI, see the `OpenStackClient documentation
   <https://docs.openstack.org/developer/python-openstackclient/>`_

.. note::

   The ``heat`` CLI is deprecated in favor of ``python-openstackclient``.
   For a Python library, continue using ``python-heatclient``.

As an administrator, you can also carry out stack functions
on behalf of your users. For example, to resume, suspend,
or delete a stack, run:

.. code-block:: console

   $ openstack stack resume STACK
   $ openstack stack suspend STACK
   $ openstack stack delete STACK
