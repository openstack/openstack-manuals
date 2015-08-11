.. highlight: ini
   :linenothreshold: 3

.. _orchestration-auth-model:

=================================
Orchestration authorization model
=================================


Orchestration authorization model defines the process of authorization
that orchestration module uses to authorize requests during so called
deferred operations. The typical example of such operation is
autoscaling group update when Orchestration requests other components
(OpenStack Compute, Openstack Networking or others) to extend (reduce)
capacity of autoscaling group.

Currently, Orchestration provides two kinds of authorization models:

* Password authorization,

* Authorization with OpenStack Identity trusts.

Password authorization
~~~~~~~~~~~~~~~~~~~~~~

Password authorization is the initial authorization model that was
supported by Orchestration module. This kind of authorization requires
from a user to pass a password to Orchestration. Orchestration stores
the encrypted password in the database and uses it for deferred
operations.

The following steps are executed for password authorization:

#. User requests a stack creation, providing a token and
   username/password (python-heatclient or OpenStack dashboard
   normally requests the token for you).

#. If the stack contains any resources marked as requiring deferred
   operations, orchestration engine will fail validation checks if no
   username/password is provided.

#. The username/password are encrypted and stored in the Orchestration
   DB.

#. Stack creation is completed.

#. At some later stage, Orchestration retrieves the credentials and
   requests another token on behalf of the user. The token is not
   limited in scope and provides access to all the roles of the stack
   owner.

Keystone trusts authorization
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack Identity trusts is a new authorization method available
since the Icehouse release.

A trust is an OpenStack Identity extension that provides a method
to enable delegation, and optionally impersonation via OpenStack
Identity. The key terminology is *trustor* (the user delegating) and
*trustee* (the user being delegated to).

To create a trust, the *trustor* (in this case, the user creating the
stack in Orchestration module) provides OpenStack Identity with the
following information:

* The ID of the *trustee* (who you want to delegate to, in this case,
  the Orchestration module user).

* The roles to be delegated (configurable via the ``heat.conf``, but
  it needs to contain whatever roles are required to perform the
  deferred operations on the users behalf, for example, launching an
  OpenStack Compute instance in response to an AutoScaling event).

* Whether to enable impersonation.

OpenStack Identity then provides a trust_id, which can be consumed by
*only* the trustee to obtain a *trust scoped token*. This token is
limited in scope such that the trustee has limited access to those
roles delegated, along with effective impersonation of the trustor
user if it was selected when creating the trust. More information is
available in the :ref:`Identity management <identity_management>`
section.

The following steps are executed for trusts authorization:

#. User creates a stack via an API request (only the token is
   required).

#. Orchestration uses the token to create a trust between the stack
   owner (trustor) and the Orchestration module user (trustee),
   delegating a special role (or roles) as defined in the
   *trusts_delegated_roles* list in the Orchestration configuration
   file. By default, Orchestration module sets all the roles from
   trustor available for trustee. Deployers may modify this list to
   reflect local RBAC policy, for example, to ensure the heat process
   can only access those services expected while impersonating a
   stack owner.

#. Orchestration stores the encrypted *trust id* in the Orchestration
   DB.

#. When a deferred operation is required, Orchestration retrieves the
   *trust id* and requests a trust scoped token which enables the
   service user to impersonate the stack owner for the duration of
   the deferred operation, for example, to launch some OpenStack
   Compute instances on behalf of the stack owner in response to an
   AutoScaling event.

Authorization model configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Password authorization model had been the default authorization model
enabled for the Orchestration module before the Kilo release. Since
the Kilo release, the trusts authorization model has been enabled by
default.

To enable the password authorization model, the following change
should be made in ``heat.conf``:

.. code-block:: ini

   deferred_auth_method=password

To enable the trusts authorization model, the following change should
be made in ``heat.conf``:

.. code-block:: ini

   deferred_auth_method=trusts

To specify the trustor roles that it delegates to trustee during
authorization, the ``trusts_delegated_roles`` parameter should be
specified in ``heat.conf``. If ``trusts_delegated_roles`` is not
defined, then all the trustor roles are delegated to trustee.

.. note::

   The trustor delegated roles should be pre-configured in the
   OpenStack Identity before using it in the Orchestration module.
