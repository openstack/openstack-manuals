.. _identity_management:

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

User management
---------------

The main components of Identity user management are:

* User
    Represents a human user. Has associated information such as
    user name, password, and email. This example creates a user named
    ``alice``:

    .. code::

       $ openstack user create --password-prompt --email alice@example.com alice

* Project
    A tenant, group, or organization. When you make requests
    to OpenStack services, you must specify a project. For example, if
    you query the Compute service for a list of running instances, you
    get a list of all running instances in the project that you specified
    in your query. This example creates a project named ``acme``:

    .. code::

       $ openstack project create acme

* Domain
    Defines administrative boundaries for the management of
    Identity entities. A domain may represent an individual, company, or
    operator-owned space. It is used for exposing administrative
    activities directly to the system users.

    A domain is a collection of projects and users. Users may be given a
    domain's administrator role. A domain administrator may create
    projects, users, and groups within a domain and assign roles to users
    and groups.

    This example creates a domain named ``emea``:

    .. code::

       $ openstack domain create emea

* Role
    Captures the operations that a user can perform in a given
    tenant.

    This example creates a role named ``compute-user``:

    .. code::

       $ openstack role create compute-user

    .. note::

       Individual services, such as Compute and the Image service,
       assign meaning to roles. In the Identity service, a role is
       simply a name.

The Identity service assigns a tenant and a role to a user. You might
assign the ``compute-user`` role to the ``alice`` user in the ``acme``
tenant:

.. code::

    $ openstack user list
    +--------+-------+
    | ID     | Name  |
    +--------+-------+
    | 892585 | alice |
    +--------+-------+

.. code::

    $ openstack role list
    +--------+---------------+
    | ID     | Name          |
    +--------+---------------+
    | 9a764e | compute-user  |
    +--------+---------------+

.. code::

    $ openstack project list
    +--------+--------------------+
    | ID     | Name               |
    +--------+--------------------+
    | 6b8fd2 | acme               |
    +--------+--------------------+

.. code::

    $ openstack role add --project 6b8fd2 --user 892585 9a764e

A user can have different roles in different tenants. For example, Alice
might also have the ``admin`` role in the ``Cyberdyne`` tenant. A user
can also have multiple roles in the same tenant.

The :file:`/etc/[SERVICE_CODENAME]/policy.json` file controls the tasks that
users can perform for a given service. For example,
:file:`/etc/nova/policy.json` file specifies the access policy for the Compute
service, :file:`/etc/glance/policy.json` file specifies the access policy for
the Image service, and :file:`/etc/keystone/policy.json` file specifies the
access policy for the Identity service.

The default :file:`policy.json` files in the Compute, Identity, and Image
service recognize only the ``admin`` role; all operations that do not
require the ``admin`` role are accessible by any user that has any role
in a tenant.

To restrict users from performing operations in, for example, the
Compute service, you need to create a role in the Identity service and
then modify the :file:`/etc/nova/policy.json` file so that this role
is required for Compute operations.

For example, the following line in the :file:`/etc/nova/policy.json` file
specifies that there are no restrictions on which users can create volumes:

.. code:: json

    "volume:create": "",

If the user has any role in a tenant, they can create volumes in that tenant.

To restrict the creation of volumes to users who had the ``compute-user``
role in a particular tenant, you would add ``"role:compute-user"``:

.. code:: json

    "volume:create": "role:compute-user",

To restrict all Compute service requests to require this role, the
resulting file would look like:

.. code-block:: json
   :linenos:

   {
      "admin_or_owner": "role:admin or project_id:%(project_id)s",
      "default": "rule:admin_or_owner",
      "compute:create": "role:compute-user",
      "compute:create:attach_network": "role:compute-user",
      "compute:create:attach_volume": "role:compute-user",
      "compute:get_all": "role:compute-user",
      "compute:unlock_override": "rule:admin_api",
      "admin_api": "role:admin",
      "compute_extension:accounts": "rule:admin_api",
      "compute_extension:admin_actions": "rule:admin_api",
      "compute_extension:admin_actions:pause": "rule:admin_or_owner",
      "compute_extension:admin_actions:unpause": "rule:admin_or_owner",
      "compute_extension:admin_actions:suspend": "rule:admin_or_owner",
      "compute_extension:admin_actions:resume": "rule:admin_or_owner",
      "compute_extension:admin_actions:lock": "rule:admin_or_owner",
      "compute_extension:admin_actions:unlock": "rule:admin_or_owner",
      "compute_extension:admin_actions:resetNetwork": "rule:admin_api",
      "compute_extension:admin_actions:injectNetworkInfo": "rule:admin_api",
      "compute_extension:admin_actions:createBackup": "rule:admin_or_owner",
      "compute_extension:admin_actions:migrateLive": "rule:admin_api",
      "compute_extension:admin_actions:migrate": "rule:admin_api",
      "compute_extension:aggregates": "rule:admin_api",
      "compute_extension:certificates": "role:compute-user",
      "compute_extension:cloudpipe": "rule:admin_api",
      "compute_extension:console_output": "role:compute-user",
      "compute_extension:consoles": "role:compute-user",
      "compute_extension:createserverext": "role:compute-user",
      "compute_extension:deferred_delete": "role:compute-user",
      "compute_extension:disk_config": "role:compute-user",
      "compute_extension:evacuate": "rule:admin_api",
      "compute_extension:extended_server_attributes": "rule:admin_api",
      "compute_extension:extended_status": "role:compute-user",
      "compute_extension:flavorextradata": "role:compute-user",
      "compute_extension:flavorextraspecs": "role:compute-user",
      "compute_extension:flavormanage": "rule:admin_api",
      "compute_extension:floating_ip_dns": "role:compute-user",
      "compute_extension:floating_ip_pools": "role:compute-user",
      "compute_extension:floating_ips": "role:compute-user",
      "compute_extension:hosts": "rule:admin_api",
      "compute_extension:keypairs": "role:compute-user",
      "compute_extension:multinic": "role:compute-user",
      "compute_extension:networks": "rule:admin_api",
      "compute_extension:quotas": "role:compute-user",
      "compute_extension:rescue": "role:compute-user",
      "compute_extension:security_groups": "role:compute-user",
      "compute_extension:server_action_list": "rule:admin_api",
      "compute_extension:server_diagnostics": "rule:admin_api",
      "compute_extension:simple_tenant_usage:show": "rule:admin_or_owner",
      "compute_extension:simple_tenant_usage:list": "rule:admin_api",
      "compute_extension:users": "rule:admin_api",
      "compute_extension:virtual_interfaces": "role:compute-user",
      "compute_extension:virtual_storage_arrays": "role:compute-user",
      "compute_extension:volumes": "role:compute-user",
      "compute_extension:volume_attachments:index": "role:compute-user",
      "compute_extension:volume_attachments:show": "role:compute-user",
      "compute_extension:volume_attachments:create": "role:compute-user",
      "compute_extension:volume_attachments:delete": "role:compute-user",
      "compute_extension:volumetypes": "role:compute-user",
      "volume:create": "role:compute-user",
      "volume:get_all": "role:compute-user",
      "volume:get_volume_metadata": "role:compute-user",
      "volume:get_snapshot": "role:compute-user",
      "volume:get_all_snapshots": "role:compute-user",
      "network:get_all_networks": "role:compute-user",
      "network:get_network": "role:compute-user",
      "network:delete_network": "role:compute-user",
      "network:disassociate_network": "role:compute-user",
      "network:get_vifs_by_instance": "role:compute-user",
      "network:allocate_for_instance": "role:compute-user",
      "network:deallocate_for_instance": "role:compute-user",
      "network:validate_networks": "role:compute-user",
      "network:get_instance_uuids_by_ip_filter": "role:compute-user",
      "network:get_floating_ip": "role:compute-user",
      "network:get_floating_ip_pools": "role:compute-user",
      "network:get_floating_ip_by_address": "role:compute-user",
      "network:get_floating_ips_by_project": "role:compute-user",
      "network:get_floating_ips_by_fixed_address": "role:compute-user",
      "network:allocate_floating_ip": "role:compute-user",
      "network:deallocate_floating_ip": "role:compute-user",
      "network:associate_floating_ip": "role:compute-user",
      "network:disassociate_floating_ip": "role:compute-user",
      "network:get_fixed_ip": "role:compute-user",
      "network:add_fixed_ip_to_instance": "role:compute-user",
      "network:remove_fixed_ip_from_instance": "role:compute-user",
      "network:add_network_to_project": "role:compute-user",
      "network:get_instance_nw_info": "role:compute-user",
      "network:get_dns_domains": "role:compute-user",
      "network:add_dns_entry": "role:compute-user",
      "network:modify_dns_entry": "role:compute-user",
      "network:delete_dns_entry": "role:compute-user",
      "network:get_dns_entries_by_address": "role:compute-user",
      "network:get_dns_entries_by_name": "role:compute-user",
      "network:create_private_dns_domain": "role:compute-user",
      "network:create_public_dns_domain": "role:compute-user",
      "network:delete_dns_domain": "role:compute-user"
   }

.. TODO (DC) Convert the following common files and include(?) them as
   sections:
   /common/section_keystone_certificates-for-pki.xml
   /common/section_keystone-ssl-config.xml
   /common/section_keystone-external-auth.xml
   /common/section_keystone_config_ldap.xml
   identity/section_keystone-token-binding.xml
   identity/section_keystone-trusts.xml
   identity/section_caching-layer.xml

Service management
------------------

The Identity service provides identity, token, catalog, and policy
services. It consists of:

* keystone Web Server Gateway Interface (WSGI) service
    Can be run in a WSGI-capable web server such as Apache httpd to provide
    the Identity service. The service and administrative APIs are run as
    separate instances of the WSGI service.

* Identity service functions
    Each has a pluggable back end that allow different ways to use the
    particular service. Most support standard back ends like LDAP or SQL.

* keystone-all
    Starts both the service and administrative APIs in a single process.
    Using federation with keystone-all is not supported. keystone-all is
    deprecated in favor of the WSGI service.

The Identity service also maintains a user that corresponds to each
service, such as, a user named ``nova`` for the Compute service, and a
special service tenant called ``service``.

For information about how to create services and endpoints, see the
`OpenStack Admin User Guide <http://docs.openstack.org/user-guide-admin/index.html>`__.

Groups
------

A group is a collection of users in a domain. Administrators can create groups
and add users to them. A role can then be assigned to the group, rather than
individual users. Groups were introduced with the Identity API v3.

Identity API V3 provides the following group-related operations:

* Create a group

* Delete a group

* Update a group (change its name or description)

* Add a user to a group

* Remove a user from a group

* List group members

* List groups for a user

* Assign a role on a tenant to a group

* Assign a role on a domain to a group

* Query role assignments to groups

.. note::

    The Identity service server might not allow all operations. For
    example, if using the Identity server with the LDAP Identity back
    end and group updates are disabled, then a request to create,
    delete, or update a group fails.

Here are a couple of examples:

* Group A is granted Role A on Tenant A. If User A is a member of Group
  A, when User A gets a token scoped to Tenant A, the token also
  includes Role A.

* Group B is granted Role B on Domain B. If User B is a member of
  Domain B, if User B gets a token scoped to Domain B, the token also
  includes Role B.

.. include:: keystone_certificates_for_pki.rst

.. include:: keystone_configure_with_SSL.rst

.. include:: keystone_external_authentication.rst

.. toctree::
   :hidden:

   keystone_certificates_for_pki.rst
   keystone_configure_with_SSL.rst
   keystone_external_authentication.rst

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
servers is :code:`admin` (the administration API) and the other is
:code:`main` (the primary/public API interface). Both run in a single
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

Troubleshoot the Identity service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To troubleshoot the Identity service, review the logs in the
``/var/log/keystone/keystone.log`` file.

.. note

    Use the :file:`/etc/keystone/logging.conf` file to configure the
    location of log files.

The logs show the components that have come in to the WSGI request, and
ideally show an error that explains why an authorization request failed.
If you do not see the request in the logs, run keystone with the
:option:`--debug` parameter. Pass the :option:`--debug` parameter before the
command parameters.

Debug PKI middleware
--------------------

If you receive an ``Invalid OpenStack Identity Credentials`` message when
you talk to an OpenStack service, it might be caused by the changeover from
UUID tokens to PKI tokens in the Grizzly release. Learn how to troubleshoot
this error.

The PKI-based token validation scheme relies on certificates from
Identity that are fetched through HTTP and stored in a local directory.
The location for this directory is specified by the ``signing_dir``
configuration option. In your services configuration file, look for a
section like this:

.. code-block:: ini
   :linenos:

    [keystone_authtoken]
    signing_dir = /var/cache/glance/api
    auth_uri = http://controller:5000/v2.0
    identity_uri = http://controller:35357
    admin_tenant_name = service
    admin_user = glance

If your service lacks this stanza, the
`keystoneclient/middleware/auth\_token.py <https://github.com/openstack/python-keystoneclient/blob/master/keystoneclient/middleware/auth_token.py#L198>`__
file specifies the defaults. If no value is specified for this directory, it `defaults to a secure temporary directory. <https://github.com/openstack/python-keystoneclient/blob/master/keystoneclient/middleware/auth_token.py#L299>`__
Initialization code for the service checks that the directory exists and
is writable. If it does not exist, the code tries to create it. If this
fails, the service fails to start. However, it often succeeds but
problems occur later.

The first thing to check is that the ``signing_dir`` does, in fact,
exist. If it does, check for certificate files:

.. code::

    $ ls -la /var/cache/glance/api/

.. code::

    total 24
    drwx------. 2 ayoung root 4096 Jul 22 10:58 .
    drwxr-xr-x. 4 root root 4096 Nov 7 2012 ..
    -rw-r-----. 1 ayoung ayoung 1424 Jul 22 10:58 cacert.pem
    -rw-r-----. 1 ayoung ayoung 15 Jul 22 10:58 revoked.pem
    -rw-r-----. 1 ayoung ayoung 4518 Jul 22 10:58 signing_cert.pem

This directory contains two certificates and the token revocation list.
If these files are not present, your service cannot fetch them from
Identity. To troubleshoot, try to talk to Identity to make sure it
correctly serves files, as follows:

.. code::

    $ curl http://localhost:35357/v2.0/certificates/signing

This command fetches the signing certificate:

.. code::

    Certificate:
        Data:
            Version: 3 (0x2)
            Serial Number: 1 (0x1)
        Signature Algorithm: sha1WithRSAEncryption
            Issuer: C=US, ST=Unset, L=Unset, O=Unset, CN=www.example.com
            Validity
                Not Before: Jul 22 14:57:31 2013 GMT
                Not After : Jul 20 14:57:31 2023 GMT
            Subject: C=US, ST=Unset, O=Unset, CN=www.example.com

Note the expiration dates of the certificate:

.. code::

    Not Before: Jul 22 14:57:31 2013 GMT
    Not After : Jul 20 14:57:31 2023 GMT

The token revocation list is updated once a minute, but the certificates
are not. One possible problem is that the certificates are the wrong
files or garbage. You can remove these files and run another command
against your server; they are fetched on demand.

The Identity service log should show the access of the certificate
files. You might have to turn up your logging levels. Set
``debug = True`` and ``verbose = True`` in your Identity configuration
file and restart the Identity server.

.. code::

    (keystone.common.wsgi): 2013-07-24 12:18:11,461 DEBUG wsgi __call__
    arg_dict: {}
    (access): 2013-07-24 12:18:11,462 INFO core __call__ 127.0.0.1 - - [24/Jul/2013:16:18:11 +0000]
    "GET http://localhost:35357/v2.0/certificates/signing HTTP/1.0" 200 4518

If the files do not appear in your directory after this, it is likely
one of the following issues:

* Your service is configured incorrectly and cannot talk to Identity.
  Check the ``auth_port`` and ``auth_host`` values and make sure that
  you can talk to that service through cURL, as shown previously.

* Your signing directory is not writable. Use the ``chmod`` command to
  change its permissions so that the service (POSIX) user can write to
  it. Verify the change through ``su`` and ``touch`` commands.

* The SELinux policy is denying access to the directory.

SELinux troubles often occur when you use Fedora or RHEL-based packages and
you choose configuration options that do not match the standard policy.
Run the ``setenforce permissive`` command. If that makes a difference,
you should relabel the directory. If you are using a sub-directory of
the ``/var/cache/`` directory, run the following command:

.. code::

    # restorecon /var/cache/

If you are not using a ``/var/cache`` sub-directory, you should. Modify
the ``signing_dir`` configuration option for your service and restart.

Set back to ``setenforce enforcing`` to confirm that your changes solve
the problem.

If your certificates are fetched on demand, the PKI validation is
working properly. Most likely, the token from Identity is not valid for
the operation you are attempting to perform, and your user needs a
different role for the operation.

Debug signing key file errors
-----------------------------

If an error occurs when the signing key file opens, it is possible that
the person who ran the ``keystone-manage pki_setup`` command to generate
certificates and keys did not use the correct user. When you run the
``keystone-manage pki_setup`` command, Identity generates a set of
certificates and keys in ``/etc/keystone/ssl*``, which is owned by
``root:root``.

This can present a problem when you run the Identity daemon under the
keystone user account (nologin) when you try to run PKI. Unless you run
the ``chown`` command against the files ``keystone:keystone``, or run the
``keystone-manage pki_setup`` command with the :option:`--keystone-user` and
:option:`--keystone-group`` parameters, you will get an error. For example:

.. code::

    2012-07-31 11:10:53 ERROR [keystone.common.cms] Error opening signing key file
    /etc/keystone/ssl/private/signing_key.pem
    140380567730016:error:0200100D:system library:fopen:Permission
    denied:bss_file.c:398:fopen('/etc/keystone/ssl/private/signing_key.pem','r')
    140380567730016:error:20074002:BIO routines:FILE_CTRL:system lib:bss_file.c:400:
    unable to load signing key file

Flush expired tokens from the token database table
--------------------------------------------------

As you generate tokens, the token database table on the Identity server
grows. To clear the token table, an administrative user must run the
``keystone-manage token_flush`` command to flush the tokens. When you
flush tokens, expired tokens are deleted and traceability is eliminated.

Use ``cron`` to schedule this command to run frequently based on your
workload. For large workloads, running it every minute is recommended.

