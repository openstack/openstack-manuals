======================================
Launch and manage stacks using the CLI
======================================

The Orchestration service provides a template-based
orchestration engine for the OpenStack cloud, which
can be used to create and manage cloud infrastructure
resources such as storage, networking, instances, and
applications as a repeatable running environment.

Templates are used to create stacks, which are collections
of resources. For example, a stack might include instances,
floating IPs, volumes, security groups, or users.
The Orchestration service offers access to all OpenStack
core services via a single modular template, with additional
orchestration capabilities such as auto-scaling and basic
high availability.

For information about:

-  basic creation and deletion of Orchestration stacks, refer
   to the `OpenStack End User Guide <http://docs.openstack.org/user-guide/dashboard_stacks.html>`_

-  **heat** CLI commands, see the `OpenStack Command Line Interface Reference
   <http://docs.openstack.org/cli-reference/heat.html>`_

As an administrator, you can also carry out stack functions
on behalf of your users. For example, to resume, suspend,
or delete a stack, run:

.. code-block:: console

   $ heat action-resume stackID
   $ heat action-suspend stackID
   $ heat stack-delete stackID
