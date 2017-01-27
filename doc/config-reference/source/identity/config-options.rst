=====================================================
Additional configuration options for Identity service
=====================================================

The Identity service is configured in the ``/etc/keystone/keystone.conf`` file.

The following tables provide a comprehensive list of the Identity
service options.

.. include:: ../tables/keystone-assignment.rst
.. include:: ../tables/keystone-auth.rst
.. include:: ../tables/keystone-ca.rst
.. include:: ../tables/keystone-catalog.rst
.. include:: ../tables/keystone-common.rst
.. include:: ../tables/keystone-credential.rst
.. include:: ../tables/keystone-debug.rst
.. include:: ../tables/keystone-domain.rst
.. include:: ../tables/keystone-federation.rst
.. include:: ../tables/keystone-fernet_tokens.rst
.. include:: ../tables/keystone-identity.rst
.. include:: ../tables/keystone-kvs.rst
.. include:: ../tables/keystone-ldap.rst
.. include:: ../tables/keystone-mapping.rst
.. include:: ../tables/keystone-memcache.rst
.. include:: ../tables/keystone-oauth.rst
.. include:: ../tables/keystone-os_inherit.rst
.. include:: ../tables/keystone-policy.rst
.. include:: ../tables/keystone-revoke.rst
.. include:: ../tables/keystone-role.rst
.. include:: ../tables/keystone-saml.rst
.. include:: ../tables/keystone-security.rst
.. include:: ../tables/keystone-token.rst
.. include:: ../tables/keystone-tokenless.rst
.. include:: ../tables/keystone-trust.rst
.. include:: ../tables/keystone-redis.rst

Domain-specific Identity drivers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Identity service supports domain-specific Identity drivers
installed on an SQL or LDAP back end, and supports domain-specific
Identity configuration options, which are stored in domain-specific
configuration files. See the
`Admin guide Identity Management Chapter
<https://docs.openstack.org/admin-guide/identity-domain-specific-config.html>`_
for more information.
