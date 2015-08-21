.. highlight: ini

.. _orchestration-stack-domain-users:

==================
Stack domain users
==================

Orchestration stack domain users allows Orchestration module to
authorize inside VMs booted and execute the following operations:

* Provide metadata to agents inside instances, which poll for changes
  and apply the configuration expressed in the metadata to the
  instance.

* Detect signal completion of some action, typically configuration of
  software on a VM after it is booted (because OpenStack Compute moves
  the state of a VM to "Active" as soon as it spawns it, not when
  Orchestration has fully configured it).

* Provide application level status or meters from inside the instance.
  For example, allow AutoScaling actions to be performed in response
  to some measure of performance or quality of service.

Orchestration provides APIs which enable all of these things, but all
of those APIs require some sort of authentication. For example,
credentials to access the instance agent is running on. The
heat-cfntools agents use signed requests, which requires an ec2
keypair created via OpenStack Identity, which is then used to sign
requests to the Orchestration CloudFormation and CloudWatch compatible
APIs, which are authenticated by Orchestration via signature validation
(which uses the OpenStack Identity ec2tokens extension). Stack domain
users allow to encapsulate all stack-defined users (users created as
a result of things contained in an Orchestration template) in a
separate domain which is created specifically to contain things
related only to the Orchestration stacks. A user is created which is
the *domain admin*, and Orchestration uses that user to manage the
lifecycle of the users in the stack *user domain*.

Stack domain users configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To configure stack domain users the following steps shall be executed:

#. A special OpenStack Identity service domain is created. For
   example, the one called ``heat`` and the ID is set in the
   ``stack_user_domain`` option in :file:`heat.conf`.
#. A user with sufficient permissions to create and delete projects
   and users in the ``heat`` domain is created.
#. The username and password for the domain admin user is set in
   :file:`heat.conf` (``stack_domain_admin`` and
   ``stack_domain_admin_password``). This user administers
   *stack domain users* on behalf of stack owners, so they no longer
   need to be admins themselves, and the risk of this escalation path
   is limited because the ``heat_domain_admin`` is only given
   administrative permission for the ``heat`` domain.

You must complete the following steps to setup stack domain users:

#. Create the domain:

   ``$OS_TOKEN`` refers to a token. For example, the service admin
   token or some other valid token for a user with sufficient roles
   to create users and domains. ``$KS_ENDPOINT_V3`` refers to the v3
   OpenStack Identity endpoint (for example,
   ``http://keystone_address:5000/v3`` where *keystone_address* is
   the IP address or resolvable name for the OpenStack Identity
   service).

   ::

    $ openstack --os-token $OS_TOKEN --os-url=$KS_ENDPOINT_V3 --os-\
      identity-api-version=3 domain create heat --description "Owns \
      users and projects created by heat"

   The domain ID is returned by this command, and is referred to as
   ``$HEAT_DOMAIN_ID`` below.

#. Create the user::

    $ openstack --os-token $OS_TOKEN --os-url=$KS_ENDPOINT_V3 --os-\
      identity-api-version=3 user create --password $PASSWORD --domain \
      $HEAT_DOMAIN_ID heat_domain_admin --description "Manages users \
      and projects created by heat"

   The user ID is returned by this command and is referred to as
   ``$DOMAIN_ADMIN_ID`` below.

#. Make the user a domain admin::

    $ openstack --os-token $OS_TOKEN --os-url=$KS_ENDPOINT_V3 --os-\
      identity-api-version=3 role add --user $DOMAIN_ADMIN_ID --domain \
      $HEAT_DOMAIN_ID admin

   Then you need to add the domain ID, username and password from these
   steps to :file:`heat.conf`:

   .. code-block:: ini
      :linenos:

       stack_domain_admin_password = password
       stack_domain_admin = heat_domain_admin
       stack_user_domain = domain id returned from domain create above

Usage workflow
~~~~~~~~~~~~~~

The following steps will be executed during stack creation:

#. Orchestration creates a new *stack domain project* in the ``heat``
   domain if the stack contains any resources which require creation
   of a *stack domain user*.

#. For any resources which require a user, Orchestration creates the
   user in the *stack domain project*, which is associated with the
   Orchestration stack in the Orchestration database, but is
   completely separate and unrelated (from an authentication
   perspective) to the stack owners project (the users created in the
   stack domain are still assigned the ``heat_stack_user`` role, so
   the API surface they can access is limited via :file:`policy.json`.
   See :ref:`OpenStack Identity documentation <identity_management>`
   for more info).

#. When API requests are processed, Orchestration does an internal
   lookup and allows stack details for a given stack to be retrieved
   from the database for both the stack owner's project (the default
   API path to the stack) and the stack domain project, subject to the
   :file:`policy.json` restrictions.

To clarify that last point, that means there are now two paths which
can result in retrieval of the same data via the Orchestration API.
The example for resource-metadata is below::

  GET v1/​{stack_owner_project_id}​/stacks/​{stack_name}​/\
  ​{stack_id}​/resources/​{resource_name}​/metadata

or::

  GET v1/​{stack_domain_project_id}​/stacks/​{stack_name}​/​\
  {stack_id}​/resources/​{resource_name}​/metadata

The stack owner uses the former (via ``heat resource-metadata
{stack_name} {resource_name}``), and any agents in the instance
use the latter.
