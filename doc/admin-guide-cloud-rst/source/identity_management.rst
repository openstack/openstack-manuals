===================
Identity management
===================

OpenStack Identity, code-named keystone, is the default identity
management system for OpenStack. After you install Identity, you
configure it through the :file:`etc/keystone.conf` configuration file and,
possibly, a separate logging configuration file. You initialize data
into Identity by using the ``keystone`` command-line client.

Identity concepts
~~~~~~~~~~~~~~~~~

.. TODO (DC) Convert the following common files and include(?) them under the
   identity concepts section:
   /common/section_keystone-concepts-user-management.xml
   /common/section_keystone-concepts-service-management.xml
   /common/section_keystone-concepts-group-management.xml

.. TODO (DC) Convert the following common files and include(?) them as
   sections:
   /common/section_keystone_certificates-for-pki.xml
   /common/section_keystone-ssl-config.xml
   /common/section_keystone-external-auth.xml
   /common/section_keystone_config_ldap.xml
   identity/section_keystone-token-binding.xml
   identity/section_keystone-trusts.xml
   identity/section_caching-layer.xml

User CRUD
~~~~~~~~~

Identity provides a user CRUD (Create, Read, Update, and Delete) filter
that can be added to the ``public_api`` pipeline. The user CRUD filter
enables users to use a HTTP PATCH to change their own password. To
enable this extension you should define a :code:`user_crud_extension`
filter, insert it after the "option:`*_body` middleware and before the
``public_service`` application in the ``public_api`` WSGI pipeline in
:file:`keystone-paste.ini`. For example:

.. code-block:: ini
   :linenos:

    [filter:user_crud_extension]
    paste.filter_factory = keystone.contrib.user_crud:CrudExtension.factory

    [pipeline:public_api]
    pipeline = sizelimit url_normalize request_id build_auth_context token_auth admin_token_auth json_body ec2_extension user_crud_extension public_service

Each user can then change their own password with a HTTP PATCH::

    $ curl -X PATCH http://localhost:5000/v2.0/OS-KSCRUD/users/USERID -H "Content-type: application/json"  \
      -H "X_Auth_Token: AUTHTOKENID" -d '{"user": {"password": "ABCD", "original_password": "DCBA"}}'

In addition to changing their password, all current tokens for the user
are invalidated.

.. note::

    Only use a KVS back end for tokens when testing.

Logging
~~~~~~~

You configure logging externally to the rest of Identity. The name of
the file specifying the logging configuration is set using the
``log_config`` option in the ``[DEFAULT]`` section of the
:file:`keystone.conf` file. To route logging through syslog, set
``use_syslog=true`` in the ``[DEFAULT]`` section.

A sample logging configuration file is available with the project in
:file:`etc/logging.conf.sample`. Like other OpenStack projects, Identity
uses the Python logging module, which provides extensive configuration
options that let you define the output levels and formats.

Start the Identity services
~~~~~~~~~~~~~~~~~~~~~~~~~~~

To start the services for Identity, run the following command:

.. code::

    $ keystone-all

This command starts two wsgi.Server instances configured by the
:file:`keystone.conf` file as described previously. One of these wsgi
servers is :code:`admin` (the administration API) and the other is :code:`main` (the primary/public API interface). Both run in a single
process.

Example usage
~~~~~~~~~~~~~

The ``keystone`` client is set up to expect commands in the general
form of ``keystone command argument``, followed by flag-like keyword
arguments to provide additional (often optional) information. For
example, the :command:`user-list` and :command:`tenant-create`
commands can be invoked as follows:

.. code-block:: bash
   :linenos:

    # Using token auth env variables
    export OS_SERVICE_ENDPOINT=http://127.0.0.1:5000/v2.0/
    export OS_SERVICE_TOKEN=secrete_token
    keystone user-list
    keystone tenant-create --name demo

    # Using token auth flags
    keystone --os-token secrete --os-endpoint http://127.0.0.1:5000/v2.0/ user-list
    keystone --os-token secrete --os-endpoint http://127.0.0.1:5000/v2.0/ tenant-create --name=demo

    # Using user + password + project_name env variables
    export OS_USERNAME=admin
    export OS_PASSWORD=secrete
    export OS_PROJECT_NAME=admin
    openstack user list
    openstack project create demo

    # Using user + password + project-name flags
    openstack --os-username admin --os-password secrete --os-project-name admin user list
    openstack --os-username admin --os-password secrete --os-project-name admin project create demo

Authentication middleware with user name and password
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can also configure Identity authentication middleware using the
:code:`admin_user` and :code:`admin_password` options.

.. note::

    The :code:`admin_token` option is deprecated and no longer used for
    configuring auth_token middleware.

For services that have a separate paste-deploy :file:`.ini` file, you can
configure the authentication middleware in the ``[keystone_authtoken]``
section of the main configuration file, such as :file:`nova.conf`. In
Compute, for example, you can remove the middleware parameters from
:file:`api-paste.ini`, as follows:

.. code:: ini

    [filter:authtoken]
    paste.filter_factory = keystonemiddleware.auth_token:filter_factory

.. note::

    Prior to the Juno release, ``the auth_token`` middleware was in
    ``python-keystoneclient``. The ``filter_factory`` must be set to
    ``keystoneclient.middleware.auth_token:filter_factory`` in those
    releases.

And set the following values in :file:`nova.conf` as follows:

.. code:: ini

    [DEFAULT]
    ...
    auth_strategy=keystone

    [keystone_authtoken]
    auth_uri = http://controller:5000/v2.0
    identity_uri = http://controller:35357
    admin_user = admin
    admin_password = SuperSekretPassword
    admin_tenant_name = service

.. note::

    The middleware parameters in the paste config take priority. You
    must remove them to use the values in the ``[keystone_authtoken]``
    section.

.. note::

    Comment out any :code:`auth_host`, :code:`auth_port`, and
    :code:`auth_protocol` options because the :code:`identity_uri` option
    replaces them.

This sample paste config filter makes use of the :code:`admin_user` and
:code:`admin_password` options:

.. code:: ini

    [filter:authtoken]
    paste.filter_factory = keystonemiddleware.auth_token:filter_factory
    auth_uri = http://controller:5000/v2.0
    identity_uri = http://controller:35357
    auth_token = 012345SECRET99TOKEN012345
    admin_user = admin
    admin_password = keystone123

.. note::

    Using this option requires an admin tenant/role relationship. The
    admin user is granted access to the admin role on the admin tenant.

.. note::

    Comment out any ``auth_host``, ``auth_port``, and
    ``auth_protocol`` options because the ``identity_uri`` option
    replaces them.

.. note::

    Prior to the Juno release, the ``auth_token middleware`` was in
    ``python-keystoneclient``. The ``filter_factory`` must be set to
    ``keystoneclient.middleware.auth_token:filter_factory`` in those
    releases.

Identity API protection with role-based access control (RBAC)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Like most OpenStack projects, Identity supports the protection of its
APIs by defining policy rules based on an RBAC approach. Identity stores
a reference to a policy JSON file in the main Identity configuration
file, :file:`keystone.conf`. Typically this file is named ``policy.json``,
and contains the rules for which roles have access to certain actions
in defined services.

Each Identity API v3 call has a line in the policy file that dictates
which level of governance of access applies.

.. code:: ini

    API_NAME: RULE_STATEMENT or MATCH_STATEMENT

Where:

``RULE_STATEMENT`` can contain ``RULE_STATEMENT`` or
``MATCH_STATEMENT``.

``MATCH_STATEMENT`` is a set of identifiers that must match between the
token provided by the caller of the API and the parameters or target
entities of the API call in question. For example:

.. code:: ini

    "identity:create_user": [["role:admin", "domain_id:%(user.domain_id)s"]]

Indicates that to create a user, you must have the admin role in your
token. The :code:`domain_id` in your token must match the
:code:`domain_id` in the user object that you are trying
to create, which implies this must be a domain-scoped token.
In other words, you must have the admin role on the domain
in which you are creating the user, and the token that you use
must be scoped to that domain.

Each component of a match statement uses this format:

.. code:: ini

    ATTRIB_FROM_TOKEN:CONSTANT or ATTRIB_RELATED_TO_API_CALL

The Identity service expects these attributes:

Attributes from token:

- ``user_id``
- ``domain_id``
- ``project_id``

The ``project_id`` attribute requirement depends on the scope, and the
list of roles you have within that scope.

Attributes related to API call:

- ``user.domain_id``
- Any parameters passed into the API call
- Any filters specified in the query string

You reference attributes of objects passed with an object.attribute
syntax (such as, ``user.domain_id``). The target objects of an API are
also available using a target.object.attribute syntax. For instance:

.. code:: ini

    "identity:delete_user": [["role:admin", "domain_id:%(target.user.domain_id)s"]]

would ensure that Identity only deletes the user object in the same
domain as the provided token.

Every target object has an ``id`` and a ``name`` available as
``target.OBJECT.id`` and ``target.OBJECT.name``. Identity retrieves
other attributes from the database, and the attributes vary between
object types. The Identity service filters out some database fields,
such as user passwords.

List of object attributes:

.. code-block:: ini
   :linenos:

    role:
         target.role.id
         target.role.name

     user:
         target.user.default_project_id
         target.user.description
         target.user.domain_id
         target.user.enabled
         target.user.id
         target.user.name

     group:
         target.group.description
         target.group.domain_id
         target.group.id
         target.group.name

     domain:
         target.domain.enabled
         target.domain.id
         target.domain.name

     project:
         target.project.description
         target.project.domain_id
         target.project.enabled
         target.project.id
         target.project.name

The default :file:`policy.json` file supplied provides a somewhat
basic example of API protection, and does not assume any particular
use of domains. Refer to :file:`policy.v3cloudsample.json` as an
example of multi-domain configuration installations where a cloud
provider wants to delegate administration of the contents of a domain
to a particular :code:`admin domain`. This example policy file also
shows the use of an :code:`admin_domain` to allow a cloud provider to
enable cloud administrators to have wider access across the APIs.

A clean installation could start with the standard policy file, to
allow creation of the :code:`admin_domain` with the first users within
it. You could then obtain the :code:`domain_id` of the admin domain,
paste the ID into a modified version of
:file:`policy.v3cloudsample.json`, and then enable it as the main
policy file.

.. TODO (DC) Convert the following file and include(?) it as
   a section:
   /common/section_identity-troubleshooting.xml
