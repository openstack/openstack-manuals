.. _identity_management:

===================
Identity management
===================

OpenStack Identity, code-named keystone, is the default Identity
management system for OpenStack. After you install Identity, you
configure it through the ``/etc/keystone/keystone.conf``
configuration file and, possibly, a separate logging configuration
file. You initialize data into Identity by using the ``keystone``
command-line client.

.. toctree::
   :maxdepth: 1

   identity-concepts.rst
   keystone-certificates-for-pki.rst
   keystone-configure-with-SSL.rst
   keystone-domain-specific-config.rst
   keystone-external-authentication.rst
   keystone-integrate-with-ldap.rst
   keystone-tokens.rst
   keystone-token-binding.rst
   keystone-fernet-token-faq.rst
   keystone-use-trusts.rst
   keystone-caching-layer.rst
   identity-start.rst
   identity-keystone-usage-and-features.rst
   identity-auth-token-middleware.rst
   identity-service-api-protection.rst
   identity-troubleshoot.rst
