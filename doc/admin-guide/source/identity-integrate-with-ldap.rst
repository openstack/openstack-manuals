.. _integrate-identity-with-ldap:

============================
Integrate Identity with LDAP
============================

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


.. toctree::
   :maxdepth: 2

   identity-ldap-server.rst
   identity-integrate-identity-backend-ldap.rst
   identity-secure-ldap-backend.rst
