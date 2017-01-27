========================
Create and manage stacks
========================

The Orchestration service enables you to orchestrate multiple composite
cloud applications. This service supports use of both the Amazon Web
Services (AWS) CloudFormation template format through both a Query API
that is compatible with CloudFormation and the native OpenStack
:term:`Heat Orchestration Template (HOT)` format through a REST API.

These flexible template languages enable application developers to
describe and automate the deployment of infrastructure, services, and
applications. The templates enable creation of most OpenStack resource
types, such as instances, floating IP addresses, volumes, security
groups, and users. The resources, once created, are referred to as
stacks.

The template languages are described in the `Template
Guide <https://docs.openstack.org/developer/heat/template_guide/index.html>`__
in the `Heat developer
documentation <https://docs.openstack.org/developer/heat/>`__.

Create a stack from an example template file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  To create a stack, or template, from an `example template
   file <https://git.openstack.org/cgit/openstack/heat-templates>`__, run
   the following command:

   .. code-block:: console

      $ openstack stack create --template server_console.yaml \
        --parameter "image=cirros" MYSTACK

   The ``--parameter`` values that you specify depend on the parameters
   that are defined in the template. If a website hosts the template
   file, you can also specify the URL with the ``--template`` parameter.

   The command returns the following output:

   .. code-block:: console

      +---------------------+----------------------------------------------------------------+
      | Field               | Value                                                          |
      +---------------------+----------------------------------------------------------------+
      | id                  | 70b9feca-8f99-418e-b2f1-cc38d61b3ffb                           |
      | stack_name          | MYSTACK                                                        |
      | description         | The heat template is used to demo the 'console_urls' attribute |
      |                     | of OS::Nova::Server.                                           |
      |                     |                                                                |
      | creation_time       | 2016-06-08T09:54:15                                            |
      | updated_time        | None                                                           |
      | stack_status        | CREATE_IN_PROGRESS                                             |
      | stack_status_reason |                                                                |
      +---------------------+----------------------------------------------------------------+

-  You can also use the ``--dry-run`` option with the
   :command:`openstack stack create` command to validate a
   template file without creating a stack from it.

   If validation fails, the response returns an error message.

Get information about stacks
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To explore the state and history of a particular stack, you can run a
number of commands.

-  To see which stacks are visible to the current user, run the
   following command:

   .. code-block:: console

      $ openstack stack list
      +--------------------------------------+------------+-----------------+---------------------+--------------+
      | ID                                   | Stack Name | Stack Status    | Creation Time       | Updated Time |
      +--------------------------------------+------------+-----------------+---------------------+--------------+
      | 70b9feca-8f99-418e-b2f1-cc38d61b3ffb | MYSTACK    | CREATE_COMPLETE | 2016-06-08T09:54:15 | None         |
      +--------------------------------------+------------+-----------------+---------------------+--------------+

-  To show the details of a stack, run the following command:

   .. code-block:: console

      $ openstack stack show MYSTACK

-  A stack consists of a collection of resources. To list the resources
   and their status, run the following command:

   .. code-block:: console

      $ openstack stack resource list MYSTACK
      +---------------+--------------------------------------+------------------+-----------------+---------------------+
      | resource_name | physical_resource_id                 | resource_type    | resource_status | updated_time        |
      +---------------+--------------------------------------+------------------+-----------------+---------------------+
      | server        | 1b3a7c13-42be-4999-a2a1-8fbefd00062b | OS::Nova::Server | CREATE_COMPLETE | 2016-06-08T09:54:15 |
      +---------------+--------------------------------------+------------------+-----------------+---------------------+

-  To show the details for a specific resource in a stack, run the
   following command:

   .. code-block:: console

      $ openstack stack resource show MYSTACK server

-  Some resources have associated metadata which can change throughout
   the lifecycle of a resource. Show the metadata by running the
   following command:

   .. code-block:: console

      $ openstack stack resource metadata MYSTACK server

-  A series of events is generated during the lifecycle of a stack. To
   display lifecycle events, run the following command:

   .. code-block:: console

      $ openstack stack event list MYSTACK
      2016-06-08 09:54:15 [MYSTACK]: CREATE_IN_PROGRESS  Stack CREATE started
      2016-06-08 09:54:15 [server]: CREATE_IN_PROGRESS  state changed
      2016-06-08 09:54:41 [server]: CREATE_COMPLETE  state changed
      2016-06-08 09:54:41 [MYSTACK]: CREATE_COMPLETE  Stack CREATE completed successfully

-  To show the details for a particular event, run the following
   command:

   .. code-block:: console

      $ openstack stack event show MYSTACK server EVENT

Update a stack
~~~~~~~~~~~~~~

To update an existing stack from a modified template file, run a command
like the following command:

.. code-block:: console

   $ openstack stack update --template server_console.yaml \
     --parameter "image=ubuntu" MYSTACK
   +---------------------+----------------------------------------------------------------+
   | Field               | Value                                                          |
   +---------------------+----------------------------------------------------------------+
   | id                  | 267a459a-a8cd-4d3e-b5a1-8c08e945764f                           |
   | stack_name          | mystack                                                        |
   | description         | The heat template is used to demo the 'console_urls' attribute |
   |                     | of OS::Nova::Server.                                           |
   |                     |                                                                |
   | creation_time       | 2016-06-08T09:54:15                                            |
   | updated_time        | 2016-06-08T10:41:18                                            |
   | stack_status        | UPDATE_IN_PROGRESS                                             |
   | stack_status_reason | Stack UPDATE started                                           |
   +---------------------+----------------------------------------------------------------+

Some resources are updated in-place, while others are replaced with new
resources.
