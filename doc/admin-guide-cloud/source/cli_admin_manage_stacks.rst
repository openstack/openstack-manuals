======================================
Launch and manage stacks using the CLI
======================================

The Orchestration service provides a template-based
orchestration engine. Administrators can use the orchestration engine
to create and manage Openstack cloud infrastructure resources. For
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
