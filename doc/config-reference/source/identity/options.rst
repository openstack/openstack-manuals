===================================
Identity service configuration file
===================================

The Identity service is configured in the ``/etc/keystone/keystone.conf`` file.

The following tables provide a comprehensive list of the Identity
service options.

.. include:: ../tables/keystone-api.rst
.. include:: ../tables/keystone-assignment.rst
.. include:: ../tables/keystone-auth.rst
.. include:: ../tables/keystone-auth_token.rst
.. include:: ../tables/keystone-ca.rst
.. include:: ../tables/keystone-catalog.rst
.. include:: ../tables/keystone-common.rst
.. include:: ../tables/keystone-cors.rst
.. include:: ../tables/keystone-credential.rst
.. include:: ../tables/keystone-database.rst
.. include:: ../tables/keystone-debug.rst
.. include:: ../tables/keystone-domain.rst
.. include:: ../tables/keystone-federation.rst
.. include:: ../tables/keystone-fernet_tokens.rst
.. include:: ../tables/keystone-identity.rst
.. include:: ../tables/keystone-kvs.rst
.. include:: ../tables/keystone-ldap.rst
.. include:: ../tables/keystone-logging.rst
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
.. include:: ../tables/keystone-rpc.rst
.. include:: ../tables/keystone-amqp.rst
.. include:: ../tables/keystone-qpid.rst
.. include:: ../tables/keystone-rabbitmq.rst
.. include:: ../tables/keystone-zeromq.rst
.. include:: ../tables/keystone-redis.rst

Domain-specific configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Identity service supports domain-specific Identity drivers which allow a
domain to have its own LDAP or SQL back end. By default, domain-specific
drivers are disabled.

Domain-specific Identity configuration options can be stored in domain-specific
configuration files, or in the Identity SQL database using API REST calls.

.. note::

    Storing and managing configuration options in an SQL database is
    experimental in Kilo.

Enable drivers for domain-specific configuration files
------------------------------------------------------

To enable domain-specific drivers, set these options in the
``/etc/keystone/keystone.conf`` file:

.. code-block:: ini

    [identity]
    domain_specific_drivers_enabled = True
    domain_config_dir = /etc/keystone/domains

When you enable domain-specific drivers, Identity looks in the
``domain_config_dir`` directory for configuration files that are named as
``keystone.DOMAIN_NAME.conf``. Any domain without a domain-specific
configuration file uses options in the primary configuration file.

Domain-specific configuration file
----------------------------------

Any options that you define in the domain-specific configuration file override
options in the ``/etc/keystone/keystone.conf`` configuration file.

Domains configured for the service user or project use the Identity API v3 to
retrieve the service token.

To configure the domain for the service user, set the following options in the
[DEFAULT] section of the ``/etc/keystone/domains/keystone.DOMAIN_NAME.conf``
file:

.. code-block:: ini

    admin_user_domain_id = USER_DOMAIN_ID
    admin_user_domain_name = USER_DOMAIN_NAME

Replace ``USER_DOMAIN_ID`` with the Identity service account user domain
ID, and ``USER_DOMAIN_NAME`` with the Identity service account user domain
name.

To configure the domain for the project, set the following options in the
``[DEFAULT]`` section of the
``/etc/keystone/domains/keystone.DOMAIN_NAME.conf`` file:

.. code-block:: ini

    admin_project_domain_id = PROJECT_DOMAIN_ID
    admin_project_domain_name = PROJECT_DOMAIN_NAME

Replace ``PROJECT_DOMAIN_ID`` with the Identity service account project
domain ID, and ``PROJECT_DOMAIN_NAME`` with the Identity service account
project domain name.

Enable drivers for storing configuration options in SQL database
----------------------------------------------------------------

To enable domain-specific drivers, set these options in the
``/etc/keystone/keystone.conf`` file:

.. code-block:: ini

    [identity]
    domain_specific_drivers_enabled = True
    domain_configurations_from_database = True

Any domain-specific configuration options specified through the Identity v3 API
will override domain-specific configuration files in the
``/etc/keystone/domains`` directory.

Migrate domain-specific configuration files to the SQL database
---------------------------------------------------------------

You can use the ``keystone-manage`` command to migrate configuration options in
domain-specific configuration files to the SQL database:

.. code-block:: console

    # keystone-manage domain_config_upload --all

To upload options from a specific domain-configuration file, specify the domain
name:

.. code-block:: console

    # keystone-manage domain_config_upload --domain-name DOMAIN_NAME
