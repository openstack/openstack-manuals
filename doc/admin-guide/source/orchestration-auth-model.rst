.. _orchestration-auth-model:

=================================
Orchestration authorization model
=================================


The Orchestration authorization model defines the
authorization process for requests during deferred operations.
A common example is an auto-scaling group update. During
the auto-scaling update operation, the Orchestration service
requests resources of other components (such as servers from
Compute or networks from Networking) to extend or reduce the
capacity of an auto-scaling group.

The Orchestration service provides the following authorization models:

* Password authorization

* OpenStack Identity trusts authorization

Password authorization
~~~~~~~~~~~~~~~~~~~~~~

The Orchestration service supports password authorization.
Password authorization requires that a user pass a
username and password to the Orchestration service. Encrypted
password are stored in the database, and used for deferred
operations.

Password authorization involves the following steps:

#. A user requests stack creation, by providing a token and
   username and password. The Dashboard or
   python-heatclient requests the token on the user's behalf.

#. If the stack contains any resources that require deferred
   operations, then the orchestration engine fails its validation
   checks if the user did not provide a valid username/password.

#. The username/password are encrypted and stored in the Orchestration
   database.

#. Orchestration creates a stack.

#. Later, the Orchestration service retrieves the credentials and
   requests another token on behalf of the user. The token is not
   limited in scope and provides access to all the roles of the stack
   owner.

OpenStack Identity trusts authorization
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A trust is an OpenStack Identity extension that enables delegation,
and optionally impersonation through the OpenStack Identity service.
The key terminology is *trustor* (the user delegating) and
*trustee* (the user being delegated to).

To create a trust, the *trustor* (in this case, the user creating the
stack in the Orchestration service) provides the OpenStack Identity service
with the following information:

* The ID of the *trustee* (who you want to delegate to, in this case,
  the Orchestration service user).

* The roles to be delegated. Configure roles through
  the ``heat.conf`` file. Ensure the configuration contains whatever
  roles are required to perform the deferred operations on the
  user's behalf. For example, launching an OpenStack Compute
  instance in response to an auto-scaling event.

* Whether to enable impersonation.

The OpenStack Identity service provides a *trust ID*,
which is consumed by *only* the trustee to obtain a
*trust scoped token*. This token is limited in scope,
such that the trustee has limited access to those
roles delegated. In addition, the trustee has effective impersonation
of the trustor user if it was selected when creating the trust.
For more information, see :doc:`Identity management <identity-management>`.

Trusts authorization involves the following steps:

#. A user creates a stack through an API request (only the token is
   required).

#. The Orchestration service uses the token to create a trust
   between the stack owner (trustor) and the Orchestration
   service user (trustee). The service delegates a special role (or roles)
   as defined in the *trusts_delegated_roles* list in the
   Orchestration configuration file. By default, the Orchestration
   service sets all the roles from trustor available for trustee.
   Deployers might modify this list to reflect a local RBAC policy.
   For example, to ensure that the heat process can access only
   those services that are expected while impersonating a stack owner.

#. Orchestration stores the encrypted *trust ID* in the Orchestration
   database.

#. When a deferred operation is required, the Orchestration service
   retrieves the *trust ID* and requests a trust scoped token which
   enables the service user to impersonate the stack owner during
   the deferred operation. Impersonation is helpful, for example,
   so the service user can launch Compute instances on
   behalf of the stack owner in response to an auto-scaling event.

Authorization model configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Initially, the password authorization model was the
default authorization model. Since the Kilo release, the
Identity trusts authorization model is enabled for the Orchestration
service by default.

To enable the password authorization model, change the following
parameter in the ``heat.conf`` file:

.. code-block:: ini

   deferred_auth_method=password

To enable the trusts authorization model, change the following
two parameters in the ``heat.conf`` file.

Specify the authentication method for the deferred Orchestration actions.
This parameter triggers creating *trust ID* and stores it
in the Orchestration database:

.. code-block:: ini

   deferred_auth_method=trusts

Allow reauthentication with the trust scoped token issued
by using the stored *trust ID* for long running tasks:

.. code-block:: ini

   reauthentication_auth_method=trusts

To specify the trustor roles that it delegates to trustee during
authorization, specify the ``trusts_delegated_roles`` parameter
in the ``heat.conf`` file. If ``trusts_delegated_roles`` is not
defined, then all the trustor roles are delegated to trustee.

.. note::

   The trustor delegated roles must be pre-configured in the
   OpenStack Identity service before using them in the Orchestration service.
