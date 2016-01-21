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
Guide <http://docs.openstack.org/developer/heat/template_guide/index.html>`__
in the `Heat developer
documentation <http://docs.openstack.org/developer/heat/>`__.

Create a stack from an example template file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-  To create a stack, or template, from an `example template
   file <https://git.openstack.org/cgit/openstack/heat-templates>`__, run
   the following command:

   .. code-block:: console

      $ heat stack-create mystack --template-file /PATH_TO_HEAT_TEMPLATES/WordPress_Single_Instance.template \
        --parameters "InstanceType=m1.large;DBUsername=USERNAME;DBPassword=PASSWORD;KeyName=HEAT_KEY;LinuxDistribution=F17"

   The `--parameters` values that you specify depend on the parameters
   that are defined in the template. If a website hosts the template
   file, you can specify the URL with the `--template-url` parameter
   instead of the :`--template-file` parameter.

   The command returns the following output:

   .. code-block:: console

      +------------------+---------------+--------------------+----------------------+
      | id               | stack_name    | stack_status       | creation_time        |
      +------------------+---------------+--------------------+----------------------+
      | 4c712026-dcd5... | mystack       | CREATE_IN_PROGRESS | 2013-04-03T23:22:08Z |
      +------------------+---------------+--------------------+----------------------+

   .. note::

      When you run the :command:`heat stack-create` command with the
      `--poll` option, it prints the :command:`heat stack-show`
      output first, and then continuously prints the events in log format
      until the stack completes its action with success or failure.

-  You can also use the :command:`template-validate` command to validate a
   template file without creating a stack from it.

   .. note::

      Previous versions of the heat client used :command:`validate` instead of
      :command:`template-validate`, but it has been deprecated in favor of
      :command:`template-validate`.

   To do so, run the following command:

   .. code-block:: console

      $ heat template-validate --template-file /PATH_TO_HEAT_TEMPLATES/WordPress_Single_Instance.template

   If validation fails, the response returns an error message.

Get information about stacks
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To explore the state and history of a particular stack, you can run a
number of commands.

-  To see which stacks are visible to the current user, run the
   following command:

   .. code-block:: console

      $ heat stack-list
      +------------------+---------------+-----------------+----------------------+
      | id               | stack_name    | stack_status    | creation_time        |
      +------------------+---------------+-----------------+----------------------+
      | 4c712026-dcd5... | mystack       | CREATE_COMPLETE | 2013-04-03T23:22:08Z |
      | 7edc7480-bda5... | my-otherstack | CREATE_FAILED   | 2013-04-03T23:28:20Z |
      +------------------+---------------+-----------------+----------------------+

-  To show the details of a stack, run the following command:

   .. code-block:: console

      $ heat stack-show mystack

-  A stack consists of a collection of resources. To list the resources
   and their status, run the following command:

   .. code-block:: console

      $ heat resource-list mystack
      +---------------------+--------------------+-----------------+----------------------+
      | logical_resource_id | resource_type      | resource_status | updated_time         |
      +---------------------+--------------------+-----------------+----------------------+
      | WikiDatabase        | AWS::EC2::Instance | CREATE_COMPLETE | 2013-04-03T23:25:56Z |
      +---------------------+--------------------+-----------------+----------------------+

-  To show the details for a specific resource in a stack, run the
   following command:

   .. code-block:: console

      $ heat resource-show mystack WikiDatabase

-  Some resources have associated metadata which can change throughout
   the life cycle of a resource. Show the metadata by running the
   following command:

   .. code-block:: console

      $ heat resource-metadata mystack WikiDatabase

-  A series of events is generated during the life cycle of a stack. To
   display life cycle events, run the following command:

   .. code-block:: console

      $ heat event-list mystack
      +---------------------+----+------------------------+-----------------+----------------------+
      | logical_resource_id | id | resource_status_reason | resource_status | event_time           |
      +---------------------+----+------------------------+-----------------+----------------------+
      | WikiDatabase        | 1  | state changed          | IN_PROGRESS     | 2013-04-03T23:22:09Z |
      | WikiDatabase        | 2  | state changed          | CREATE_COMPLETE | 2013-04-03T23:25:56Z |
      +---------------------+----+------------------------+-----------------+----------------------+

-  To show the details for a particular event, run the following
   command:

   .. code-block:: console

      $ heat event-show WikiDatabase 1

Update a stack
~~~~~~~~~~~~~~

To update an existing stack from a modified template file, run a command
like the following command:

.. code-block:: console

   $ heat stack-update mystack --template-file \
     /path/to/heat/templates/WordPress_Single_Instance_v2.template \
     --parameters "InstanceType=m1.large;DBUsername=wp;DBPassword=verybadpassword;KeyName=heat_key;LinuxDistribution=F17"
   +--------------------------------------+---------------+-----------------+----------------------+
   | id                                   | stack_name    | stack_status    | creation_time        |
   +--------------------------------------+---------------+-----------------+----------------------+
   | 4c712026-dcd5-4664-90b8-0915494c1332 | mystack       | UPDATE_COMPLETE | 2013-04-03T23:22:08Z |
   | 7edc7480-bda5-4e1c-9d5d-f567d3b6a050 | my-otherstack | CREATE_FAILED   | 2013-04-03T23:28:20Z |
   +--------------------------------------+---------------+-----------------+----------------------+

Some resources are updated in-place, while others are replaced with new
resources.
