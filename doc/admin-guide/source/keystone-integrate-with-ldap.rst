.. _integrate-identity-with-ldap:

============================
Integrate Identity with LDAP
============================

.. toctree::
   :maxdepth: 2

   keystone-integrate-identity-backend-ldap.rst
   keystone-integrate-assignment-backend-ldap.rst
   keystone-secure-identity-to-ldap-backend.rst

The OpenStack Identity service supports integration with existing LDAP
directories for authentication and authorization services. LDAP back
ends require initialization before configuring the OpenStack Identity
service to work with it. For more information, see `Setting up LDAP
for use with Keystone <https://wiki.openstack.org/wiki/OpenLDAP>`__.

When the OpenStack Identity service is configured to use LDAP back ends,
you can split authentication (using the *identity* feature) and
authorization (using the *assignment* feature).

The *identity* feature enables administrators to manage users and groups
by each domain or the OpenStack Identity service entirely.

The *assignment* feature enables administrators to manage project role
authorization using the OpenStack Identity service SQL database, while
providing user authentication through the LDAP directory.

.. important::

   For the OpenStack Identity service to access LDAP servers, you must
   enable the ``authlogin_nsswitch_use_ldap`` boolean value for SELinux
   on the server running the OpenStack Identity service. To enable and
   make the option persistent across reboots, set the following boolean
   value as the root user:

.. code-block:: console

   # setsebool -P authlogin_nsswitch_use_ldap on

The Identity configuration is split into two separate back ends; identity
(back end for users and groups), and assignments (back end for domains,
projects, roles, role assignments). To configure Identity, set options
in the ``/etc/keystone/keystone.conf`` file. See
:ref:`integrate-identity-backend-ldap` for Identity back end configuration
examples and :ref:`integrate-assignment-backend-ldap` for assignment back
end configuration examples. Modify these examples as needed.

.. note::

   Multiple back ends are supported. You can integrate the OpenStack
   Identity service with a single LDAP server (configure both identity
   and assignments to LDAP, or set identity and assignments back end
   with SQL or LDAP), or multiple back ends using domain-specific
   configuration files.


**To define the destination LDAP server**

#. Define the destination LDAP server in the ``keystone.conf`` file:

   .. code-block:: ini

      [ldap]
      url = ldap://localhost
      user = dc=Manager,dc=example,dc=org
      password = samplepassword
      suffix = dc=example,dc=org
      use_dumb_member = False
      allow_subtree_delete = False

#. Configure ``dumb_member`` to true if your environment requires
   the ``use_dumb_member`` variable.

   .. code-block:: ini

      [ldap]
      dumb_member = cn=dumb,dc=nonexistent

**Additional LDAP integration settings**

Set these options in the ``/etc/keystone/keystone.conf`` file for a
single LDAP server, or ``/etc/keystone/domains/keystone.DOMAIN_NAME.conf``
files for multiple back ends. Example configurations appear below each
setting summary:

**Query option**

.. hlist::
   :columns: 1

   * Use ``query_scope`` to control the scope level of data presented
     (search only the first level or search an entire sub-tree)
     through LDAP.
   * Use ``page_size`` to control the maximum results per page. A value
     of zero disables paging.
   * Use ``alias_dereferencing`` to control the LDAP dereferencing
     option for queries.
   * Use ``chase_referrals`` to override the system's default referral
     chasing behavior for queries.

.. code-block:: ini

   [ldap]
   query_scope = sub
   page_size = 0
   alias_dereferencing = default
   chase_referrals =

**Debug**

Use ``debug_level`` to set the LDAP debugging level for LDAP calls.
A value of zero means that debugging is not enabled.

.. code-block:: ini

   [ldap]
   debug_level = 0

.. warning::

   This value is a bitmask, consult your LDAP documentation for
   possible values.

**Connection pooling**

Use ``use_pool`` to enable LDAP connection pooling. Configure the
connection pool size, maximum retry, reconnect trials, timeout (-1
indicates indefinite wait) and lifetime in seconds.

.. code-block:: ini

   [ldap]
   use_pool = true
   pool_size = 10
   pool_retry_max = 3
   pool_retry_delay = 0.1
   pool_connection_timeout = -1
   pool_connection_lifetime = 600

**Connection pooling for end user authentication**

Use ``use_auth_pool`` to enable LDAP connection pooling for end user
authentication. Configure the connection pool size and lifetime in
seconds.

.. code-block:: ini

   [ldap]
   use_auth_pool = false
   auth_pool_size = 100
   auth_pool_connection_lifetime = 60

When you have finished the configuration, restart the OpenStack Identity
service.

.. warning::

   During the service restart, authentication and authorization are
   unavailable.
