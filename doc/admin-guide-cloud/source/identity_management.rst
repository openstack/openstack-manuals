.. _identity_management:

===================
Identity management
===================

OpenStack Identity, code-named keystone, is the default identity
management system for OpenStack. After you install Identity, you
configure it through the :file:`/etc/keystone/keystone.conf`
configuration file and, possibly, a separate logging configuration
file. You initialize data into Identity by using the ``keystone``
command-line client.

.. toctree::
   :maxdepth: 1

   identity_concepts.rst
   keystone_certificates_for_pki.rst
   keystone_configure_with_SSL.rst
   keystone_external_authentication.rst
   keystone_integrate_with_ldap.rst
   keystone_tokens.rst
   keystone_token-binding.rst
   keystone_fernet_token_faq.rst
   keystone_use_trusts.rst
   keystone_caching_layer.rst
   identity_user_crud.rst
   identity_logging.rst
   identity_start.rst
   identity_example_usage.rst
   identity_auth_token_middleware.rst
   identity_service_api_protection.rst
   identity_troubleshoot.rst
