.. _orchestration-stack-domain-users:

==================
Stack domain users
==================

Stack domain users allow the Orchestration service to
authorize and start the following operations within booted virtual
machines:

* Provide metadata to agents inside instances. Agents poll for changes
  and apply the configuration that is expressed in the metadata to the
  instance.

* Detect when an action is complete. Typically, software configuration
  on a virtual machine after it is booted. Compute moves
  the VM state to "Active" as soon as it creates it, not when the
  Orchestration service has fully configured it.

* Provide application level status or meters from inside the instance.
  For example, allow auto-scaling actions to be performed in response
  to some measure of performance or quality of service.

The Orchestration service provides APIs that enable all of these
operations, but all of those APIs require authentication.
For example, credentials to access the instance that the agent
is running upon. The heat-cfntools agents use signed requests,
which require an ec2 key pair created through Identity.
The key pair is then used to sign requests to the Orchestration
CloudFormation and CloudWatch compatible APIs, which are
authenticated through signature validation. Signature validation
uses the Identity ec2tokens extension.

Stack domain users encapsulate all stack-defined users (users who are
created as a result of data that is contained in an
Orchestration template) in a separate domain.
The separate domain is created specifically to contain data
related to the Orchestration stacks only. A user is created, which is
the *domain admin*, and Orchestration uses the *domain admin* to manage
the lifecycle of the users in the stack *user domain*.

Stack domain users configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To configure stack domain user, the Orchestration service completes the
following tasks:

#. A special OpenStack Identity service domain is created. For
   example, a domain that is called ``heat`` and the ID is set with the
   ``stack_user_domain`` option in the :file:`heat.conf` file.
#. A user with sufficient permissions to create and delete projects
   and users in the ``heat`` domain is created.
#. The username and password for the domain admin user is set in the
   :file:`heat.conf` file (``stack_domain_admin`` and
   ``stack_domain_admin_password``). This user administers
   *stack domain users* on behalf of stack owners, so they no longer
   need to be administrators themselves. The risk of this escalation path
   is limited because the ``heat_domain_admin`` is only given
   administrative permission for the ``heat`` domain.

To set up stack domain users, complete the following steps:

#. Create the domain:

   ``$OS_TOKEN`` refers to a token. For example, the service admin
   token or some other valid token for a user with sufficient roles
   to create users and domains. ``$KS_ENDPOINT_V3`` refers to the v3
   OpenStack Identity endpoint (for example,
   ``http://keystone_address:5000/v3`` where *keystone_address* is
   the IP address or resolvable name for the Identity
   service).

   .. code-block:: console

    $ openstack --os-token $OS_TOKEN --os-url=$KS_ENDPOINT_V3 --os-\
      identity-api-version=3 domain create heat --description "Owns \
      users and projects created by heat"

   The domain ID is returned by this command, and is referred to as
   ``$HEAT_DOMAIN_ID`` below.

#. Create the user:

   .. code-block:: console

    $ openstack --os-token $OS_TOKEN --os-url=$KS_ENDPOINT_V3 --os-\
      identity-api-version=3 user create --password $PASSWORD --domain \
      $HEAT_DOMAIN_ID heat_domain_admin --description "Manages users \
      and projects created by heat"

   The user ID is returned by this command and is referred to as
   ``$DOMAIN_ADMIN_ID`` below.

#. Make the user a domain admin:

   .. code-block:: console

    $ openstack --os-token $OS_TOKEN --os-url=$KS_ENDPOINT_V3 --os-\
      identity-api-version=3 role add --user $DOMAIN_ADMIN_ID --domain \
      $HEAT_DOMAIN_ID admin

   Then you must add the domain ID, username and password from these
   steps to the :file:`heat.conf` file:

   .. code-block:: ini

       stack_domain_admin_password = password
       stack_domain_admin = heat_domain_admin
       stack_user_domain = domain id returned from domain create above

Usage workflow
~~~~~~~~~~~~~~

The following steps are run during stack creation:

#. Orchestration creates a new *stack domain project* in the ``heat``
   domain if the stack contains any resources that require creation
   of a *stack domain user*.

#. For any resources that require a user, the Orchestration service creates
   the user in the *stack domain project*. The *stack domain project* is
   associated with the Orchestration stack in the Orchestration
   database, but is separate and unrelated (from an authentication
   perspective) to the stack owners project. The users who are created
   in the stack domain are still assigned the ``heat_stack_user`` role, so
   the API surface they can access is limited through
   the :file:`policy.json` file.
   For more  information, see :doc:`OpenStack Identity
   documentation <identity-management>`.

#. When API requests are processed, the Orchestration service performs
   an internal lookup, and allows stack details for a given stack to be
   retrieved. Details are retrieved from the database for
   both the stack owner's project (the default
   API path to the stack) and the stack domain project, subject to the
   :file:`policy.json` restrictions.

This means there are now two paths that
can result in the same data being retrieved through the Orchestration API.
The following example is for resource-metadata::

  GET v1/​{stack_owner_project_id}​/stacks/​{stack_name}​/\
  ​{stack_id}​/resources/​{resource_name}​/metadata

or::

  GET v1/​{stack_domain_project_id}​/stacks/​{stack_name}​/​\
  {stack_id}​/resources/​{resource_name}​/metadata

The stack owner uses the former (via ``openstack stack resource metadata
STACK RESOURCE``), and any agents in the instance
use the latter.
