.. ##  WARNING  #####################################
.. This file is tool-generated. Do not edit manually.
.. ##################################################

=============================
OpenStack command-line client
=============================

The openstack client is a common OpenStackcommand-line interface (CLI).

This chapter documents :command:`openstack` version ``3.0.1``.

For help on a specific :command:`openstack` command, enter:

.. code-block:: console

   $ openstack help COMMAND

.. _openstack_command_usage:

openstack usage
~~~~~~~~~~~~~~~

.. code-block:: console

   usage: openstack [--version] [-v | -q] [--log-file LOG_FILE] [-h] [--debug]
                    [--os-cloud <cloud-config-name>]
                    [--os-region-name <auth-region-name>]
                    [--os-cacert <ca-bundle-file>] [--os-cert <certificate-file>]
                    [--os-key <key-file>] [--verify | --insecure]
                    [--os-default-domain <auth-domain>]
                    [--os-interface <interface>] [--timing] [--os-beta-command]
                    [--os-profile hmac-key]
                    [--os-compute-api-version <compute-api-version>]
                    [--os-network-api-version <network-api-version>]
                    [--os-image-api-version <image-api-version>]
                    [--os-volume-api-version <volume-api-version>]
                    [--os-identity-api-version <identity-api-version>]
                    [--os-object-api-version <object-api-version>]
                    [--os-baremetal-api-version <baremetal-api-version>]
                    [--os-dns-api-version <dns-api-version>]
                    [--os-data-processing-api-version <data-processing-api-version>]
                    [--os-data-processing-url OS_DATA_PROCESSING_URL]
                    [--os-queues-api-version <queues-api-version>]
                    [--os-key-manager-api-version <key-manager-api-version>]
                    [--os-orchestration-api-version <orchestration-api-version>]
                    [--inspector-api-version INSPECTOR_API_VERSION]
                    [--inspector-url INSPECTOR_URL] [--os-auth-type <auth-type>]
                    [--os-authorization-code <auth-authorization-code>]
                    [--os-project-domain-id <auth-project-domain-id>]
                    [--os-protocol <auth-protocol>]
                    [--os-project-name <auth-project-name>]
                    [--os-trust-id <auth-trust-id>]
                    [--os-domain-name <auth-domain-name>]
                    [--os-user-domain-id <auth-user-domain-id>]
                    [--os-access-token-type <auth-access-token-type>]
                    [--os-identity-provider-url <auth-identity-provider-url>]
                    [--os-default-domain-name <auth-default-domain-name>]
                    [--os-access-token-endpoint <auth-access-token-endpoint>]
                    [--os-access-token <auth-access-token>]
                    [--os-domain-id <auth-domain-id>]
                    [--os-user-domain-name <auth-user-domain-name>]
                    [--os-openid-scope <auth-openid-scope>]
                    [--os-user-id <auth-user-id>]
                    [--os-identity-provider <auth-identity-provider>]
                    [--os-username <auth-username>]
                    [--os-auth-url <auth-auth-url>]
                    [--os-client-secret <auth-client-secret>]
                    [--os-default-domain-id <auth-default-domain-id>]
                    [--os-discovery-endpoint <auth-discovery-endpoint>]
                    [--os-client-id <auth-client-id>]
                    [--os-project-domain-name <auth-project-domain-name>]
                    [--os-password <auth-password>]
                    [--os-redirect-uri <auth-redirect-uri>]
                    [--os-endpoint <auth-endpoint>] [--os-url <auth-url>]
                    [--os-token <auth-token>] [--os-passcode <auth-passcode>]
                    [--os-project-id <auth-project-id>]

.. _openstack_command_options:

openstack optional arguments
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``--version``
  show program's version number and exit

``-v, --verbose``
  Increase verbosity of output. Can be repeated.

``-q, --quiet``
  Suppress output except warnings and errors.

``--log-file LOG_FILE``
  Specify a file to log output. Disabled by default.

``-h, --help``
  Show help message and exit.

``--debug``
  Show tracebacks on errors.

``--os-cloud <cloud-config-name>``
  Cloud name in clouds.yaml (Env: OS_CLOUD)

``--os-region-name <auth-region-name>``
  Authentication region name (Env: OS_REGION_NAME)

``--os-cacert <ca-bundle-file>``
  CA certificate bundle file (Env: OS_CACERT)

``--os-cert <certificate-file>``
  Client certificate bundle file (Env: OS_CERT)

``--os-key <key-file>``
  Client certificate key file (Env: OS_KEY)

``--verify``
  Verify server certificate (default)

``--insecure``
  Disable server certificate verification

``--os-default-domain <auth-domain>``
  Default domain ID, default=default. (Env:
  OS_DEFAULT_DOMAIN)

``--os-interface <interface>``
  Select an interface type. Valid interface types:
  [admin, public, internal]. (Env: OS_INTERFACE)

``--timing``
  Print API call timing info

``--os-beta-command``
  Enable beta commands which are subject to change

``--os-profile``
  hmac-key
  HMAC key for encrypting profiling context data

``--os-compute-api-version <compute-api-version>``
  Compute API version, default=2 (Env:
  OS_COMPUTE_API_VERSION)

``--os-network-api-version <network-api-version>``
  Network API version, default=2.0 (Env:
  OS_NETWORK_API_VERSION)

``--os-image-api-version <image-api-version>``
  Image API version, default=1 (Env:
  OS_IMAGE_API_VERSION)

``--os-volume-api-version <volume-api-version>``
  Volume API version, default=2 (Env:
  OS_VOLUME_API_VERSION)

``--os-identity-api-version <identity-api-version>``
  Identity API version, default=3 (Env:
  OS_IDENTITY_API_VERSION)

``--os-object-api-version <object-api-version>``
  Object API version, default=1 (Env:
  OS_OBJECT_API_VERSION)

``--os-baremetal-api-version <baremetal-api-version>``
  Baremetal API version, default=1.6 (Env:
  OS_BAREMETAL_API_VERSION)

``--os-dns-api-version <dns-api-version>``
  DNS API version, default=2 (Env: OS_DNS_API_VERSION)

``--os-data-processing-api-version <data-processing-api-version>``
  Data processing API version, default=1.1 (Env:
  OS_DATA_PROCESSING_API_VERSION)

``--os-data-processing-url OS_DATA_PROCESSING_URL``
  Data processing API URL, (Env:
  OS_DATA_PROCESSING_API_URL)

``--os-queues-api-version <queues-api-version>``
  Queues API version, default=2 (Env:
  OS_QUEUES_API_VERSION)

``--os-key-manager-api-version <key-manager-api-version>``
  Barbican API version, default=1 (Env:
  OS_KEY_MANAGER_API_VERSION)

``--os-orchestration-api-version <orchestration-api-version>``
  Orchestration API version, default=1 (Env:
  OS_ORCHESTRATION_API_VERSION)

``--inspector-api-version INSPECTOR_API_VERSION``
  inspector API version, only 1 is supported now (env:
  INSPECTOR_VERSION).

``--inspector-url INSPECTOR_URL``
  inspector URL, defaults to localhost (env:
  INSPECTOR_URL).

``--os-auth-type <auth-type>``
  Select an authentication type. Available types:
  v2token, password, admin_token, v3oidcauthcode,
  v2password, v3samlpassword, v3password,
  v3oidcaccesstoken, token_endpoint, token,
  v3oidcclientcredentials, v3tokenlessauth, v3token,
  v3totp, v3oidcpassword. Default: selected based on
  :option:`--os-username/--os-token` (Env: OS_AUTH_TYPE)

``--os-authorization-code <auth-authorization-code>``
  With v3oidcauthcode: OAuth 2.0 Authorization Code
  (Env: OS_AUTHORIZATION_CODE)

``--os-project-domain-id <auth-project-domain-id>``
  With password: Domain ID containing project With
  v3oidcauthcode: Domain ID containing project With
  v3samlpassword: Domain ID containing project With
  v3password: Domain ID containing project With
  v3oidcaccesstoken: Domain ID containing project With
  token: Domain ID containing project With
  v3oidcclientcredentials: Domain ID containing project
  With v3tokenlessauth: Domain ID containing project
  With v3token: Domain ID containing project With
  v3totp: Domain ID containing project With
  v3oidcpassword: Domain ID containing project (Env:
  OS_PROJECT_DOMAIN_ID)

``--os-protocol <auth-protocol>``
  With v3oidcauthcode: Protocol for federated plugin
  With v3samlpassword: Protocol for federated plugin
  With v3oidcaccesstoken: Protocol for federated plugin
  With v3oidcclientcredentials: Protocol for federated
  plugin With v3oidcpassword: Protocol for federated
  plugin (Env: OS_PROTOCOL)

``--os-project-name <auth-project-name>``
  With password: Project name to scope to With
  v3oidcauthcode: Project name to scope to With
  v3samlpassword: Project name to scope to With
  v3password: Project name to scope to With
  v3oidcaccesstoken: Project name to scope to With
  token: Project name to scope to With
  v3oidcclientcredentials: Project name to scope to With
  v3tokenlessauth: Project name to scope to With
  v3token: Project name to scope to With v3totp: Project
  name to scope to With v3oidcpassword: Project name to
  scope to (Env: OS_PROJECT_NAME)

``--os-trust-id <auth-trust-id>``
  With v2token: Trust ID With password: Trust ID With
  v3oidcauthcode: Trust ID With v2password: Trust ID
  With v3samlpassword: Trust ID With v3password: Trust
  ID With v3oidcaccesstoken: Trust ID With token: Trust
  ID With v3oidcclientcredentials: Trust ID With
  v3token: Trust ID With v3totp: Trust ID With
  v3oidcpassword: Trust ID (Env: OS_TRUST_ID)

``--os-domain-name <auth-domain-name>``
  With password: Domain name to scope to With
  v3oidcauthcode: Domain name to scope to With
  v3samlpassword: Domain name to scope to With
  v3password: Domain name to scope to With
  v3oidcaccesstoken: Domain name to scope to With token:
  Domain name to scope to With v3oidcclientcredentials:
  Domain name to scope to With v3tokenlessauth: Domain
  name to scope to With v3token: Domain name to scope to
  With v3totp: Domain name to scope to With
  v3oidcpassword: Domain name to scope to (Env:
  OS_DOMAIN_NAME)

``--os-user-domain-id <auth-user-domain-id>``
  With password: User's domain id With v3password:
  User's domain id With v3totp: User's domain id (Env:
  OS_USER_DOMAIN_ID)

``--os-access-token-type <auth-access-token-type>``
  With v3oidcauthcode: OAuth 2.0 Authorization Server
  Introspection token type, it is used to decide which
  type of token will be used when processing token
  introspection. Valid values are: "access_token" or
  "id_token" With v3oidcclientcredentials: OAuth 2.0
  Authorization Server Introspection token type, it is
  used to decide which type of token will be used when
  processing token introspection. Valid values are:
  "access_token" or "id_token" With v3oidcpassword:
  OAuth 2.0 Authorization Server Introspection token
  type, it is used to decide which type of token will be
  used when processing token introspection. Valid values
  are: "access_token" or "id_token" (Env:
  OS_ACCESS_TOKEN_TYPE)

``--os-identity-provider-url <auth-identity-provider-url>``
  With v3samlpassword: An Identity Provider URL, where
  the SAML2 authentication request will be sent. (Env:
  OS_IDENTITY_PROVIDER_URL)

``--os-default-domain-name <auth-default-domain-name>``
  With password: Optional domain name to use with v3 API
  and v2 parameters. It will be used for both the user
  and project domain in v3 and ignored in v2
  authentication. With token: Optional domain name to
  use with v3 API and v2 parameters. It will be used for
  both the user and project domain in v3 and ignored in
  v2 authentication. (Env: OS_DEFAULT_DOMAIN_NAME)

``--os-access-token-endpoint <auth-access-token-endpoint>``
  With v3oidcauthcode: OpenID Connect Provider Token
  Endpoint. Note that if a discovery document is being
  passed this option will override the endpoint provided
  by the server in the discovery document. With
  v3oidcclientcredentials: OpenID Connect Provider Token
  Endpoint. Note that if a discovery document is being
  passed this option will override the endpoint provided
  by the server in the discovery document. With
  v3oidcpassword: OpenID Connect Provider Token
  Endpoint. Note that if a discovery document is being
  passed this option will override the endpoint provided
  by the server in the discovery document. (Env:
  OS_ACCESS_TOKEN_ENDPOINT)

``--os-access-token <auth-access-token>``
  With v3oidcaccesstoken: OAuth 2.0 Access Token (Env:
  OS_ACCESS_TOKEN)

``--os-domain-id <auth-domain-id>``
  With password: Domain ID to scope to With
  v3oidcauthcode: Domain ID to scope to With
  v3samlpassword: Domain ID to scope to With v3password:
  Domain ID to scope to With v3oidcaccesstoken: Domain
  ID to scope to With token: Domain ID to scope to With
  v3oidcclientcredentials: Domain ID to scope to With
  v3tokenlessauth: Domain ID to scope to With v3token:
  Domain ID to scope to With v3totp: Domain ID to scope
  to With v3oidcpassword: Domain ID to scope to (Env:
  OS_DOMAIN_ID)

``--os-user-domain-name <auth-user-domain-name>``
  With password: User's domain name With v3password:
  User's domain name With v3totp: User's domain name
  (Env: OS_USER_DOMAIN_NAME)

``--os-openid-scope <auth-openid-scope>``
  With v3oidcauthcode: OpenID Connect scope that is
  requested from authorization server. Note that the
  OpenID Connect specification states that "openid" must
  be always specified. With v3oidcclientcredentials:
  OpenID Connect scope that is requested from
  authorization server. Note that the OpenID Connect
  specification states that "openid" must be always
  specified. With v3oidcpassword: OpenID Connect scope
  that is requested from authorization server. Note that
  the OpenID Connect specification states that "openid"
  must be always specified. (Env: OS_OPENID_SCOPE)

``--os-user-id <auth-user-id>``
  With password: User id With v2password: User ID to
  login with With v3password: User ID With v3totp: User
  ID (Env: OS_USER_ID)

``--os-identity-provider <auth-identity-provider>``
  With v3oidcauthcode: Identity Provider's name With
  v3samlpassword: Identity Provider's name With
  v3oidcaccesstoken: Identity Provider's name With
  v3oidcclientcredentials: Identity Provider's name With
  v3oidcpassword: Identity Provider's name (Env:
  OS_IDENTITY_PROVIDER)

``--os-username <auth-username>``
  With password: Username With v2password: Username to
  login with With v3samlpassword: Username With
  v3password: Username With v3totp: Username With
  v3oidcpassword: Username (Env: OS_USERNAME)

``--os-auth-url <auth-auth-url>``
  With v2token: Authentication URL With password:
  Authentication URL With v3oidcauthcode: Authentication
  URL With v2password: Authentication URL With
  v3samlpassword: Authentication URL With v3password:
  Authentication URL With v3oidcaccesstoken:
  Authentication URL With token: Authentication URL With
  v3oidcclientcredentials: Authentication URL With
  v3tokenlessauth: Authentication URL With v3token:
  Authentication URL With v3totp: Authentication URL
  With v3oidcpassword: Authentication URL (Env:
  OS_AUTH_URL)

``--os-client-secret <auth-client-secret>``
  With v3oidcauthcode: OAuth 2.0 Client Secret With
  v3oidcclientcredentials: OAuth 2.0 Client Secret With
  v3oidcpassword: OAuth 2.0 Client Secret (Env:
  OS_CLIENT_SECRET)

``--os-default-domain-id <auth-default-domain-id>``
  With password: Optional domain ID to use with v3 and
  v2 parameters. It will be used for both the user and
  project domain in v3 and ignored in v2 authentication.
  With token: Optional domain ID to use with v3 and v2
  parameters. It will be used for both the user and
  project domain in v3 and ignored in v2 authentication.
  (Env: OS_DEFAULT_DOMAIN_ID)

``--os-discovery-endpoint <auth-discovery-endpoint>``
  With v3oidcauthcode: OpenID Connect Discovery Document
  URL. The discovery document will be used to obtain the
  values of the access token endpoint and the
  authentication endpoint. This URL should look like
  https://idp.example.org/.well-known/openid-configuration
  With
  v3oidcclientcredentials:
  OpenID
  Connect Discovery Document URL. The discovery document
  will be used to obtain the values of the access token
  endpoint and the authentication endpoint. This URL
  should look like https://idp.example.org/.well-known
  /openid-configuration With v3oidcpassword: OpenID
  Connect Discovery Document URL. The discovery document
  will be used to obtain the values of the access token
  endpoint and the authentication endpoint. This URL
  should look like https://idp.example.org/.well-known
  /openid-configuration (Env: OS_DISCOVERY_ENDPOINT)

``--os-client-id <auth-client-id>``
  With v3oidcauthcode: OAuth 2.0 Client ID With
  v3oidcclientcredentials: OAuth 2.0 Client ID With
  v3oidcpassword: OAuth 2.0 Client ID (Env:
  OS_CLIENT_ID)

``--os-project-domain-name <auth-project-domain-name>``
  With password: Domain name containing project With
  v3oidcauthcode: Domain name containing project With
  v3samlpassword: Domain name containing project With
  v3password: Domain name containing project With
  v3oidcaccesstoken: Domain name containing project With
  token: Domain name containing project With
  v3oidcclientcredentials: Domain name containing
  project With v3tokenlessauth: Domain name containing
  project With v3token: Domain name containing project
  With v3totp: Domain name containing project With
  v3oidcpassword: Domain name containing project (Env:
  OS_PROJECT_DOMAIN_NAME)

``--os-password <auth-password>``
  With password: User's password With v2password:
  Password to use With v3samlpassword: Password With
  v3password: User's password With v3oidcpassword:
  Password (Env: OS_PASSWORD)

``--os-redirect-uri <auth-redirect-uri>``
  With v3oidcauthcode: OpenID Connect Redirect URL (Env:
  OS_REDIRECT_URI)

``--os-endpoint <auth-endpoint>``
  With admin_token: The endpoint that will always be
  used (Env: OS_ENDPOINT)

``--os-url <auth-url>``
  With token_endpoint: Specific service endpoint to use
  (Env: OS_URL)

``--os-token <auth-token>``
  With v2token: Token With admin_token: The token that
  will always be used With token_endpoint:
  Authentication token to use With token: Token to
  authenticate with With v3token: Token to authenticate
  with (Env: OS_TOKEN)

``--os-passcode <auth-passcode>``
  With v3totp: User's TOTP passcode (Env: OS_PASSCODE)

``--os-project-id <auth-project-id>``
  With password: Project ID to scope to With
  v3oidcauthcode: Project ID to scope to With
  v3samlpassword: Project ID to scope to With
  v3password: Project ID to scope to With
  v3oidcaccesstoken: Project ID to scope to With token:
  Project ID to scope to With v3oidcclientcredentials:
  Project ID to scope to With v3tokenlessauth: Project
  ID to scope to With v3token: Project ID to scope to
  With v3totp: Project ID to scope to With
  v3oidcpassword: Project ID to scope to (Env:
  OS_PROJECT_ID)

OpenStack with Identity API v3 commands
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. important::

   OpenStack Identity API v2 is deprecated in
   the Mitaka release and later.

   You can select the Identity API version to use
   by adding the
   :option:`--os-identity-api-version`
   parameter or by setting the corresponding
   environment variable:

   .. code-block:: console

      export OS_IDENTITY_API_VERSION=3

.. _openstack_access_token_create:

openstack access token create
-----------------------------

.. code-block:: console

   usage: openstack access token create [-h]
                                        [-f {html,json,shell,table,value,yaml}]
                                        [-c COLUMN] [--max-width <integer>]
                                        [--noindent] [--prefix PREFIX]
                                        --consumer-key <consumer-key>
                                        --consumer-secret <consumer-secret>
                                        --request-key <request-key>
                                        --request-secret <request-secret>
                                        --verifier <verifier>

Create an access token

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--consumer-key <consumer-key>``
  Consumer key (required)

``--consumer-secret <consumer-secret>``
  Consumer secret (required)

``--request-key <request-key>``
  Request token to exchange for access token (required)

``--request-secret <request-secret>``
  Secret associated with <request-key> (required)

``--verifier <verifier>``
  Verifier associated with <request-key> (required)

.. _openstack_acl_delete:

openstack acl delete
--------------------

.. code-block:: console

   usage: openstack acl delete [-h] URI

Delete ACLs for a secret or container as identified by its href.

**Positional arguments:**

``URI``
  The URI reference for the secret or container.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_acl_get:

openstack acl get
-----------------

.. code-block:: console

   usage: openstack acl get [-h] [-f {csv,html,json,table,value,yaml}]
                            [-c COLUMN] [--max-width <integer>] [--noindent]
                            [--quote {all,minimal,none,nonnumeric}]
                            URI

Retrieve ACLs for a secret or container by providing its href.

**Positional arguments:**

``URI``
  The URI reference for the secret or container.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_acl_submit:

openstack acl submit
--------------------

.. code-block:: console

   usage: openstack acl submit [-h] [-f {csv,html,json,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>] [--noindent]
                               [--quote {all,minimal,none,nonnumeric}]
                               [--user [USERS]]
                               [--project-access | --no-project-access]
                               [--operation-type {read}]
                               URI

Submit ACL on a secret or container as identified by its href.

**Positional arguments:**

``URI``
  The URI reference for the secret or container.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--user [USERS], -u [USERS]``
  Keystone userid(s) for ACL.

``--project-access``
  Flag to enable project access behavior.

``--no-project-access``
  Flag to disable project access behavior.

``--operation-type {read}, -o {read}``
  Type of Barbican operation ACL is set for

.. _openstack_acl_user_add:

openstack acl user add
----------------------

.. code-block:: console

   usage: openstack acl user add [-h] [-f {csv,html,json,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>] [--noindent]
                                 [--quote {all,minimal,none,nonnumeric}]
                                 [--user [USERS]]
                                 [--project-access | --no-project-access]
                                 [--operation-type {read}]
                                 URI

Add ACL users to a secret or container as identified by its href.

**Positional arguments:**

``URI``
  The URI reference for the secret or container.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--user [USERS], -u [USERS]``
  Keystone userid(s) for ACL.

``--project-access``
  Flag to enable project access behavior.

``--no-project-access``
  Flag to disable project access behavior.

``--operation-type {read}, -o {read}``
  Type of Barbican operation ACL is set for

.. _openstack_acl_user_remove:

openstack acl user remove
-------------------------

.. code-block:: console

   usage: openstack acl user remove [-h] [-f {csv,html,json,table,value,yaml}]
                                    [-c COLUMN] [--max-width <integer>]
                                    [--noindent]
                                    [--quote {all,minimal,none,nonnumeric}]
                                    [--user [USERS]]
                                    [--project-access | --no-project-access]
                                    [--operation-type {read}]
                                    URI

Remove ACL users from a secret or container as identified by its href.

**Positional arguments:**

``URI``
  The URI reference for the secret or container.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--user [USERS], -u [USERS]``
  Keystone userid(s) for ACL.

``--project-access``
  Flag to enable project access behavior.

``--no-project-access``
  Flag to disable project access behavior.

``--operation-type {read}, -o {read}``
  Type of Barbican operation ACL is set for

.. _openstack_address_scope_create:

openstack address scope create
------------------------------

.. code-block:: console

   usage: openstack address scope create [-h]
                                         [-f {html,json,shell,table,value,yaml}]
                                         [-c COLUMN] [--max-width <integer>]
                                         [--noindent] [--prefix PREFIX]
                                         [--ip-version {4,6}]
                                         [--project <project>]
                                         [--project-domain <project-domain>]
                                         [--share | --no-share]
                                         <name>

Create a new Address Scope

**Positional arguments:**

``<name>``
  New address scope name

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--ip-version {4,6} IP``
  version (default is 4)

``--project <project>``
  Owner's project (name or ID)

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

``--share``
  Share the address scope between projects

``--no-share``
  Do not share the address scope between projects
  (default)

.. _openstack_address_scope_delete:

openstack address scope delete
------------------------------

.. code-block:: console

   usage: openstack address scope delete [-h]
                                         <address-scope> [<address-scope> ...]

Delete address scope(s)

**Positional arguments:**

``<address-scope>``
  Address scope(s) to delete (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_address_scope_list:

openstack address scope list
----------------------------

.. code-block:: console

   usage: openstack address scope list [-h] [-f {csv,html,json,table,value,yaml}]
                                       [-c COLUMN] [--max-width <integer>]
                                       [--noindent]
                                       [--quote {all,minimal,none,nonnumeric}]

List address scopes

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_address_scope_set:

openstack address scope set
---------------------------

.. code-block:: console

   usage: openstack address scope set [-h] [--name <name>] [--share | --no-share]
                                      <address-scope>

Set address scope properties

**Positional arguments:**

``<address-scope>``
  Address scope to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  Set address scope name

``--share``
  Share the address scope between projects

``--no-share``
  Do not share the address scope between projects

.. _openstack_address_scope_show:

openstack address scope show
----------------------------

.. code-block:: console

   usage: openstack address scope show [-h]
                                       [-f {html,json,shell,table,value,yaml}]
                                       [-c COLUMN] [--max-width <integer>]
                                       [--noindent] [--prefix PREFIX]
                                       <address-scope>

Display address scope details

**Positional arguments:**

``<address-scope>``
  Address scope to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_aggregate_add_host:

openstack aggregate add host
----------------------------

.. code-block:: console

   usage: openstack aggregate add host [-h]
                                       [-f {html,json,shell,table,value,yaml}]
                                       [-c COLUMN] [--max-width <integer>]
                                       [--noindent] [--prefix PREFIX]
                                       <aggregate> <host>

Add host to aggregate

**Positional arguments:**

``<aggregate>``
  Aggregate (name or ID)

``<host>``
  Host to add to <aggregate>

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_aggregate_create:

openstack aggregate create
--------------------------

.. code-block:: console

   usage: openstack aggregate create [-h] [-f {html,json,shell,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--noindent] [--prefix PREFIX]
                                     [--zone <availability-zone>]
                                     [--property <key=value>]
                                     <name>

Create a new aggregate

**Positional arguments:**

``<name>``
  New aggregate name

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--zone <availability-zone>``
  Availability zone name

``--property <key=value>``
  Property to add to this aggregate (repeat option to
  set multiple properties)

.. _openstack_aggregate_delete:

openstack aggregate delete
--------------------------

.. code-block:: console

   usage: openstack aggregate delete [-h] <aggregate> [<aggregate> ...]

Delete existing aggregate(s)

**Positional arguments:**

``<aggregate>``
  Aggregate(s) to delete (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_aggregate_list:

openstack aggregate list
------------------------

.. code-block:: console

   usage: openstack aggregate list [-h] [-f {csv,html,json,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--noindent]
                                   [--quote {all,minimal,none,nonnumeric}]
                                   [--long]

List all aggregates

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--long``
  List additional fields in output

.. _openstack_aggregate_remove_host:

openstack aggregate remove host
-------------------------------

.. code-block:: console

   usage: openstack aggregate remove host [-h]
                                          [-f {html,json,shell,table,value,yaml}]
                                          [-c COLUMN] [--max-width <integer>]
                                          [--noindent] [--prefix PREFIX]
                                          <aggregate> <host>

Remove host from aggregate

**Positional arguments:**

``<aggregate>``
  Aggregate (name or ID)

``<host>``
  Host to remove from <aggregate>

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_aggregate_set:

openstack aggregate set
-----------------------

.. code-block:: console

   usage: openstack aggregate set [-h] [--name <name>]
                                  [--zone <availability-zone>]
                                  [--property <key=value>]
                                  <aggregate>

Set aggregate properties

**Positional arguments:**

``<aggregate>``
  Aggregate to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  Set aggregate name

``--zone <availability-zone>``
  Set availability zone name

``--property <key=value>``
  Property to set on <aggregate> (repeat option to set
  multiple properties)

.. _openstack_aggregate_show:

openstack aggregate show
------------------------

.. code-block:: console

   usage: openstack aggregate show [-h] [-f {html,json,shell,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--noindent] [--prefix PREFIX]
                                   <aggregate>

Display aggregate details

**Positional arguments:**

``<aggregate>``
  Aggregate to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_aggregate_unset:

openstack aggregate unset
-------------------------

.. code-block:: console

   usage: openstack aggregate unset [-h] --property <key> <aggregate>

Unset aggregate properties

**Positional arguments:**

``<aggregate>``
  Aggregate to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--property <key>``
  Property to remove from aggregate (repeat option to remove
  multiple properties)

.. _openstack_availability_zone_list:

openstack availability zone list
--------------------------------

.. code-block:: console

   usage: openstack availability zone list [-h]
                                           [-f {csv,html,json,table,value,yaml}]
                                           [-c COLUMN] [--max-width <integer>]
                                           [--noindent]
                                           [--quote {all,minimal,none,nonnumeric}]
                                           [--compute] [--network] [--volume]
                                           [--long]

List availability zones and their status

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--compute``
  List compute availability zones

``--network``
  List network availability zones

``--volume``
  List volume availability zones

``--long``
  List additional fields in output

.. _openstack_backup_create:

openstack backup create
-----------------------

.. code-block:: console

   usage: openstack backup create [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--noindent] [--prefix PREFIX] [--name <name>]
                                  [--description <description>]
                                  [--container <container>]
                                  [--snapshot <snapshot>] [--force]
                                  [--incremental]
                                  <volume>

Create new backup

**Positional arguments:**

``<volume>``
  Volume to backup (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  Name of the backup

``--description <description>``
  Description of the backup

``--container <container>``
  Optional backup container name

``--snapshot <snapshot>``
  Snapshot to backup (name or ID)

``--force``
  Allow to back up an in-use volume

``--incremental``
  Perform an incremental backup

.. _openstack_backup_delete:

openstack backup delete
-----------------------

.. code-block:: console

   usage: openstack backup delete [-h] [--force] <backup> [<backup> ...]

Delete backup(s)

**Positional arguments:**

``<backup>``
  Backup(s) to delete (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--force``
  Allow delete in state other than error or available

.. _openstack_backup_list:

openstack backup list
---------------------

.. code-block:: console

   usage: openstack backup list [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}] [--long]

List backups

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--long``
  List additional fields in output

.. _openstack_backup_restore:

openstack backup restore
------------------------

.. code-block:: console

   usage: openstack backup restore [-h] [-f {html,json,shell,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--noindent] [--prefix PREFIX]
                                   <backup> <volume>

Restore backup

**Positional arguments:**

``<backup>``
  Backup to restore (name or ID)

``<volume>``
  Volume to restore to (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_backup_show:

openstack backup show
---------------------

.. code-block:: console

   usage: openstack backup show [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--prefix PREFIX]
                                <backup>

Display backup details

**Positional arguments:**

``<backup>``
  Backup to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_baremetal_introspection_abort:

openstack baremetal introspection abort
---------------------------------------

.. code-block:: console

   usage: openstack baremetal introspection abort [-h] uuid

Abort running introspection for node.

**Positional arguments:**

``uuid``
  baremetal node UUID

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_baremetal_introspection_data_save:

openstack baremetal introspection data save
-------------------------------------------

.. code-block:: console

   usage: openstack baremetal introspection data save [-h] [--file <filename>]
                                                      uuid

Save or display raw introspection data.

**Positional arguments:**

``uuid``
  baremetal node UUID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--file <filename>``
  downloaded introspection data filename (default: stdout)

.. _openstack_baremetal_introspection_reprocess:

openstack baremetal introspection reprocess
-------------------------------------------

.. code-block:: console

   usage: openstack baremetal introspection reprocess [-h] uuid

Reprocess stored introspection data

**Positional arguments:**

``uuid``
  baremetal node UUID

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_baremetal_introspection_rule_delete:

openstack baremetal introspection rule delete
---------------------------------------------

.. code-block:: console

   usage: openstack baremetal introspection rule delete [-h] uuid

Delete an introspection rule.

**Positional arguments:**

``uuid``
  rule UUID

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_baremetal_introspection_rule_import:

openstack baremetal introspection rule import
---------------------------------------------

.. code-block:: console

   usage: openstack baremetal introspection rule import [-h]
                                                        [-f {csv,html,json,table,value,yaml}]
                                                        [-c COLUMN]
                                                        [--max-width <integer>]
                                                        [--noindent]
                                                        [--quote {all,minimal,none,nonnumeric}]
                                                        file

Import one or several introspection rules from a json file.

**Positional arguments:**

``file``
  JSON file to import, may contain one or several rules

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_baremetal_introspection_rule_list:

openstack baremetal introspection rule list
-------------------------------------------

.. code-block:: console

   usage: openstack baremetal introspection rule list [-h]
                                                      [-f {csv,html,json,table,value,yaml}]
                                                      [-c COLUMN]
                                                      [--max-width <integer>]
                                                      [--noindent]
                                                      [--quote {all,minimal,none,nonnumeric}]

List all introspection rules.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_baremetal_introspection_rule_purge:

openstack baremetal introspection rule purge
--------------------------------------------

.. code-block:: console

   usage: openstack baremetal introspection rule purge [-h]

Drop all introspection rules.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_baremetal_introspection_rule_show:

openstack baremetal introspection rule show
-------------------------------------------

.. code-block:: console

   usage: openstack baremetal introspection rule show [-h]
                                                      [-f {html,json,shell,table,value,yaml}]
                                                      [-c COLUMN]
                                                      [--max-width <integer>]
                                                      [--noindent]
                                                      [--prefix PREFIX]
                                                      uuid

Show an introspection rule.

**Positional arguments:**

``uuid``
  rule UUID

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_baremetal_introspection_start:

openstack baremetal introspection start
---------------------------------------

.. code-block:: console

   usage: openstack baremetal introspection start [-h]
                                                  [-f {csv,html,json,table,value,yaml}]
                                                  [-c COLUMN]
                                                  [--max-width <integer>]
                                                  [--noindent]
                                                  [--quote {all,minimal,none,nonnumeric}]
                                                  [--new-ipmi-username NEW_IPMI_USERNAME]
                                                  [--new-ipmi-password NEW_IPMI_PASSWORD]
                                                  [--wait]
                                                  uuid [uuid ...]

Start the introspection.

**Positional arguments:**

``uuid``
  baremetal node UUID(s)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--new-ipmi-username NEW_IPMI_USERNAME``
  if set, \*Ironic Inspector\* will update IPMI user name
  to this value

``--new-ipmi-password NEW_IPMI_PASSWORD``
  if set, \*Ironic Inspector\* will update IPMI password
  to this value

``--wait``
  wait for introspection to finish; the result will be
  displayed in the end

.. _openstack_baremetal_introspection_status:

openstack baremetal introspection status
----------------------------------------

.. code-block:: console

   usage: openstack baremetal introspection status [-h]
                                                   [-f {html,json,shell,table,value,yaml}]
                                                   [-c COLUMN]
                                                   [--max-width <integer>]
                                                   [--noindent] [--prefix PREFIX]
                                                   uuid

Get introspection status.

**Positional arguments:**

``uuid``
  baremetal node UUID

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_baremetal_node_abort:

openstack baremetal node abort
------------------------------

.. code-block:: console

   usage: openstack baremetal node abort [-h] <node>

Set provision state of baremetal node to 'abort'

**Positional arguments:**

``<node>``
  Name or UUID of the node.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_baremetal_node_clean:

openstack baremetal node clean
------------------------------

.. code-block:: console

   usage: openstack baremetal node clean [-h] --clean-steps <clean-steps> <node>

Set provision state of baremetal node to 'clean'

**Positional arguments:**

``<node>``
  Name or UUID of the node.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--clean-steps <clean-steps>``
  The clean steps in JSON format. May be the path to a
  file containing the clean steps; OR '-', with the
  clean steps being read from standard input; OR a
  string. The value should be a list of clean-step
  dictionaries; each dictionary should have keys
  'interface' and 'step', and optional key 'args'.

.. _openstack_baremetal_node_create:

openstack baremetal node create
-------------------------------

.. code-block:: console

   usage: openstack baremetal node create [-h]
                                          [-f {html,json,shell,table,value,yaml}]
                                          [-c COLUMN] [--max-width <integer>]
                                          [--noindent] [--prefix PREFIX]
                                          [--chassis-uuid <chassis>] --driver
                                          <driver> [--driver-info <key=value>]
                                          [--property <key=value>]
                                          [--extra <key=value>] [--uuid <uuid>]
                                          [--name <name>]
                                          [--network-interface <network_interface>]
                                          [--resource-class <resource_class>]

Register a new node with the baremetal service

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--chassis-uuid <chassis>``
  UUID of the chassis that this node belongs to.

``--driver <driver>``
  Driver used to control the node [REQUIRED].

``--driver-info <key=value>``
  Key/value pair used by the driver, such as out-of-band
  management credentials. Can be specified multiple
  times.

``--property <key=value>``
  Key/value pair describing the physical characteristics
  of the node. This is exported to Nova and used by the
  scheduler. Can be specified multiple times.

``--extra <key=value>``
  Record arbitrary key/value metadata. Can be specified
  multiple times.

``--uuid <uuid>``
  Unique UUID for the node.

``--name <name>``
  Unique name for the node.

``--network-interface <network_interface>``
  Network interface used for switching node to
  cleaning/provisioning networks.

``--resource-class <resource_class>``
  Resource class for mapping nodes to Nova flavors

.. _openstack_baremetal_node_delete:

openstack baremetal node delete
-------------------------------

.. code-block:: console

   usage: openstack baremetal node delete [-h] <node> [<node> ...]

Unregister a baremetal node

**Positional arguments:**

``<node>``
  Node(s) to delete (name or UUID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_baremetal_node_deploy:

openstack baremetal node deploy
-------------------------------

.. code-block:: console

   usage: openstack baremetal node deploy [-h] [--config-drive <config-drive>]
                                          <node>

Set provision state of baremetal node to 'deploy'

**Positional arguments:**

``<node>``
  Name or UUID of the node.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--config-drive <config-drive>``
  A gzipped, base64-encoded configuration drive string
  OR the path to the configuration drive file OR the
  path to a directory containing the config drive files.
  In case it's a directory, a config drive will be
  generated from it.

.. _openstack_baremetal_node_inspect:

openstack baremetal node inspect
--------------------------------

.. code-block:: console

   usage: openstack baremetal node inspect [-h] <node>

Set provision state of baremetal node to 'inspect'

**Positional arguments:**

``<node>``
  Name or UUID of the node.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_baremetal_node_list:

openstack baremetal node list
-----------------------------

.. code-block:: console

   usage: openstack baremetal node list [-h]
                                        [-f {csv,html,json,table,value,yaml}]
                                        [-c COLUMN] [--max-width <integer>]
                                        [--noindent]
                                        [--quote {all,minimal,none,nonnumeric}]
                                        [--limit <limit>] [--marker <node>]
                                        [--sort <key>[:<direction>]]
                                        [--maintenance] [--associated]
                                        [--provision-state <provision state>]
                                        [--resource-class <resource class>]
                                        [--long | --fields <field> [<field> ...]]

List baremetal nodes

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--limit <limit>``
  Maximum number of nodes to return per request, 0 for
  no limit. Default is the maximum number used by the
  Baremetal API Service.

``--marker <node>``
  Node UUID (for example, of the last node in the list
  from a previous request). Returns the list of nodes
  after this UUID.

``--sort <key>[:<direction>]``
  Sort output by specified node fields and directions
  (asc or desc) (default: asc). Multiple fields and
  directions can be specified, separated by comma.

``--maintenance``
  List nodes in maintenance mode.

``--associated``
  List only nodes associated with an instance.

``--provision-state <provision state>``
  Limit list to nodes in <provision state>. One of
  active, deleted, rebuild, inspect, provide, manage,
  clean, abort.

``--resource-class <resource class>``
  Limit list to nodes with resource class <resource
  class>

``--long``
  Show detailed information about the nodes.

``--fields <field> [<field> ...]``
  One or more node fields. Only these fields will be
  fetched from the server. Can not be used when ':option:`--long`'
  is specified.

.. _openstack_baremetal_node_maintenance_set:

openstack baremetal node maintenance set
----------------------------------------

.. code-block:: console

   usage: openstack baremetal node maintenance set [-h] [--reason <reason>]
                                                   <node>

Set baremetal node to maintenance mode

**Positional arguments:**

``<node>``
  Name or UUID of the node.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--reason <reason>``
  Reason for setting maintenance mode.

.. _openstack_baremetal_node_maintenance_unset:

openstack baremetal node maintenance unset
------------------------------------------

.. code-block:: console

   usage: openstack baremetal node maintenance unset [-h] <node>

Unset baremetal node from maintenance mode

**Positional arguments:**

``<node>``
  Name or UUID of the node.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_baremetal_node_manage:

openstack baremetal node manage
-------------------------------

.. code-block:: console

   usage: openstack baremetal node manage [-h] <node>

Set provision state of baremetal node to 'manage'

**Positional arguments:**

``<node>``
  Name or UUID of the node.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_baremetal_node_power:

openstack baremetal node power
------------------------------

.. code-block:: console

   usage: openstack baremetal node power [-h] <on|off> <node>

Set power state of baremetal node

**Positional arguments:**

``<on|off>``
  Power node on or off

``<node>``
  Name or UUID of the node.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_baremetal_node_provide:

openstack baremetal node provide
--------------------------------

.. code-block:: console

   usage: openstack baremetal node provide [-h] <node>

Set provision state of baremetal node to 'provide'

**Positional arguments:**

``<node>``
  Name or UUID of the node.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_baremetal_node_reboot:

openstack baremetal node reboot
-------------------------------

.. code-block:: console

   usage: openstack baremetal node reboot [-h] <node>

Reboot baremetal node

**Positional arguments:**

``<node>``
  Name or UUID of the node.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_baremetal_node_rebuild:

openstack baremetal node rebuild
--------------------------------

.. code-block:: console

   usage: openstack baremetal node rebuild [-h] <node>

Set provision state of baremetal node to 'rebuild'

**Positional arguments:**

``<node>``
  Name or UUID of the node.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_baremetal_node_set:

openstack baremetal node set
----------------------------

.. code-block:: console

   usage: openstack baremetal node set [-h] [--instance-uuid <uuid>]
                                       [--name <name>] [--driver <driver>]
                                       [--network-interface <network_interface>]
                                       [--resource-class <resource_class>]
                                       [--property <key=value>]
                                       [--extra <key=value>]
                                       [--driver-info <key=value>]
                                       [--instance-info <key=value>]
                                       <node>

Set baremetal properties

**Positional arguments:**

``<node>``
  Name or UUID of the node.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--instance-uuid <uuid>``
  Set instance UUID of node to <uuid>

``--name <name>``
  Set the name of the node

``--driver <driver>``
  Set the driver for the node

``--network-interface <network_interface>``
  Set the network interface for the node

``--resource-class <resource_class>``
  Set the resource class for the node

``--property <key=value>``
  Property to set on this baremetal node (repeat option
  to set multiple properties)

``--extra <key=value>``
  Extra to set on this baremetal node (repeat option to
  set multiple extras)

``--driver-info <key=value>``
  Driver information to set on this baremetal node
  (repeat option to set multiple driver infos)

``--instance-info <key=value>``
  Instance information to set on this baremetal node
  (repeat option to set multiple instance infos)

.. _openstack_baremetal_node_show:

openstack baremetal node show
-----------------------------

.. code-block:: console

   usage: openstack baremetal node show [-h]
                                        [-f {html,json,shell,table,value,yaml}]
                                        [-c COLUMN] [--max-width <integer>]
                                        [--noindent] [--prefix PREFIX]
                                        [--instance]
                                        [--fields <field> [<field> ...]]
                                        <node>

Show baremetal node details

**Positional arguments:**

``<node>``
  Name or UUID of the node (or instance UUID if
  :option:`--instance` is specified)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--instance <node>``
  is an instance UUID.

``--fields <field> [<field> ...]``
  One or more node fields. Only these fields will be
  fetched from the server.

.. _openstack_baremetal_node_undeploy:

openstack baremetal node undeploy
---------------------------------

.. code-block:: console

   usage: openstack baremetal node undeploy [-h] <node>

Set provision state of baremetal node to 'deleted'

**Positional arguments:**

``<node>``
  Name or UUID of the node.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_baremetal_node_unset:

openstack baremetal node unset
------------------------------

.. code-block:: console

   usage: openstack baremetal node unset [-h] [--instance-uuid] [--name]
                                         [--resource-class] [--property <key>]
                                         [--extra <key>] [--driver-info <key>]
                                         [--instance-info <key>]
                                         <node>

Unset baremetal properties

**Positional arguments:**

``<node>``
  Name or UUID of the node.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--instance-uuid``
  Unset instance UUID on this baremetal node

``--name``
  Unset the name of the node

``--resource-class``
  Unset the resource class of the node

``--property <key>``
  Property to unset on this baremetal node (repeat
  option to unset multiple properties)

``--extra <key>``
  Extra to unset on this baremetal node (repeat option
  to unset multiple extras)

``--driver-info <key>``
  Driver information to unset on this baremetal node
  (repeat option to unset multiple driver informations)

``--instance-info <key>``
  Instance information to unset on this baremetal node
  (repeat option to unset multiple instance
  informations)

.. _openstack_baremetal_port_create:

openstack baremetal port create
-------------------------------

.. code-block:: console

   usage: openstack baremetal port create [-h]
                                          [-f {html,json,shell,table,value,yaml}]
                                          [-c COLUMN] [--max-width <integer>]
                                          [--noindent] [--prefix PREFIX] --node
                                          <uuid> [--extra <key=value>]
                                          [-l <key=value>]
                                          [--pxe-enabled <boolean>]
                                          <address>

Create a new port

**Positional arguments:**

``<address>``
  MAC address for this port.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--node <uuid>``
  UUID of the node that this port belongs to.

``--extra <key=value>``
  Record arbitrary key/value metadata. Can be specified
  multiple times.

``-l <key=value>, --local-link-connection <key=value>``
  Key/value metadata describing Local link connection
  information. Valid keys are switch_info, switch_id,
  port_id. Can be specified multiple times.

``--pxe-enabled <boolean>``
  Indicates whether this Port should be used when PXE
  booting this Node.

.. _openstack_baremetal_port_show:

openstack baremetal port show
-----------------------------

.. code-block:: console

   usage: openstack baremetal port show [-h]
                                        [-f {html,json,shell,table,value,yaml}]
                                        [-c COLUMN] [--max-width <integer>]
                                        [--noindent] [--prefix PREFIX]
                                        [--address]
                                        [--fields <field> [<field> ...]]
                                        <id>

Show baremetal port details.

**Positional arguments:**

``<id>``
  UUID of the port (or MAC address if :option:`--address` is
  specified).

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--address <id>``
  is the MAC address (instead of the UUID) of the
  port.

``--fields <field> [<field> ...]``
  One or more port fields. Only these fields will be
  fetched from the server.

.. _openstack_ca_get:

openstack ca get
----------------

.. code-block:: console

   usage: openstack ca get [-h] [-f {html,json,shell,table,value,yaml}]
                           [-c COLUMN] [--max-width <integer>] [--noindent]
                           [--prefix PREFIX]
                           URI

Retrieve a CA by providing its URI.

**Positional arguments:**

``URI``
  The URI reference for the CA.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_ca_list:

openstack ca list
-----------------

.. code-block:: console

   usage: openstack ca list [-h] [-f {csv,html,json,table,value,yaml}]
                            [-c COLUMN] [--max-width <integer>] [--noindent]
                            [--quote {all,minimal,none,nonnumeric}]
                            [--limit LIMIT] [--offset OFFSET] [--name NAME]

List cas.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--limit LIMIT, -l LIMIT``
  specify the limit to the number of items to list per
  page (default: 10; maximum: 100)

``--offset OFFSET, -o OFFSET``
  specify the page offset (default: 0)

``--name NAME, -n NAME``
  specify the secret name (default: None)

.. _openstack_catalog_list:

openstack catalog list
----------------------

.. code-block:: console

   usage: openstack catalog list [-h] [-f {csv,html,json,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>] [--noindent]
                                 [--quote {all,minimal,none,nonnumeric}]

List services in the service catalog

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_catalog_show:

openstack catalog show
----------------------

.. code-block:: console

   usage: openstack catalog show [-h] [-f {html,json,shell,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>] [--noindent]
                                 [--prefix PREFIX]
                                 <service>

Display service catalog details

**Positional arguments:**

``<service>``
  Service to display (type or name)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_claim_create:

openstack claim create
----------------------

.. code-block:: console

   usage: openstack claim create [-h] [-f {csv,html,json,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>] [--noindent]
                                 [--quote {all,minimal,none,nonnumeric}]
                                 [--ttl <ttl>] [--grace <grace>]
                                 [--limit <limit>]
                                 <queue_name>

Create claim and return a list of claimed messages

**Positional arguments:**

``<queue_name>``
  Name of the queue to be claim

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--ttl <ttl>``
  Time to live in seconds for claim

``--grace <grace>``
  The message grace period in seconds

``--limit <limit>``
  Claims a set of messages, up to limit

.. _openstack_claim_query:

openstack claim query
---------------------

.. code-block:: console

   usage: openstack claim query [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}]
                                <queue_name> <claim_id>

Display claim details

**Positional arguments:**

``<queue_name>``
  Name of the claimed queue

``<claim_id>``
  ID of the claim

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_claim_release:

openstack claim release
-----------------------

.. code-block:: console

   usage: openstack claim release [-h] <queue_name> <claim_id>

Delete a claim

**Positional arguments:**

``<queue_name>``
  Name of the claimed queue

``<claim_id>``
  Claim ID to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_claim_renew:

openstack claim renew
---------------------

.. code-block:: console

   usage: openstack claim renew [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}]
                                [--ttl <ttl>] [--grace <grace>]
                                <queue_name> <claim_id>

Renew a claim

**Positional arguments:**

``<queue_name>``
  Name of the claimed queue

``<claim_id>``
  Claim ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--ttl <ttl>``
  Time to live in seconds for claim

``--grace <grace>``
  The message grace period in seconds

.. _openstack_command_list:

openstack command list
----------------------

.. code-block:: console

   usage: openstack command list [-h] [-f {csv,html,json,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>] [--noindent]
                                 [--quote {all,minimal,none,nonnumeric}]

List recognized commands by group

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_compute_agent_create:

openstack compute agent create
------------------------------

.. code-block:: console

   usage: openstack compute agent create [-h]
                                         [-f {html,json,shell,table,value,yaml}]
                                         [-c COLUMN] [--max-width <integer>]
                                         [--noindent] [--prefix PREFIX]
                                         <os> <architecture> <version> <url>
                                         <md5hash> <hypervisor>

Create compute agent

**Positional arguments:**

``<os>``
  Type of OS

``<architecture>``
  Type of architecture

``<version>``
  Version

``<url>``
  URL

``<md5hash>``
  MD5 hash

``<hypervisor>``
  Type of hypervisor

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_compute_agent_delete:

openstack compute agent delete
------------------------------

.. code-block:: console

   usage: openstack compute agent delete [-h] <id> [<id> ...]

Delete compute agent(s)

**Positional arguments:**

``<id>``
  ID of agent(s) to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_compute_agent_list:

openstack compute agent list
----------------------------

.. code-block:: console

   usage: openstack compute agent list [-h] [-f {csv,html,json,table,value,yaml}]
                                       [-c COLUMN] [--max-width <integer>]
                                       [--noindent]
                                       [--quote {all,minimal,none,nonnumeric}]
                                       [--hypervisor <hypervisor>]

List compute agents

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--hypervisor <hypervisor>``
  Type of hypervisor

.. _openstack_compute_agent_set:

openstack compute agent set
---------------------------

.. code-block:: console

   usage: openstack compute agent set [-h] [--agent-version <version>]
                                      [--url <url>] [--md5hash <md5hash>]
                                      <id>

Set compute agent properties

**Positional arguments:**

``<id>``
  ID of the agent

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--agent-version <version>``
  Version of the agent

``--url <url>``
  URL of the agent

``--md5hash <md5hash>``
  MD5 hash of the agent

.. _openstack_compute_service_delete:

openstack compute service delete
--------------------------------

.. code-block:: console

   usage: openstack compute service delete [-h] <service> [<service> ...]

Delete compute service(s)

**Positional arguments:**

``<service>``
  Compute service(s) to delete (ID only)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_compute_service_list:

openstack compute service list
------------------------------

.. code-block:: console

   usage: openstack compute service list [-h]
                                         [-f {csv,html,json,table,value,yaml}]
                                         [-c COLUMN] [--max-width <integer>]
                                         [--noindent]
                                         [--quote {all,minimal,none,nonnumeric}]
                                         [--host <host>] [--service <service>]
                                         [--long]

List compute services

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--host <host>``
  List services on specified host (name only)

``--service <service>``
  List only specified service (name only)

``--long``
  List additional fields in output

.. _openstack_compute_service_set:

openstack compute service set
-----------------------------

.. code-block:: console

   usage: openstack compute service set [-h] [--enable | --disable]
                                        [--disable-reason <reason>]
                                        [--up | --down]
                                        <host> <service>

Set compute service properties

**Positional arguments:**

``<host>``
  Name of host

``<service>``
  Name of service (Binary name)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--enable``
  Enable service

``--disable``
  Disable service

``--disable-reason <reason>``
  Reason for disabling the service (in quotas). Should
  be used with :option:`--disable` option.

``--up``
  Force up service

``--down``
  Force down service

.. _openstack_configuration_show:

openstack configuration show
----------------------------

.. code-block:: console

   usage: openstack configuration show [-h]
                                       [-f {html,json,shell,table,value,yaml}]
                                       [-c COLUMN] [--max-width <integer>]
                                       [--noindent] [--prefix PREFIX]
                                       [--mask | --unmask]

Display configuration details

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--mask``
  Attempt to mask passwords (default)

``--unmask``
  Show password in clear text

.. _openstack_console_log_show:

openstack console log show
--------------------------

.. code-block:: console

   usage: openstack console log show [-h] [--lines <num-lines>] <server>

Show server's console output

**Positional arguments:**

``<server>``
  Server to show console log (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--lines <num-lines>``
  Number of lines to display from the end of the log
  (default=all)

.. _openstack_console_url_show:

openstack console url show
--------------------------

.. code-block:: console

   usage: openstack console url show [-h] [-f {html,json,shell,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--noindent] [--prefix PREFIX]
                                     [--novnc | --xvpvnc | --spice | --rdp | --serial | --mks]
                                     <server>

Show server's remote console URL

**Positional arguments:**

``<server>``
  Server to show URL (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--novnc``
  Show noVNC console URL (default)

``--xvpvnc``
  Show xvpvnc console URL

``--spice``
  Show SPICE console URL

``--rdp``
  Show RDP console URL

``--serial``
  Show serial console URL

``--mks``
  Show WebMKS console URL

.. _openstack_consumer_create:

openstack consumer create
-------------------------

.. code-block:: console

   usage: openstack consumer create [-h] [-f {html,json,shell,table,value,yaml}]
                                    [-c COLUMN] [--max-width <integer>]
                                    [--noindent] [--prefix PREFIX]
                                    [--description <description>]

Create new consumer

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--description <description>``
  New consumer description

.. _openstack_consumer_delete:

openstack consumer delete
-------------------------

.. code-block:: console

   usage: openstack consumer delete [-h] <consumer> [<consumer> ...]

Delete consumer(s)

**Positional arguments:**

``<consumer>``
  Consumer(s) to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_consumer_list:

openstack consumer list
-----------------------

.. code-block:: console

   usage: openstack consumer list [-h] [-f {csv,html,json,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--noindent]
                                  [--quote {all,minimal,none,nonnumeric}]

List consumers

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_consumer_set:

openstack consumer set
----------------------

.. code-block:: console

   usage: openstack consumer set [-h] [--description <description>] <consumer>

Set consumer properties

**Positional arguments:**

``<consumer>``
  Consumer to modify

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--description <description>``
  New consumer description

.. _openstack_consumer_show:

openstack consumer show
-----------------------

.. code-block:: console

   usage: openstack consumer show [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--noindent] [--prefix PREFIX]
                                  <consumer>

Display consumer details

**Positional arguments:**

``<consumer>``
  Consumer to display

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_container_create:

openstack container create
--------------------------

.. code-block:: console

   usage: openstack container create [-h] [-f {csv,html,json,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--noindent]
                                     [--quote {all,minimal,none,nonnumeric}]
                                     <container-name> [<container-name> ...]

Create new container

**Positional arguments:**

``<container-name>``
  New container name(s)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_container_delete:

openstack container delete
--------------------------

.. code-block:: console

   usage: openstack container delete [-h] [--recursive]
                                     <container> [<container> ...]

Delete container

**Positional arguments:**

``<container>``
  Container(s) to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--recursive, -r``
  Recursively delete objects and container

.. _openstack_container_list:

openstack container list
------------------------

.. code-block:: console

   usage: openstack container list [-h] [-f {csv,html,json,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--noindent]
                                   [--quote {all,minimal,none,nonnumeric}]
                                   [--prefix <prefix>] [--marker <marker>]
                                   [--end-marker <end-marker>] [--limit <limit>]
                                   [--long] [--all]

List containers

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--prefix <prefix>``
  Filter list using <prefix>

``--marker <marker>``
  Anchor for paging

``--end-marker <end-marker>``
  End anchor for paging

``--limit <limit>``
  Limit the number of containers returned

``--long``
  List additional fields in output

``--all``
  List all containers (default is 10000)

.. _openstack_container_save:

openstack container save
------------------------

.. code-block:: console

   usage: openstack container save [-h] <container>

Save container contents locally

**Positional arguments:**

``<container>``
  Container to save

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_container_set:

openstack container set
-----------------------

.. code-block:: console

   usage: openstack container set [-h] --property <key=value> <container>

Set container properties

**Positional arguments:**

``<container>``
  Container to modify

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--property <key=value>``
  Set a property on this container (repeat option to set
  multiple properties)

.. _openstack_container_show:

openstack container show
------------------------

.. code-block:: console

   usage: openstack container show [-h] [-f {html,json,shell,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--noindent] [--prefix PREFIX]
                                   <container>

Display container details

**Positional arguments:**

``<container>``
  Container to display

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_container_unset:

openstack container unset
-------------------------

.. code-block:: console

   usage: openstack container unset [-h] --property <key> <container>

Unset container properties

**Positional arguments:**

``<container>``
  Container to modify

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--property <key>``
  Property to remove from container (repeat option to remove
  multiple properties)

.. _openstack_credential_create:

openstack credential create
---------------------------

.. code-block:: console

   usage: openstack credential create [-h]
                                      [-f {html,json,shell,table,value,yaml}]
                                      [-c COLUMN] [--max-width <integer>]
                                      [--noindent] [--prefix PREFIX]
                                      [--type <type>] [--project <project>]
                                      <user> <data>

Create new credential

**Positional arguments:**

``<user>``
  user that owns the credential (name or ID)

``<data>``
  New credential data

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--type <type>``
  New credential type

``--project <project>``
  Project which limits the scope of the credential (name
  or ID)

.. _openstack_credential_delete:

openstack credential delete
---------------------------

.. code-block:: console

   usage: openstack credential delete [-h] <credential-id> [<credential-id> ...]

Delete credential(s)

**Positional arguments:**

``<credential-id>``
  ID of credential(s) to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_credential_list:

openstack credential list
-------------------------

.. code-block:: console

   usage: openstack credential list [-h] [-f {csv,html,json,table,value,yaml}]
                                    [-c COLUMN] [--max-width <integer>]
                                    [--noindent]
                                    [--quote {all,minimal,none,nonnumeric}]

List credentials

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_credential_set:

openstack credential set
------------------------

.. code-block:: console

   usage: openstack credential set [-h] --user <user> --type <type> --data <data>
                                   [--project <project>]
                                   <credential-id>

Set credential properties

**Positional arguments:**

``<credential-id>``
  ID of credential to change

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--user <user>``
  User that owns the credential (name or ID)

``--type <type>``
  New credential type

``--data <data>``
  New credential data

``--project <project>``
  Project which limits the scope of the credential (name
  or ID)

.. _openstack_credential_show:

openstack credential show
-------------------------

.. code-block:: console

   usage: openstack credential show [-h] [-f {html,json,shell,table,value,yaml}]
                                    [-c COLUMN] [--max-width <integer>]
                                    [--noindent] [--prefix PREFIX]
                                    <credential-id>

Display credential details

**Positional arguments:**

``<credential-id>``
  ID of credential to display

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_dataprocessing_cluster_create:

openstack dataprocessing cluster create
---------------------------------------

.. code-block:: console

   usage: openstack dataprocessing cluster create [-h]
                                                  [-f {html,json,shell,table,value,yaml}]
                                                  [-c COLUMN]
                                                  [--max-width <integer>]
                                                  [--noindent] [--prefix PREFIX]
                                                  [--name <name>]
                                                  [--cluster-template <cluster-template>]
                                                  [--image <image>]
                                                  [--description <description>]
                                                  [--user-keypair <keypair>]
                                                  [--neutron-network <network>]
                                                  [--count <count>] [--public]
                                                  [--protected] [--transient]
                                                  [--json <filename>] [--wait]

Creates cluster

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  Name of the cluster [REQUIRED if JSON is not provided]

``--cluster-template <cluster-template>``
  Cluster template name or ID [REQUIRED if JSON is not
  provided]

``--image <image>``
  Image that will be used for cluster deployment (Name
  or ID) [REQUIRED if JSON is not provided]

``--description <description>``
  Description of the cluster

``--user-keypair <keypair>``
  User keypair to get acces to VMs after cluster
  creation

``--neutron-network <network>``
  Instances of the cluster will get fixed IP addresses
  in this network. (Name or ID should be provided)

``--count <count>``
  Number of clusters to be created

``--public``
  Make the cluster public (Visible from other tenants)

``--protected``
  Make the cluster protected

``--transient``
  Create transient cluster

``--json <filename>``
  JSON representation of the cluster. Other arguments
  (except for :option:`--wait)` will not be taken into account if
  this one is provided

``--wait``
  Wait for the cluster creation to complete

.. _openstack_dataprocessing_cluster_delete:

openstack dataprocessing cluster delete
---------------------------------------

.. code-block:: console

   usage: openstack dataprocessing cluster delete [-h] [--wait]
                                                  <cluster> [<cluster> ...]

Deletes cluster

**Positional arguments:**

``<cluster>``
  Name(s) or id(s) of the cluster(s) to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--wait``
  Wait for the cluster(s) delete to complete

.. _openstack_dataprocessing_cluster_list:

openstack dataprocessing cluster list
-------------------------------------

.. code-block:: console

   usage: openstack dataprocessing cluster list [-h]
                                                [-f {csv,html,json,table,value,yaml}]
                                                [-c COLUMN]
                                                [--max-width <integer>]
                                                [--noindent]
                                                [--quote {all,minimal,none,nonnumeric}]
                                                [--long] [--plugin <plugin>]
                                                [--plugin-version <plugin_version>]
                                                [--name <name-substring>]

Lists clusters

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--long``
  List additional fields in output

``--plugin <plugin>``
  List clusters with specific plugin

``--plugin-version <plugin_version>``
  List clusters with specific version of the plugin

``--name <name-substring>``
  List clusters with specific substring in the name

.. _openstack_dataprocessing_cluster_scale:

openstack dataprocessing cluster scale
--------------------------------------

.. code-block:: console

   usage: openstack dataprocessing cluster scale [-h]
                                                 [-f {html,json,shell,table,value,yaml}]
                                                 [-c COLUMN]
                                                 [--max-width <integer>]
                                                 [--noindent] [--prefix PREFIX]
                                                 [--instances <node-group-template:instances_count> [<node-group-template:instances_count> ...]]
                                                 [--json <filename>] [--wait]
                                                 <cluster>

Scales cluster

**Positional arguments:**

``<cluster>``
  Name or ID of the cluster

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--instances <node-group-template:instances_count> [<node-group-template:instances_count> ...]``
  Node group templates and number of their instances to
  be scale to [REQUIRED if JSON is not provided]

``--json <filename>``
  JSON representation of the cluster scale object. Other
  arguments (except for :option:`--wait)` will not be taken into
  account if this one is provided

``--wait``
  Wait for the cluster scale to complete

.. _openstack_dataprocessing_cluster_show:

openstack dataprocessing cluster show
-------------------------------------

.. code-block:: console

   usage: openstack dataprocessing cluster show [-h]
                                                [-f {html,json,shell,table,value,yaml}]
                                                [-c COLUMN]
                                                [--max-width <integer>]
                                                [--noindent] [--prefix PREFIX]
                                                [--verification]
                                                [--show-progress]
                                                [--full-dump-events]
                                                <cluster>

Display cluster details

**Positional arguments:**

``<cluster>``
  Name or id of the cluster to display

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--verification``
  List additional fields for verifications

``--show-progress``
  Provides ability to show brief details of event logs.

``--full-dump-events``
  Provides ability to make full dump with event log
  details.

.. _openstack_dataprocessing_cluster_template_create:

openstack dataprocessing cluster template create
------------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing cluster template create [-h]
                                                           [-f {html,json,shell,table,value,yaml}]
                                                           [-c COLUMN]
                                                           [--max-width <integer>]
                                                           [--noindent]
                                                           [--prefix PREFIX]
                                                           [--name <name>]
                                                           [--node-groups <node-group:instances_count> [<node-group:instances_count> ...]]
                                                           [--anti-affinity <anti-affinity> [<anti-affinity> ...]]
                                                           [--description <description>]
                                                           [--autoconfig]
                                                           [--public]
                                                           [--protected]
                                                           [--json <filename>]
                                                           [--shares <filename>]
                                                           [--configs <filename>]
                                                           [--domain-name <domain-name>]

Creates cluster template

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  Name of the cluster template [REQUIRED if JSON is not
  provided]

``--node-groups <node-group:instances_count> [<node-group:instances_count> ...]``
  List of the node groups(names or IDs) and numbers of
  instances for each one of them [REQUIRED if JSON is
  not provided]

``--anti-affinity <anti-affinity> [<anti-affinity> ...]``
  List of processes that should be added to an anti-affinity group

``--description <description>``
  Description of the cluster template

``--autoconfig``
  If enabled, instances of the cluster will be
  automatically configured

``--public``
  Make the cluster template public (Visible from other
  tenants)

``--protected``
  Make the cluster template protected

``--json <filename>``
  JSON representation of the cluster template. Other
  arguments will not be taken into account if this one
  is provided

``--shares <filename>``
  JSON representation of the manila shares

``--configs <filename>``
  JSON representation of the cluster template configs

``--domain-name <domain-name>``
  Domain name for instances of this cluster template.
  This option is available if 'use_designate' config is
  True

.. _openstack_dataprocessing_cluster_template_delete:

openstack dataprocessing cluster template delete
------------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing cluster template delete [-h]
                                                           <cluster-template>
                                                           [<cluster-template> ...]

Deletes cluster template

**Positional arguments:**

``<cluster-template>``
  Name(s) or id(s) of the cluster template(s) to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_dataprocessing_cluster_template_list:

openstack dataprocessing cluster template list
----------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing cluster template list [-h]
                                                         [-f {csv,html,json,table,value,yaml}]
                                                         [-c COLUMN]
                                                         [--max-width <integer>]
                                                         [--noindent]
                                                         [--quote {all,minimal,none,nonnumeric}]
                                                         [--long]
                                                         [--plugin <plugin>]
                                                         [--plugin-version <plugin_version>]
                                                         [--name <name-substring>]

Lists cluster templates

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--long``
  List additional fields in output

``--plugin <plugin>``
  List cluster templates for specific plugin

``--plugin-version <plugin_version>``
  List cluster templates with specific version of the
  plugin

``--name <name-substring>``
  List cluster templates with specific substring in the
  name

.. _openstack_dataprocessing_cluster_template_show:

openstack dataprocessing cluster template show
----------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing cluster template show [-h]
                                                         [-f {html,json,shell,table,value,yaml}]
                                                         [-c COLUMN]
                                                         [--max-width <integer>]
                                                         [--noindent]
                                                         [--prefix PREFIX]
                                                         <cluster-template>

Display cluster template details

**Positional arguments:**

``<cluster-template>``
  Name or id of the cluster template to display

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_dataprocessing_cluster_template_update:

openstack dataprocessing cluster template update
------------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing cluster template update [-h]
                                                           [-f {html,json,shell,table,value,yaml}]
                                                           [-c COLUMN]
                                                           [--max-width <integer>]
                                                           [--noindent]
                                                           [--prefix PREFIX]
                                                           [--name <name>]
                                                           [--node-groups <node-group:instances_count> [<node-group:instances_count> ...]]
                                                           [--anti-affinity <anti-affinity> [<anti-affinity> ...]]
                                                           [--description <description>]
                                                           [--autoconfig-enable | --autoconfig-disable]
                                                           [--public | --private]
                                                           [--protected | --unprotected]
                                                           [--json <filename>]
                                                           [--shares <filename>]
                                                           [--configs <filename>]
                                                           [--domain-name <domain-name>]
                                                           <cluster-template>

Updates cluster template

**Positional arguments:**

``<cluster-template>``
  Name or ID of the cluster template [REQUIRED]

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  New name of the cluster template

``--node-groups <node-group:instances_count> [<node-group:instances_count> ...]``
  List of the node groups(names or IDs) and numbers
  ofinstances for each one of them

``--anti-affinity <anti-affinity> [<anti-affinity> ...]``
  List of processes that should be added to an anti-affinity group

``--description <description>``
  Description of the cluster template

``--autoconfig-enable``
  Instances of the cluster will be automatically
  configured

``--autoconfig-disable``
  Instances of the cluster will not be automatically
  configured

``--public``
  Make the cluster template public (Visible from other
  tenants)

``--private``
  Make the cluster template private (Visible only from
  this tenant)

``--protected``
  Make the cluster template protected

``--unprotected``
  Make the cluster template unprotected

``--json <filename>``
  JSON representation of the cluster template. Other
  arguments will not be taken into account if this one
  is provided

``--shares <filename>``
  JSON representation of the manila shares

``--configs <filename>``
  JSON representation of the cluster template configs

``--domain-name <domain-name>``
  Domain name for instances of this cluster template.
  This option is available if 'use_designate' config is
  True

.. _openstack_dataprocessing_cluster_update:

openstack dataprocessing cluster update
---------------------------------------

.. code-block:: console

   usage: openstack dataprocessing cluster update [-h]
                                                  [-f {html,json,shell,table,value,yaml}]
                                                  [-c COLUMN]
                                                  [--max-width <integer>]
                                                  [--noindent] [--prefix PREFIX]
                                                  [--name <name>]
                                                  [--description <description>]
                                                  [--shares <filename>]
                                                  [--public | --private]
                                                  [--protected | --unprotected]
                                                  <cluster>

Updates cluster

**Positional arguments:**

``<cluster>``
  Name or ID of the cluster

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  New name of the cluster

``--description <description>``
  Description of the cluster

``--shares <filename>``
  JSON representation of the manila shares

``--public``
  Make the cluster public (Visible from other tenants)

``--private``
  Make the cluster private (Visible only from this
  tenant)

``--protected``
  Make the cluster protected

``--unprotected``
  Make the cluster unprotected

.. _openstack_dataprocessing_cluster_verification:

openstack dataprocessing cluster verification
---------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing cluster verification [-h]
                                                        [-f {html,json,shell,table,value,yaml}]
                                                        [-c COLUMN]
                                                        [--max-width <integer>]
                                                        [--noindent]
                                                        [--prefix PREFIX]
                                                        (--start | --show)
                                                        <cluster>

Updates cluster verifications

**Positional arguments:**

``<cluster>``
  Name or ID of the cluster

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--start``
  Start health verification for the cluster

``--show``
  Show health of the cluster

.. _openstack_dataprocessing_data_source_create:

openstack dataprocessing data source create
-------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing data source create [-h]
                                                      [-f {html,json,shell,table,value,yaml}]
                                                      [-c COLUMN]
                                                      [--max-width <integer>]
                                                      [--noindent]
                                                      [--prefix PREFIX] --type
                                                      <type> --url <url>
                                                      [--username <username>]
                                                      [--password <password>]
                                                      [--description <description>]
                                                      [--public] [--protected]
                                                      <name>

Creates data source

**Positional arguments:**

``<name>``
  Name of the data source

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--type <type>``
  Type of the data source (swift, hdfs, maprfs, manila)
  [REQUIRED]

``--url <url>``
  Url for the data source [REQUIRED]

``--username <username>``
  Username for accessing the data source url

``--password <password>``
  Password for accessing the data source url

``--description <description>``
  Description of the data source

``--public``
  Make the data source public

``--protected``
  Make the data source protected

.. _openstack_dataprocessing_data_source_delete:

openstack dataprocessing data source delete
-------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing data source delete [-h]
                                                      <data-source>
                                                      [<data-source> ...]

Delete data source

**Positional arguments:**

``<data-source>``
  Name(s) or id(s) of the data source(s) to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_dataprocessing_data_source_list:

openstack dataprocessing data source list
-----------------------------------------

.. code-block:: console

   usage: openstack dataprocessing data source list [-h]
                                                    [-f {csv,html,json,table,value,yaml}]
                                                    [-c COLUMN]
                                                    [--max-width <integer>]
                                                    [--noindent]
                                                    [--quote {all,minimal,none,nonnumeric}]
                                                    [--long] [--type <type>]

Lists data sources

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--long``
  List additional fields in output

``--type <type>``
  List data sources of specific type (swift, hdfs,
  maprfs, manila)

.. _openstack_dataprocessing_data_source_show:

openstack dataprocessing data source show
-----------------------------------------

.. code-block:: console

   usage: openstack dataprocessing data source show [-h]
                                                    [-f {html,json,shell,table,value,yaml}]
                                                    [-c COLUMN]
                                                    [--max-width <integer>]
                                                    [--noindent]
                                                    [--prefix PREFIX]
                                                    <data-source>

Display data source details

**Positional arguments:**

``<data-source>``
  Name or id of the data source to display

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_dataprocessing_data_source_update:

openstack dataprocessing data source update
-------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing data source update [-h]
                                                      [-f {html,json,shell,table,value,yaml}]
                                                      [-c COLUMN]
                                                      [--max-width <integer>]
                                                      [--noindent]
                                                      [--prefix PREFIX]
                                                      [--name <name>]
                                                      [--type <type>]
                                                      [--url <url>]
                                                      [--username <username>]
                                                      [--password <password>]
                                                      [--description <description>]
                                                      [--public | --private]
                                                      [--protected | --unprotected]
                                                      <data-source>

Update data source

**Positional arguments:**

``<data-source>``
  Name or id of the data source

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  New name of the data source

``--type <type>``
  Type of the data source (swift, hdfs, maprfs, manila)

``--url <url>``
  Url for the data source

``--username <username>``
  Username for accessing the data source url

``--password <password>``
  Password for accessing the data source url

``--description <description>``
  Description of the data source

``--public``
  Make the data source public (Visible from other
  tenants)

``--private``
  Make the data source private (Visible only from this
  tenant)

``--protected``
  Make the data source protected

``--unprotected``
  Make the data source unprotected

.. _openstack_dataprocessing_image_list:

openstack dataprocessing image list
-----------------------------------

.. code-block:: console

   usage: openstack dataprocessing image list [-h]
                                              [-f {csv,html,json,table,value,yaml}]
                                              [-c COLUMN] [--max-width <integer>]
                                              [--noindent]
                                              [--quote {all,minimal,none,nonnumeric}]
                                              [--long] [--name <name-regex>]
                                              [--tags <tag> [<tag> ...]]
                                              [--username <username>]

Lists registered images

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--long``
  List additional fields in output

``--name <name-regex>``
  Regular expression to match image name

``--tags <tag> [<tag> ...]``
  List images with specific tag(s)

``--username <username>``
  List images with specific username

.. _openstack_dataprocessing_image_register:

openstack dataprocessing image register
---------------------------------------

.. code-block:: console

   usage: openstack dataprocessing image register [-h]
                                                  [-f {html,json,shell,table,value,yaml}]
                                                  [-c COLUMN]
                                                  [--max-width <integer>]
                                                  [--noindent] [--prefix PREFIX]
                                                  --username <username>
                                                  [--description <description>]
                                                  <image>

Register an image

**Positional arguments:**

``<image>``
  Name or ID of the image to register

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--username <username>``
  Username of privileged user in the image [REQUIRED]

``--description <description>``
  Description of the image. If not provided, description
  of the image will be reset to empty

.. _openstack_dataprocessing_image_show:

openstack dataprocessing image show
-----------------------------------

.. code-block:: console

   usage: openstack dataprocessing image show [-h]
                                              [-f {html,json,shell,table,value,yaml}]
                                              [-c COLUMN] [--max-width <integer>]
                                              [--noindent] [--prefix PREFIX]
                                              <image>

Display image details

**Positional arguments:**

``<image>``
  Name or id of the image to display

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_dataprocessing_image_tags_add:

openstack dataprocessing image tags add
---------------------------------------

.. code-block:: console

   usage: openstack dataprocessing image tags add [-h]
                                                  [-f {html,json,shell,table,value,yaml}]
                                                  [-c COLUMN]
                                                  [--max-width <integer>]
                                                  [--noindent] [--prefix PREFIX]
                                                  --tags <tag> [<tag> ...]
                                                  <image>

Add image tags

**Positional arguments:**

``<image>``
  Name or id of the image

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--tags <tag> [<tag> ...]``
  Tag(s) to add [REQUIRED]

.. _openstack_dataprocessing_image_tags_remove:

openstack dataprocessing image tags remove
------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing image tags remove [-h]
                                                     [-f {html,json,shell,table,value,yaml}]
                                                     [-c COLUMN]
                                                     [--max-width <integer>]
                                                     [--noindent]
                                                     [--prefix PREFIX]
                                                     [--tags <tag> [<tag> ...] |
                                                     --all]
                                                     <image>

Remove image tags

**Positional arguments:**

``<image>``
  Name or id of the image

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--tags <tag> [<tag> ...]``
  Tag(s) to remove

``--all``
  Remove all tags from image

.. _openstack_dataprocessing_image_tags_set:

openstack dataprocessing image tags set
---------------------------------------

.. code-block:: console

   usage: openstack dataprocessing image tags set [-h]
                                                  [-f {html,json,shell,table,value,yaml}]
                                                  [-c COLUMN]
                                                  [--max-width <integer>]
                                                  [--noindent] [--prefix PREFIX]
                                                  --tags <tag> [<tag> ...]
                                                  <image>

Set image tags (Replace current image tags with provided ones)

**Positional arguments:**

``<image>``
  Name or id of the image

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--tags <tag> [<tag> ...]``
  Tag(s) to set [REQUIRED]

.. _openstack_dataprocessing_image_unregister:

openstack dataprocessing image unregister
-----------------------------------------

.. code-block:: console

   usage: openstack dataprocessing image unregister [-h] <image> [<image> ...]

Unregister image(s)

**Positional arguments:**

``<image>``
  Name(s) or id(s) of the image(s) to unregister

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_dataprocessing_job_binary_create:

openstack dataprocessing job binary create
------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing job binary create [-h]
                                                     [-f {html,json,shell,table,value,yaml}]
                                                     [-c COLUMN]
                                                     [--max-width <integer>]
                                                     [--noindent]
                                                     [--prefix PREFIX]
                                                     [--name <name>]
                                                     [--data <file> | --url <url>]
                                                     [--description <description>]
                                                     [--username <username>]
                                                     [--password <password> | --password-prompt]
                                                     [--public] [--protected]
                                                     [--json <filename>]

Creates job binary

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  Name of the job binary [REQUIRED if JSON is not
  provided]

``--data <file>``
  File that will be stored in the internal DB [REQUIRED
  if JSON and URL are not provided]

``--url <url>``
  URL for the job binary [REQUIRED if JSON and file are
  not provided]

``--description <description>``
  Description of the job binary

``--username <username>``
  Username for accessing the job binary URL

``--password <password>``
  Password for accessing the job binary URL

``--password-prompt``
  Prompt interactively for password

``--public``
  Make the job binary public

``--protected``
  Make the job binary protected

``--json <filename>``
  JSON representation of the job binary. Other arguments
  will not be taken into account if this one is provided

.. _openstack_dataprocessing_job_binary_delete:

openstack dataprocessing job binary delete
------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing job binary delete [-h]
                                                     <job-binary>
                                                     [<job-binary> ...]

Deletes job binary

**Positional arguments:**

``<job-binary>``
  Name(s) or id(s) of the job binary(ies) to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_dataprocessing_job_binary_download:

openstack dataprocessing job binary download
--------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing job binary download [-h] [--file <file>]
                                                       <job-binary>

Downloads job binary

**Positional arguments:**

``<job-binary>``
  Name or ID of the job binary to download

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--file <file>``
  Destination file (defaults to job binary name)

.. _openstack_dataprocessing_job_binary_list:

openstack dataprocessing job binary list
----------------------------------------

.. code-block:: console

   usage: openstack dataprocessing job binary list [-h]
                                                   [-f {csv,html,json,table,value,yaml}]
                                                   [-c COLUMN]
                                                   [--max-width <integer>]
                                                   [--noindent]
                                                   [--quote {all,minimal,none,nonnumeric}]
                                                   [--long]
                                                   [--name <name-substring>]

Lists job binaries

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--long``
  List additional fields in output

``--name <name-substring>``
  List job binaries with specific substring in the name

.. _openstack_dataprocessing_job_binary_show:

openstack dataprocessing job binary show
----------------------------------------

.. code-block:: console

   usage: openstack dataprocessing job binary show [-h]
                                                   [-f {html,json,shell,table,value,yaml}]
                                                   [-c COLUMN]
                                                   [--max-width <integer>]
                                                   [--noindent] [--prefix PREFIX]
                                                   <job-binary>

Display job binary details

**Positional arguments:**

``<job-binary>``
  Name or ID of the job binary to display

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_dataprocessing_job_binary_update:

openstack dataprocessing job binary update
------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing job binary update [-h]
                                                     [-f {html,json,shell,table,value,yaml}]
                                                     [-c COLUMN]
                                                     [--max-width <integer>]
                                                     [--noindent]
                                                     [--prefix PREFIX]
                                                     [--name <name>]
                                                     [--url <url>]
                                                     [--description <description>]
                                                     [--username <username>]
                                                     [--password <password> | --password-prompt]
                                                     [--public | --private]
                                                     [--protected | --unprotected]
                                                     [--json <filename>]
                                                     <job-binary>

Updates job binary

**Positional arguments:**

``<job-binary>``
  Name or ID of the job binary

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  New name of the job binary

``--url <url>``
  URL for the job binary [Internal DB URL can not be
  updated]

``--description <description>``
  Description of the job binary

``--username <username>``
  Username for accessing the job binary URL

``--password <password>``
  Password for accessing the job binary URL

``--password-prompt``
  Prompt interactively for password

``--public``
  Make the job binary public (Visible from other
  tenants)

``--private``
  Make the job binary private (Visible only from this
  tenant)

``--protected``
  Make the job binary protected

``--unprotected``
  Make the job binary unprotected

``--json <filename>``
  JSON representation of the update object. Other
  arguments will not be taken into account if this one
  is provided

.. _openstack_dataprocessing_job_delete:

openstack dataprocessing job delete
-----------------------------------

.. code-block:: console

   usage: openstack dataprocessing job delete [-h] [--wait] <job> [<job> ...]

Deletes job

**Positional arguments:**

``<job>``
  ID(s) of the job(s) to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--wait``
  Wait for the job(s) delete to complete

.. _openstack_dataprocessing_job_execute:

openstack dataprocessing job execute
------------------------------------

.. code-block:: console

   usage: openstack dataprocessing job execute [-h]
                                               [-f {html,json,shell,table,value,yaml}]
                                               [-c COLUMN]
                                               [--max-width <integer>]
                                               [--noindent] [--prefix PREFIX]
                                               [--job-template <job-template>]
                                               [--cluster <cluster>]
                                               [--input <input>]
                                               [--output <output>]
                                               [--params <name:value> [<name:value> ...]]
                                               [--args <argument> [<argument> ...]]
                                               [--public] [--protected]
                                               [--config-json <filename> | --configs <name:value> [<name:value> ...]]
                                               [--interface <filename>]
                                               [--json <filename>]

Executes job

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--job-template <job-template>``
  Name or ID of the job template [REQUIRED if JSON is
  not provided]

``--cluster <cluster>``
  Name or ID of the cluster [REQUIRED if JSON is not
  provided]

``--input <input>``
  Name or ID of the input data source

``--output <output>``
  Name or ID of the output data source

``--params <name:value> [<name:value> ...]``
  Parameters to add to the job

``--args <argument> [<argument> ...]``
  Arguments to add to the job

``--public``
  Make the job public

``--protected``
  Make the job protected

``--config-json <filename>``
  JSON representation of the job configs

``--configs <name:value> [<name:value> ...]``
  Configs to add to the job

``--interface <filename>``
  JSON representation of the interface

``--json <filename>``
  JSON representation of the job. Other arguments will
  not be taken into account if this one is provided

.. _openstack_dataprocessing_job_list:

openstack dataprocessing job list
---------------------------------

.. code-block:: console

   usage: openstack dataprocessing job list [-h]
                                            [-f {csv,html,json,table,value,yaml}]
                                            [-c COLUMN] [--max-width <integer>]
                                            [--noindent]
                                            [--quote {all,minimal,none,nonnumeric}]
                                            [--long] [--status <status>]

Lists jobs

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--long``
  List additional fields in output

``--status <status>``
  List jobs with specific status

.. _openstack_dataprocessing_job_show:

openstack dataprocessing job show
---------------------------------

.. code-block:: console

   usage: openstack dataprocessing job show [-h]
                                            [-f {html,json,shell,table,value,yaml}]
                                            [-c COLUMN] [--max-width <integer>]
                                            [--noindent] [--prefix PREFIX]
                                            <job>

Display job details

**Positional arguments:**

``<job>``
  ID of the job to display

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_dataprocessing_job_template_create:

openstack dataprocessing job template create
--------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing job template create [-h]
                                                       [-f {html,json,shell,table,value,yaml}]
                                                       [-c COLUMN]
                                                       [--max-width <integer>]
                                                       [--noindent]
                                                       [--prefix PREFIX]
                                                       [--name <name>]
                                                       [--type <type>]
                                                       [--mains <main> [<main> ...]]
                                                       [--libs <lib> [<lib> ...]]
                                                       [--description <description>]
                                                       [--public] [--protected]
                                                       [--interface <filename>]
                                                       [--json <filename>]

Creates job template

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  Name of the job template [REQUIRED if JSON is not
  provided]

``--type <type>``
  Type of the job (Hive, Java, MapReduce, Storm,
  Storm.Pyleus, Pig, Shell, MapReduce.Streaming, Spark)
  [REQUIRED if JSON is not provided]

``--mains <main> [<main> ...]``
  Name(s) or ID(s) for job's main job binary(s)

``--libs <lib> [<lib> ...]``
  Name(s) or ID(s) for job's lib job binary(s)

``--description <description>``
  Description of the job template

``--public``
  Make the job template public

``--protected``
  Make the job template protected

``--interface <filename>``
  JSON representation of the interface

``--json <filename>``
  JSON representation of the job template

.. _openstack_dataprocessing_job_template_delete:

openstack dataprocessing job template delete
--------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing job template delete [-h]
                                                       <job-template>
                                                       [<job-template> ...]

Deletes job template

**Positional arguments:**

``<job-template>``
  Name(s) or id(s) of the job template(s) to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_dataprocessing_job_template_list:

openstack dataprocessing job template list
------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing job template list [-h]
                                                     [-f {csv,html,json,table,value,yaml}]
                                                     [-c COLUMN]
                                                     [--max-width <integer>]
                                                     [--noindent]
                                                     [--quote {all,minimal,none,nonnumeric}]
                                                     [--long] [--type <type>]
                                                     [--name <name-substring>]

Lists job templates

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--long``
  List additional fields in output

``--type <type>``
  List job templates of specific type

``--name <name-substring>``
  List job templates with specific substring in the name

.. _openstack_dataprocessing_job_template_show:

openstack dataprocessing job template show
------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing job template show [-h]
                                                     [-f {html,json,shell,table,value,yaml}]
                                                     [-c COLUMN]
                                                     [--max-width <integer>]
                                                     [--noindent]
                                                     [--prefix PREFIX]
                                                     <job-template>

Display job template details

**Positional arguments:**

``<job-template>``
  Name or ID of the job template to display

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_dataprocessing_job_template_update:

openstack dataprocessing job template update
--------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing job template update [-h]
                                                       [-f {html,json,shell,table,value,yaml}]
                                                       [-c COLUMN]
                                                       [--max-width <integer>]
                                                       [--noindent]
                                                       [--prefix PREFIX]
                                                       [--name <name>]
                                                       [--description <description>]
                                                       [--public | --private]
                                                       [--protected | --unprotected]
                                                       <job-template>

Updates job template

**Positional arguments:**

``<job-template>``
  Name or ID of the job template

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  New name of the job template

``--description <description>``
  Description of the job template

``--public``
  Make the job template public (Visible from other
  tenants)

``--private``
  Make the job_template private (Visible only from this
  tenant)

``--protected``
  Make the job template protected

``--unprotected``
  Make the job template unprotected

.. _openstack_dataprocessing_job_type_configs_get:

openstack dataprocessing job type configs get
---------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing job type configs get [-h] [--file <file>]
                                                        <job-type>

Get job type configs

**Positional arguments:**

``<job-type>``
  Type of the job to provide config information about

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--file <file>``
  Destination file (defaults to job type)

.. _openstack_dataprocessing_job_type_list:

openstack dataprocessing job type list
--------------------------------------

.. code-block:: console

   usage: openstack dataprocessing job type list [-h]
                                                 [-f {csv,html,json,table,value,yaml}]
                                                 [-c COLUMN]
                                                 [--max-width <integer>]
                                                 [--noindent]
                                                 [--quote {all,minimal,none,nonnumeric}]
                                                 [--type <type>]
                                                 [--plugin <plugin>]
                                                 [--plugin-version <plugin_version>]

Lists job types supported by plugins

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--type <type>``
  Get information about specific job type

``--plugin <plugin>``
  Get only job types supported by this plugin

``--plugin-version <plugin_version>``
  Get only job types supported by specific version of
  the plugin. This parameter will be taken into account
  only if plugin is provided

.. _openstack_dataprocessing_job_update:

openstack dataprocessing job update
-----------------------------------

.. code-block:: console

   usage: openstack dataprocessing job update [-h]
                                              [-f {html,json,shell,table,value,yaml}]
                                              [-c COLUMN] [--max-width <integer>]
                                              [--noindent] [--prefix PREFIX]
                                              [--public | --private]
                                              [--protected | --unprotected]
                                              <job>

Updates job

**Positional arguments:**

``<job>``
  ID of the job to update

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--public``
  Make the job public (Visible from other tenants)

``--private``
  Make the job private (Visible only from this tenant)

``--protected``
  Make the job protected

``--unprotected``
  Make the job unprotected

.. _openstack_dataprocessing_node_group_template_create:

openstack dataprocessing node group template create
---------------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing node group template create [-h]
                                                              [-f {html,json,shell,table,value,yaml}]
                                                              [-c COLUMN]
                                                              [--max-width <integer>]
                                                              [--noindent]
                                                              [--prefix PREFIX]
                                                              [--name <name>]
                                                              [--plugin <plugin>]
                                                              [--plugin-version <plugin_version>]
                                                              [--processes <processes> [<processes> ...]]
                                                              [--flavor <flavor>]
                                                              [--security-groups <security-groups> [<security-groups> ...]]
                                                              [--auto-security-group]
                                                              [--availability-zone <availability-zone>]
                                                              [--floating-ip-pool <floating-ip-pool>]
                                                              [--volumes-per-node <volumes-per-node>]
                                                              [--volumes-size <volumes-size>]
                                                              [--volumes-type <volumes-type>]
                                                              [--volumes-availability-zone <volumes-availability-zone>]
                                                              [--volumes-mount-prefix <volumes-mount-prefix>]
                                                              [--volumes-locality]
                                                              [--description <description>]
                                                              [--autoconfig]
                                                              [--proxy-gateway]
                                                              [--public]
                                                              [--protected]
                                                              [--json <filename>]
                                                              [--shares <filename>]
                                                              [--configs <filename>]

Creates node group template

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  Name of the node group template [REQUIRED if JSON is
  not provided]

``--plugin <plugin>``
  Name of the plugin [REQUIRED if JSON is not provided]

``--plugin-version <plugin_version>``
  Version of the plugin [REQUIRED if JSON is not
  provided]

``--processes <processes> [<processes> ...]``
  List of the processes that will be launched on each
  instance [REQUIRED if JSON is not provided]

``--flavor <flavor>``
  Name or ID of the flavor [REQUIRED if JSON is not
  provided]

``--security-groups <security-groups> [<security-groups> ...]``
  List of the security groups for the instances in this
  node group

``--auto-security-group``
  Indicates if an additional security group should be
  created for the node group

``--availability-zone <availability-zone>``
  Name of the availability zone where instances will be
  created

``--floating-ip-pool <floating-ip-pool>``
  ID of the floating IP pool

``--volumes-per-node <volumes-per-node>``
  Number of volumes attached to every node

``--volumes-size <volumes-size>``
  Size of volumes attached to node (GB). This parameter
  will be taken into account only if volumes-per-node is
  set and non-zero

``--volumes-type <volumes-type>``
  Type of the volumes. This parameter will be taken into
  account only if volumes-per-node is set and non-zero

``--volumes-availability-zone <volumes-availability-zone>``
  Name of the availability zone where volumes will be
  created. This parameter will be taken into account
  only if volumes-per-node is set and non-zero

``--volumes-mount-prefix <volumes-mount-prefix>``
  Prefix for mount point directory. This parameter will
  be taken into account only if volumes-per-node is set
  and non-zero

``--volumes-locality``
  If enabled, instance and attached volumes will be
  created on the same physical host. This parameter will
  be taken into account only if volumes-per-node is set
  and non-zero

``--description <description>``
  Description of the node group template

``--autoconfig``
  If enabled, instances of the node group will be
  automatically configured

``--proxy-gateway``
  If enabled, instances of the node group will be used
  to access other instances in the cluster

``--public``
  Make the node group template public (Visible from
  other tenants)

``--protected``
  Make the node group template protected

``--json <filename>``
  JSON representation of the node group template. Other
  arguments will not be taken into account if this one
  is provided

``--shares <filename>``
  JSON representation of the manila shares

``--configs <filename>``
  JSON representation of the node group template configs

.. _openstack_dataprocessing_node_group_template_delete:

openstack dataprocessing node group template delete
---------------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing node group template delete [-h]
                                                              <node-group-template>
                                                              [<node-group-template> ...]

Deletes node group template

**Positional arguments:**

``<node-group-template>``
  Name(s) or id(s) of the node group template(s) to
  delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_dataprocessing_node_group_template_list:

openstack dataprocessing node group template list
-------------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing node group template list [-h]
                                                            [-f {csv,html,json,table,value,yaml}]
                                                            [-c COLUMN]
                                                            [--max-width <integer>]
                                                            [--noindent]
                                                            [--quote {all,minimal,none,nonnumeric}]
                                                            [--long]
                                                            [--plugin <plugin>]
                                                            [--plugin-version <plugin_version>]
                                                            [--name <name-substring>]

Lists node group templates

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--long``
  List additional fields in output

``--plugin <plugin>``
  List node group templates for specific plugin

``--plugin-version <plugin_version>``
  List node group templates with specific version of the
  plugin

``--name <name-substring>``
  List node group templates with specific substring in
  the name

.. _openstack_dataprocessing_node_group_template_show:

openstack dataprocessing node group template show
-------------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing node group template show [-h]
                                                            [-f {html,json,shell,table,value,yaml}]
                                                            [-c COLUMN]
                                                            [--max-width <integer>]
                                                            [--noindent]
                                                            [--prefix PREFIX]
                                                            <node-group-template>

Display node group template details

**Positional arguments:**

``<node-group-template>``
  Name or id of the node group template to display

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_dataprocessing_node_group_template_update:

openstack dataprocessing node group template update
---------------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing node group template update [-h]
                                                              [-f {html,json,shell,table,value,yaml}]
                                                              [-c COLUMN]
                                                              [--max-width <integer>]
                                                              [--noindent]
                                                              [--prefix PREFIX]
                                                              [--name <name>]
                                                              [--plugin <plugin>]
                                                              [--plugin-version <plugin_version>]
                                                              [--processes <processes> [<processes> ...]]
                                                              [--security-groups <security-groups> [<security-groups> ...]]
                                                              [--auto-security-group-enable | --auto-security-group-disable]
                                                              [--availability-zone <availability-zone>]
                                                              [--flavor <flavor>]
                                                              [--floating-ip-pool <floating-ip-pool>]
                                                              [--volumes-per-node <volumes-per-node>]
                                                              [--volumes-size <volumes-size>]
                                                              [--volumes-type <volumes-type>]
                                                              [--volumes-availability-zone <volumes-availability-zone>]
                                                              [--volumes-mount-prefix <volumes-mount-prefix>]
                                                              [--volumes-locality-enable | --volumes-locality-disable]
                                                              [--description <description>]
                                                              [--autoconfig-enable | --autoconfig-disable]
                                                              [--proxy-gateway-enable | --proxy-gateway-disable]
                                                              [--public | --private]
                                                              [--protected | --unprotected]
                                                              [--json <filename>]
                                                              [--shares <filename>]
                                                              [--configs <filename>]
                                                              <node-group-template>

Updates node group template

**Positional arguments:**

``<node-group-template>``
  Name or ID of the node group template

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  New name of the node group template

``--plugin <plugin>``
  Name of the plugin

``--plugin-version <plugin_version>``
  Version of the plugin

``--processes <processes> [<processes> ...]``
  List of the processes that will be launched on each
  instance

``--security-groups <security-groups> [<security-groups> ...]``
  List of the security groups for the instances in this
  node group

``--auto-security-group-enable``
  Additional security group should be created for the
  node group

``--auto-security-group-disable``
  Additional security group should not be created for
  the node group

``--availability-zone <availability-zone>``
  Name of the availability zone where instances will be
  created

``--flavor <flavor>``
  Name or ID of the flavor

``--floating-ip-pool <floating-ip-pool>``
  ID of the floating IP pool

``--volumes-per-node <volumes-per-node>``
  Number of volumes attached to every node

``--volumes-size <volumes-size>``
  Size of volumes attached to node (GB). This parameter
  will be taken into account only if volumes-per-node is
  set and non-zero

``--volumes-type <volumes-type>``
  Type of the volumes. This parameter will be taken into
  account only if volumes-per-node is set and non-zero

``--volumes-availability-zone <volumes-availability-zone>``
  Name of the availability zone where volumes will be
  created. This parameter will be taken into account
  only if volumes-per-node is set and non-zero

``--volumes-mount-prefix <volumes-mount-prefix>``
  Prefix for mount point directory. This parameter will
  be taken into account only if volumes-per-node is set
  and non-zero

``--volumes-locality-enable``
  Instance and attached volumes will be created on the
  same physical host. This parameter will be taken into
  account only if volumes-per-node is set and non-zero

``--volumes-locality-disable``
  Instance and attached volumes creation on the same
  physical host will not be regulated. This parameter
  will be takeninto account only if volumes-per-node is
  set and non-zero

``--description <description>``
  Description of the node group template

``--autoconfig-enable``
  Instances of the node group will be automatically
  configured

``--autoconfig-disable``
  Instances of the node group will not be automatically
  configured

``--proxy-gateway-enable``
  Instances of the node group will be used to access
  other instances in the cluster

``--proxy-gateway-disable``
  Instances of the node group will not be used to access
  other instances in the cluster

``--public``
  Make the node group template public (Visible from
  other tenants)

``--private``
  Make the node group template private (Visible only
  from this tenant)

``--protected``
  Make the node group template protected

``--unprotected``
  Make the node group template unprotected

``--json <filename>``
  JSON representation of the node group template update
  fields. Other arguments will not be taken into account
  if this one is provided

``--shares <filename>``
  JSON representation of the manila shares

``--configs <filename>``
  JSON representation of the node group template configs

.. _openstack_dataprocessing_plugin_configs_get:

openstack dataprocessing plugin configs get
-------------------------------------------

.. code-block:: console

   usage: openstack dataprocessing plugin configs get [-h] [--file <file>]
                                                      <plugin> <plugin_version>

Get plugin configs

**Positional arguments:**

``<plugin>``
  Name of the plugin to provide config information about

``<plugin_version>``
  Version of the plugin to provide config information about

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--file <file>``
  Destination file (defaults to plugin name)

.. _openstack_dataprocessing_plugin_list:

openstack dataprocessing plugin list
------------------------------------

.. code-block:: console

   usage: openstack dataprocessing plugin list [-h]
                                               [-f {csv,html,json,table,value,yaml}]
                                               [-c COLUMN]
                                               [--max-width <integer>]
                                               [--noindent]
                                               [--quote {all,minimal,none,nonnumeric}]
                                               [--long]

Lists plugins

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--long``
  List additional fields in output

.. _openstack_dataprocessing_plugin_show:

openstack dataprocessing plugin show
------------------------------------

.. code-block:: console

   usage: openstack dataprocessing plugin show [-h]
                                               [-f {html,json,shell,table,value,yaml}]
                                               [-c COLUMN]
                                               [--max-width <integer>]
                                               [--noindent] [--prefix PREFIX]
                                               [--plugin-version <plugin_version>]
                                               <plugin>

Display plugin details

**Positional arguments:**

``<plugin>``
  Name of the plugin to display

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--plugin-version <plugin_version>``
  Version of the plugin to display

.. _openstack_dataprocessing_plugin_update:

openstack dataprocessing plugin update
--------------------------------------

.. code-block:: console

   usage: openstack dataprocessing plugin update [-h]
                                                 [-f {html,json,shell,table,value,yaml}]
                                                 [-c COLUMN]
                                                 [--max-width <integer>]
                                                 [--noindent] [--prefix PREFIX]
                                                 <plugin> <json>


**Positional arguments:**

``<plugin>``
  Name of the plugin to provide config information about

``<json>``
  JSON representation of the plugin update dictionary

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_dns_quota_list:

openstack dns quota list
------------------------

.. code-block:: console

   usage: openstack dns quota list [-h] [-f {html,json,shell,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--noindent] [--prefix PREFIX]
                                   [--all-projects] [--edit-managed]
                                   [--sudo-project-id SUDO_PROJECT_ID]
                                   [--project-id PROJECT_ID]

List quotas

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

``--project-id PROJECT_ID``
  Project ID Default: current project

.. _openstack_dns_quota_reset:

openstack dns quota reset
-------------------------

.. code-block:: console

   usage: openstack dns quota reset [-h] [--all-projects] [--edit-managed]
                                    [--sudo-project-id SUDO_PROJECT_ID]
                                    [--project-id PROJECT_ID]

Delete blacklist

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

``--project-id PROJECT_ID``
  Project ID

.. _openstack_dns_quota_set:

openstack dns quota set
-----------------------

.. code-block:: console

   usage: openstack dns quota set [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--noindent] [--prefix PREFIX] [--all-projects]
                                  [--edit-managed]
                                  [--sudo-project-id SUDO_PROJECT_ID]
                                  [--project-id PROJECT_ID]
                                  [--api-export-size <api-export-size>]
                                  [--zones <zones>]
                                  [--recordset-records <recordset-records>]
                                  [--zone-records <zone-records>]
                                  [--zone-recordsets <zone-recordsets>]

Set blacklist properties

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

``--project-id PROJECT_ID``
  Project ID

``--api-export-size <api-export-size>``
  New value for the api-export-size quota

``--zones <zones>``
  New value for the zones quota

``--recordset-records <recordset-records>``
  New value for the recordset-records quota

``--zone-records <zone-records>``
  New value for the zone-records quota

``--zone-recordsets <zone-recordsets>``
  New value for the zone-recordsets quota

.. _openstack_dns_service_list:

openstack dns service list
--------------------------

.. code-block:: console

   usage: openstack dns service list [-h] [-f {csv,html,json,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--noindent]
                                     [--quote {all,minimal,none,nonnumeric}]
                                     [--hostname HOSTNAME]
                                     [--service_name SERVICE_NAME]
                                     [--status STATUS] [--all-projects]
                                     [--edit-managed]
                                     [--sudo-project-id SUDO_PROJECT_ID]

List service statuses

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--hostname HOSTNAME``
  Hostname

``--service_name SERVICE_NAME``
  Service Name

``--status STATUS``
  Status

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_dns_service_show:

openstack dns service show
--------------------------

.. code-block:: console

   usage: openstack dns service show [-h] [-f {html,json,shell,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--noindent] [--prefix PREFIX]
                                     [--all-projects] [--edit-managed]
                                     [--sudo-project-id SUDO_PROJECT_ID]
                                     id

Show service status details

**Positional arguments:**

``id``
  Service Status ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_domain_create:

openstack domain create
-----------------------

.. code-block:: console

   usage: openstack domain create [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--noindent] [--prefix PREFIX]
                                  [--description <description>]
                                  [--enable | --disable] [--or-show]
                                  <domain-name>

Create new domain

**Positional arguments:**

``<domain-name>``
  New domain name

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--description <description>``
  New domain description

``--enable``
  Enable domain (default)

``--disable``
  Disable domain

``--or-show``
  Return existing domain

.. _openstack_domain_delete:

openstack domain delete
-----------------------

.. code-block:: console

   usage: openstack domain delete [-h] <domain> [<domain> ...]

Delete domain(s)

**Positional arguments:**

``<domain>``
  Domain(s) to delete (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_domain_list:

openstack domain list
---------------------

.. code-block:: console

   usage: openstack domain list [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}]

List domains

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_domain_set:

openstack domain set
--------------------

.. code-block:: console

   usage: openstack domain set [-h] [--name <name>] [--description <description>]
                               [--enable | --disable]
                               <domain>

Set domain properties

**Positional arguments:**

``<domain>``
  Domain to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  New domain name

``--description <description>``
  New domain description

``--enable``
  Enable domain

``--disable``
  Disable domain

.. _openstack_domain_show:

openstack domain show
---------------------

.. code-block:: console

   usage: openstack domain show [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--prefix PREFIX]
                                <domain>

Display domain details

**Positional arguments:**

``<domain>``
  Domain to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_ec2_credentials_create:

openstack ec2 credentials create
--------------------------------

.. code-block:: console

   usage: openstack ec2 credentials create [-h]
                                           [-f {html,json,shell,table,value,yaml}]
                                           [-c COLUMN] [--max-width <integer>]
                                           [--noindent] [--prefix PREFIX]
                                           [--project <project>] [--user <user>]
                                           [--user-domain <user-domain>]
                                           [--project-domain <project-domain>]

Create EC2 credentials

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--project <project>``
  Create credentials in project (name or ID; default:
  current authenticated project)

``--user <user>``
  Create credentials for user (name or ID; default:
  current authenticated user)

``--user-domain <user-domain>``
  Domain the user belongs to (name or ID). This can be
  used in case collisions between user names exist.

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

.. _openstack_ec2_credentials_delete:

openstack ec2 credentials delete
--------------------------------

.. code-block:: console

   usage: openstack ec2 credentials delete [-h] [--user <user>]
                                           [--user-domain <user-domain>]
                                           <access-key> [<access-key> ...]

Delete EC2 credentials

**Positional arguments:**

``<access-key>``
  Credentials access key(s)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--user <user>``
  Delete credentials for user (name or ID)

``--user-domain <user-domain>``
  Domain the user belongs to (name or ID). This can be
  used in case collisions between user names exist.

.. _openstack_ec2_credentials_list:

openstack ec2 credentials list
------------------------------

.. code-block:: console

   usage: openstack ec2 credentials list [-h]
                                         [-f {csv,html,json,table,value,yaml}]
                                         [-c COLUMN] [--max-width <integer>]
                                         [--noindent]
                                         [--quote {all,minimal,none,nonnumeric}]
                                         [--user <user>]
                                         [--user-domain <user-domain>]

List EC2 credentials

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--user <user>``
  Filter list by user (name or ID)

``--user-domain <user-domain>``
  Domain the user belongs to (name or ID). This can be
  used in case collisions between user names exist.

.. _openstack_ec2_credentials_show:

openstack ec2 credentials show
------------------------------

.. code-block:: console

   usage: openstack ec2 credentials show [-h]
                                         [-f {html,json,shell,table,value,yaml}]
                                         [-c COLUMN] [--max-width <integer>]
                                         [--noindent] [--prefix PREFIX]
                                         [--user <user>]
                                         [--user-domain <user-domain>]
                                         <access-key>

Display EC2 credentials details

**Positional arguments:**

``<access-key>``
  Credentials access key

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--user <user>``
  Show credentials for user (name or ID)

``--user-domain <user-domain>``
  Domain the user belongs to (name or ID). This can be
  used in case collisions between user names exist.

.. _openstack_endpoint_create:

openstack endpoint create
-------------------------

.. code-block:: console

   usage: openstack endpoint create [-h] [-f {html,json,shell,table,value,yaml}]
                                    [-c COLUMN] [--max-width <integer>]
                                    [--noindent] [--prefix PREFIX]
                                    [--region <region-id>] [--enable | --disable]
                                    <service> <interface> <url>

Create new endpoint

**Positional arguments:**

``<service>``
  Service to be associated with new endpoint (name or
  ID)

``<interface>``
  New endpoint interface type (admin, public or
  internal)

``<url>``
  New endpoint URL

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--region <region-id>``
  New endpoint region ID

``--enable``
  Enable endpoint (default)

``--disable``
  Disable endpoint

.. _openstack_endpoint_delete:

openstack endpoint delete
-------------------------

.. code-block:: console

   usage: openstack endpoint delete [-h] <endpoint-id> [<endpoint-id> ...]

Delete endpoint(s)

**Positional arguments:**

``<endpoint-id>``
  Endpoint(s) to delete (ID only)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_endpoint_list:

openstack endpoint list
-----------------------

.. code-block:: console

   usage: openstack endpoint list [-h] [-f {csv,html,json,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--noindent]
                                  [--quote {all,minimal,none,nonnumeric}]
                                  [--service <service>] [--interface <interface>]
                                  [--region <region-id>]

List endpoints

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--service <service>``
  Filter by service (name or ID)

``--interface <interface>``
  Filter by interface type (admin, public or internal)

``--region <region-id>``
  Filter by region ID

.. _openstack_endpoint_set:

openstack endpoint set
----------------------

.. code-block:: console

   usage: openstack endpoint set [-h] [--region <region-id>]
                                 [--interface <interface>] [--url <url>]
                                 [--service <service>] [--enable | --disable]
                                 <endpoint-id>

Set endpoint properties

**Positional arguments:**

``<endpoint-id>``
  Endpoint to modify (ID only)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--region <region-id>``
  New endpoint region ID

``--interface <interface>``
  New endpoint interface type (admin, public or
  internal)

``--url <url>``
  New endpoint URL

``--service <service>``
  New endpoint service (name or ID)

``--enable``
  Enable endpoint

``--disable``
  Disable endpoint

.. _openstack_endpoint_show:

openstack endpoint show
-----------------------

.. code-block:: console

   usage: openstack endpoint show [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--noindent] [--prefix PREFIX]
                                  <endpoint>

Display endpoint details

**Positional arguments:**

``<endpoint>``
  Endpoint to display (endpoint ID, service ID, service
  name, service type)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_extension_list:

openstack extension list
------------------------

.. code-block:: console

   usage: openstack extension list [-h] [-f {csv,html,json,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--noindent]
                                   [--quote {all,minimal,none,nonnumeric}]
                                   [--compute] [--identity] [--network]
                                   [--volume] [--long]

List API extensions

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--compute``
  List extensions for the Compute API

``--identity``
  List extensions for the Identity API

``--network``
  List extensions for the Network API

``--volume``
  List extensions for the Block Storage API

``--long``
  List additional fields in output

.. _openstack_federation_domain_list:

openstack federation domain list
--------------------------------

.. code-block:: console

   usage: openstack federation domain list [-h]
                                           [-f {csv,html,json,table,value,yaml}]
                                           [-c COLUMN] [--max-width <integer>]
                                           [--noindent]
                                           [--quote {all,minimal,none,nonnumeric}]

List accessible domains

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_federation_project_list:

openstack federation project list
---------------------------------

.. code-block:: console

   usage: openstack federation project list [-h]
                                            [-f {csv,html,json,table,value,yaml}]
                                            [-c COLUMN] [--max-width <integer>]
                                            [--noindent]
                                            [--quote {all,minimal,none,nonnumeric}]

List accessible projects

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_federation_protocol_create:

openstack federation protocol create
------------------------------------

.. code-block:: console

   usage: openstack federation protocol create [-h]
                                               [-f {html,json,shell,table,value,yaml}]
                                               [-c COLUMN]
                                               [--max-width <integer>]
                                               [--noindent] [--prefix PREFIX]
                                               --identity-provider
                                               <identity-provider> --mapping
                                               <mapping>
                                               <name>

Create new federation protocol

**Positional arguments:**

``<name>``
  New federation protocol name (must be unique per
  identity provider)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--identity-provider <identity-provider>``
  Identity provider that will support the new federation
  protocol (name or ID) (required)

``--mapping <mapping>``
  Mapping that is to be used (name or ID) (required)

.. _openstack_federation_protocol_delete:

openstack federation protocol delete
------------------------------------

.. code-block:: console

   usage: openstack federation protocol delete [-h] --identity-provider
                                               <identity-provider>
                                               <federation-protocol>
                                               [<federation-protocol> ...]

Delete federation protocol(s)

**Positional arguments:**

``<federation-protocol>``
  Federation protocol(s) to delete (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--identity-provider <identity-provider>``
  Identity provider that supports <federation-protocol>
  (name or ID) (required)

.. _openstack_federation_protocol_list:

openstack federation protocol list
----------------------------------

.. code-block:: console

   usage: openstack federation protocol list [-h]
                                             [-f {csv,html,json,table,value,yaml}]
                                             [-c COLUMN] [--max-width <integer>]
                                             [--noindent]
                                             [--quote {all,minimal,none,nonnumeric}]
                                             --identity-provider
                                             <identity-provider>

List federation protocols

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--identity-provider <identity-provider>``
  Identity provider to list (name or ID) (required)

.. _openstack_federation_protocol_set:

openstack federation protocol set
---------------------------------

.. code-block:: console

   usage: openstack federation protocol set [-h] --identity-provider
                                            <identity-provider>
                                            [--mapping <mapping>]
                                            <name>

Set federation protocol properties

**Positional arguments:**

``<name>``
  Federation protocol to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--identity-provider <identity-provider>``
  Identity provider that supports <federation-protocol>
  (name or ID) (required)

``--mapping <mapping>``
  Mapping that is to be used (name or ID)

.. _openstack_federation_protocol_show:

openstack federation protocol show
----------------------------------

.. code-block:: console

   usage: openstack federation protocol show [-h]
                                             [-f {html,json,shell,table,value,yaml}]
                                             [-c COLUMN] [--max-width <integer>]
                                             [--noindent] [--prefix PREFIX]
                                             --identity-provider
                                             <identity-provider>
                                             <federation-protocol>

Display federation protocol details

**Positional arguments:**

``<federation-protocol>``
  Federation protocol to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--identity-provider <identity-provider>``
  Identity provider that supports <federation-protocol>
  (name or ID) (required)

.. _openstack_flavor_create:

openstack flavor create
-----------------------

.. code-block:: console

   usage: openstack flavor create [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--noindent] [--prefix PREFIX] [--id <id>]
                                  [--ram <size-mb>] [--disk <size-gb>]
                                  [--ephemeral <size-gb>] [--swap <size-gb>]
                                  [--vcpus <vcpus>] [--rxtx-factor <factor>]
                                  [--public | --private] [--property <key=value>]
                                  [--project <project>]
                                  [--project-domain <project-domain>]
                                  <flavor-name>

Create new flavor

**Positional arguments:**

``<flavor-name>``
  New flavor name

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--id <id>``
  Unique flavor ID; 'auto' creates a UUID (default:
  auto)

``--ram <size-mb>``
  Memory size in MB (default 256M)

``--disk <size-gb>``
  Disk size in GB (default 0G)

``--ephemeral <size-gb>``
  Ephemeral disk size in GB (default 0G)

``--swap <size-gb>``
  Swap space size in GB (default 0G)

``--vcpus <vcpus>``
  Number of vcpus (default 1)

``--rxtx-factor <factor>``
  RX/TX factor (default 1.0)

``--public``
  Flavor is available to other projects (default)

``--private``
  Flavor is not available to other projects

``--property <key=value>``
  Property to add for this flavor (repeat option to set
  multiple properties)

``--project <project>``
  Allow <project> to access private flavor (name or ID)
  (Must be used with :option:`--private` option)

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

.. _openstack_flavor_delete:

openstack flavor delete
-----------------------

.. code-block:: console

   usage: openstack flavor delete [-h] <flavor> [<flavor> ...]

Delete flavor(s)

**Positional arguments:**

``<flavor>``
  Flavor(s) to delete (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_flavor_list:

openstack flavor list
---------------------

.. code-block:: console

   usage: openstack flavor list [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}]
                                [--public | --private | --all] [--long]
                                [--marker <marker>] [--limit <limit>]

List flavors

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--public``
  List only public flavors (default)

``--private``
  List only private flavors

``--all``
  List all flavors, whether public or private

``--long``
  List additional fields in output

``--marker <marker>``
  The last flavor ID of the previous page

``--limit <limit>``
  Maximum number of flavors to display

.. _openstack_flavor_set:

openstack flavor set
--------------------

.. code-block:: console

   usage: openstack flavor set [-h] [--property <key=value>]
                               [--project <project>]
                               [--project-domain <project-domain>]
                               <flavor>

Set flavor properties

**Positional arguments:**

``<flavor>``
  Flavor to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--property <key=value>``
  Property to add or modify for this flavor (repeat
  option to set multiple properties)

``--project <project>``
  Set flavor access to project (name or ID) (admin only)

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

.. _openstack_flavor_show:

openstack flavor show
---------------------

.. code-block:: console

   usage: openstack flavor show [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--prefix PREFIX]
                                <flavor>

Display flavor details

**Positional arguments:**

``<flavor>``
  Flavor to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_flavor_unset:

openstack flavor unset
----------------------

.. code-block:: console

   usage: openstack flavor unset [-h] [--property <key>] [--project <project>]
                                 [--project-domain <project-domain>]
                                 <flavor>

Unset flavor properties

**Positional arguments:**

``<flavor>``
  Flavor to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--property <key>``
  Property to remove from flavor (repeat option to unset
  multiple properties)

``--project <project>``
  Remove flavor access from project (name or ID) (admin
  only)

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

.. _openstack_floating_ip_create:

openstack floating ip create
----------------------------

.. code-block:: console

   usage: openstack floating ip create [-h]
                                       [-f {html,json,shell,table,value,yaml}]
                                       [-c COLUMN] [--max-width <integer>]
                                       [--noindent] [--prefix PREFIX]
                                       [--subnet <subnet>] [--port <port>]
                                       [--floating-ip-address <floating-ip-address>]
                                       [--fixed-ip-address <fixed-ip-address>]
                                       <network>

Create floating IP

**Positional arguments:**

``<network>``
  Network to allocate floating IP from (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--subnet <subnet>``
  Subnet on which you want to create the floating IP
  (name or ID)

``--port <port>``
  Port to be associated with the floating IP (name or
  ID)

``--floating-ip-address <floating-ip-address>``
  Floating IP address

``--fixed-ip-address <fixed-ip-address>``
  Fixed IP address mapped to the floating IP

.. _openstack_floating_ip_delete:

openstack floating ip delete
----------------------------

.. code-block:: console

   usage: openstack floating ip delete [-h] <floating-ip> [<floating-ip> ...]

Delete floating IP(s)

**Positional arguments:**

``<floating-ip>``
  Floating IP(s) to delete (IP address or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_floating_ip_list:

openstack floating ip list
--------------------------

.. code-block:: console

   usage: openstack floating ip list [-h] [-f {csv,html,json,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--noindent]
                                     [--quote {all,minimal,none,nonnumeric}]

List floating IP(s)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_floating_ip_pool_list:

openstack floating ip pool list
-------------------------------

.. code-block:: console

   usage: openstack floating ip pool list [-h]
                                          [-f {csv,html,json,table,value,yaml}]
                                          [-c COLUMN] [--max-width <integer>]
                                          [--noindent]
                                          [--quote {all,minimal,none,nonnumeric}]

List pools of floating IP addresses

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_floating_ip_show:

openstack floating ip show
--------------------------

.. code-block:: console

   usage: openstack floating ip show [-h] [-f {html,json,shell,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--noindent] [--prefix PREFIX]
                                     <floating-ip>

Display floating IP details

**Positional arguments:**

``<floating-ip>``
  Floating IP to display (IP address or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_group_add_user:

openstack group add user
------------------------

.. code-block:: console

   usage: openstack group add user [-h] [--group-domain <group-domain>]
                                   [--user-domain <user-domain>]
                                   <group> <user>

Add user to group

**Positional arguments:**

``<group>``
  Group to contain <user> (name or ID)

``<user>``
  User to add to <group> (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--group-domain <group-domain>``
  Domain the group belongs to (name or ID). This can be
  used in case collisions between group names exist.

``--user-domain <user-domain>``
  Domain the user belongs to (name or ID). This can be
  used in case collisions between user names exist.

.. _openstack_group_contains_user:

openstack group contains user
-----------------------------

.. code-block:: console

   usage: openstack group contains user [-h] [--group-domain <group-domain>]
                                        [--user-domain <user-domain>]
                                        <group> <user>

Check user membership in group

**Positional arguments:**

``<group>``
  Group to check (name or ID)

``<user>``
  User to check (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--group-domain <group-domain>``
  Domain the group belongs to (name or ID). This can be
  used in case collisions between group names exist.

``--user-domain <user-domain>``
  Domain the user belongs to (name or ID). This can be
  used in case collisions between user names exist.

.. _openstack_group_create:

openstack group create
----------------------

.. code-block:: console

   usage: openstack group create [-h] [-f {html,json,shell,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>] [--noindent]
                                 [--prefix PREFIX] [--domain <domain>]
                                 [--description <description>] [--or-show]
                                 <group-name>

Create new group

**Positional arguments:**

``<group-name>``
  New group name

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--domain <domain>``
  Domain to contain new group (name or ID)

``--description <description>``
  New group description

``--or-show``
  Return existing group

.. _openstack_group_delete:

openstack group delete
----------------------

.. code-block:: console

   usage: openstack group delete [-h] [--domain <domain>] <group> [<group> ...]

Delete group(s)

**Positional arguments:**

``<group>``
  Group(s) to delete (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--domain <domain>``
  Domain containing group(s) (name or ID)

.. _openstack_group_list:

openstack group list
--------------------

.. code-block:: console

   usage: openstack group list [-h] [-f {csv,html,json,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>] [--noindent]
                               [--quote {all,minimal,none,nonnumeric}]
                               [--domain <domain>] [--user <user>]
                               [--user-domain <user-domain>] [--long]

List groups

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--domain <domain>``
  Filter group list by <domain> (name or ID)

``--user <user>``
  Filter group list by <user> (name or ID)

``--user-domain <user-domain>``
  Domain the user belongs to (name or ID). This can be
  used in case collisions between user names exist.

``--long``
  List additional fields in output

.. _openstack_group_remove_user:

openstack group remove user
---------------------------

.. code-block:: console

   usage: openstack group remove user [-h] [--group-domain <group-domain>]
                                      [--user-domain <user-domain>]
                                      <group> <user>

Remove user from group

**Positional arguments:**

``<group>``
  Group containing <user> (name or ID)

``<user>``
  User to remove from <group> (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--group-domain <group-domain>``
  Domain the group belongs to (name or ID). This can be
  used in case collisions between group names exist.

``--user-domain <user-domain>``
  Domain the user belongs to (name or ID). This can be
  used in case collisions between user names exist.

.. _openstack_group_set:

openstack group set
-------------------

.. code-block:: console

   usage: openstack group set [-h] [--domain <domain>] [--name <name>]
                              [--description <description>]
                              <group>

Set group properties

**Positional arguments:**

``<group>``
  Group to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--domain <domain>``
  Domain containing <group> (name or ID)

``--name <name>``
  New group name

``--description <description>``
  New group description

.. _openstack_group_show:

openstack group show
--------------------

.. code-block:: console

   usage: openstack group show [-h] [-f {html,json,shell,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>] [--noindent]
                               [--prefix PREFIX] [--domain <domain>]
                               <group>

Display group details

**Positional arguments:**

``<group>``
  Group to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--domain <domain>``
  Domain containing <group> (name or ID)

.. _openstack_host_list:

openstack host list
-------------------

.. code-block:: console

   usage: openstack host list [-h] [-f {csv,html,json,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--noindent]
                              [--quote {all,minimal,none,nonnumeric}]
                              [--zone <zone>]

List hosts

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--zone <zone>``
  Only return hosts in the availability zone

.. _openstack_host_set:

openstack host set
------------------

.. code-block:: console

   usage: openstack host set [-h] [--enable | --disable]
                             [--enable-maintenance | --disable-maintenance]
                             <host>

Set host properties

**Positional arguments:**

``<host>``
  Host to modify (name only)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--enable``
  Enable the host

``--disable``
  Disable the host

``--enable-maintenance``
  Enable maintenance mode for the host

``--disable-maintenance``
  Disable maintenance mode for the host

.. _openstack_host_show:

openstack host show
-------------------

.. code-block:: console

   usage: openstack host show [-h] [-f {csv,html,json,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--noindent]
                              [--quote {all,minimal,none,nonnumeric}]
                              <host>

Display host details

**Positional arguments:**

``<host>``
  Name of host

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_hypervisor_list:

openstack hypervisor list
-------------------------

.. code-block:: console

   usage: openstack hypervisor list [-h] [-f {csv,html,json,table,value,yaml}]
                                    [-c COLUMN] [--max-width <integer>]
                                    [--noindent]
                                    [--quote {all,minimal,none,nonnumeric}]
                                    [--matching <hostname>]

List hypervisors

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--matching <hostname>``
  Filter hypervisors using <hostname> substring

.. _openstack_hypervisor_show:

openstack hypervisor show
-------------------------

.. code-block:: console

   usage: openstack hypervisor show [-h] [-f {html,json,shell,table,value,yaml}]
                                    [-c COLUMN] [--max-width <integer>]
                                    [--noindent] [--prefix PREFIX]
                                    <hypervisor>

Display hypervisor details

**Positional arguments:**

``<hypervisor>``
  Hypervisor to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_hypervisor_stats_show:

openstack hypervisor stats show
-------------------------------

.. code-block:: console

   usage: openstack hypervisor stats show [-h]
                                          [-f {html,json,shell,table,value,yaml}]
                                          [-c COLUMN] [--max-width <integer>]
                                          [--noindent] [--prefix PREFIX]

Display hypervisor stats details

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_identity_provider_create:

openstack identity provider create
----------------------------------

.. code-block:: console

   usage: openstack identity provider create [-h]
                                             [-f {html,json,shell,table,value,yaml}]
                                             [-c COLUMN] [--max-width <integer>]
                                             [--noindent] [--prefix PREFIX]
                                             [--remote-id <remote-id> | --remote-id-file <file-name>]
                                             [--description <description>]
                                             [--enable | --disable]
                                             <name>

Create new identity provider

**Positional arguments:**

``<name>``
  New identity provider name (must be unique)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--remote-id <remote-id>``
  Remote IDs to associate with the Identity Provider
  (repeat option to provide multiple values)

``--remote-id-file <file-name>``
  Name of a file that contains many remote IDs to
  associate with the identity provider, one per line

``--description <description>``
  New identity provider description

``--enable``
  Enable identity provider (default)

``--disable``
  Disable the identity provider

.. _openstack_identity_provider_delete:

openstack identity provider delete
----------------------------------

.. code-block:: console

   usage: openstack identity provider delete [-h]
                                             <identity-provider>
                                             [<identity-provider> ...]

Delete identity provider(s)

**Positional arguments:**

``<identity-provider>``
  Identity provider(s) to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_identity_provider_list:

openstack identity provider list
--------------------------------

.. code-block:: console

   usage: openstack identity provider list [-h]
                                           [-f {csv,html,json,table,value,yaml}]
                                           [-c COLUMN] [--max-width <integer>]
                                           [--noindent]
                                           [--quote {all,minimal,none,nonnumeric}]

List identity providers

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_identity_provider_set:

openstack identity provider set
-------------------------------

.. code-block:: console

   usage: openstack identity provider set [-h] [--description <description>]
                                          [--remote-id <remote-id> | --remote-id-file <file-name>]
                                          [--enable | --disable]
                                          <identity-provider>

Set identity provider properties

**Positional arguments:**

``<identity-provider>``
  Identity provider to modify

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--description <description>``
  Set identity provider description

``--remote-id <remote-id>``
  Remote IDs to associate with the Identity Provider
  (repeat option to provide multiple values)

``--remote-id-file <file-name>``
  Name of a file that contains many remote IDs to
  associate with the identity provider, one per line

``--enable``
  Enable the identity provider

``--disable``
  Disable the identity provider

.. _openstack_identity_provider_show:

openstack identity provider show
--------------------------------

.. code-block:: console

   usage: openstack identity provider show [-h]
                                           [-f {html,json,shell,table,value,yaml}]
                                           [-c COLUMN] [--max-width <integer>]
                                           [--noindent] [--prefix PREFIX]
                                           <identity-provider>

Display identity provider details

**Positional arguments:**

``<identity-provider>``
  Identity provider to display

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_image_add_project:

openstack image add project
---------------------------

.. code-block:: console

   usage: openstack image add project [-h]
                                      [-f {html,json,shell,table,value,yaml}]
                                      [-c COLUMN] [--max-width <integer>]
                                      [--noindent] [--prefix PREFIX]
                                      [--project-domain <project-domain>]
                                      <image> <project>

Associate project with image

**Positional arguments:**

``<image>``
  Image to share (name or ID)

``<project>``
  Project to associate with image (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

.. _openstack_image_create:

openstack image create
----------------------

.. code-block:: console

   usage: openstack image create [-h] [-f {html,json,shell,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>] [--noindent]
                                 [--prefix PREFIX] [--id <id>]
                                 [--container-format <container-format>]
                                 [--disk-format <disk-format>]
                                 [--min-disk <disk-gb>] [--min-ram <ram-mb>]
                                 [--file <file>] [--volume <volume>] [--force]
                                 [--protected | --unprotected]
                                 [--public | --private] [--property <key=value>]
                                 [--tag <tag>] [--project <project>]
                                 [--project-domain <project-domain>]
                                 <image-name>

Create/upload an image

**Positional arguments:**

``<image-name>``
  New image name

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--id <id>``
  Image ID to reserve

``--container-format <container-format>``
  Image container format (default: bare)

``--disk-format <disk-format>``
  Image disk format (default: raw)

``--min-disk <disk-gb>``
  Minimum disk size needed to boot image, in gigabytes

``--min-ram <ram-mb>``
  Minimum RAM size needed to boot image, in megabytes

``--file <file>``
  Upload image from local file

``--volume <volume>``
  Create image from a volume

``--force``
  Force image creation if volume is in use (only
  meaningful with :option:`--volume)`

``--protected``
  Prevent image from being deleted

``--unprotected``
  Allow image to be deleted (default)

``--public``
  Image is accessible to the public

``--private``
  Image is inaccessible to the public (default)

``--property <key=value>``
  Set a property on this image (repeat option to set
  multiple properties)

``--tag <tag>``
  Set a tag on this image (repeat option to set multiple
  tags)

``--project <project>``
  Set an alternate project on this image (name or ID)

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

.. _openstack_image_delete:

openstack image delete
----------------------

.. code-block:: console

   usage: openstack image delete [-h] <image> [<image> ...]

Delete image(s)

**Positional arguments:**

``<image>``
  Image(s) to delete (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_image_list:

openstack image list
--------------------

.. code-block:: console

   usage: openstack image list [-h] [-f {csv,html,json,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>] [--noindent]
                               [--quote {all,minimal,none,nonnumeric}]
                               [--public | --private | --shared]
                               [--property <key=value>] [--long]
                               [--sort <key>[:<direction>]] [--limit <limit>]
                               [--marker <marker>]

List available images

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--public``
  List only public images

``--private``
  List only private images

``--shared``
  List only shared images

``--property <key=value>``
  Filter output based on property

``--long``
  List additional fields in output

``--sort <key>[:<direction>]``
  Sort output by selected keys and directions(asc or
  desc) (default: asc), multiple keys and directions can
  be specified separated by comma

``--limit <limit>``
  Maximum number of images to display.

``--marker <marker>``
  The last image (name or ID) of the previous page.
  Display list of images after marker. Display all
  images if not specified.

.. _openstack_image_remove_project:

openstack image remove project
------------------------------

.. code-block:: console

   usage: openstack image remove project [-h] [--project-domain <project-domain>]
                                         <image> <project>

Disassociate project with image

**Positional arguments:**

``<image>``
  Image to unshare (name or ID)

``<project>``
  Project to disassociate with image (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

.. _openstack_image_save:

openstack image save
--------------------

.. code-block:: console

   usage: openstack image save [-h] [--file <filename>] <image>

Save an image locally

**Positional arguments:**

``<image>``
  Image to save (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--file <filename>``
  Downloaded image save filename (default: stdout)

.. _openstack_image_set:

openstack image set
-------------------

.. code-block:: console

   usage: openstack image set [-h] [--name <name>] [--min-disk <disk-gb>]
                              [--min-ram <ram-mb>]
                              [--container-format <container-format>]
                              [--disk-format <disk-format>]
                              [--protected | --unprotected]
                              [--public | --private] [--property <key=value>]
                              [--tag <tag>] [--architecture <architecture>]
                              [--instance-id <instance-id>]
                              [--kernel-id <kernel-id>] [--os-distro <os-distro>]
                              [--os-version <os-version>]
                              [--ramdisk-id <ramdisk-id>]
                              [--deactivate | --activate] [--project <project>]
                              [--project-domain <project-domain>]
                              <image>

Set image properties

**Positional arguments:**

``<image>``
  Image to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  New image name

``--min-disk <disk-gb>``
  Minimum disk size needed to boot image, in gigabytes

``--min-ram <ram-mb>``
  Minimum RAM size needed to boot image, in megabytes

``--container-format <container-format>``
  Image container format (default: bare)

``--disk-format <disk-format>``
  Image disk format (default: raw)

``--protected``
  Prevent image from being deleted

``--unprotected``
  Allow image to be deleted (default)

``--public``
  Image is accessible to the public

``--private``
  Image is inaccessible to the public (default)

``--property <key=value>``
  Set a property on this image (repeat option to set
  multiple properties)

``--tag <tag>``
  Set a tag on this image (repeat option to set multiple
  tags)

``--architecture <architecture>``
  Operating system architecture

``--instance-id <instance-id>``
  ID of server instance used to create this image

``--kernel-id <kernel-id>``
  ID of kernel image used to boot this disk image

``--os-distro <os-distro>``
  Operating system distribution name

``--os-version <os-version>``
  Operating system distribution version

``--ramdisk-id <ramdisk-id>``
  ID of ramdisk image used to boot this disk image

``--deactivate``
  Deactivate the image

``--activate``
  Activate the image

``--project <project>``
  Set an alternate project on this image (name or ID)

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

.. _openstack_image_show:

openstack image show
--------------------

.. code-block:: console

   usage: openstack image show [-h] [-f {html,json,shell,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>] [--noindent]
                               [--prefix PREFIX]
                               <image>

Display image details

**Positional arguments:**

``<image>``
  Image to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_image_unset:

openstack image unset
---------------------

.. code-block:: console

   usage: openstack image unset [-h] [--tag <tag>] [--property <property_key>]
                                <image>

Unset image tags and properties

**Positional arguments:**

``<image>``
  Image to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--tag <tag>``
  Unset a tag on this image (repeat option to set
  multiple tags)

``--property <property_key>``
  Unset a property on this image (repeat option to set
  multiple properties)

.. _openstack_ip_availability_list:

openstack ip availability list
------------------------------

.. code-block:: console

   usage: openstack ip availability list [-h]
                                         [-f {csv,html,json,table,value,yaml}]
                                         [-c COLUMN] [--max-width <integer>]
                                         [--noindent]
                                         [--quote {all,minimal,none,nonnumeric}]
                                         [--ip-version <ip-version>]
                                         [--project <project>]
                                         [--project-domain <project-domain>]

List IP availability for network

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--ip-version <ip-version>``
  List IP availability of given IP version networks
  (default is 4)

``--project <project>``
  List IP availability of given project (name or ID)

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

.. _openstack_ip_availability_show:

openstack ip availability show
------------------------------

.. code-block:: console

   usage: openstack ip availability show [-h]
                                         [-f {html,json,shell,table,value,yaml}]
                                         [-c COLUMN] [--max-width <integer>]
                                         [--noindent] [--prefix PREFIX]
                                         <network>

Show network IP availability details

**Positional arguments:**

``<network>``
  Show IP availability for a specific network (name or
  ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_ip_fixed_add:

openstack ip fixed add
----------------------

.. code-block:: console

   usage: openstack ip fixed add [-h] <network> <server>

Add fixed IP address to server

**Positional arguments:**

``<network>``
  Network to fetch an IP address from (name or ID)

``<server>``
  Server to receive the IP address (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_ip_fixed_remove:

openstack ip fixed remove
-------------------------

.. code-block:: console

   usage: openstack ip fixed remove [-h] <ip-address> <server>

Remove fixed IP address from server

**Positional arguments:**

``<ip-address>``
  IP address to remove from server (name only)

``<server>``
  Server to remove the IP address from (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_ip_floating_add:

openstack ip floating add
-------------------------

.. code-block:: console

   usage: openstack ip floating add [-h] <ip-address> <server>

Add floating IP address to server

**Positional arguments:**

``<ip-address>``
  IP address to add to server (name only)

``<server>``
  Server to receive the IP address (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_ip_floating_create:

openstack ip floating create
----------------------------

.. code-block:: console

   usage: openstack ip floating create [-h]
                                       [-f {html,json,shell,table,value,yaml}]
                                       [-c COLUMN] [--max-width <integer>]
                                       [--noindent] [--prefix PREFIX]
                                       [--subnet <subnet>] [--port <port>]
                                       [--floating-ip-address <floating-ip-address>]
                                       [--fixed-ip-address <fixed-ip-address>]
                                       <network>

Create floating IP

**Positional arguments:**

``<network>``
  Network to allocate floating IP from (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--subnet <subnet>``
  Subnet on which you want to create the floating IP
  (name or ID)

``--port <port>``
  Port to be associated with the floating IP (name or
  ID)

``--floating-ip-address <floating-ip-address>``
  Floating IP address

``--fixed-ip-address <fixed-ip-address>``
  Fixed IP address mapped to the floating IP

.. _openstack_ip_floating_delete:

openstack ip floating delete
----------------------------

.. code-block:: console

   usage: openstack ip floating delete [-h] <floating-ip> [<floating-ip> ...]

Delete floating IP(s)

**Positional arguments:**

``<floating-ip>``
  Floating IP(s) to delete (IP address or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_ip_floating_list:

openstack ip floating list
--------------------------

.. code-block:: console

   usage: openstack ip floating list [-h] [-f {csv,html,json,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--noindent]
                                     [--quote {all,minimal,none,nonnumeric}]

List floating IP(s)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_ip_floating_pool_list:

openstack ip floating pool list
-------------------------------

.. code-block:: console

   usage: openstack ip floating pool list [-h]
                                          [-f {csv,html,json,table,value,yaml}]
                                          [-c COLUMN] [--max-width <integer>]
                                          [--noindent]
                                          [--quote {all,minimal,none,nonnumeric}]

List pools of floating IP addresses

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_ip_floating_remove:

openstack ip floating remove
----------------------------

.. code-block:: console

   usage: openstack ip floating remove [-h] <ip-address> <server>

Remove floating IP address from server

**Positional arguments:**

``<ip-address>``
  IP address to remove from server (name only)

``<server>``
  Server to remove the IP address from (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_ip_floating_show:

openstack ip floating show
--------------------------

.. code-block:: console

   usage: openstack ip floating show [-h] [-f {html,json,shell,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--noindent] [--prefix PREFIX]
                                     <floating-ip>

Display floating IP details

**Positional arguments:**

``<floating-ip>``
  Floating IP to display (IP address or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_keypair_create:

openstack keypair create
------------------------

.. code-block:: console

   usage: openstack keypair create [-h] [-f {html,json,shell,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--noindent] [--prefix PREFIX]
                                   [--public-key <file>]
                                   <name>

Create new public key

**Positional arguments:**

``<name>``
  New public key name

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--public-key <file>``
  Filename for public key to add

.. _openstack_keypair_delete:

openstack keypair delete
------------------------

.. code-block:: console

   usage: openstack keypair delete [-h] <key> [<key> ...]

Delete public key(s)

**Positional arguments:**

``<key>``
  Public key(s) to delete (name only)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_keypair_list:

openstack keypair list
----------------------

.. code-block:: console

   usage: openstack keypair list [-h] [-f {csv,html,json,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>] [--noindent]
                                 [--quote {all,minimal,none,nonnumeric}]

List public key fingerprints

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_keypair_show:

openstack keypair show
----------------------

.. code-block:: console

   usage: openstack keypair show [-h] [-f {html,json,shell,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>] [--noindent]
                                 [--prefix PREFIX] [--public-key]
                                 <key>

Display public key details

**Positional arguments:**

``<key>``
  Public key to display (name only)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--public-key``
  Show only bare public key (name only)

.. _openstack_limits_show:

openstack limits show
---------------------

.. code-block:: console

   usage: openstack limits show [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}]
                                (--absolute | --rate) [--reserved]
                                [--project <project>] [--domain <domain>]

Show compute and block storage limits

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--absolute``
  Show absolute limits

``--rate``
  Show rate limits

``--reserved``
  Include reservations count [only valid with
  :option:`--absolute]`

``--project <project>``
  Show limits for a specific project (name or ID) [only
  valid with :option:`--absolute]`

``--domain <domain>``
  Domain the project belongs to (name or ID) [only valid
  with :option:`--absolute]`

.. _openstack_mapping_create:

openstack mapping create
------------------------

.. code-block:: console

   usage: openstack mapping create [-h] [-f {html,json,shell,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--noindent] [--prefix PREFIX] --rules
                                   <filename>
                                   <name>

Create new mapping

**Positional arguments:**

``<name>``
  New mapping name (must be unique)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--rules <filename>``
  Filename that contains a set of mapping rules
  (required)

.. _openstack_mapping_delete:

openstack mapping delete
------------------------

.. code-block:: console

   usage: openstack mapping delete [-h] <mapping> [<mapping> ...]

Delete mapping(s)

**Positional arguments:**

``<mapping>``
  Mapping(s) to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_mapping_list:

openstack mapping list
----------------------

.. code-block:: console

   usage: openstack mapping list [-h] [-f {csv,html,json,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>] [--noindent]
                                 [--quote {all,minimal,none,nonnumeric}]

List mappings

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_mapping_set:

openstack mapping set
---------------------

.. code-block:: console

   usage: openstack mapping set [-h] [--rules <filename>] <name>

Set mapping properties

**Positional arguments:**

``<name>``
  Mapping to modify

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--rules <filename>``
  Filename that contains a new set of mapping rules

.. _openstack_mapping_show:

openstack mapping show
----------------------

.. code-block:: console

   usage: openstack mapping show [-h] [-f {html,json,shell,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>] [--noindent]
                                 [--prefix PREFIX]
                                 <mapping>

Display mapping details

**Positional arguments:**

``<mapping>``
  Mapping to display

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_messaging_flavor_create:

openstack messaging flavor create
---------------------------------

.. code-block:: console

   usage: openstack messaging flavor create [-h]
                                            [-f {html,json,shell,table,value,yaml}]
                                            [-c COLUMN] [--max-width <integer>]
                                            [--noindent] [--prefix PREFIX]
                                            [--capabilities <capabilities>]
                                            <flavor_name> <pool_group>

Create a pool flavor

**Positional arguments:**

``<flavor_name>``
  Name of the flavor

``<pool_group>``
  Pool group for flavor

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--capabilities <capabilities>``
  Describes flavor-specific capabilities, This option is
  only available in client api version < 2 .

.. _openstack_messaging_flavor_delete:

openstack messaging flavor delete
---------------------------------

.. code-block:: console

   usage: openstack messaging flavor delete [-h] <flavor_name>

Delete a flavor

**Positional arguments:**

``<flavor_name>``
  Name of the flavor

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_messaging_flavor_list:

openstack messaging flavor list
-------------------------------

.. code-block:: console

   usage: openstack messaging flavor list [-h]
                                          [-f {csv,html,json,table,value,yaml}]
                                          [-c COLUMN] [--max-width <integer>]
                                          [--noindent]
                                          [--quote {all,minimal,none,nonnumeric}]
                                          [--marker <flavor_name>]
                                          [--limit <limit>]
                                          [--detailed <detailed>]

List available flavors

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--marker <flavor_name>``
  Flavor's paging marker

``--limit <limit>``
  Page size limit

``--detailed <detailed>``
  If show detailed capabilities of flavor

.. _openstack_messaging_flavor_show:

openstack messaging flavor show
-------------------------------

.. code-block:: console

   usage: openstack messaging flavor show [-h]
                                          [-f {html,json,shell,table,value,yaml}]
                                          [-c COLUMN] [--max-width <integer>]
                                          [--noindent] [--prefix PREFIX]
                                          <flavor_name>

Display flavor details

**Positional arguments:**

``<flavor_name>``
  Flavor to display (name)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_messaging_flavor_update:

openstack messaging flavor update
---------------------------------

.. code-block:: console

   usage: openstack messaging flavor update [-h]
                                            [-f {html,json,shell,table,value,yaml}]
                                            [-c COLUMN] [--max-width <integer>]
                                            [--noindent] [--prefix PREFIX]
                                            [--pool_group <pool_group>]
                                            [--capabilities <capabilities>]
                                            <flavor_name>

Update a flavor's attributes

**Positional arguments:**

``<flavor_name>``
  Name of the flavor

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--pool_group <pool_group>``
  Pool group the flavor sits on

``--capabilities <capabilities>``
  Describes flavor-specific capabilities.

.. _openstack_messaging_health:

openstack messaging health
--------------------------

.. code-block:: console

   usage: openstack messaging health [-h]

Display detailed health status of Zaqar server

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_messaging_ping:

openstack messaging ping
------------------------

.. code-block:: console

   usage: openstack messaging ping [-h] [-f {html,json,shell,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--noindent] [--prefix PREFIX]

Check if Zaqar server is alive or not

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_module_list:

openstack module list
---------------------

.. code-block:: console

   usage: openstack module list [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--prefix PREFIX] [--all]

List module versions

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all``
  Show all modules that have version information

.. _openstack_network_agent_delete:

openstack network agent delete
------------------------------

.. code-block:: console

   usage: openstack network agent delete [-h]
                                         <network-agent> [<network-agent> ...]

Delete network agent(s)

**Positional arguments:**

``<network-agent>``
  Network agent(s) to delete (ID only)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_network_agent_list:

openstack network agent list
----------------------------

.. code-block:: console

   usage: openstack network agent list [-h] [-f {csv,html,json,table,value,yaml}]
                                       [-c COLUMN] [--max-width <integer>]
                                       [--noindent]
                                       [--quote {all,minimal,none,nonnumeric}]

List network agents

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_network_agent_set:

openstack network agent set
---------------------------

.. code-block:: console

   usage: openstack network agent set [-h] [--description <description>]
                                      [--enable | --disable]
                                      <network-agent>

Set network agent properties

**Positional arguments:**

``<network-agent>``
  Network agent to modify (ID only)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--description <description>``
  Set network agent description

``--enable``
  Enable network agent

``--disable``
  Disable network agent

.. _openstack_network_agent_show:

openstack network agent show
----------------------------

.. code-block:: console

   usage: openstack network agent show [-h]
                                       [-f {html,json,shell,table,value,yaml}]
                                       [-c COLUMN] [--max-width <integer>]
                                       [--noindent] [--prefix PREFIX]
                                       <network-agent>

Display network agent details

**Positional arguments:**

``<network-agent>``
  Network agent to display (ID only)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_network_create:

openstack network create
------------------------

.. code-block:: console

   usage: openstack network create [-h] [-f {html,json,shell,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--noindent] [--prefix PREFIX]
                                   [--share | --no-share] [--enable | --disable]
                                   [--project <project>]
                                   [--project-domain <project-domain>]
                                   [--availability-zone-hint <availability-zone>]
                                   [--enable-port-security | --disable-port-security]
                                   [--external | --internal]
                                   [--default | --no-default]
                                   [--provider-network-type <provider-network-type>]
                                   [--provider-physical-network <provider-physical-network>]
                                   [--provider-segment <provider-segment>]
                                   [--transparent-vlan | --no-transparent-vlan]
                                   <name>

Create new network

**Positional arguments:**

``<name>``
  New network name

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--share``
  Share the network between projects

``--no-share``
  Do not share the network between projects

``--enable``
  Enable network (default)

``--disable``
  Disable network

``--project <project>``
  Owner's project (name or ID)

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

``--availability-zone-hint <availability-zone>``
  Availability Zone in which to create this network
  (Network Availability Zone extension required, repeat
  option to set multiple availability zones)

``--enable-port-security``
  Enable port security by default for ports created on
  this network (default)

``--disable-port-security``
  Disable port security by default for ports created on
  this network

``--external``
  Set this network as an external network (external-net
  extension required)

``--internal``
  Set this network as an internal network (default)

``--default``
  Specify if this network should be used as the default
  external network

``--no-default``
  Do not use the network as the default external network
  (default)

``--provider-network-type <provider-network-type>``
  The physical mechanism by which the virtual network is
  implemented. The supported options are: flat, geneve,
  gre, local, vlan, vxlan.

``--provider-physical-network <provider-physical-network>``
  Name of the physical network over which the virtual
  network is implemented

``--provider-segment <provider-segment>``
  VLAN ID for VLAN networks or Tunnel ID for
  GENEVE/GRE/VXLAN networks

``--transparent-vlan``
  Make the network VLAN transparent

``--no-transparent-vlan``
  Do not make the network VLAN transparent

.. _openstack_network_delete:

openstack network delete
------------------------

.. code-block:: console

   usage: openstack network delete [-h] <network> [<network> ...]

Delete network(s)

**Positional arguments:**

``<network>``
  Network(s) to delete (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_network_list:

openstack network list
----------------------

.. code-block:: console

   usage: openstack network list [-h] [-f {csv,html,json,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>] [--noindent]
                                 [--quote {all,minimal,none,nonnumeric}]
                                 [--external] [--long]

List networks

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--external``
  List external networks

``--long``
  List additional fields in output

.. _openstack_network_rbac_create:

openstack network rbac create
-----------------------------

.. code-block:: console

   usage: openstack network rbac create [-h]
                                        [-f {html,json,shell,table,value,yaml}]
                                        [-c COLUMN] [--max-width <integer>]
                                        [--noindent] [--prefix PREFIX] --type
                                        <type> --action <action> --target-project
                                        <target-project>
                                        [--target-project-domain <target-project-domain>]
                                        [--project <project>]
                                        [--project-domain <project-domain>]
                                        <rbac-object>

Create network RBAC policy

**Positional arguments:**

``<rbac-object>``
  The object to which this RBAC policy affects (name or
  ID for network objects, ID only for QoS policy
  objects)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--type <type>``
  Type of the object that RBAC policy affects
  ("qos_policy" or "network")

``--action <action>``
  Action for the RBAC policy ("access_as_external" or
  "access_as_shared")

``--target-project <target-project>``
  The project to which the RBAC policy will be enforced
  (name or ID)

``--target-project-domain <target-project-domain>``
  Domain the target project belongs to (name or ID).
  This can be used in case collisions between project
  names exist.

``--project <project>``
  The owner project (name or ID)

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

.. _openstack_network_rbac_delete:

openstack network rbac delete
-----------------------------

.. code-block:: console

   usage: openstack network rbac delete [-h] <rbac-policy> [<rbac-policy> ...]

Delete network RBAC policy(s)

**Positional arguments:**

``<rbac-policy>``
  RBAC policy(s) to delete (ID only)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_network_rbac_list:

openstack network rbac list
---------------------------

.. code-block:: console

   usage: openstack network rbac list [-h] [-f {csv,html,json,table,value,yaml}]
                                      [-c COLUMN] [--max-width <integer>]
                                      [--noindent]
                                      [--quote {all,minimal,none,nonnumeric}]

List network RBAC policies

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_network_rbac_set:

openstack network rbac set
--------------------------

.. code-block:: console

   usage: openstack network rbac set [-h] [--target-project <target-project>]
                                     [--target-project-domain <target-project-domain>]
                                     <rbac-policy>

Set network RBAC policy properties

**Positional arguments:**

``<rbac-policy>``
  RBAC policy to be modified (ID only)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--target-project <target-project>``
  The project to which the RBAC policy will be enforced
  (name or ID)

``--target-project-domain <target-project-domain>``
  Domain the target project belongs to (name or ID).
  This can be used in case collisions between project
  names exist.

.. _openstack_network_rbac_show:

openstack network rbac show
---------------------------

.. code-block:: console

   usage: openstack network rbac show [-h]
                                      [-f {html,json,shell,table,value,yaml}]
                                      [-c COLUMN] [--max-width <integer>]
                                      [--noindent] [--prefix PREFIX]
                                      <rbac-policy>

Display network RBAC policy details

**Positional arguments:**

``<rbac-policy>``
  RBAC policy (ID only)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_network_segment_list:

openstack network segment list
------------------------------

.. code-block:: console

   usage: openstack network segment list [-h]
                                         [-f {csv,html,json,table,value,yaml}]
                                         [-c COLUMN] [--max-width <integer>]
                                         [--noindent]
                                         [--quote {all,minimal,none,nonnumeric}]
                                         [--long] [--network <network>]

List network segments (Caution: This is a beta command and subject to change.
Use global option :option:`--os-beta-command` to enable this command)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--long``
  List additional fields in output

``--network <network>``
  List network segments that belong to this network
  (name or ID)

.. _openstack_network_segment_show:

openstack network segment show
------------------------------

.. code-block:: console

   usage: openstack network segment show [-h]
                                         [-f {html,json,shell,table,value,yaml}]
                                         [-c COLUMN] [--max-width <integer>]
                                         [--noindent] [--prefix PREFIX]
                                         <network-segment>

Display network segment details (Caution: This is a beta command and subject
to
change.
Use
global
option
:option:`--os-beta-command`
to
enable
this
command)

**Positional arguments:**

``<network-segment>``
  Network segment to display (ID only)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_network_set:

openstack network set
---------------------

.. code-block:: console

   usage: openstack network set [-h] [--name <name>] [--enable | --disable]
                                [--share | --no-share]
                                [--enable-port-security | --disable-port-security]
                                [--external | --internal]
                                [--default | --no-default]
                                [--provider-network-type <provider-network-type>]
                                [--provider-physical-network <provider-physical-network>]
                                [--provider-segment <provider-segment>]
                                [--transparent-vlan | --no-transparent-vlan]
                                <network>

Set network properties

**Positional arguments:**

``<network>``
  Network to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  Set network name

``--enable``
  Enable network

``--disable``
  Disable network

``--share``
  Share the network between projects

``--no-share``
  Do not share the network between projects

``--enable-port-security``
  Enable port security by default for ports created on
  this network

``--disable-port-security``
  Disable port security by default for ports created on
  this network

``--external``
  Set this network as an external network (external-net
  extension required)

``--internal``
  Set this network as an internal network

``--default``
  Set the network as the default external network

``--no-default``
  Do not use the network as the default external network

``--provider-network-type <provider-network-type>``
  The physical mechanism by which the virtual network is
  implemented. The supported options are: flat, geneve,
  gre, local, vlan, vxlan.

``--provider-physical-network <provider-physical-network>``
  Name of the physical network over which the virtual
  network is implemented

``--provider-segment <provider-segment>``
  VLAN ID for VLAN networks or Tunnel ID for
  GENEVE/GRE/VXLAN networks

``--transparent-vlan``
  Make the network VLAN transparent

``--no-transparent-vlan``
  Do not make the network VLAN transparent

.. _openstack_network_show:

openstack network show
----------------------

.. code-block:: console

   usage: openstack network show [-h] [-f {html,json,shell,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>] [--noindent]
                                 [--prefix PREFIX]
                                 <network>

Show network details

**Positional arguments:**

``<network>``
  Network to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_object_create:

openstack object create
-----------------------

.. code-block:: console

   usage: openstack object create [-h] [-f {csv,html,json,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--noindent]
                                  [--quote {all,minimal,none,nonnumeric}]
                                  <container> <filename> [<filename> ...]

Upload object to container

**Positional arguments:**

``<container>``
  Container for new object

``<filename>``
  Local filename(s) to upload

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_object_delete:

openstack object delete
-----------------------

.. code-block:: console

   usage: openstack object delete [-h] <container> <object> [<object> ...]

Delete object from container

**Positional arguments:**

``<container>``
  Delete object(s) from <container>

``<object>``
  Object(s) to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_object_list:

openstack object list
---------------------

.. code-block:: console

   usage: openstack object list [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}]
                                [--prefix <prefix>] [--delimiter <delimiter>]
                                [--marker <marker>] [--end-marker <end-marker>]
                                [--limit <limit>] [--long] [--all]
                                <container>

List objects

**Positional arguments:**

``<container>``
  Container to list

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--prefix <prefix>``
  Filter list using <prefix>

``--delimiter <delimiter>``
  Roll up items with <delimiter>

``--marker <marker>``
  Anchor for paging

``--end-marker <end-marker>``
  End anchor for paging

``--limit <limit>``
  Limit the number of objects returned

``--long``
  List additional fields in output

``--all``
  List all objects in container (default is 10000)

.. _openstack_object_save:

openstack object save
---------------------

.. code-block:: console

   usage: openstack object save [-h] [--file <filename>] <container> <object>

Save object locally

**Positional arguments:**

``<container>``
  Download <object> from <container>

``<object>``
  Object to save

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--file <filename>``
  Destination filename (defaults to object name)

.. _openstack_object_set:

openstack object set
--------------------

.. code-block:: console

   usage: openstack object set [-h] --property <key=value> <container> <object>

Set object properties

**Positional arguments:**

``<container>``
  Modify <object> from <container>

``<object>``
  Object to modify

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--property <key=value>``
  Set a property on this object (repeat option to set
  multiple properties)

.. _openstack_object_show:

openstack object show
---------------------

.. code-block:: console

   usage: openstack object show [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--prefix PREFIX]
                                <container> <object>

Display object details

**Positional arguments:**

``<container>``
  Display <object> from <container>

``<object>``
  Object to display

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_object_store_account_set:

openstack object store account set
----------------------------------

.. code-block:: console

   usage: openstack object store account set [-h] --property <key=value>

Set account properties

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--property <key=value>``
  Set a property on this account (repeat option to set
  multiple properties)

.. _openstack_object_store_account_show:

openstack object store account show
-----------------------------------

.. code-block:: console

   usage: openstack object store account show [-h]
                                              [-f {html,json,shell,table,value,yaml}]
                                              [-c COLUMN] [--max-width <integer>]
                                              [--noindent] [--prefix PREFIX]

Display account details

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_object_store_account_unset:

openstack object store account unset
------------------------------------

.. code-block:: console

   usage: openstack object store account unset [-h] --property <key>

Unset account properties

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--property <key>``
  Property to remove from account (repeat option to remove
  multiple properties)

.. _openstack_object_unset:

openstack object unset
----------------------

.. code-block:: console

   usage: openstack object unset [-h] --property <key> <container> <object>

Unset object properties

**Positional arguments:**

``<container>``
  Modify <object> from <container>

``<object>``
  Object to modify

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--property <key>``
  Property to remove from object (repeat option to remove
  multiple properties)

.. _openstack_orchestration_build_info:

openstack orchestration build info
----------------------------------

.. code-block:: console

   usage: openstack orchestration build info [-h]
                                             [-f {html,json,shell,table,value,yaml}]
                                             [-c COLUMN] [--max-width <integer>]
                                             [--noindent] [--prefix PREFIX]

Retrieve build information.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_orchestration_resource_type_list:

openstack orchestration resource type list
------------------------------------------

.. code-block:: console

   usage: openstack orchestration resource type list [-h]
                                                     [-f {csv,html,json,table,value,yaml}]
                                                     [-c COLUMN]
                                                     [--max-width <integer>]
                                                     [--noindent]
                                                     [--quote {all,minimal,none,nonnumeric}]
                                                     [--filter <key=value>]
                                                     [--long]

List resource types.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--filter <key=value>``
  Filter parameters to apply on returned resource types.
  This can be specified multiple times. It can be any of
  name, version or support_status

``--long``
  Show resource types with corresponding description of
  each resource type.

.. _openstack_orchestration_resource_type_show:

openstack orchestration resource type show
------------------------------------------

.. code-block:: console

   usage: openstack orchestration resource type show [-h]
                                                     [-f {html,json,shell,table,value,yaml}]
                                                     [-c COLUMN]
                                                     [--max-width <integer>]
                                                     [--noindent]
                                                     [--prefix PREFIX]
                                                     [--template-type <template-type>]
                                                     [--long]
                                                     <resource-type>

Show details and optionally generate a template for a resource type.

**Positional arguments:**

``<resource-type>``
  Resource type to show details for

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--template-type <template-type>``
  Optional template type to generate, hot or cfn

``--long``
  Show resource type with corresponding description.

.. _openstack_orchestration_service_list:

openstack orchestration service list
------------------------------------

.. code-block:: console

   usage: openstack orchestration service list [-h]
                                               [-f {csv,html,json,table,value,yaml}]
                                               [-c COLUMN]
                                               [--max-width <integer>]
                                               [--noindent]
                                               [--quote {all,minimal,none,nonnumeric}]

List the Heat engines.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_orchestration_template_function_list:

openstack orchestration template function list
----------------------------------------------

.. code-block:: console

   usage: openstack orchestration template function list [-h]
                                                         [-f {csv,html,json,table,value,yaml}]
                                                         [-c COLUMN]
                                                         [--max-width <integer>]
                                                         [--noindent]
                                                         [--quote {all,minimal,none,nonnumeric}]
                                                         <template-version>

List the available functions.

**Positional arguments:**

``<template-version>``
  Template version to get the functions for

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_orchestration_template_validate:

openstack orchestration template validate
-----------------------------------------

.. code-block:: console

   usage: openstack orchestration template validate [-h]
                                                    [-f {html,json,shell,table,value,yaml}]
                                                    [-c COLUMN]
                                                    [--max-width <integer>]
                                                    [--noindent]
                                                    [--prefix PREFIX]
                                                    [-e <environment>]
                                                    [--show-nested]
                                                    [--parameter <key=value>]
                                                    [--ignore-errors <error1,error2,...>]
                                                    -t <template>

Validate a template

**Optional arguments:**

``-h, --help``
  show this help message and exit

``-e <environment>, --environment <environment>``
  Path to the environment. Can be specified multiple
  times

``--show-nested``
  Resolve parameters from nested templates as well

``--parameter <key=value>``
  Parameter values used to create the stack. This can be
  specified multiple times

``--ignore-errors <error1,error2,...>``
  List of heat errors to ignore

``-t <template>, --template <template>``
  Path to the template

.. _openstack_orchestration_template_version_list:

openstack orchestration template version list
---------------------------------------------

.. code-block:: console

   usage: openstack orchestration template version list [-h]
                                                        [-f {csv,html,json,table,value,yaml}]
                                                        [-c COLUMN]
                                                        [--max-width <integer>]
                                                        [--noindent]
                                                        [--quote {all,minimal,none,nonnumeric}]

List the available template versions.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_policy_create:

openstack policy create
-----------------------

.. code-block:: console

   usage: openstack policy create [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--noindent] [--prefix PREFIX] [--type <type>]
                                  <filename>

Create new policy

**Positional arguments:**

``<filename>``
  New serialized policy rules file

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--type <type>``
  New MIME type of the policy rules file (defaults to
  application/json)

.. _openstack_policy_delete:

openstack policy delete
-----------------------

.. code-block:: console

   usage: openstack policy delete [-h] <policy> [<policy> ...]

Delete policy(s)

**Positional arguments:**

``<policy>``
  Policy(s) to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_policy_list:

openstack policy list
---------------------

.. code-block:: console

   usage: openstack policy list [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}] [--long]

List policies

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--long``
  List additional fields in output

.. _openstack_policy_set:

openstack policy set
--------------------

.. code-block:: console

   usage: openstack policy set [-h] [--type <type>] [--rules <filename>] <policy>

Set policy properties

**Positional arguments:**

``<policy>``
  Policy to modify

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--type <type>``
  New MIME type of the policy rules file

``--rules <filename>``
  New serialized policy rules file

.. _openstack_policy_show:

openstack policy show
---------------------

.. code-block:: console

   usage: openstack policy show [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--prefix PREFIX]
                                <policy>

Display policy details

**Positional arguments:**

``<policy>``
  Policy to display

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_pool_create:

openstack pool create
---------------------

.. code-block:: console

   usage: openstack pool create [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--prefix PREFIX] [--pool_group <pool_group>]
                                [--pool_options <pool_options>]
                                <pool_name> <pool_uri> <pool_weight>

Create a pool

**Positional arguments:**

``<pool_name>``
  Name of the pool

``<pool_uri>``
  Storage engine URI

``<pool_weight>``
  weight of the pool

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--pool_group <pool_group>``
  Group of the pool

``--pool_options <pool_options>``
  An optional request component related to storage-specific options

.. _openstack_pool_delete:

openstack pool delete
---------------------

.. code-block:: console

   usage: openstack pool delete [-h] <pool_name>

Delete a pool

**Positional arguments:**

``<pool_name>``
  Name of the pool

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_pool_list:

openstack pool list
-------------------

.. code-block:: console

   usage: openstack pool list [-h] [-f {csv,html,json,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--noindent]
                              [--quote {all,minimal,none,nonnumeric}]
                              [--marker <pool_name>] [--limit <limit>]
                              [--detailed <detailed>]

List available Pools

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--marker <pool_name>``
  Pool's paging marker

``--limit <limit>``
  Page size limit

``--detailed <detailed>``
  Detailed output

.. _openstack_pool_show:

openstack pool show
-------------------

.. code-block:: console

   usage: openstack pool show [-h] [-f {html,json,shell,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--noindent]
                              [--prefix PREFIX]
                              <pool_name>

Display pool details

**Positional arguments:**

``<pool_name>``
  Pool to display (name)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_pool_update:

openstack pool update
---------------------

.. code-block:: console

   usage: openstack pool update [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--prefix PREFIX] [--pool_uri <pool_uri>]
                                [--pool_weight <pool_weight>]
                                [--pool_group <pool_group>]
                                [--pool_options <pool_options>]
                                <pool_name>

Update a pool attribute

**Positional arguments:**

``<pool_name>``
  Name of the pool

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--pool_uri <pool_uri>``
  Storage engine URI

``--pool_weight <pool_weight>``
  Weight of the pool

``--pool_group <pool_group>``
  Group of the pool

``--pool_options <pool_options>``
  An optional request component related to storage-specific options

.. _openstack_port_create:

openstack port create
---------------------

.. code-block:: console

   usage: openstack port create [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--prefix PREFIX] --network <network>
                                [--device <device-id>]
                                [--device-owner <device-owner>]
                                [--vnic-type <vnic-type>] [--host <host-id>]
                                [--fixed-ip subnet=<subnet>,ip-address=<ip-address>]
                                [--binding-profile <binding-profile>]
                                [--enable | --disable]
                                [--mac-address <mac-address>]
                                [--project <project>]
                                [--project-domain <project-domain>]
                                <name>

Create a new port

**Positional arguments:**

``<name>``
  Name of this port

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--network <network>``
  Network this port belongs to (name or ID)

``--device <device-id>``
  Port device ID

``--device-owner <device-owner>``
  Device owner of this port. This is the entity that
  uses the port (for example, network:dhcp).

``--vnic-type <vnic-type>``
  VNIC type for this port (direct | direct-physical |
  macvtap | normal | baremetal, default: normal)

``--host <host-id>``
  Allocate port on host <host-id> (ID only)

``--fixed-ip``
  subnet=<subnet>,ip-address=<ip-address>
  Desired IP and/or subnet (name or ID) for this port:
  subnet=<subnet>,ip-address=<ip-address> (repeat option
  to set multiple fixed IP addresses)

``--binding-profile <binding-profile>``
  Custom data to be passed as binding:profile. Data may
  be passed as <key>=<value> or JSON. (repeat option to
  set multiple binding:profile data)

``--enable``
  Enable port (default)

``--disable``
  Disable port

``--mac-address <mac-address>``
  MAC address of this port

``--project <project>``
  Owner's project (name or ID)

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

.. _openstack_port_delete:

openstack port delete
---------------------

.. code-block:: console

   usage: openstack port delete [-h] <port> [<port> ...]

Delete port(s)

**Positional arguments:**

``<port>``
  Port(s) to delete (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_port_list:

openstack port list
-------------------

.. code-block:: console

   usage: openstack port list [-h] [-f {csv,html,json,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--noindent]
                              [--quote {all,minimal,none,nonnumeric}]
                              [--device-owner <device-owner>] [--router <router>]

List ports

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--device-owner <device-owner>``
  List only ports with the specified device owner. This
  is the entity that uses the port (for example,
  network:dhcp).

``--router <router>``
  List only ports attached to this router (name or ID)

.. _openstack_port_set:

openstack port set
------------------

.. code-block:: console

   usage: openstack port set [-h] [--device <device-id>]
                             [--device-owner <device-owner>]
                             [--vnic-type <vnic-type>] [--host <host-id>]
                             [--enable | --disable] [--name <name>]
                             [--fixed-ip subnet=<subnet>,ip-address=<ip-address> | --no-fixed-ip]
                             [--binding-profile <binding-profile> | --no-binding-profile]
                             <port>

Set port properties

**Positional arguments:**

``<port>``
  Port to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--device <device-id>``
  Port device ID

``--device-owner <device-owner>``
  Device owner of this port. This is the entity that
  uses the port (for example, network:dhcp).

``--vnic-type <vnic-type>``
  VNIC type for this port (direct | direct-physical |
  macvtap | normal | baremetal, default: normal)

``--host <host-id>``
  Allocate port on host <host-id> (ID only)

``--enable``
  Enable port

``--disable``
  Disable port

``--name <name>``
  Set port name

``--fixed-ip``
  subnet=<subnet>,ip-address=<ip-address>
  Desired IP and/or subnet (name or ID) for this port:
  subnet=<subnet>,ip-address=<ip-address> (repeat option
  to set multiple fixed IP addresses)

``--no-fixed-ip``
  Clear existing information of fixed IP addresses

``--binding-profile <binding-profile>``
  Custom data to be passed as binding:profile. Data may
  be passed as <key>=<value> or JSON. (repeat option to
  set multiple binding:profile data)

``--no-binding-profile``
  Clear existing information of binding:profile

.. _openstack_port_show:

openstack port show
-------------------

.. code-block:: console

   usage: openstack port show [-h] [-f {html,json,shell,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--noindent]
                              [--prefix PREFIX]
                              <port>

Display port details

**Positional arguments:**

``<port>``
  Port to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_port_unset:

openstack port unset
--------------------

.. code-block:: console

   usage: openstack port unset [-h]
                               [--fixed-ip subnet=<subnet>,ip-address=<ip-address>]
                               [--binding-profile <binding-profile-key>]
                               <port>

Unset port properties

**Positional arguments:**

``<port>``
  Port to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--fixed-ip``
  subnet=<subnet>,ip-address=<ip-address>
  Desired IP and/or subnet (name or ID) which should be
  removed from this port: subnet=<subnet>,ip-address
  =<ip-address> (repeat option to unset multiple fixed
  IP addresses)

``--binding-profile <binding-profile-key>``
  Desired key which should be removed from
  binding:profile(repeat option to unset multiple
  binding:profile data)

.. _openstack_project_create:

openstack project create
------------------------

.. code-block:: console

   usage: openstack project create [-h] [-f {html,json,shell,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--noindent] [--prefix PREFIX]
                                   [--domain <domain>] [--parent <project>]
                                   [--description <description>]
                                   [--enable | --disable]
                                   [--property <key=value>] [--or-show]
                                   <project-name>

Create new project

**Positional arguments:**

``<project-name>``
  New project name

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--domain <domain>``
  Domain owning the project (name or ID)

``--parent <project>``
  Parent of the project (name or ID)

``--description <description>``
  Project description

``--enable``
  Enable project

``--disable``
  Disable project

``--property <key=value>``
  Add a property to <name> (repeat option to set
  multiple properties)

``--or-show``
  Return existing project

.. _openstack_project_delete:

openstack project delete
------------------------

.. code-block:: console

   usage: openstack project delete [-h] [--domain <domain>]
                                   <project> [<project> ...]

Delete project(s)

**Positional arguments:**

``<project>``
  Project(s) to delete (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--domain <domain>``
  Domain owning <project> (name or ID)

.. _openstack_project_list:

openstack project list
----------------------

.. code-block:: console

   usage: openstack project list [-h] [-f {csv,html,json,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>] [--noindent]
                                 [--quote {all,minimal,none,nonnumeric}]
                                 [--domain <domain>] [--user <user>] [--long]

List projects

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--domain <domain>``
  Filter projects by <domain> (name or ID)

``--user <user>``
  Filter projects by <user> (name or ID)

``--long``
  List additional fields in output

.. _openstack_project_set:

openstack project set
---------------------

.. code-block:: console

   usage: openstack project set [-h] [--name <name>] [--domain <domain>]
                                [--description <description>]
                                [--enable | --disable] [--property <key=value>]
                                <project>

Set project properties

**Positional arguments:**

``<project>``
  Project to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  Set project name

``--domain <domain>``
  Domain owning <project> (name or ID)

``--description <description>``
  Set project description

``--enable``
  Enable project

``--disable``
  Disable project

``--property <key=value>``
  Set a property on <project> (repeat option to set
  multiple properties)

.. _openstack_project_show:

openstack project show
----------------------

.. code-block:: console

   usage: openstack project show [-h] [-f {html,json,shell,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>] [--noindent]
                                 [--prefix PREFIX] [--domain <domain>]
                                 [--parents] [--children]
                                 <project>

Display project details

**Positional arguments:**

``<project>``
  Project to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--domain <domain>``
  Domain owning <project> (name or ID)

``--parents``
  Show the project's parents as a list

``--children``
  Show project's subtree (children) as a list

.. _openstack_ptr_record_list:

openstack ptr record list
-------------------------

.. code-block:: console

   usage: openstack ptr record list [-h] [-f {csv,html,json,table,value,yaml}]
                                    [-c COLUMN] [--max-width <integer>]
                                    [--noindent]
                                    [--quote {all,minimal,none,nonnumeric}]

List floatingip ptr records

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_ptr_record_set:

openstack ptr record set
------------------------

.. code-block:: console

   usage: openstack ptr record set [-h] [-f {html,json,shell,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--noindent] [--prefix PREFIX]
                                   [--description DESCRIPTION | --no-description]
                                   [--ttl TTL | --no-ttl] [--all-projects]
                                   [--edit-managed]
                                   [--sudo-project-id SUDO_PROJECT_ID]
                                   floatingip_id ptrdname

Set floatingip ptr record

**Positional arguments:**

``floatingip_id``
  Floating IP ID

``ptrdname``
  PTRD Name

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--description DESCRIPTION``
  Description

``--no-description``

``--ttl TTL``
  TTL

``--no-ttl``

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_ptr_record_show:

openstack ptr record show
-------------------------

.. code-block:: console

   usage: openstack ptr record show [-h] [-f {html,json,shell,table,value,yaml}]
                                    [-c COLUMN] [--max-width <integer>]
                                    [--noindent] [--prefix PREFIX]
                                    [--all-projects] [--edit-managed]
                                    [--sudo-project-id SUDO_PROJECT_ID]
                                    floatingip_id

Show floatingip ptr record details

**Positional arguments:**

``floatingip_id``
  Floating IP ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_ptr_record_unset:

openstack ptr record unset
--------------------------

.. code-block:: console

   usage: openstack ptr record unset [-h] [--all-projects] [--edit-managed]
                                     [--sudo-project-id SUDO_PROJECT_ID]
                                     floatingip_id

Unset floatingip ptr record

**Positional arguments:**

``floatingip_id``
  Floating IP ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_queue_create:

openstack queue create
----------------------

.. code-block:: console

   usage: openstack queue create [-h] [-f {html,json,shell,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>] [--noindent]
                                 [--prefix PREFIX]
                                 <queue_name>

Create a queue

**Positional arguments:**

``<queue_name>``
  Name of the queue

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_queue_delete:

openstack queue delete
----------------------

.. code-block:: console

   usage: openstack queue delete [-h] <queue_name>

Delete a queue

**Positional arguments:**

``<queue_name>``
  Name of the queue

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_queue_get_metadata:

openstack queue get metadata
----------------------------

.. code-block:: console

   usage: openstack queue get metadata [-h]
                                       [-f {html,json,shell,table,value,yaml}]
                                       [-c COLUMN] [--max-width <integer>]
                                       [--noindent] [--prefix PREFIX]
                                       <queue_name>

Get queue metadata

**Positional arguments:**

``<queue_name>``
  Name of the queue

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_queue_list:

openstack queue list
--------------------

.. code-block:: console

   usage: openstack queue list [-h] [-f {csv,html,json,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>] [--noindent]
                               [--quote {all,minimal,none,nonnumeric}]
                               [--marker <queue_id>] [--limit <limit>]

List available queues

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--marker <queue_id>``
  Queue's paging marker

``--limit <limit>``
  Page size limit

.. _openstack_queue_set_metadata:

openstack queue set metadata
----------------------------

.. code-block:: console

   usage: openstack queue set metadata [-h] <queue_name> <queue_metadata>

Set queue metadata

**Positional arguments:**

``<queue_name>``
  Name of the queue

``<queue_metadata>``
  Queue metadata

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_queue_signed_url:

openstack queue signed url
--------------------------

.. code-block:: console

   usage: openstack queue signed url [-h] [-f {html,json,shell,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--noindent] [--prefix PREFIX]
                                     [--paths <paths>]
                                     [--ttl-seconds <ttl_seconds>]
                                     [--methods <methods>]
                                     <queue_name>

Create a queue

**Positional arguments:**

``<queue_name>``
  Name of the queue

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--paths <paths>``
  Allowed paths in a comma-separated list. Options:
  messages, subscriptions, claims

``--ttl-seconds <ttl_seconds>``
  Length of time (in seconds) until the signature
  expires

``--methods <methods>``
  HTTP methods to allow as a comma-separated list.
  Options: GET, HEAD, OPTIONS, POST, PUT, DELETE

.. _openstack_queue_stats:

openstack queue stats
---------------------

.. code-block:: console

   usage: openstack queue stats [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--prefix PREFIX]
                                <queue_name>

Get queue stats

**Positional arguments:**

``<queue_name>``
  Name of the queue

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_quota_set:

openstack quota set
-------------------

.. code-block:: console

   usage: openstack quota set [-h] [--class] [--properties <properties>]
                              [--server-groups <server-groups>] [--ram <ram>]
                              [--key-pairs <key-pairs>] [--instances <instances>]
                              [--fixed-ips <fixed-ips>]
                              [--injected-file-size <injected-file-size>]
                              [--server-group-members <server-group-members>]
                              [--injected-files <injected-files>]
                              [--cores <cores>]
                              [--injected-path-size <injected-path-size>]
                              [--gigabytes <gigabytes>] [--volumes <volumes>]
                              [--snapshots <snapshots>]
                              [--subnetpools <subnetpools>] [--vips <vips>]
                              [--members <members>] [--ports <ports>]
                              [--subnets <subnets>] [--networks <networks>]
                              [--floating-ips <floating-ips>]
                              [--health-monitors <health-monitors>]
                              [--secgroup-rules <secgroup-rules>]
                              [--secgroups <secgroups>] [--routers <routers>]
                              [--rbac-policies <rbac-policies>]
                              [--volume-type <volume-type>]
                              <project/class>

Set quotas for project or class

**Positional arguments:**

``<project/class>``
  Set quotas for this project or class (name/ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--class``
  Set quotas for <class>

``--properties <properties>``
  New value for the properties quota

``--server-groups <server-groups>``
  New value for the server-groups quota

``--ram <ram>``
  New value for the ram quota

``--key-pairs <key-pairs>``
  New value for the key-pairs quota

``--instances <instances>``
  New value for the instances quota

``--fixed-ips <fixed-ips>``
  New value for the fixed-ips quota

``--injected-file-size <injected-file-size>``
  New value for the injected-file-size quota

``--server-group-members <server-group-members>``
  New value for the server-group-members quota

``--injected-files <injected-files>``
  New value for the injected-files quota

``--cores <cores>``
  New value for the cores quota

``--injected-path-size <injected-path-size>``
  New value for the injected-path-size quota

``--gigabytes <gigabytes>``
  New value for the gigabytes quota

``--volumes <volumes>``
  New value for the volumes quota

``--snapshots <snapshots>``
  New value for the snapshots quota

``--subnetpools <subnetpools>``
  New value for the subnetpools quota

``--vips <vips>``
  New value for the vips quota

``--members <members>``
  New value for the members quota

``--ports <ports>``
  New value for the ports quota

``--subnets <subnets>``
  New value for the subnets quota

``--networks <networks>``
  New value for the networks quota

``--floating-ips <floating-ips>``
  New value for the floating-ips quota

``--health-monitors <health-monitors>``
  New value for the health-monitors quota

``--secgroup-rules <secgroup-rules>``
  New value for the secgroup-rules quota

``--secgroups <secgroups>``
  New value for the secgroups quota

``--routers <routers>``
  New value for the routers quota

``--rbac-policies <rbac-policies>``
  New value for the rbac-policies quota

``--volume-type <volume-type>``
  Set quotas for a specific <volume-type>

.. _openstack_quota_show:

openstack quota show
--------------------

.. code-block:: console

   usage: openstack quota show [-h] [-f {html,json,shell,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>] [--noindent]
                               [--prefix PREFIX] [--class | --default]
                               [<project/class>]

Show quotas for project or class

**Positional arguments:**

``<project/class>``
  Show quotas for this project or class (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--class``
  Show quotas for <class>

``--default``
  Show default quotas for <project>

.. _openstack_recordset_create:

openstack recordset create
--------------------------

.. code-block:: console

   usage: openstack recordset create [-h] [-f {html,json,shell,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--noindent] [--prefix PREFIX] --records
                                     RECORDS [RECORDS ...] --type TYPE
                                     [--ttl TTL] [--description DESCRIPTION]
                                     [--all-projects] [--edit-managed]
                                     [--sudo-project-id SUDO_PROJECT_ID]
                                     zone_id name

Create new recordset

**Positional arguments:**

``zone_id``
  Zone ID

``name``
  RecordSet Name

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--records RECORDS [RECORDS ...]``
  RecordSet Records

``--type TYPE``
  RecordSet Type

``--ttl TTL``
  Time To Live (Seconds)

``--description DESCRIPTION``
  Description

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_recordset_delete:

openstack recordset delete
--------------------------

.. code-block:: console

   usage: openstack recordset delete [-h] [-f {html,json,shell,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--noindent] [--prefix PREFIX]
                                     [--all-projects] [--edit-managed]
                                     [--sudo-project-id SUDO_PROJECT_ID]
                                     zone_id id

Delete recordset

**Positional arguments:**

``zone_id``
  Zone ID

``id``
  RecordSet ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_recordset_list:

openstack recordset list
------------------------

.. code-block:: console

   usage: openstack recordset list [-h] [-f {csv,html,json,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--noindent]
                                   [--quote {all,minimal,none,nonnumeric}]
                                   [--name NAME] [--type TYPE] [--data DATA]
                                   [--ttl TTL] [--description DESCRIPTION]
                                   [--status STATUS] [--action ACTION]
                                   [--all-projects] [--edit-managed]
                                   [--sudo-project-id SUDO_PROJECT_ID]
                                   zone_id

List recordsets

**Positional arguments:**

``zone_id``
  Zone ID. To list all recordsets specify 'all'

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name NAME``
  RecordSet Name

``--type TYPE``
  RecordSet Type

``--data DATA``
  RecordSet Record Data

``--ttl TTL``
  Time To Live (Seconds)

``--description DESCRIPTION``
  Description

``--status STATUS``
  RecordSet Status

``--action ACTION``
  RecordSet Action

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_recordset_set:

openstack recordset set
-----------------------

.. code-block:: console

   usage: openstack recordset set [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--noindent] [--prefix PREFIX]
                                  [--records RECORDS [RECORDS ...]]
                                  [--description DESCRIPTION | --no-description]
                                  [--ttl TTL | --no-ttl] [--all-projects]
                                  [--edit-managed]
                                  [--sudo-project-id SUDO_PROJECT_ID]
                                  zone_id id

Set recordset properties

**Positional arguments:**

``zone_id``
  Zone ID

``id``
  RecordSet ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--records RECORDS [RECORDS ...]``
  Records

``--description DESCRIPTION``
  Description

``--no-description``

``--ttl TTL``
  TTL

``--no-ttl``

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_recordset_show:

openstack recordset show
------------------------

.. code-block:: console

   usage: openstack recordset show [-h] [-f {html,json,shell,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--noindent] [--prefix PREFIX]
                                   [--all-projects] [--edit-managed]
                                   [--sudo-project-id SUDO_PROJECT_ID]
                                   zone_id id

Show recordset details

**Positional arguments:**

``zone_id``
  Zone ID

``id``
  RecordSet ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_region_create:

openstack region create
-----------------------

.. code-block:: console

   usage: openstack region create [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--noindent] [--prefix PREFIX]
                                  [--parent-region <region-id>]
                                  [--description <description>]
                                  <region-id>

Create new region

**Positional arguments:**

``<region-id>``
  New region ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--parent-region <region-id>``
  Parent region ID

``--description <description>``
  New region description

.. _openstack_region_delete:

openstack region delete
-----------------------

.. code-block:: console

   usage: openstack region delete [-h] <region-id> [<region-id> ...]

Delete region(s)

**Positional arguments:**

``<region-id>``
  Region ID(s) to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_region_list:

openstack region list
---------------------

.. code-block:: console

   usage: openstack region list [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}]
                                [--parent-region <region-id>]

List regions

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--parent-region <region-id>``
  Filter by parent region ID

.. _openstack_region_set:

openstack region set
--------------------

.. code-block:: console

   usage: openstack region set [-h] [--parent-region <region-id>]
                               [--description <description>]
                               <region-id>

Set region properties

**Positional arguments:**

``<region-id>``
  Region to modify

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--parent-region <region-id>``
  New parent region ID

``--description <description>``
  New region description

.. _openstack_region_show:

openstack region show
---------------------

.. code-block:: console

   usage: openstack region show [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--prefix PREFIX]
                                <region-id>

Display region details

**Positional arguments:**

``<region-id>``
  Region to display

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_request_token_authorize:

openstack request token authorize
---------------------------------

.. code-block:: console

   usage: openstack request token authorize [-h]
                                            [-f {html,json,shell,table,value,yaml}]
                                            [-c COLUMN] [--max-width <integer>]
                                            [--noindent] [--prefix PREFIX]
                                            --request-key <request-key> --role
                                            <role>

Authorize a request token

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--request-key <request-key>``
  Request token to authorize (ID only) (required)

``--role <role>``
  Roles to authorize (name or ID) (repeat option to set
  multiple values, required)

.. _openstack_request_token_create:

openstack request token create
------------------------------

.. code-block:: console

   usage: openstack request token create [-h]
                                         [-f {html,json,shell,table,value,yaml}]
                                         [-c COLUMN] [--max-width <integer>]
                                         [--noindent] [--prefix PREFIX]
                                         --consumer-key <consumer-key>
                                         --consumer-secret <consumer-secret>
                                         --project <project> [--domain <domain>]

Create a request token

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--consumer-key <consumer-key>``
  Consumer key (required)

``--consumer-secret <consumer-secret>``
  Consumer secret (required)

``--project <project>``
  Project that consumer wants to access (name or ID)
  (required)

``--domain <domain>``
  Domain owning <project> (name or ID)

.. _openstack_role_add:

openstack role add
------------------

.. code-block:: console

   usage: openstack role add [-h] [--domain <domain> | --project <project>]
                             [--user <user> | --group <group>]
                             [--group-domain <group-domain>]
                             [--project-domain <project-domain>]
                             [--user-domain <user-domain>] [--inherited]
                             [--role-domain <role-domain>]
                             <role>

Adds a role assignment to a user or group on a domain or project

**Positional arguments:**

``<role>``
  Role to add to <user> (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--domain <domain>``
  Include <domain> (name or ID)

``--project <project>``
  Include <project> (name or ID)

``--user <user>``
  Include <user> (name or ID)

``--group <group>``
  Include <group> (name or ID)

``--group-domain <group-domain>``
  Domain the group belongs to (name or ID). This can be
  used in case collisions between group names exist.

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

``--user-domain <user-domain>``
  Domain the user belongs to (name or ID). This can be
  used in case collisions between user names exist.

``--inherited``
  Specifies if the role grant is inheritable to the sub
  projects

``--role-domain <role-domain>``
  Domain the role belongs to (name or ID). This must be
  specified when the name of a domain specific role is
  used.

.. _openstack_role_assignment_list:

openstack role assignment list
------------------------------

.. code-block:: console

   usage: openstack role assignment list [-h]
                                         [-f {csv,html,json,table,value,yaml}]
                                         [-c COLUMN] [--max-width <integer>]
                                         [--noindent]
                                         [--quote {all,minimal,none,nonnumeric}]
                                         [--effective] [--role <role>]
                                         [--role-domain <role-domain>] [--names]
                                         [--user <user>]
                                         [--user-domain <user-domain>]
                                         [--group <group>]
                                         [--group-domain <group-domain>]
                                         [--domain <domain> | --project <project>]
                                         [--project-domain <project-domain>]
                                         [--inherited] [--auth-user]
                                         [--auth-project]

List role assignments

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--effective``
  Returns only effective role assignments

``--role <role>``
  Role to filter (name or ID)

``--role-domain <role-domain>``
  Domain the role belongs to (name or ID). This must be
  specified when the name of a domain specific role is
  used.

``--names``
  Display names instead of IDs

``--user <user>``
  User to filter (name or ID)

``--user-domain <user-domain>``
  Domain the user belongs to (name or ID). This can be
  used in case collisions between user names exist.

``--group <group>``
  Group to filter (name or ID)

``--group-domain <group-domain>``
  Domain the group belongs to (name or ID). This can be
  used in case collisions between group names exist.

``--domain <domain>``
  Domain to filter (name or ID)

``--project <project>``
  Project to filter (name or ID)

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

``--inherited``
  Specifies if the role grant is inheritable to the sub
  projects

``--auth-user``
  Only list assignments for the authenticated user

``--auth-project``
  Only list assignments for the project to which the
  authenticated user's token is scoped

.. _openstack_role_create:

openstack role create
---------------------

.. code-block:: console

   usage: openstack role create [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--prefix PREFIX] [--domain <domain>] [--or-show]
                                <role-name>

Create new role

**Positional arguments:**

``<role-name>``
  New role name

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--domain <domain>``
  Domain the role belongs to (name or ID)

``--or-show``
  Return existing role

.. _openstack_role_delete:

openstack role delete
---------------------

.. code-block:: console

   usage: openstack role delete [-h] [--domain <domain>] <role> [<role> ...]

Delete role(s)

**Positional arguments:**

``<role>``
  Role(s) to delete (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--domain <domain>``
  Domain the role belongs to (name or ID)

.. _openstack_role_list:

openstack role list
-------------------

.. code-block:: console

   usage: openstack role list [-h] [-f {csv,html,json,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--noindent]
                              [--quote {all,minimal,none,nonnumeric}]
                              [--domain <domain> | --project <project>]
                              [--user <user> | --group <group>]
                              [--group-domain <group-domain>]
                              [--project-domain <project-domain>]
                              [--user-domain <user-domain>] [--inherited]

List roles

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--domain <domain>``
  Include <domain> (name or ID)

``--project <project>``
  Include <project> (name or ID)

``--user <user>``
  Include <user> (name or ID)

``--group <group>``
  Include <group> (name or ID)

``--group-domain <group-domain>``
  Domain the group belongs to (name or ID). This can be
  used in case collisions between group names exist.

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

``--user-domain <user-domain>``
  Domain the user belongs to (name or ID). This can be
  used in case collisions between user names exist.

``--inherited``
  Specifies if the role grant is inheritable to the sub
  projects

.. _openstack_role_remove:

openstack role remove
---------------------

.. code-block:: console

   usage: openstack role remove [-h] [--domain <domain> | --project <project>]
                                [--user <user> | --group <group>]
                                [--group-domain <group-domain>]
                                [--project-domain <project-domain>]
                                [--user-domain <user-domain>] [--inherited]
                                [--role-domain <role-domain>]
                                <role>

Removes a role assignment from domain/project : user/group

**Positional arguments:**

``<role>``
  Role to remove (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--domain <domain>``
  Include <domain> (name or ID)

``--project <project>``
  Include <project> (name or ID)

``--user <user>``
  Include <user> (name or ID)

``--group <group>``
  Include <group> (name or ID)

``--group-domain <group-domain>``
  Domain the group belongs to (name or ID). This can be
  used in case collisions between group names exist.

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

``--user-domain <user-domain>``
  Domain the user belongs to (name or ID). This can be
  used in case collisions between user names exist.

``--inherited``
  Specifies if the role grant is inheritable to the sub
  projects

``--role-domain <role-domain>``
  Domain the role belongs to (name or ID). This must be
  specified when the name of a domain specific role is
  used.

.. _openstack_role_set:

openstack role set
------------------

.. code-block:: console

   usage: openstack role set [-h] [--domain <domain>] [--name <name>] <role>

Set role properties

**Positional arguments:**

``<role>``
  Role to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--domain <domain>``
  Domain the role belongs to (name or ID)

``--name <name>``
  Set role name

.. _openstack_role_show:

openstack role show
-------------------

.. code-block:: console

   usage: openstack role show [-h] [-f {html,json,shell,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--noindent]
                              [--prefix PREFIX] [--domain <domain>]
                              <role>

Display role details

**Positional arguments:**

``<role>``
  Role to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--domain <domain>``
  Domain the role belongs to (name or ID)

.. _openstack_router_add_port:

openstack router add port
-------------------------

.. code-block:: console

   usage: openstack router add port [-h] <router> <port>

Add a port to a router

**Positional arguments:**

``<router>``
  Router to which port will be added (name or ID)

``<port>``
  Port to be added (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_router_add_subnet:

openstack router add subnet
---------------------------

.. code-block:: console

   usage: openstack router add subnet [-h] <router> <subnet>

Add a subnet to a router

**Positional arguments:**

``<router>``
  Router to which subnet will be added (name or ID)

``<subnet>``
  Subnet to be added (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_router_create:

openstack router create
-----------------------

.. code-block:: console

   usage: openstack router create [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--noindent] [--prefix PREFIX]
                                  [--enable | --disable] [--distributed]
                                  [--project <project>]
                                  [--project-domain <project-domain>]
                                  [--availability-zone-hint <availability-zone>]
                                  <name>

Create a new router

**Positional arguments:**

``<name>``
  New router name

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--enable``
  Enable router (default)

``--disable``
  Disable router

``--distributed``
  Create a distributed router

``--project <project>``
  Owner's project (name or ID)

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

``--availability-zone-hint <availability-zone>``
  Availability Zone in which to create this router
  (Router Availability Zone extension required, repeat
  option to set multiple availability zones)

.. _openstack_router_delete:

openstack router delete
-----------------------

.. code-block:: console

   usage: openstack router delete [-h] <router> [<router> ...]

Delete router(s)

**Positional arguments:**

``<router>``
  Router(s) to delete (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_router_list:

openstack router list
---------------------

.. code-block:: console

   usage: openstack router list [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}] [--long]

List routers

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--long``
  List additional fields in output

.. _openstack_router_remove_port:

openstack router remove port
----------------------------

.. code-block:: console

   usage: openstack router remove port [-h] <router> <port>

Remove a port from a router

**Positional arguments:**

``<router>``
  Router from which port will be removed (name or ID)

``<port>``
  Port to be removed and deleted (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_router_remove_subnet:

openstack router remove subnet
------------------------------

.. code-block:: console

   usage: openstack router remove subnet [-h] <router> <subnet>

Remove a subnet from a router

**Positional arguments:**

``<router>``
  Router from which the subnet will be removed (name or ID)

``<subnet>``
  Subnet to be removed (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_router_set:

openstack router set
--------------------

.. code-block:: console

   usage: openstack router set [-h] [--name <name>] [--enable | --disable]
                               [--distributed | --centralized]
                               [--route destination=<subnet>,gateway=<ip-address> | --no-route]
                               <router>

Set router properties

**Positional arguments:**

``<router>``
  Router to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  Set router name

``--enable``
  Enable router

``--disable``
  Disable router

``--distributed``
  Set router to distributed mode (disabled router only)

``--centralized``
  Set router to centralized mode (disabled router only)

``--route``
  destination=<subnet>,gateway=<ip-address>
  Routes associated with the router destination:
  destination subnet (in CIDR notation) gateway: nexthop
  IP address (repeat option to set multiple routes)

``--no-route``
  Clear routes associated with the router

.. _openstack_router_show:

openstack router show
---------------------

.. code-block:: console

   usage: openstack router show [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--prefix PREFIX]
                                <router>

Display router details

**Positional arguments:**

``<router>``
  Router to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_router_unset:

openstack router unset
----------------------

.. code-block:: console

   usage: openstack router unset [-h]
                                 [--route destination=<subnet>,gateway=<ip-address>]
                                 <router>

Unset router properties

**Positional arguments:**

``<router>``
  Router to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--route``
  destination=<subnet>,gateway=<ip-address>
  Routes to be removed from the router destination:
  destination subnet (in CIDR notation) gateway: nexthop
  IP address (repeat option to unset multiple routes)

.. _openstack_secret_container_create:

openstack secret container create
---------------------------------

.. code-block:: console

   usage: openstack secret container create [-h]
                                            [-f {html,json,shell,table,value,yaml}]
                                            [-c COLUMN] [--max-width <integer>]
                                            [--noindent] [--prefix PREFIX]
                                            [--name NAME] [--type TYPE]
                                            [--secret SECRET]

Store a container in Barbican.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name NAME, -n NAME``
  a human-friendly name.

``--type TYPE``
  type of container to create (default: generic).

``--secret SECRET, -s SECRET``
  one secret to store in a container (can be set
  multiple times). Example: :option:`--secret`
  "private_key=https://url.test/v1/secrets/1-2-3-4"

.. _openstack_secret_container_delete:

openstack secret container delete
---------------------------------

.. code-block:: console

   usage: openstack secret container delete [-h] URI

Delete a container by providing its href.

**Positional arguments:**

``URI``
  The URI reference for the container

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_secret_container_get:

openstack secret container get
------------------------------

.. code-block:: console

   usage: openstack secret container get [-h]
                                         [-f {html,json,shell,table,value,yaml}]
                                         [-c COLUMN] [--max-width <integer>]
                                         [--noindent] [--prefix PREFIX]
                                         URI

Retrieve a container by providing its URI.

**Positional arguments:**

``URI``
  The URI reference for the container.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_secret_container_list:

openstack secret container list
-------------------------------

.. code-block:: console

   usage: openstack secret container list [-h]
                                          [-f {csv,html,json,table,value,yaml}]
                                          [-c COLUMN] [--max-width <integer>]
                                          [--noindent]
                                          [--quote {all,minimal,none,nonnumeric}]
                                          [--limit LIMIT] [--offset OFFSET]
                                          [--name NAME] [--type TYPE]

List containers.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--limit LIMIT, -l LIMIT``
  specify the limit to the number of items to list per
  page (default: 10; maximum: 100)

``--offset OFFSET, -o OFFSET``
  specify the page offset (default: 0)

``--name NAME, -n NAME``
  specify the container name (default: None)

``--type TYPE, -t TYPE``
  specify the type filter for the list (default: None).

.. _openstack_secret_delete:

openstack secret delete
-----------------------

.. code-block:: console

   usage: openstack secret delete [-h] URI

Delete a secret by providing its URI.

**Positional arguments:**

``URI``
  The URI reference for the secret

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_secret_get:

openstack secret get
--------------------

.. code-block:: console

   usage: openstack secret get [-h] [-f {html,json,shell,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>] [--noindent]
                               [--prefix PREFIX] [--decrypt] [--payload]
                               [--payload_content_type PAYLOAD_CONTENT_TYPE]
                               URI

Retrieve a secret by providing its URI.

**Positional arguments:**

``URI``
  The URI reference for the secret.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--decrypt, -d``
  if specified, retrieve the unencrypted secret data;
  the data type can be specified with :option:`--payload-content-`
  type.

``--payload, -p``
  if specified, retrieve the unencrypted secret data;
  the data type can be specified with :option:`--payload-content-`
  type. If the user wishes to only retrieve the value of
  the payload they must add "-f value" to format
  returning only the value of the payload

``--payload_content_type PAYLOAD_CONTENT_TYPE, -t PAYLOAD_CONTENT_TYPE``
  the content type of the decrypted secret (default:
  text/plain.

.. _openstack_secret_list:

openstack secret list
---------------------

.. code-block:: console

   usage: openstack secret list [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}]
                                [--limit LIMIT] [--offset OFFSET] [--name NAME]
                                [--algorithm ALGORITHM] [--bit-length BIT_LENGTH]
                                [--mode MODE]

List secrets.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--limit LIMIT, -l LIMIT``
  specify the limit to the number of items to list per
  page (default: 10; maximum: 100)

``--offset OFFSET, -o OFFSET``
  specify the page offset (default: 0)

``--name NAME, -n NAME``
  specify the secret name (default: None)

``--algorithm ALGORITHM, -a ALGORITHM``
  the algorithm filter for the list(default: None).

``--bit-length BIT_LENGTH, -b BIT_LENGTH``
  the bit length filter for the list (default: 0).

``--mode MODE, -m MODE``
  the algorithm mode filter for the list (default:
  None).

.. _openstack_secret_order_create:

openstack secret order create
-----------------------------

.. code-block:: console

   usage: openstack secret order create [-h]
                                        [-f {html,json,shell,table,value,yaml}]
                                        [-c COLUMN] [--max-width <integer>]
                                        [--noindent] [--prefix PREFIX]
                                        [--name NAME] [--algorithm ALGORITHM]
                                        [--bit-length BIT_LENGTH] [--mode MODE]
                                        [--payload-content-type PAYLOAD_CONTENT_TYPE]
                                        [--expiration EXPIRATION]
                                        [--request-type REQUEST_TYPE]
                                        [--subject-dn SUBJECT_DN]
                                        [--source-container-ref SOURCE_CONTAINER_REF]
                                        [--ca-id CA_ID] [--profile PROFILE]
                                        [--request-file REQUEST_FILE]
                                        type

Create a new order.

**Positional arguments:**

``type``
  the type of the order to create.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name NAME, -n NAME``
  a human-friendly name.

``--algorithm ALGORITHM, -a ALGORITHM``
  the algorithm to be used with the requested key
  (default: aes).

``--bit-length BIT_LENGTH, -b BIT_LENGTH``
  the bit length of the requested secret key (default:
  256).

``--mode MODE, -m MODE``
  the algorithm mode to be used with the requested key
  (default: cbc).

``--payload-content-type PAYLOAD_CONTENT_TYPE, -t PAYLOAD_CONTENT_TYPE``
  the type/format of the secret to be generated
  (default: application/octet-stream).

``--expiration EXPIRATION, -x EXPIRATION``
  the expiration time for the secret in ISO 8601 format.

``--request-type REQUEST_TYPE``
  the type of the certificate request.

``--subject-dn SUBJECT_DN``
  the subject of the certificate.

``--source-container-ref SOURCE_CONTAINER_REF``
  the source of the certificate when using stored-key
  requests.

``--ca-id CA_ID``
  the identifier of the CA to use for the certificate
  request.

``--profile PROFILE``
  the profile of certificate to use.

``--request-file REQUEST_FILE``
  the file containing the CSR.

.. _openstack_secret_order_delete:

openstack secret order delete
-----------------------------

.. code-block:: console

   usage: openstack secret order delete [-h] URI

Delete an order by providing its href.

**Positional arguments:**

``URI``
  The URI reference for the order

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_secret_order_get:

openstack secret order get
--------------------------

.. code-block:: console

   usage: openstack secret order get [-h] [-f {html,json,shell,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--noindent] [--prefix PREFIX]
                                     URI

Retrieve an order by providing its URI.

**Positional arguments:**

``URI``
  The URI reference order.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_secret_order_list:

openstack secret order list
---------------------------

.. code-block:: console

   usage: openstack secret order list [-h] [-f {csv,html,json,table,value,yaml}]
                                      [-c COLUMN] [--max-width <integer>]
                                      [--noindent]
                                      [--quote {all,minimal,none,nonnumeric}]
                                      [--limit LIMIT] [--offset OFFSET]

List orders.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--limit LIMIT, -l LIMIT``
  specify the limit to the number of items to list per
  page (default: 10; maximum: 100)

``--offset OFFSET, -o OFFSET``
  specify the page offset (default: 0)

.. _openstack_secret_store:

openstack secret store
----------------------

.. code-block:: console

   usage: openstack secret store [-h] [-f {html,json,shell,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>] [--noindent]
                                 [--prefix PREFIX] [--name NAME]
                                 [--payload PAYLOAD] [--secret-type SECRET_TYPE]
                                 [--payload-content-type PAYLOAD_CONTENT_TYPE]
                                 [--payload-content-encoding PAYLOAD_CONTENT_ENCODING]
                                 [--algorithm ALGORITHM]
                                 [--bit-length BIT_LENGTH] [--mode MODE]
                                 [--expiration EXPIRATION]

Store a secret in Barbican.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name NAME, -n NAME``
  a human-friendly name.

``--payload PAYLOAD, -p PAYLOAD``
  the unencrypted secret; if provided, you must also
  provide a payload_content_type

``--secret-type SECRET_TYPE, -s SECRET_TYPE``
  the secret type; must be one of symmetric, public,
  private, certificate, passphrase, opaque (default)

``--payload-content-type PAYLOAD_CONTENT_TYPE, -t PAYLOAD_CONTENT_TYPE``
  the type/format of the provided secret data;
  "text/plain" is assumed to be UTF-8; required when
  :option:`--payload` is supplied.

``--payload-content-encoding PAYLOAD_CONTENT_ENCODING, -e PAYLOAD_CONTENT_ENCODING``
  required if :option:`--payload-content-type` is "application
  /octet-stream".

``--algorithm ALGORITHM, -a ALGORITHM``
  the algorithm (default: aes).

``--bit-length BIT_LENGTH, -b BIT_LENGTH``
  the bit length (default: 256).

``--mode MODE, -m MODE``
  the algorithm mode; used only for reference (default:
  cbc)

``--expiration EXPIRATION, -x EXPIRATION``
  the expiration time for the secret in ISO 8601 format.

.. _openstack_secret_update:

openstack secret update
-----------------------

.. code-block:: console

   usage: openstack secret update [-h] URI payload

Update a secret with no payload in Barbican.

**Positional arguments:**

``URI``
  The URI reference for the secret.

``payload``
  the unencrypted secret

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_security_group_create:

openstack security group create
-------------------------------

.. code-block:: console

   usage: openstack security group create [-h]
                                          [-f {html,json,shell,table,value,yaml}]
                                          [-c COLUMN] [--max-width <integer>]
                                          [--noindent] [--prefix PREFIX]
                                          [--description <description>]
                                          [--project <project>]
                                          [--project-domain <project-domain>]
                                          <name>

Create a new security group

**Positional arguments:**

``<name>``
  New security group name

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--description <description>``
  Security group description

``--project <project>``
  Owner's project (name or ID)

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

.. _openstack_security_group_delete:

openstack security group delete
-------------------------------

.. code-block:: console

   usage: openstack security group delete [-h] <group> [<group> ...]

Delete security group(s)

**Positional arguments:**

``<group>``
  Security group(s) to delete (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_security_group_list:

openstack security group list
-----------------------------

.. code-block:: console

   usage: openstack security group list [-h]
                                        [-f {csv,html,json,table,value,yaml}]
                                        [-c COLUMN] [--max-width <integer>]
                                        [--noindent]
                                        [--quote {all,minimal,none,nonnumeric}]

List security groups

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_security_group_rule_create:

openstack security group rule create
------------------------------------

.. code-block:: console

   usage: openstack security group rule create [-h]
                                               [-f {html,json,shell,table,value,yaml}]
                                               [-c COLUMN]
                                               [--max-width <integer>]
                                               [--noindent] [--prefix PREFIX]
                                               [--src-ip <ip-address> | --src-group <group>]
                                               [--dst-port <port-range>]
                                               [--icmp-type <icmp-type>]
                                               [--icmp-code <icmp-code>]
                                               [--protocol <protocol>]
                                               [--ingress | --egress]
                                               [--ethertype <ethertype>]
                                               [--project <project>]
                                               [--project-domain <project-domain>]
                                               <group>

Create a new security group rule

**Positional arguments:**

``<group>``
  Create rule in this security group (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--src-ip <ip-address>``
  Source IP address block (may use CIDR notation;
  default for IPv4 rule: 0.0.0.0/0)

``--src-group <group>``
  Source security group (name or ID)

``--dst-port <port-range>``
  Destination port, may be a single port or a starting
  and ending port range: 137:139. Required for IP
  protocols TCP and UDP. Ignored for ICMP IP protocols.

``--icmp-type <icmp-type>``
  ICMP type for ICMP IP protocols

``--icmp-code <icmp-code>``
  ICMP code for ICMP IP protocols

``--protocol <protocol>``
  IP protocol (ah, dccp, egp, esp, gre, icmp, igmp,
  ipv6-encap, ipv6-frag, ipv6-icmp, ipv6-nonxt,
  ipv6-opts, ipv6-route, ospf, pgm, rsvp, sctp, tcp,
  udp, udplite, vrrp and integer representations
  [0-255]; default: tcp)

``--ingress``
  Rule applies to incoming network traffic (default)

``--egress``
  Rule applies to outgoing network traffic

``--ethertype <ethertype>``
  Ethertype of network traffic (IPv4, IPv6; default:
  based on IP protocol)

``--project <project>``
  Owner's project (name or ID)

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

.. _openstack_security_group_rule_delete:

openstack security group rule delete
------------------------------------

.. code-block:: console

   usage: openstack security group rule delete [-h] <rule> [<rule> ...]

Delete security group rule(s)

**Positional arguments:**

``<rule>``
  Security group rule(s) to delete (ID only)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_security_group_rule_list:

openstack security group rule list
----------------------------------

.. code-block:: console

   usage: openstack security group rule list [-h]
                                             [-f {csv,html,json,table,value,yaml}]
                                             [-c COLUMN] [--max-width <integer>]
                                             [--noindent]
                                             [--quote {all,minimal,none,nonnumeric}]
                                             [--long]
                                             [<group>]

List security group rules

**Positional arguments:**

``<group>``
  List all rules in this security group (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--long``
  List additional fields in output

.. _openstack_security_group_rule_show:

openstack security group rule show
----------------------------------

.. code-block:: console

   usage: openstack security group rule show [-h]
                                             [-f {html,json,shell,table,value,yaml}]
                                             [-c COLUMN] [--max-width <integer>]
                                             [--noindent] [--prefix PREFIX]
                                             <rule>

Display security group rule details

**Positional arguments:**

``<rule>``
  Security group rule to display (ID only)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_security_group_set:

openstack security group set
----------------------------

.. code-block:: console

   usage: openstack security group set [-h] [--name <new-name>]
                                       [--description <description>]
                                       <group>

Set security group properties

**Positional arguments:**

``<group>``
  Security group to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <new-name>``
  New security group name

``--description <description>``
  New security group description

.. _openstack_security_group_show:

openstack security group show
-----------------------------

.. code-block:: console

   usage: openstack security group show [-h]
                                        [-f {html,json,shell,table,value,yaml}]
                                        [-c COLUMN] [--max-width <integer>]
                                        [--noindent] [--prefix PREFIX]
                                        <group>

Display security group details

**Positional arguments:**

``<group>``
  Security group to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_server_add_fixed_ip:

openstack server add fixed ip
-----------------------------

.. code-block:: console

   usage: openstack server add fixed ip [-h] <server> <network>

Add fixed IP address to server

**Positional arguments:**

``<server>``
  Server (name or ID) to receive the fixed IP address

``<network>``
  Network (name or ID) to allocate the fixed IP address from

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_server_add_floating_ip:

openstack server add floating ip
--------------------------------

.. code-block:: console

   usage: openstack server add floating ip [-h] <server> <ip-address>

Add floating IP address to server

**Positional arguments:**

``<server>``
  Server (name or ID) to receive the floating IP address

``<ip-address>``
  Floating IP address (IP address only) to assign to server

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_server_add_security_group:

openstack server add security group
-----------------------------------

.. code-block:: console

   usage: openstack server add security group [-h] <server> <group>

Add security group to server

**Positional arguments:**

``<server>``
  Server (name or ID)

``<group>``
  Security group to add (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_server_add_volume:

openstack server add volume
---------------------------

.. code-block:: console

   usage: openstack server add volume [-h] [--device <device>] <server> <volume>

Add volume to server

**Positional arguments:**

``<server>``
  Server (name or ID)

``<volume>``
  Volume to add (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--device <device>``
  Server internal device name for volume

.. _openstack_server_backup_create:

openstack server backup create
------------------------------

.. code-block:: console

   usage: openstack server backup create [-h]
                                         [-f {html,json,shell,table,value,yaml}]
                                         [-c COLUMN] [--max-width <integer>]
                                         [--noindent] [--prefix PREFIX]
                                         [--name <image-name>]
                                         [--type <backup-type>]
                                         [--rotate <count>] [--wait]
                                         <server>

Create a server backup image

**Positional arguments:**

``<server>``
  Server to back up (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <image-name>``
  Name of the backup image (default: server name)

``--type <backup-type>``
  Used to populate the backup_type property of the
  backup image (default: empty)

``--rotate <count>``
  Number of backups to keep (default: 1)

``--wait``
  Wait for backup image create to complete

.. _openstack_server_create:

openstack server create
-----------------------

.. code-block:: console

   usage: openstack server create [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--noindent] [--prefix PREFIX]
                                  (--image <image> | --volume <volume>) --flavor
                                  <flavor>
                                  [--security-group <security-group-name>]
                                  [--key-name <key-name>]
                                  [--property <key=value>]
                                  [--file <dest-filename=source-filename>]
                                  [--user-data <user-data>]
                                  [--availability-zone <zone-name>]
                                  [--block-device-mapping <dev-name=mapping>]
                                  [--nic <net-id=net-uuid,v4-fixed-ip=ip-addr,v6-fixed-ip=ip-addr,port-id=port-uuid>]
                                  [--hint <key=value>]
                                  [--config-drive <config-drive-volume>|True]
                                  [--min <count>] [--max <count>] [--wait]
                                  <server-name>

Create a new server

**Positional arguments:**

``<server-name>``
  New server name

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--image <image>``
  Create server from this image (name or ID)

``--volume <volume>``
  Create server from this volume (name or ID)

``--flavor <flavor>``
  Create server with this flavor (name or ID)

``--security-group <security-group-name>``
  Security group to assign to this server (name or ID)
  (repeat option to set multiple groups)

``--key-name <key-name>``
  Keypair to inject into this server (optional
  extension)

``--property <key=value>``
  Set a property on this server (repeat option to set
  multiple values)

``--file <dest-filename=source-filename>``
  File to inject into image before boot (repeat option
  to set multiple files)

``--user-data <user-data>``
  User data file to serve from the metadata server

``--availability-zone <zone-name>``
  Select an availability zone for the server

``--block-device-mapping <dev-name=mapping>``
  Map block devices; map is
  <id>:<type>:<size(GB)>:<delete_on_terminate> (optional
  extension)

``--nic <net-id=net-uuid,v4-fixed-ip=ip-addr,v6-fixed-ip=ip-addr,port-id=port-uuid>``
  Create a NIC on the server. Specify option multiple
  times
  to
  create
  multiple
  NICs.
  Either
  net-id
  or
  port-id
  must
  be
  provided,
  but
  not
  both.
  net-id:
  attach
  NIC
  to network with this UUID, port-id: attach NIC to port
  with this UUID, v4-fixed-ip: IPv4 fixed address for
  NIC (optional), v6-fixed-ip: IPv6 fixed address for
  NIC (optional).

``--hint <key=value>``
  Hints for the scheduler (optional extension)

``--config-drive <config-drive-volume>|True``
  Use specified volume as the config drive, or 'True' to
  use an ephemeral drive

``--min <count>``
  Minimum number of servers to launch (default=1)

``--max <count>``
  Maximum number of servers to launch (default=1)

``--wait``
  Wait for build to complete

.. _openstack_server_delete:

openstack server delete
-----------------------

.. code-block:: console

   usage: openstack server delete [-h] [--wait] <server> [<server> ...]

Delete server(s)

**Positional arguments:**

``<server>``
  Server(s) to delete (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--wait``
  Wait for delete to complete

.. _openstack_server_dump_create:

openstack server dump create
----------------------------

.. code-block:: console

   usage: openstack server dump create [-h] <server> [<server> ...]

Create a dump file in server(s) Trigger crash dump in server(s) with features
like kdump in Linux. It will create a dump file in the server(s) dumping the
server(s)' memory, and also crash the server(s). OSC sees the dump file
(server dump) as a kind of resource.

**Positional arguments:**

``<server>``
  Server(s) to create dump file (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_server_group_create:

openstack server group create
-----------------------------

.. code-block:: console

   usage: openstack server group create [-h]
                                        [-f {html,json,shell,table,value,yaml}]
                                        [-c COLUMN] [--max-width <integer>]
                                        [--noindent] [--prefix PREFIX] --policy
                                        <policy>
                                        <name>

Create a new server group.

**Positional arguments:**

``<name>``
  New server group name

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--policy <policy>``
  Add a policy to <name> (repeat option to add multiple
  policies)

.. _openstack_server_group_delete:

openstack server group delete
-----------------------------

.. code-block:: console

   usage: openstack server group delete [-h] <server-group> [<server-group> ...]

Delete existing server group(s).

**Positional arguments:**

``<server-group>``
  server group(s) to delete (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_server_group_list:

openstack server group list
---------------------------

.. code-block:: console

   usage: openstack server group list [-h] [-f {csv,html,json,table,value,yaml}]
                                      [-c COLUMN] [--max-width <integer>]
                                      [--noindent]
                                      [--quote {all,minimal,none,nonnumeric}]
                                      [--all-projects] [--long]

List all server groups.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Display information from all projects (admin only)

``--long``
  List additional fields in output

.. _openstack_server_group_show:

openstack server group show
---------------------------

.. code-block:: console

   usage: openstack server group show [-h]
                                      [-f {html,json,shell,table,value,yaml}]
                                      [-c COLUMN] [--max-width <integer>]
                                      [--noindent] [--prefix PREFIX]
                                      <server-group>

Display server group details.

**Positional arguments:**

``<server-group>``
  server group to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_server_image_create:

openstack server image create
-----------------------------

.. code-block:: console

   usage: openstack server image create [-h]
                                        [-f {html,json,shell,table,value,yaml}]
                                        [-c COLUMN] [--max-width <integer>]
                                        [--noindent] [--prefix PREFIX]
                                        [--name <image-name>] [--wait]
                                        <server>

Create a new server disk image from an existing server

**Positional arguments:**

``<server>``
  Server to create image (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <image-name>``
  Name of new disk image (default: server name)

``--wait``
  Wait for operation to complete

.. _openstack_server_list:

openstack server list
---------------------

.. code-block:: console

   usage: openstack server list [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}]
                                [--reservation-id <reservation-id>]
                                [--ip <ip-address-regex>]
                                [--ip6 <ip-address-regex>] [--name <name-regex>]
                                [--instance-name <server-name>]
                                [--status <status>] [--flavor <flavor>]
                                [--image <image>] [--host <hostname>]
                                [--all-projects] [--project <project>]
                                [--project-domain <project-domain>]
                                [--user <user>] [--user-domain <user-domain>]
                                [--long] [--marker <marker>] [--limit <limit>]

List servers

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--reservation-id <reservation-id>``
  Only return instances that match the reservation

``--ip <ip-address-regex>``
  Regular expression to match IP addresses

``--ip6 <ip-address-regex>``
  Regular expression to match IPv6 addresses

``--name <name-regex>``
  Regular expression to match names

``--instance-name <server-name>``
  Regular expression to match instance name (admin only)

``--status <status>``
  Search by server status

``--flavor <flavor>``
  Search by flavor (name or ID)

``--image <image>``
  Search by image (name or ID)

``--host <hostname>``
  Search by hostname

``--all-projects``
  Include all projects (admin only)

``--project <project>``
  Search by project (admin only) (name or ID)

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

``--user <user>``
  Search by user (admin only) (name or ID)

``--user-domain <user-domain>``
  Domain the user belongs to (name or ID). This can be
  used in case collisions between user names exist.

``--long``
  List additional fields in output

``--marker <marker>``
  The last server (name or ID) of the previous page.
  Display list of servers after marker. Display all
  servers if not specified.

``--limit <limit>``
  Maximum number of servers to display. If limit equals
  -1, all servers will be displayed. If limit is greater
  than 'osapi_max_limit' option of Nova API,
  'osapi_max_limit' will be used instead.

.. _openstack_server_lock:

openstack server lock
---------------------

.. code-block:: console

   usage: openstack server lock [-h] <server> [<server> ...]

Lock server(s). A non-admin user will not be able to execute actions

**Positional arguments:**

``<server>``
  Server(s) to lock (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_server_migrate:

openstack server migrate
------------------------

.. code-block:: console

   usage: openstack server migrate [-h] [--live <hostname>]
                                   [--shared-migration | --block-migration]
                                   [--disk-overcommit | --no-disk-overcommit]
                                   [--wait]
                                   <server>

Migrate server to different host

**Positional arguments:**

``<server>``
  Server (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--live <hostname>``
  Target hostname

``--shared-migration``
  Perform a shared live migration (default)

``--block-migration``
  Perform a block live migration

``--disk-overcommit``
  Allow disk over-commit on the destination host

``--no-disk-overcommit``
  Do not over-commit disk on the destination host
  (default)

``--wait``
  Wait for resize to complete

.. _openstack_server_pause:

openstack server pause
----------------------

.. code-block:: console

   usage: openstack server pause [-h] <server> [<server> ...]

Pause server(s)

**Positional arguments:**

``<server>``
  Server(s) to pause (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_server_reboot:

openstack server reboot
-----------------------

.. code-block:: console

   usage: openstack server reboot [-h] [--hard | --soft] [--wait] <server>

Perform a hard or soft server reboot

**Positional arguments:**

``<server>``
  Server (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--hard``
  Perform a hard reboot

``--soft``
  Perform a soft reboot

``--wait``
  Wait for reboot to complete

.. _openstack_server_rebuild:

openstack server rebuild
------------------------

.. code-block:: console

   usage: openstack server rebuild [-h] [-f {html,json,shell,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--noindent] [--prefix PREFIX]
                                   [--image <image>] [--password <password>]
                                   [--wait]
                                   <server>

Rebuild server

**Positional arguments:**

``<server>``
  Server (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--image <image>``
  Recreate server from the specified image (name or ID).
  Defaults to the currently used one.

``--password <password>``
  Set the password on the rebuilt instance

``--wait``
  Wait for rebuild to complete

.. _openstack_server_remove_fixed_ip:

openstack server remove fixed ip
--------------------------------

.. code-block:: console

   usage: openstack server remove fixed ip [-h] <server> <ip-address>

Remove fixed IP address from server

**Positional arguments:**

``<server>``
  Server (name or ID) to remove the fixed IP address from

``<ip-address>``
  Fixed IP address (IP address only) to remove from the server

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_server_remove_floating_ip:

openstack server remove floating ip
-----------------------------------

.. code-block:: console

   usage: openstack server remove floating ip [-h] <server> <ip-address>

Remove floating IP address from server

**Positional arguments:**

``<server>``
  Server (name or ID) to remove the floating IP address from

``<ip-address>``
  Floating IP address (IP address only) to remove from server

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_server_remove_security_group:

openstack server remove security group
--------------------------------------

.. code-block:: console

   usage: openstack server remove security group [-h] <server> <group>

Remove security group from server

**Positional arguments:**

``<server>``
  Name or ID of server to use

``<group>``
  Name or ID of security group to remove from server

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_server_remove_volume:

openstack server remove volume
------------------------------

.. code-block:: console

   usage: openstack server remove volume [-h] <server> <volume>

Remove volume from server

**Positional arguments:**

``<server>``
  Server (name or ID)

``<volume>``
  Volume to remove (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_server_rescue:

openstack server rescue
-----------------------

.. code-block:: console

   usage: openstack server rescue [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--noindent] [--prefix PREFIX]
                                  <server>

Put server in rescue mode

**Positional arguments:**

``<server>``
  Server (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_server_resize:

openstack server resize
-----------------------

.. code-block:: console

   usage: openstack server resize [-h] [--flavor <flavor> | --confirm | --revert]
                                  [--wait]
                                  <server>

Scale server to a new flavor

**Positional arguments:**

``<server>``
  Server (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--flavor <flavor>``
  Resize server to specified flavor

``--confirm``
  Confirm server resize is complete

``--revert``
  Restore server state before resize

``--wait``
  Wait for resize to complete

.. _openstack_server_restore:

openstack server restore
------------------------

.. code-block:: console

   usage: openstack server restore [-h] <server> [<server> ...]

Restore server(s)

**Positional arguments:**

``<server>``
  Server(s) to restore (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_server_resume:

openstack server resume
-----------------------

.. code-block:: console

   usage: openstack server resume [-h] <server> [<server> ...]

Resume server(s)

**Positional arguments:**

``<server>``
  Server(s) to resume (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_server_set:

openstack server set
--------------------

.. code-block:: console

   usage: openstack server set [-h] [--name <new-name>] [--root-password]
                               [--property <key=value>] [--state <state>]
                               <server>

Set server properties

**Positional arguments:**

``<server>``
  Server (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <new-name>``
  New server name

``--root-password``
  Set new root password (interactive only)

``--property <key=value>``
  Property to add/change for this server (repeat option
  to set multiple properties)

``--state <state>``
  New server state (valid value: active, error)

.. _openstack_server_shelve:

openstack server shelve
-----------------------

.. code-block:: console

   usage: openstack server shelve [-h] <server> [<server> ...]

Shelve server(s)

**Positional arguments:**

``<server>``
  Server(s) to shelve (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_server_show:

openstack server show
---------------------

.. code-block:: console

   usage: openstack server show [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--prefix PREFIX] [--diagnostics]
                                <server>

Show server details

**Positional arguments:**

``<server>``
  Server (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--diagnostics``
  Display server diagnostics information

.. _openstack_server_ssh:

openstack server ssh
--------------------

.. code-block:: console

   usage: openstack server ssh [-h] [--login <login-name>] [--port <port>]
                               [--identity <keyfile>] [--option <config-options>]
                               [-4 | -6]
                               [--public | --private | --address-type <address-type>]
                               <server>

SSH to server

**Positional arguments:**

``<server>``
  Server (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--login <login-name>``
  Login name (ssh -l option)

``--port <port>``
  Destination port (ssh -p option)

``--identity <keyfile>``
  Private key file (ssh -i option)

``--option <config-options>``
  Options in ssh_config(5) format (ssh -o option)

``-4``
  Use only IPv4 addresses

``-6``
  Use only IPv6 addresses

``--public``
  Use public IP address

``--private``
  Use private IP address

``--address-type <address-type>``
  Use other IP address (public, private, etc)

.. _openstack_server_start:

openstack server start
----------------------

.. code-block:: console

   usage: openstack server start [-h] <server> [<server> ...]

Start server(s).

**Positional arguments:**

``<server>``
  Server(s) to start (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_server_stop:

openstack server stop
---------------------

.. code-block:: console

   usage: openstack server stop [-h] <server> [<server> ...]

Stop server(s).

**Positional arguments:**

``<server>``
  Server(s) to stop (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_server_suspend:

openstack server suspend
------------------------

.. code-block:: console

   usage: openstack server suspend [-h] <server> [<server> ...]

Suspend server(s)

**Positional arguments:**

``<server>``
  Server(s) to suspend (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_server_unlock:

openstack server unlock
-----------------------

.. code-block:: console

   usage: openstack server unlock [-h] <server> [<server> ...]

Unlock server(s)

**Positional arguments:**

``<server>``
  Server(s) to unlock (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_server_unpause:

openstack server unpause
------------------------

.. code-block:: console

   usage: openstack server unpause [-h] <server> [<server> ...]

Unpause server(s)

**Positional arguments:**

``<server>``
  Server(s) to unpause (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_server_unrescue:

openstack server unrescue
-------------------------

.. code-block:: console

   usage: openstack server unrescue [-h] <server>

Restore server from rescue mode

**Positional arguments:**

``<server>``
  Server (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_server_unset:

openstack server unset
----------------------

.. code-block:: console

   usage: openstack server unset [-h] [--property <key>] <server>

Unset server properties

**Positional arguments:**

``<server>``
  Server (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--property <key>``
  Property key to remove from server (repeat option to
  remove multiple values)

.. _openstack_server_unshelve:

openstack server unshelve
-------------------------

.. code-block:: console

   usage: openstack server unshelve [-h] <server> [<server> ...]

Unshelve server(s)

**Positional arguments:**

``<server>``
  Server(s) to unshelve (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_service_create:

openstack service create
------------------------

.. code-block:: console

   usage: openstack service create [-h] [-f {html,json,shell,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--noindent] [--prefix PREFIX] [--name <name>]
                                   [--description <description>]
                                   [--enable | --disable]
                                   <type>

Create new service

**Positional arguments:**

``<type>``
  New service type (compute, image, identity, volume,
  etc)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  New service name

``--description <description>``
  New service description

``--enable``
  Enable service (default)

``--disable``
  Disable service

.. _openstack_service_delete:

openstack service delete
------------------------

.. code-block:: console

   usage: openstack service delete [-h] <service> [<service> ...]

Delete service(s)

**Positional arguments:**

``<service>``
  Service(s) to delete (type, name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_service_list:

openstack service list
----------------------

.. code-block:: console

   usage: openstack service list [-h] [-f {csv,html,json,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>] [--noindent]
                                 [--quote {all,minimal,none,nonnumeric}] [--long]

List services

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--long``
  List additional fields in output

.. _openstack_service_provider_create:

openstack service provider create
---------------------------------

.. code-block:: console

   usage: openstack service provider create [-h]
                                            [-f {html,json,shell,table,value,yaml}]
                                            [-c COLUMN] [--max-width <integer>]
                                            [--noindent] [--prefix PREFIX]
                                            --auth-url <auth-url>
                                            [--description <description>]
                                            --service-provider-url <sp-url>
                                            [--enable | --disable]
                                            <name>

Create new service provider

**Positional arguments:**

``<name>``
  New service provider name (must be unique)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--auth-url <auth-url>``
  Authentication URL of remote federated service
  provider (required)

``--description <description>``
  New service provider description

``--service-provider-url <sp-url>``
  A service URL where SAML assertions are being sent
  (required)

``--enable``
  Enable the service provider (default)

``--disable``
  Disable the service provider

.. _openstack_service_provider_delete:

openstack service provider delete
---------------------------------

.. code-block:: console

   usage: openstack service provider delete [-h]
                                            <service-provider>
                                            [<service-provider> ...]

Delete service provider(s)

**Positional arguments:**

``<service-provider>``
  Service provider(s) to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_service_provider_list:

openstack service provider list
-------------------------------

.. code-block:: console

   usage: openstack service provider list [-h]
                                          [-f {csv,html,json,table,value,yaml}]
                                          [-c COLUMN] [--max-width <integer>]
                                          [--noindent]
                                          [--quote {all,minimal,none,nonnumeric}]

List service providers

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_service_provider_set:

openstack service provider set
------------------------------

.. code-block:: console

   usage: openstack service provider set [-h] [--auth-url <auth-url>]
                                         [--description <description>]
                                         [--service-provider-url <sp-url>]
                                         [--enable | --disable]
                                         <service-provider>

Set service provider properties

**Positional arguments:**

``<service-provider>``
  Service provider to modify

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--auth-url <auth-url>``
  New Authentication URL of remote federated service
  provider

``--description <description>``
  New service provider description

``--service-provider-url <sp-url>``
  New service provider URL, where SAML assertions are
  sent

``--enable``
  Enable the service provider

``--disable``
  Disable the service provider

.. _openstack_service_provider_show:

openstack service provider show
-------------------------------

.. code-block:: console

   usage: openstack service provider show [-h]
                                          [-f {html,json,shell,table,value,yaml}]
                                          [-c COLUMN] [--max-width <integer>]
                                          [--noindent] [--prefix PREFIX]
                                          <service-provider>

Display service provider details

**Positional arguments:**

``<service-provider>``
  Service provider to display

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_service_set:

openstack service set
---------------------

.. code-block:: console

   usage: openstack service set [-h] [--type <type>] [--name <service-name>]
                                [--description <description>]
                                [--enable | --disable]
                                <service>

Set service properties

**Positional arguments:**

``<service>``
  Service to modify (type, name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--type <type>``
  New service type (compute, image, identity, volume,
  etc)

``--name <service-name>``
  New service name

``--description <description>``
  New service description

``--enable``
  Enable service

``--disable``
  Disable service

.. _openstack_service_show:

openstack service show
----------------------

.. code-block:: console

   usage: openstack service show [-h] [-f {html,json,shell,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>] [--noindent]
                                 [--prefix PREFIX]
                                 <service>

Display service details

**Positional arguments:**

``<service>``
  Service to display (type, name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_snapshot_create:

openstack snapshot create
-------------------------

.. code-block:: console

   usage: openstack snapshot create [-h] [-f {html,json,shell,table,value,yaml}]
                                    [-c COLUMN] [--max-width <integer>]
                                    [--noindent] [--prefix PREFIX]
                                    [--name <name>] [--description <description>]
                                    [--force] [--property <key=value>]
                                    <volume>

Create new snapshot

**Positional arguments:**

``<volume>``
  Volume to snapshot (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  Name of the snapshot

``--description <description>``
  Description of the snapshot

``--force``
  Create a snapshot attached to an instance. Default is
  False

``--property <key=value>``
  Set a property to this snapshot (repeat option to set
  multiple properties)

.. _openstack_snapshot_delete:

openstack snapshot delete
-------------------------

.. code-block:: console

   usage: openstack snapshot delete [-h] <snapshot> [<snapshot> ...]

Delete volume snapshot(s)

**Positional arguments:**

``<snapshot>``
  Snapshot(s) to delete (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_snapshot_list:

openstack snapshot list
-----------------------

.. code-block:: console

   usage: openstack snapshot list [-h] [-f {csv,html,json,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--noindent]
                                  [--quote {all,minimal,none,nonnumeric}]
                                  [--all-projects] [--long] [--marker <marker>]
                                  [--limit <limit>]

List snapshots

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Include all projects (admin only)

``--long``
  List additional fields in output

``--marker <marker>``
  The last snapshot ID of the previous page

``--limit <limit>``
  Maximum number of snapshots to display

.. _openstack_snapshot_set:

openstack snapshot set
----------------------

.. code-block:: console

   usage: openstack snapshot set [-h] [--name <name>]
                                 [--description <description>]
                                 [--property <key=value>] [--state <state>]
                                 <snapshot>

Set snapshot properties

**Positional arguments:**

``<snapshot>``
  Snapshot to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  New snapshot name

``--description <description>``
  New snapshot description

``--property <key=value>``
  Property to add/change for this snapshot (repeat
  option to set multiple properties)

``--state <state>``
  New snapshot state. Valid values are available, error,
  creating, deleting, and error-deleting.

.. _openstack_snapshot_show:

openstack snapshot show
-----------------------

.. code-block:: console

   usage: openstack snapshot show [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--noindent] [--prefix PREFIX]
                                  <snapshot>

Display snapshot details

**Positional arguments:**

``<snapshot>``
  Snapshot to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_snapshot_unset:

openstack snapshot unset
------------------------

.. code-block:: console

   usage: openstack snapshot unset [-h] [--property <key>] <snapshot>

Unset snapshot properties

**Positional arguments:**

``<snapshot>``
  Snapshot to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--property <key>``
  Property to remove from snapshot (repeat option to remove
  multiple properties)

.. _openstack_software_config_create:

openstack software config create
--------------------------------

.. code-block:: console

   usage: openstack software config create [-h]
                                           [-f {html,json,shell,table,value,yaml}]
                                           [-c COLUMN] [--max-width <integer>]
                                           [--noindent] [--prefix PREFIX]
                                           [--config-file <config-file>]
                                           [--definition-file <destination-file>]
                                           [--group <group>]
                                           <config-name>

Create software config

**Positional arguments:**

``<config-name>``
  Name of the software config to create

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--config-file <config-file>``
  Path to JSON/YAML containing map defining <inputs>,
  <outputs>, and <options>

``--definition-file <destination-file>``
  Path to software config script/data

``--group <group>``
  Group name of tool expected by the software config

.. _openstack_software_config_delete:

openstack software config delete
--------------------------------

.. code-block:: console

   usage: openstack software config delete [-h] <config> [<config> ...]

Delete software configs

**Positional arguments:**

``<config>``
  IDs of the software configs to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_software_config_list:

openstack software config list
------------------------------

.. code-block:: console

   usage: openstack software config list [-h]
                                         [-f {csv,html,json,table,value,yaml}]
                                         [-c COLUMN] [--max-width <integer>]
                                         [--noindent]
                                         [--quote {all,minimal,none,nonnumeric}]
                                         [--limit <limit>] [--marker <id>]

List software configs

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--limit <limit>``
  Limit the number of configs returned

``--marker <id>``
  Return configs that appear after the given config ID

.. _openstack_software_config_show:

openstack software config show
------------------------------

.. code-block:: console

   usage: openstack software config show [-h]
                                         [-f {html,json,shell,table,value,yaml}]
                                         [-c COLUMN] [--max-width <integer>]
                                         [--noindent] [--prefix PREFIX]
                                         [--config-only]
                                         <config>

Show software config details

**Positional arguments:**

``<config>``
  ID of the config

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--config-only``
  Only display the value of the <config> property.

.. _openstack_software_deployment_create:

openstack software deployment create
------------------------------------

.. code-block:: console

   usage: openstack software deployment create [-h]
                                               [-f {html,json,shell,table,value,yaml}]
                                               [-c COLUMN]
                                               [--max-width <integer>]
                                               [--noindent] [--prefix PREFIX]
                                               [--input-value <key=value>]
                                               [--action <action>]
                                               [--config <config>]
                                               [--signal-transport <signal-transport>]
                                               [--container <container>]
                                               [--timeout <timeout>] --server
                                               <server>
                                               <deployment-name>

Create a software deployment.

**Positional arguments:**

``<deployment-name>``
  Name of the derived config associated with this
  deployment. This is used to apply a sort order to the
  list of configurations currently deployed to the
  server.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--input-value <key=value>``
  Input value to set on the deployment. This can be
  specified multiple times.

``--action <action>``
  Name of an action for this deployment. This can be a
  custom action, or one of CREATE, UPDATE, DELETE,
  SUSPEND, RESUME. Default is UPDATE

``--config <config>``
  ID of the configuration to deploy

``--signal-transport <signal-transport>``
  How the server should signal to heat with the
  deployment output values. TEMP_URL_SIGNAL will create
  a Swift TempURL to be signaled via HTTP PUT.
  ZAQAR_SIGNAL will create a dedicated zaqar queue to be
  signaled using the provided keystone
  credentials.NO_SIGNAL will result in the resource
  going to the COMPLETE state without waiting for any
  signal

``--container <container>``
  Optional name of container to store TEMP_URL_SIGNAL
  objects in. If not specified a container will be
  created with a name derived from the DEPLOY_NAME

``--timeout <timeout>``
  Deployment timeout in minutes

``--server <server>``
  ID of the server being deployed to

.. _openstack_software_deployment_delete:

openstack software deployment delete
------------------------------------

.. code-block:: console

   usage: openstack software deployment delete [-h]
                                               <deployment> [<deployment> ...]

Delete software deployment(s) and correlative config(s).

**Positional arguments:**

``<deployment>``
  ID of the deployment(s) to delete.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_software_deployment_list:

openstack software deployment list
----------------------------------

.. code-block:: console

   usage: openstack software deployment list [-h]
                                             [-f {csv,html,json,table,value,yaml}]
                                             [-c COLUMN] [--max-width <integer>]
                                             [--noindent]
                                             [--quote {all,minimal,none,nonnumeric}]
                                             [--server <server>] [--long]

List software deployments.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--server <server>``
  ID of the server to fetch deployments for

``--long``
  List more fields in output

.. _openstack_software_deployment_metadata_show:

openstack software deployment metadata show
-------------------------------------------

.. code-block:: console

   usage: openstack software deployment metadata show [-h] <server>

Get deployment configuration metadata for the specified server.

**Positional arguments:**

``<server>``
  ID of the server to fetch deployments for

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_software_deployment_output_show:

openstack software deployment output show
-----------------------------------------

.. code-block:: console

   usage: openstack software deployment output show [-h] [--all] [--long]
                                                    <deployment> [<output-name>]

Show a specific deployment output.

**Positional arguments:**

``<deployment>``
  ID of deployment to show the output for

``<output-name>``
  Name of an output to display

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all``
  Display all deployment outputs

``--long``
  Show full deployment logs in output

.. _openstack_software_deployment_show:

openstack software deployment show
----------------------------------

.. code-block:: console

   usage: openstack software deployment show [-h]
                                             [-f {html,json,shell,table,value,yaml}]
                                             [-c COLUMN] [--max-width <integer>]
                                             [--noindent] [--prefix PREFIX]
                                             [--long]
                                             <deployment>

Show SoftwareDeployment Details.

**Positional arguments:**

``<deployment>``
  ID of the deployment

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--long``
  Show more fields in output

.. _openstack_stack_abandon:

openstack stack abandon
-----------------------

.. code-block:: console

   usage: openstack stack abandon [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--noindent] [--prefix PREFIX]
                                  [--output-file <output-file>]
                                  <stack>

Abandon stack and output results.

**Positional arguments:**

``<stack>``
  Name or ID of stack to abandon

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--output-file <output-file>``
  File to output abandon results

.. _openstack_stack_adopt:

openstack stack adopt
---------------------

.. code-block:: console

   usage: openstack stack adopt [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--prefix PREFIX] [-e <environment>]
                                [--timeout <timeout>] [--enable-rollback]
                                [--parameter <key=value>] [--wait] --adopt-file
                                <adopt-file>
                                <stack-name>

Adopt a stack.

**Positional arguments:**

``<stack-name>``
  Name of the stack to adopt

**Optional arguments:**

``-h, --help``
  show this help message and exit

``-e <environment>, --environment <environment>``
  Path to the environment. Can be specified multiple
  times

``--timeout <timeout>``
  Stack creation timeout in minutes

``--enable-rollback``
  Enable rollback on create/update failure

``--parameter <key=value>``
  Parameter values used to create the stack. Can be
  specified multiple times

``--wait``
  Wait until stack adopt completes

``--adopt-file <adopt-file>``
  Path to adopt stack data file

.. _openstack_stack_cancel:

openstack stack cancel
----------------------

.. code-block:: console

   usage: openstack stack cancel [-h] [-f {csv,html,json,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>] [--noindent]
                                 [--quote {all,minimal,none,nonnumeric}] [--wait]
                                 <stack> [<stack> ...]

Cancel current task for a stack. Supported tasks for cancellation: \* update

**Positional arguments:**

``<stack>``
  Stack(s) to cancel (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--wait``
  Wait for check to complete

.. _openstack_stack_check:

openstack stack check
---------------------

.. code-block:: console

   usage: openstack stack check [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}] [--wait]
                                <stack> [<stack> ...]

Check a stack.

**Positional arguments:**

``<stack>``
  Stack(s) to check update (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--wait``
  Wait for check to complete

.. _openstack_stack_create:

openstack stack create
----------------------

.. code-block:: console

   usage: openstack stack create [-h] [-f {html,json,shell,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>] [--noindent]
                                 [--prefix PREFIX] [-e <environment>]
                                 [--timeout <timeout>] [--pre-create <resource>]
                                 [--enable-rollback] [--parameter <key=value>]
                                 [--parameter-file <key=file>] [--wait]
                                 [--tags <tag1,tag2...>] [--dry-run] -t
                                 <template>
                                 <stack-name>

Create a stack.

**Positional arguments:**

``<stack-name>``
  Name of the stack to create

**Optional arguments:**

``-h, --help``
  show this help message and exit

``-e <environment>, --environment <environment>``
  Path to the environment. Can be specified multiple
  times

``--timeout <timeout>``
  Stack creating timeout in minutes

``--pre-create <resource>``
  Name of a resource to set a pre-create hook to.
  Resources in nested stacks can be set using slash as a
  separator: nested_stack/another/my_resource. You can
  use wildcards to match multiple stacks or resources:
  nested_stack/an\*/\*_resource. This can be specified
  multiple times

``--enable-rollback``
  Enable rollback on create/update failure

``--parameter <key=value>``
  Parameter values used to create the stack. This can be
  specified multiple times

``--parameter-file <key=file>``
  Parameter values from file used to create the stack.
  This can be specified multiple times. Parameter values
  would be the content of the file

``--wait``
  Wait until stack goes to CREATE_COMPLETE or
  CREATE_FAILED

``--tags <tag1,tag2...>``
  A list of tags to associate with the stack

``--dry-run``
  Do not actually perform the stack create, but show
  what would be created

``-t <template>, --template <template>``
  Path to the template

.. _openstack_stack_delete:

openstack stack delete
----------------------

.. code-block:: console

   usage: openstack stack delete [-h] [--yes] [--wait] <stack> [<stack> ...]

Delete stack(s).

**Positional arguments:**

``<stack>``
  Stack(s) to delete (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--yes``
  Skip yes/no prompt (assume yes)

``--wait``
  Wait for stack delete to complete

.. _openstack_stack_environment_show:

openstack stack environment show
--------------------------------

.. code-block:: console

   usage: openstack stack environment show [-h]
                                           [-f {html,json,shell,table,value,yaml}]
                                           [-c COLUMN] [--max-width <integer>]
                                           [--noindent] [--prefix PREFIX]
                                           <NAME or ID>

Show a stack's environment.

**Positional arguments:**

``<NAME or ID>``
  Name or ID of stack to query

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_stack_event_list:

openstack stack event list
--------------------------

.. code-block:: console

   usage: openstack stack event list [-h] [-f {csv,json,log,table,value,yaml}]
                                     [-c COLUMN] [--noindent]
                                     [--max-width <integer>]
                                     [--quote {all,minimal,none,nonnumeric}]
                                     [--resource <resource>]
                                     [--filter <key=value>] [--limit <limit>]
                                     [--marker <id>] [--nested-depth <depth>]
                                     [--sort <key>[:<direction>]] [--follow]
                                     <stack>

List events.

**Positional arguments:**

``<stack>``
  Name or ID of stack to show events for

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--resource <resource>``
  Name of resource to show events for. Note: this cannot
  be specified with :option:`--nested-depth`

``--filter <key=value>``
  Filter parameters to apply on returned events

``--limit <limit>``
  Limit the number of events returned

``--marker <id>``
  Only return events that appear after the given ID

``--nested-depth <depth>``
  Depth of nested stacks from which to display events.
  Note: this cannot be specified with :option:`--resource`

``--sort <key>[:<direction>]``
  Sort output by selected keys and directions (asc or
  desc) (default: asc). Specify multiple times to sort
  on multiple keys

``--follow``
  Print events until process is halted

.. _openstack_stack_event_show:

openstack stack event show
--------------------------

.. code-block:: console

   usage: openstack stack event show [-h] [-f {html,json,shell,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--noindent] [--prefix PREFIX]
                                     <stack> <resource> <event>

Show event details.

**Positional arguments:**

``<stack>``
  Name or ID of stack to show events for

``<resource>``
  Name of the resource event belongs to

``<event>``
  ID of event to display details for

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_stack_failures_list:

openstack stack failures list
-----------------------------

.. code-block:: console

   usage: openstack stack failures list [-h] [--long] <stack>

Show information about failed stack resources.

**Positional arguments:**

``<stack>``
  Stack to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--long``
  Show full deployment logs in output

.. _openstack_stack_hook_clear:

openstack stack hook clear
--------------------------

.. code-block:: console

   usage: openstack stack hook clear [-h] [--pre-create] [--pre-update]
                                     [--pre-delete]
                                     <stack> <resource> [<resource> ...]

Clear resource hooks on a given stack.

**Positional arguments:**

``<stack>``
  Stack to display (name or ID)

``<resource>``
  Resource names with hooks to clear. Resources in nested stacks
  can be set using slash as a separator:
  nested_stack/another/my_resource. You can use wildcards to
  match multiple stacks or resources:
  nested_stack/an\*/\*_resource

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--pre-create``
  Clear the pre-create hooks

``--pre-update``
  Clear the pre-update hooks

``--pre-delete``
  Clear the pre-delete hooks

.. _openstack_stack_hook_poll:

openstack stack hook poll
-------------------------

.. code-block:: console

   usage: openstack stack hook poll [-h] [-f {csv,html,json,table,value,yaml}]
                                    [-c COLUMN] [--max-width <integer>]
                                    [--noindent]
                                    [--quote {all,minimal,none,nonnumeric}]
                                    [--nested-depth <nested-depth>]
                                    <stack>

List resources with pending hook for a stack.

**Positional arguments:**

``<stack>``
  Stack to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--nested-depth <nested-depth>``
  Depth of nested stacks from which to display hooks

.. _openstack_stack_list:

openstack stack list
--------------------

.. code-block:: console

   usage: openstack stack list [-h] [-f {csv,html,json,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>] [--noindent]
                               [--quote {all,minimal,none,nonnumeric}]
                               [--deleted] [--nested] [--hidden]
                               [--property <key=value>] [--tags <tag1,tag2...>]
                               [--tag-mode <mode>] [--limit <limit>]
                               [--marker <id>] [--sort <key>[:<direction>]]
                               [--all-projects] [--short] [--long]

List stacks.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--deleted``
  Include soft-deleted stacks in the stack listing

``--nested``
  Include nested stacks in the stack listing

``--hidden``
  Include hidden stacks in the stack listing

``--property <key=value>``
  Filter properties to apply on returned stacks (repeat
  to filter on multiple properties)

``--tags <tag1,tag2...>``
  List of tags to filter by. Can be combined with :option:`--tag-`
  mode to specify how to filter tags

``--tag-mode <mode>``
  Method of filtering tags. Must be one of "any", "not",
  or "not-any". If not specified, multiple tags will be
  combined with the boolean AND expression

``--limit <limit>``
  The number of stacks returned

``--marker <id>``
  Only return stacks that appear after the given ID

``--sort <key>[:<direction>]``
  Sort output by selected keys and directions (asc or
  desc) (default: asc). Specify multiple times to sort
  on multiple properties

``--all-projects``
  Include all projects (admin only)

``--short``
  List fewer fields in output

``--long``
  List additional fields in output, this is implied by
  :option:`--all-projects`

.. _openstack_stack_output_list:

openstack stack output list
---------------------------

.. code-block:: console

   usage: openstack stack output list [-h] [-f {csv,html,json,table,value,yaml}]
                                      [-c COLUMN] [--max-width <integer>]
                                      [--noindent]
                                      [--quote {all,minimal,none,nonnumeric}]
                                      <stack>

List stack outputs.

**Positional arguments:**

``<stack>``
  Name or ID of stack to query

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_stack_output_show:

openstack stack output show
---------------------------

.. code-block:: console

   usage: openstack stack output show [-h]
                                      [-f {html,json,shell,table,value,yaml}]
                                      [-c COLUMN] [--max-width <integer>]
                                      [--noindent] [--prefix PREFIX] [--all]
                                      <stack> [<output>]

Show stack output.

**Positional arguments:**

``<stack>``
  Name or ID of stack to query

``<output>``
  Name of an output to display

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all``
  Display all stack outputs

.. _openstack_stack_resource_list:

openstack stack resource list
-----------------------------

.. code-block:: console

   usage: openstack stack resource list [-h] [-f {csv,dot,json,table,value,yaml}]
                                        [-c COLUMN] [--noindent]
                                        [--max-width <integer>]
                                        [--quote {all,minimal,none,nonnumeric}]
                                        [--long] [-n <nested-depth>]
                                        [--filter <key=value>]
                                        <stack>

List stack resources.

**Positional arguments:**

``<stack>``
  Name or ID of stack to query

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--long``
  Enable detailed information presented for each
  resource in resource list

``-n <nested-depth>, --nested-depth <nested-depth>``
  Depth of nested stacks from which to display resources

``--filter <key=value>``
  Filter parameters to apply on returned resources based
  on their name, status, type, action, id and
  physical_resource_id

.. _openstack_stack_resource_mark_unhealthy:

openstack stack resource mark unhealthy
---------------------------------------

.. code-block:: console

   usage: openstack stack resource mark unhealthy [-h] [--reset]
                                                  <stack> <resource> [reason]

Set resource's health.

**Positional arguments:**

``<stack>``
  Name or ID of stack the resource belongs to

``<resource>``
  Name of the resource

``reason``
  Reason for state change

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--reset``
  Set the resource as healthy

.. _openstack_stack_resource_metadata:

openstack stack resource metadata
---------------------------------

.. code-block:: console

   usage: openstack stack resource metadata [-h]
                                            [-f {html,json,shell,table,value,yaml}]
                                            [-c COLUMN] [--max-width <integer>]
                                            [--noindent] [--prefix PREFIX]
                                            <stack> <resource>

Show resource metadata

**Positional arguments:**

``<stack>``
  Stack to display (name or ID)

``<resource>``
  Name of the resource to show the metadata for

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_stack_resource_show:

openstack stack resource show
-----------------------------

.. code-block:: console

   usage: openstack stack resource show [-h]
                                        [-f {html,json,shell,table,value,yaml}]
                                        [-c COLUMN] [--max-width <integer>]
                                        [--noindent] [--prefix PREFIX]
                                        [--with-attr <attribute>]
                                        <stack> <resource>

Display stack resource.

**Positional arguments:**

``<stack>``
  Name or ID of stack to query

``<resource>``
  Name or ID of resource

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--with-attr <attribute>``
  Attribute to show, can be specified multiple times

.. _openstack_stack_resource_signal:

openstack stack resource signal
-------------------------------

.. code-block:: console

   usage: openstack stack resource signal [-h] [--data <data>]
                                          [--data-file <data-file>]
                                          <stack> <resource>

Signal a resource with optional data.

**Positional arguments:**

``<stack>``
  Name or ID of stack the resource belongs to

``<resource>``
  Name of the resoure to signal

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--data <data>``
  JSON Data to send to the signal handler

``--data-file <data-file>``
  File containing JSON data to send to the signal
  handler

.. _openstack_stack_resume:

openstack stack resume
----------------------

.. code-block:: console

   usage: openstack stack resume [-h] [-f {csv,html,json,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>] [--noindent]
                                 [--quote {all,minimal,none,nonnumeric}] [--wait]
                                 <stack> [<stack> ...]

Resume a stack.

**Positional arguments:**

``<stack>``
  Stack(s) to resume (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--wait``
  Wait for resume to complete

.. _openstack_stack_show:

openstack stack show
--------------------

.. code-block:: console

   usage: openstack stack show [-h] [-f {html,json,shell,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>] [--noindent]
                               [--prefix PREFIX]
                               <stack>

Show stack details.

**Positional arguments:**

``<stack>``
  Stack to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_stack_snapshot_create:

openstack stack snapshot create
-------------------------------

.. code-block:: console

   usage: openstack stack snapshot create [-h]
                                          [-f {html,json,shell,table,value,yaml}]
                                          [-c COLUMN] [--max-width <integer>]
                                          [--noindent] [--prefix PREFIX]
                                          [--name <name>]
                                          <stack>

Create stack snapshot.

**Positional arguments:**

``<stack>``
  Name or ID of stack

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  Name of snapshot

.. _openstack_stack_snapshot_delete:

openstack stack snapshot delete
-------------------------------

.. code-block:: console

   usage: openstack stack snapshot delete [-h] <stack> <snapshot>

Delete stack snapshot.

**Positional arguments:**

``<stack>``
  Name or ID of stack

``<snapshot>``
  ID of stack snapshot

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_stack_snapshot_list:

openstack stack snapshot list
-----------------------------

.. code-block:: console

   usage: openstack stack snapshot list [-h]
                                        [-f {csv,html,json,table,value,yaml}]
                                        [-c COLUMN] [--max-width <integer>]
                                        [--noindent]
                                        [--quote {all,minimal,none,nonnumeric}]
                                        <stack>

List stack snapshots.

**Positional arguments:**

``<stack>``
  Name or ID of stack containing the snapshots

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_stack_snapshot_restore:

openstack stack snapshot restore
--------------------------------

.. code-block:: console

   usage: openstack stack snapshot restore [-h] <stack> <snapshot>

Restore stack snapshot

**Positional arguments:**

``<stack>``
  Name or ID of stack containing the snapshot

``<snapshot>``
  ID of the snapshot to restore

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_stack_snapshot_show:

openstack stack snapshot show
-----------------------------

.. code-block:: console

   usage: openstack stack snapshot show [-h]
                                        [-f {html,json,shell,table,value,yaml}]
                                        [-c COLUMN] [--max-width <integer>]
                                        [--noindent] [--prefix PREFIX]
                                        <stack> <snapshot>

Show stack snapshot.

**Positional arguments:**

``<stack>``
  Name or ID of stack containing the snapshot

``<snapshot>``
  ID of the snapshot to show

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_stack_suspend:

openstack stack suspend
-----------------------

.. code-block:: console

   usage: openstack stack suspend [-h] [-f {csv,html,json,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--noindent]
                                  [--quote {all,minimal,none,nonnumeric}]
                                  [--wait]
                                  <stack> [<stack> ...]

Suspend a stack.

**Positional arguments:**

``<stack>``
  Stack(s) to suspend (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--wait``
  Wait for suspend to complete

.. _openstack_stack_template_show:

openstack stack template show
-----------------------------

.. code-block:: console

   usage: openstack stack template show [-h]
                                        [-f {html,json,shell,table,value,yaml}]
                                        [-c COLUMN] [--max-width <integer>]
                                        [--noindent] [--prefix PREFIX]
                                        <stack>

Display stack template.

**Positional arguments:**

``<stack>``
  Name or ID of stack to query

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_stack_update:

openstack stack update
----------------------

.. code-block:: console

   usage: openstack stack update [-h] [-f {html,json,shell,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>] [--noindent]
                                 [--prefix PREFIX] [-t <template>]
                                 [-e <environment>] [--pre-update <resource>]
                                 [--timeout <timeout>] [--rollback <value>]
                                 [--dry-run] [--parameter <key=value>]
                                 [--parameter-file <key=file>] [--existing]
                                 [--clear-parameter <parameter>]
                                 [--tags <tag1,tag2...>] [--wait]
                                 <stack>

Update a stack.

**Positional arguments:**

``<stack>``
  Name or ID of stack to update

**Optional arguments:**

``-h, --help``
  show this help message and exit

``-t <template>, --template <template>``
  Path to the template

``-e <environment>, --environment <environment>``
  Path to the environment. Can be specified multiple
  times

``--pre-update <resource>``
  Name of a resource to set a pre-update hook to.
  Resources in nested stacks can be set using slash as a
  separator: nested_stack/another/my_resource. You can
  use wildcards to match multiple stacks or resources:
  nested_stack/an\*/\*_resource. This can be specified
  multiple times

``--timeout <timeout>``
  Stack update timeout in minutes

``--rollback <value>``
  Set rollback on update failure. Value "enabled" sets
  rollback to enabled. Value "disabled" sets rollback to
  disabled. Value "keep" uses the value of existing
  stack to be updated (default)

``--dry-run``
  Do not actually perform the stack update, but show
  what would be changed

``--parameter <key=value>``
  Parameter values used to create the stack. This can be
  specified multiple times

``--parameter-file <key=file>``
  Parameter values from file used to create the stack.
  This can be specified multiple times. Parameter value
  would be the content of the file

``--existing``
  Re-use the template, parameters and environment of the
  current stack. If the template argument is omitted
  then the existing template is used. If no
  :option:`--environment` is specified then the existing
  environment is used. Parameters specified in
  :option:`--parameter` will patch over the existing values in the
  current stack. Parameters omitted will keep the
  existing values

``--clear-parameter <parameter>``
  Remove the parameters from the set of parameters of
  current stack for the stack-update. The default value
  in the template will be used. This can be specified
  multiple times

``--tags <tag1,tag2...>``
  An updated list of tags to associate with the stack

``--wait``
  Wait until stack goes to UPDATE_COMPLETE or
  UPDATE_FAILED

.. _openstack_subnet_create:

openstack subnet create
-----------------------

.. code-block:: console

   usage: openstack subnet create [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--noindent] [--prefix PREFIX]
                                  [--project <project>]
                                  [--project-domain <project-domain>]
                                  [--subnet-pool <subnet-pool> | --use-default-subnet-pool]
                                  [--prefix-length <prefix-length>]
                                  [--subnet-range <subnet-range>]
                                  [--dhcp | --no-dhcp] [--gateway <gateway>]
                                  [--ip-version {4,6}]
                                  [--ipv6-ra-mode {dhcpv6-stateful,dhcpv6-stateless,slaac}]
                                  [--ipv6-address-mode {dhcpv6-stateful,dhcpv6-stateless,slaac}]
                                  --network <network>
                                  [--allocation-pool start=<ip-address>,end=<ip-address>]
                                  [--dns-nameserver <dns-nameserver>]
                                  [--host-route destination=<subnet>,gateway=<ip-address>]
                                  name

Create a subnet

**Positional arguments:**

``name``
  New subnet name

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--project <project>``
  Owner's project (name or ID)

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

``--subnet-pool <subnet-pool>``
  Subnet pool from which this subnet will obtain a CIDR
  (Name or ID)

``--use-default-subnet-pool``
  Use default subnet pool for :option:`--ip-version`

``--prefix-length <prefix-length>``
  Prefix length for subnet allocation from subnet pool

``--subnet-range <subnet-range>``
  Subnet range in CIDR notation (required if :option:`--subnet-`
  pool is not specified, optional otherwise)

``--dhcp``
  Enable DHCP (default)

``--no-dhcp``
  Disable DHCP

``--gateway <gateway>``
  Specify a gateway for the subnet. The three options
  are: <ip-address>: Specific IP address to use as the
  gateway, 'auto': Gateway address should automatically
  be chosen from within the subnet itself, 'none': This
  subnet will not use a gateway, e.g.: :option:`--gateway`
  192.168.9.1, :option:`--gateway` auto, :option:`--gateway` none (default
  is 'auto').

``--ip-version {4,6} IP``
  version (default is 4). Note that when subnet pool
  is specified, IP version is determined from the subnet
  pool and this option is ignored.

``--ipv6-ra-mode {dhcpv6-stateful,dhcpv6-stateless,slaac}``
  IPv6 RA (Router Advertisement) mode, valid modes:
  [dhcpv6-stateful, dhcpv6-stateless, slaac]

``--ipv6-address-mode {dhcpv6-stateful,dhcpv6-stateless,slaac}``
  IPv6 address mode, valid modes: [dhcpv6-stateful,
  dhcpv6-stateless, slaac]

``--network <network>``
  Network this subnet belongs to (name or ID)

``--allocation-pool``
  start=<ip-address>,end=<ip-address>
  Allocation pool IP addresses for this subnet e.g.:
  start=192.168.199.2,end=192.168.199.254 (repeat option
  to add multiple IP addresses)

``--dns-nameserver <dns-nameserver>``
  DNS server for this subnet (repeat option to set
  multiple DNS servers)

``--host-route``
  destination=<subnet>,gateway=<ip-address>
  Additional route for this subnet e.g.:
  destination=10.10.0.0/16,gateway=192.168.71.254
  destination: destination subnet (in CIDR notation)
  gateway: nexthop IP address (repeat option to add
  multiple routes)

.. _openstack_subnet_delete:

openstack subnet delete
-----------------------

.. code-block:: console

   usage: openstack subnet delete [-h] <subnet> [<subnet> ...]

Delete subnet(s)

**Positional arguments:**

``<subnet>``
  Subnet(s) to delete (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_subnet_list:

openstack subnet list
---------------------

.. code-block:: console

   usage: openstack subnet list [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}] [--long]
                                [--ip-version <ip-version>] [--dhcp | --no-dhcp]

List subnets

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--long``
  List additional fields in output

``--ip-version <ip-version>``
  List only subnets of given IP version in
  output.Allowed values for IP version are 4 and 6.

``--dhcp``
  List subnets which have DHCP enabled

``--no-dhcp``
  List subnets which have DHCP disabled

.. _openstack_subnet_pool_create:

openstack subnet pool create
----------------------------

.. code-block:: console

   usage: openstack subnet pool create [-h]
                                       [-f {html,json,shell,table,value,yaml}]
                                       [-c COLUMN] [--max-width <integer>]
                                       [--noindent] [--prefix PREFIX]
                                       --pool-prefix <pool-prefix>
                                       [--default-prefix-length <default-prefix-length>]
                                       [--min-prefix-length <min-prefix-length>]
                                       [--max-prefix-length <max-prefix-length>]
                                       [--project <project>]
                                       [--project-domain <project-domain>]
                                       [--address-scope <address-scope>]
                                       [--default | --no-default]
                                       [--share | --no-share]
                                       <name>

Create subnet pool

**Positional arguments:**

``<name>``
  Name of the new subnet pool

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--pool-prefix <pool-prefix>``
  Set subnet pool prefixes (in CIDR notation) (repeat
  option to set multiple prefixes)

``--default-prefix-length <default-prefix-length>``
  Set subnet pool default prefix length

``--min-prefix-length <min-prefix-length>``
  Set subnet pool minimum prefix length

``--max-prefix-length <max-prefix-length>``
  Set subnet pool maximum prefix length

``--project <project>``
  Owner's project (name or ID)

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

``--address-scope <address-scope>``
  Set address scope associated with the subnet pool
  (name or ID), prefixes must be unique across address
  scopes

``--default``
  Set this as a default subnet pool

``--no-default``
  Set this as a non-default subnet pool

``--share``
  Set this subnet pool as shared

``--no-share``
  Set this subnet pool as not shared

.. _openstack_subnet_pool_delete:

openstack subnet pool delete
----------------------------

.. code-block:: console

   usage: openstack subnet pool delete [-h] <subnet-pool> [<subnet-pool> ...]

Delete subnet pool(s)

**Positional arguments:**

``<subnet-pool>``
  Subnet pool(s) to delete (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_subnet_pool_list:

openstack subnet pool list
--------------------------

.. code-block:: console

   usage: openstack subnet pool list [-h] [-f {csv,html,json,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--noindent]
                                     [--quote {all,minimal,none,nonnumeric}]
                                     [--long]

List subnet pools

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--long``
  List additional fields in output

.. _openstack_subnet_pool_set:

openstack subnet pool set
-------------------------

.. code-block:: console

   usage: openstack subnet pool set [-h] [--name <name>]
                                    [--pool-prefix <pool-prefix>]
                                    [--default-prefix-length <default-prefix-length>]
                                    [--min-prefix-length <min-prefix-length>]
                                    [--max-prefix-length <max-prefix-length>]
                                    [--address-scope <address-scope> | --no-address-scope]
                                    [--default | --no-default]
                                    <subnet-pool>

Set subnet pool properties

**Positional arguments:**

``<subnet-pool>``
  Subnet pool to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  Set subnet pool name

``--pool-prefix <pool-prefix>``
  Set subnet pool prefixes (in CIDR notation) (repeat
  option to set multiple prefixes)

``--default-prefix-length <default-prefix-length>``
  Set subnet pool default prefix length

``--min-prefix-length <min-prefix-length>``
  Set subnet pool minimum prefix length

``--max-prefix-length <max-prefix-length>``
  Set subnet pool maximum prefix length

``--address-scope <address-scope>``
  Set address scope associated with the subnet pool
  (name or ID), prefixes must be unique across address
  scopes

``--no-address-scope``
  Remove address scope associated with the subnet pool

``--default``
  Set this as a default subnet pool

``--no-default``
  Set this as a non-default subnet pool

.. _openstack_subnet_pool_show:

openstack subnet pool show
--------------------------

.. code-block:: console

   usage: openstack subnet pool show [-h] [-f {html,json,shell,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--noindent] [--prefix PREFIX]
                                     <subnet-pool>

Display subnet pool details

**Positional arguments:**

``<subnet-pool>``
  Subnet pool to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_subnet_pool_unset:

openstack subnet pool unset
---------------------------

.. code-block:: console

   usage: openstack subnet pool unset [-h] [--pool-prefix <pool-prefix>]
                                      <subnet-pool>

Unset subnet pool properties

**Positional arguments:**

``<subnet-pool>``
  Subnet pool to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--pool-prefix <pool-prefix>``
  Remove subnet pool prefixes (in CIDR notation).
  (repeat option to unset multiple prefixes).

.. _openstack_subnet_set:

openstack subnet set
--------------------

.. code-block:: console

   usage: openstack subnet set [-h] [--name <name>] [--dhcp | --no-dhcp]
                               [--gateway <gateway>]
                               [--allocation-pool start=<ip-address>,end=<ip-address>]
                               [--dns-nameserver <dns-nameserver>]
                               [--host-route destination=<subnet>,gateway=<ip-address>]
                               <subnet>

Set subnet properties

**Positional arguments:**

``<subnet>``
  Subnet to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  Updated name of the subnet

``--dhcp``
  Enable DHCP

``--no-dhcp``
  Disable DHCP

``--gateway <gateway>``
  Specify a gateway for the subnet. The options are:
  <ip-address>: Specific IP address to use as the
  gateway, 'none': This subnet will not use a gateway,
  e.g.: :option:`--gateway` 192.168.9.1, :option:`--gateway` none.

``--allocation-pool``
  start=<ip-address>,end=<ip-address>
  Allocation pool IP addresses for this subnet e.g.:
  start=192.168.199.2,end=192.168.199.254 (repeat option
  to add multiple IP addresses)

``--dns-nameserver <dns-nameserver>``
  DNS server for this subnet (repeat option to set
  multiple DNS servers)

``--host-route``
  destination=<subnet>,gateway=<ip-address>
  Additional route for this subnet e.g.:
  destination=10.10.0.0/16,gateway=192.168.71.254
  destination: destination subnet (in CIDR notation)
  gateway: nexthop IP address (repeat option to add
  multiple routes)

.. _openstack_subnet_show:

openstack subnet show
---------------------

.. code-block:: console

   usage: openstack subnet show [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--prefix PREFIX]
                                <subnet>

Display subnet details

**Positional arguments:**

``<subnet>``
  Subnet to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_subnet_unset:

openstack subnet unset
----------------------

.. code-block:: console

   usage: openstack subnet unset [-h]
                                 [--allocation-pool start=<ip-address>,end=<ip-address>]
                                 [--dns-nameserver <dns-nameserver>]
                                 [--host-route destination=<subnet>,gateway=<ip-address>]
                                 <subnet>

Unset subnet properties

**Positional arguments:**

``<subnet>``
  Subnet to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--allocation-pool``
  start=<ip-address>,end=<ip-address>
  Allocation pool to be removed from this subnet e.g.:
  start=192.168.199.2,end=192.168.199.254 (repeat option
  to unset multiple Allocation pools)

``--dns-nameserver <dns-nameserver>``
  DNS server to be removed from this subnet (repeat
  option to set multiple DNS servers)

``--host-route``
  destination=<subnet>,gateway=<ip-address>
  Route to be removed from this subnet e.g.:
  destination=10.10.0.0/16,gateway=192.168.71.254
  destination: destination subnet (in CIDR notation)
  gateway: nexthop IP address (repeat option to unset
  multiple host routes)

.. _openstack_subscription_create:

openstack subscription create
-----------------------------

.. code-block:: console

   usage: openstack subscription create [-h]
                                        [-f {html,json,shell,table,value,yaml}]
                                        [-c COLUMN] [--max-width <integer>]
                                        [--noindent] [--prefix PREFIX]
                                        [--options <options>]
                                        <queue_name> <subscriber> <ttl>

Create a subscription for queue

**Positional arguments:**

``<queue_name>``
  Name of the queue to subscribe to

``<subscriber>``
  Subscriber which will be notified

``<ttl>``
  Time to live of the subscription in seconds

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--options <options>``
  Metadata of the subscription in JSON format

.. _openstack_subscription_delete:

openstack subscription delete
-----------------------------

.. code-block:: console

   usage: openstack subscription delete [-h] <queue_name> <subscription_id>

Delete a subscription

**Positional arguments:**

``<queue_name>``
  Name of the queue for the subscription

``<subscription_id>``
  ID of the subscription

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_subscription_list:

openstack subscription list
---------------------------

.. code-block:: console

   usage: openstack subscription list [-h] [-f {csv,html,json,table,value,yaml}]
                                      [-c COLUMN] [--max-width <integer>]
                                      [--noindent]
                                      [--quote {all,minimal,none,nonnumeric}]
                                      [--marker <subscription_id>]
                                      [--limit <limit>] [--detailed <detailed>]
                                      <queue_name>

List available subscriptions

**Positional arguments:**

``<queue_name>``
  Name of the queue to subscribe to

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--marker <subscription_id>``
  Subscription's paging marker, the ID of the last
  subscription of the previous page

``--limit <limit>``
  Page size limit, default value is 20

``--detailed <detailed>``
  Whether to show subscription metadata

.. _openstack_subscription_show:

openstack subscription show
---------------------------

.. code-block:: console

   usage: openstack subscription show [-h]
                                      [-f {html,json,shell,table,value,yaml}]
                                      [-c COLUMN] [--max-width <integer>]
                                      [--noindent] [--prefix PREFIX]
                                      <queue_name> <subscription_id>

Display subscription details

**Positional arguments:**

``<queue_name>``
  Name of the queue to subscribe to

``<subscription_id>``
  ID of the subscription

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_subscription_update:

openstack subscription update
-----------------------------

.. code-block:: console

   usage: openstack subscription update [-h]
                                        [-f {html,json,shell,table,value,yaml}]
                                        [-c COLUMN] [--max-width <integer>]
                                        [--noindent] [--prefix PREFIX]
                                        [--subscriber <subscriber>] [--ttl <ttl>]
                                        [--options <options>]
                                        <queue_name> <subscription_id>

Update a subscription

**Positional arguments:**

``<queue_name>``
  Name of the queue to subscribe to

``<subscription_id>``
  ID of the subscription

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--subscriber <subscriber>``
  Subscriber which will be notified

``--ttl <ttl>``
  Time to live of the subscription in seconds

``--options <options>``
  Metadata of the subscription in JSON format

.. _openstack_tld_create:

openstack tld create
--------------------

.. code-block:: console

   usage: openstack tld create [-h] [-f {html,json,shell,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>] [--noindent]
                               [--prefix PREFIX] --name NAME
                               [--description DESCRIPTION] [--all-projects]
                               [--edit-managed]
                               [--sudo-project-id SUDO_PROJECT_ID]

Create new tld

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name NAME``
  TLD Name

``--description DESCRIPTION``
  Description

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_tld_delete:

openstack tld delete
--------------------

.. code-block:: console

   usage: openstack tld delete [-h] [--all-projects] [--edit-managed]
                               [--sudo-project-id SUDO_PROJECT_ID]
                               id

Delete tld

**Positional arguments:**

``id``
  TLD ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_tld_list:

openstack tld list
------------------

.. code-block:: console

   usage: openstack tld list [-h] [-f {csv,html,json,table,value,yaml}]
                             [-c COLUMN] [--max-width <integer>] [--noindent]
                             [--quote {all,minimal,none,nonnumeric}]
                             [--name NAME] [--description DESCRIPTION]
                             [--all-projects] [--edit-managed]
                             [--sudo-project-id SUDO_PROJECT_ID]

List tlds

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name NAME``
  TLD NAME

``--description DESCRIPTION``
  TLD Description

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_tld_set:

openstack tld set
-----------------

.. code-block:: console

   usage: openstack tld set [-h] [-f {html,json,shell,table,value,yaml}]
                            [-c COLUMN] [--max-width <integer>] [--noindent]
                            [--prefix PREFIX] [--name NAME]
                            [--description DESCRIPTION | --no-description]
                            [--all-projects] [--edit-managed]
                            [--sudo-project-id SUDO_PROJECT_ID]
                            id

Set tld properties

**Positional arguments:**

``id``
  TLD ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name NAME``
  TLD Name

``--description DESCRIPTION``
  Description

``--no-description``

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_tld_show:

openstack tld show
------------------

.. code-block:: console

   usage: openstack tld show [-h] [-f {html,json,shell,table,value,yaml}]
                             [-c COLUMN] [--max-width <integer>] [--noindent]
                             [--prefix PREFIX] [--all-projects] [--edit-managed]
                             [--sudo-project-id SUDO_PROJECT_ID]
                             id

Show tld details

**Positional arguments:**

``id``
  TLD ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_token_issue:

openstack token issue
---------------------

.. code-block:: console

   usage: openstack token issue [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--prefix PREFIX]

Issue new token

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_token_revoke:

openstack token revoke
----------------------

.. code-block:: console

   usage: openstack token revoke [-h] <token>

Revoke existing token

**Positional arguments:**

``<token>``
  Token to be deleted

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_trust_create:

openstack trust create
----------------------

.. code-block:: console

   usage: openstack trust create [-h] [-f {html,json,shell,table,value,yaml}]
                                 [-c COLUMN] [--max-width <integer>] [--noindent]
                                 [--prefix PREFIX] --project <project> --role
                                 <role> [--impersonate]
                                 [--expiration <expiration>]
                                 [--project-domain <project-domain>]
                                 [--trustor-domain <trustor-domain>]
                                 [--trustee-domain <trustee-domain>]
                                 <trustor-user> <trustee-user>

Create new trust

**Positional arguments:**

``<trustor-user>``
  User that is delegating authorization (name or ID)

``<trustee-user>``
  User that is assuming authorization (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--project <project>``
  Project being delegated (name or ID) (required)

``--role <role>``
  Roles to authorize (name or ID) (repeat option to set
  multiple values, required)

``--impersonate``
  Tokens generated from the trust will represent
  <trustor> (defaults to False)

``--expiration <expiration>``
  Sets an expiration date for the trust (format of YYYY-mm-ddTHH:MM:SS)

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

``--trustor-domain <trustor-domain>``
  Domain that contains <trustor> (name or ID)

``--trustee-domain <trustee-domain>``
  Domain that contains <trustee> (name or ID)

.. _openstack_trust_delete:

openstack trust delete
----------------------

.. code-block:: console

   usage: openstack trust delete [-h] <trust> [<trust> ...]

Delete trust(s)

**Positional arguments:**

``<trust>``
  Trust(s) to delete

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_trust_list:

openstack trust list
--------------------

.. code-block:: console

   usage: openstack trust list [-h] [-f {csv,html,json,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>] [--noindent]
                               [--quote {all,minimal,none,nonnumeric}]

List trusts

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_trust_show:

openstack trust show
--------------------

.. code-block:: console

   usage: openstack trust show [-h] [-f {html,json,shell,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>] [--noindent]
                               [--prefix PREFIX]
                               <trust>

Display trust details

**Positional arguments:**

``<trust>``
  Trust to display

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_usage_list:

openstack usage list
--------------------

.. code-block:: console

   usage: openstack usage list [-h] [-f {csv,html,json,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>] [--noindent]
                               [--quote {all,minimal,none,nonnumeric}]
                               [--start <start>] [--end <end>]

List resource usage per project

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--start <start>``
  Usage range start date, ex 2012-01-20 (default: 4
  weeks ago)

``--end <end>``
  Usage range end date, ex 2012-01-20 (default:
  tomorrow)

.. _openstack_usage_show:

openstack usage show
--------------------

.. code-block:: console

   usage: openstack usage show [-h] [-f {html,json,shell,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>] [--noindent]
                               [--prefix PREFIX] [--project <project>]
                               [--start <start>] [--end <end>]

Show resource usage for a single project

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--project <project>``
  Name or ID of project to show usage for

``--start <start>``
  Usage range start date, ex 2012-01-20 (default: 4
  weeks ago)

``--end <end>``
  Usage range end date, ex 2012-01-20 (default:
  tomorrow)

.. _openstack_user_create:

openstack user create
---------------------

.. code-block:: console

   usage: openstack user create [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--prefix PREFIX] [--domain <domain>]
                                [--project <project>]
                                [--project-domain <project-domain>]
                                [--password <password>] [--password-prompt]
                                [--email <email-address>]
                                [--description <description>]
                                [--enable | --disable] [--or-show]
                                <name>

Create new user

**Positional arguments:**

``<name>``
  New user name

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--domain <domain>``
  Default domain (name or ID)

``--project <project>``
  Default project (name or ID)

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

``--password <password>``
  Set user password

``--password-prompt``
  Prompt interactively for password

``--email <email-address>``
  Set user email address

``--description <description>``
  User description

``--enable``
  Enable user (default)

``--disable``
  Disable user

``--or-show``
  Return existing user

.. _openstack_user_delete:

openstack user delete
---------------------

.. code-block:: console

   usage: openstack user delete [-h] [--domain <domain>] <user> [<user> ...]

Delete user(s)

**Positional arguments:**

``<user>``
  User(s) to delete (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--domain <domain>``
  Domain owning <user> (name or ID)

.. _openstack_user_list:

openstack user list
-------------------

.. code-block:: console

   usage: openstack user list [-h] [-f {csv,html,json,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--noindent]
                              [--quote {all,minimal,none,nonnumeric}]
                              [--domain <domain>]
                              [--group <group> | --project <project>] [--long]

List users

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--domain <domain>``
  Filter users by <domain> (name or ID)

``--group <group>``
  Filter users by <group> membership (name or ID)

``--project <project>``
  Filter users by <project> (name or ID)

``--long``
  List additional fields in output

.. _openstack_user_password_set:

openstack user password set
---------------------------

.. code-block:: console

   usage: openstack user password set [-h] [--password <new-password>]
                                      [--original-password <original-password>]

Change current user password

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--password <new-password>``
  New user password

``--original-password <original-password>``
  Original user password

.. _openstack_user_set:

openstack user set
------------------

.. code-block:: console

   usage: openstack user set [-h] [--name <name>] [--project <project>]
                             [--project-domain <project-domain>]
                             [--password <password>] [--password-prompt]
                             [--email <email-address>]
                             [--description <description>] [--enable | --disable]
                             <user>

Set user properties

**Positional arguments:**

``<user>``
  User to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  Set user name

``--project <project>``
  Set default project (name or ID)

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

``--password <password>``
  Set user password

``--password-prompt``
  Prompt interactively for password

``--email <email-address>``
  Set user email address

``--description <description>``
  Set user description

``--enable``
  Enable user (default)

``--disable``
  Disable user

.. _openstack_user_show:

openstack user show
-------------------

.. code-block:: console

   usage: openstack user show [-h] [-f {html,json,shell,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--noindent]
                              [--prefix PREFIX] [--domain <domain>]
                              <user>

Display user details

**Positional arguments:**

``<user>``
  User to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--domain <domain>``
  Domain owning <user> (name or ID)

.. _openstack_volume_backup_create:

openstack volume backup create
------------------------------

.. code-block:: console

   usage: openstack volume backup create [-h]
                                         [-f {html,json,shell,table,value,yaml}]
                                         [-c COLUMN] [--max-width <integer>]
                                         [--noindent] [--prefix PREFIX]
                                         [--name <name>]
                                         [--description <description>]
                                         [--container <container>]
                                         [--snapshot <snapshot>] [--force]
                                         [--incremental]
                                         <volume>

Create new volume backup

**Positional arguments:**

``<volume>``
  Volume to backup (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  Name of the backup

``--description <description>``
  Description of the backup

``--container <container>``
  Optional backup container name

``--snapshot <snapshot>``
  Snapshot to backup (name or ID)

``--force``
  Allow to back up an in-use volume

``--incremental``
  Perform an incremental backup

.. _openstack_volume_backup_delete:

openstack volume backup delete
------------------------------

.. code-block:: console

   usage: openstack volume backup delete [-h] [--force] <backup> [<backup> ...]

Delete volume backup(s)

**Positional arguments:**

``<backup>``
  Backup(s) to delete (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--force``
  Allow delete in state other than error or available

.. _openstack_volume_backup_list:

openstack volume backup list
----------------------------

.. code-block:: console

   usage: openstack volume backup list [-h] [-f {csv,html,json,table,value,yaml}]
                                       [-c COLUMN] [--max-width <integer>]
                                       [--noindent]
                                       [--quote {all,minimal,none,nonnumeric}]
                                       [--long]

List volume backups

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--long``
  List additional fields in output

.. _openstack_volume_backup_restore:

openstack volume backup restore
-------------------------------

.. code-block:: console

   usage: openstack volume backup restore [-h]
                                          [-f {html,json,shell,table,value,yaml}]
                                          [-c COLUMN] [--max-width <integer>]
                                          [--noindent] [--prefix PREFIX]
                                          <backup> <volume>

Restore volume backup

**Positional arguments:**

``<backup>``
  Backup to restore (name or ID)

``<volume>``
  Volume to restore to (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_volume_backup_show:

openstack volume backup show
----------------------------

.. code-block:: console

   usage: openstack volume backup show [-h]
                                       [-f {html,json,shell,table,value,yaml}]
                                       [-c COLUMN] [--max-width <integer>]
                                       [--noindent] [--prefix PREFIX]
                                       <backup>

Display volume backup details

**Positional arguments:**

``<backup>``
  Backup to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_volume_create:

openstack volume create
-----------------------

.. code-block:: console

   usage: openstack volume create [-h] [-f {html,json,shell,table,value,yaml}]
                                  [-c COLUMN] [--max-width <integer>]
                                  [--noindent] [--prefix PREFIX] --size <size>
                                  [--type <volume-type>] [--image <image>]
                                  [--snapshot <snapshot>] [--source <volume>]
                                  [--description <description>] [--user <user>]
                                  [--project <project>]
                                  [--availability-zone <availability-zone>]
                                  [--property <key=value>]
                                  <name>

Create new volume

**Positional arguments:**

``<name>``
  Volume name

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--size <size>``
  Volume size in GB

``--type <volume-type>``
  Set the type of volume

``--image <image>``
  Use <image> as source of volume (name or ID)

``--snapshot <snapshot>``
  Use <snapshot> as source of volume (name or ID)

``--source <volume>``
  Volume to clone (name or ID)

``--description <description>``
  Volume description

``--user <user>``
  Specify an alternate user (name or ID)

``--project <project>``
  Specify an alternate project (name or ID)

``--availability-zone <availability-zone>``
  Create volume in <availability-zone>

``--property <key=value>``
  Set a property to this volume (repeat option to set
  multiple properties)

.. _openstack_volume_delete:

openstack volume delete
-----------------------

.. code-block:: console

   usage: openstack volume delete [-h] [--force | --purge]
                                  <volume> [<volume> ...]

Delete volume(s)

**Positional arguments:**

``<volume>``
  Volume(s) to delete (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--force``
  Attempt forced removal of volume(s), regardless of state
  (defaults to False)

``--purge``
  Remove any snapshots along with volume(s) (defaults to False)

.. _openstack_volume_list:

openstack volume list
---------------------

.. code-block:: console

   usage: openstack volume list [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--quote {all,minimal,none,nonnumeric}]
                                [--project <project>]
                                [--project-domain <project-domain>]
                                [--user <user>] [--user-domain <user-domain>]
                                [--name <name>] [--status <status>]
                                [--all-projects] [--long]

List volumes

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--project <project>``
  Filter results by project (name or ID) (admin only)

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

``--user <user>``
  Filter results by user (name or ID) (admin only)

``--user-domain <user-domain>``
  Domain the user belongs to (name or ID). This can be
  used in case collisions between user names exist.

``--name <name>``
  Filter results by volume name

``--status <status>``
  Filter results by status

``--all-projects``
  Include all projects (admin only)

``--long``
  List additional fields in output

.. _openstack_volume_qos_associate:

openstack volume qos associate
------------------------------

.. code-block:: console

   usage: openstack volume qos associate [-h] <qos-spec> <volume-type>

Associate a QoS specification to a volume type

**Positional arguments:**

``<qos-spec>``
  QoS specification to modify (name or ID)

``<volume-type>``
  Volume type to associate the QoS (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_volume_qos_create:

openstack volume qos create
---------------------------

.. code-block:: console

   usage: openstack volume qos create [-h]
                                      [-f {html,json,shell,table,value,yaml}]
                                      [-c COLUMN] [--max-width <integer>]
                                      [--noindent] [--prefix PREFIX]
                                      [--consumer <consumer>]
                                      [--property <key=value>]
                                      <name>

Create new QoS specification

**Positional arguments:**

``<name>``
  New QoS specification name

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--consumer <consumer>``
  Consumer of the QoS. Valid consumers: back-end, both,
  front-end (defaults to 'both')

``--property <key=value>``
  Set a QoS specification property (repeat option to set
  multiple properties)

.. _openstack_volume_qos_delete:

openstack volume qos delete
---------------------------

.. code-block:: console

   usage: openstack volume qos delete [-h] [--force] <qos-spec> [<qos-spec> ...]

Delete QoS specification

**Positional arguments:**

``<qos-spec>``
  QoS specification(s) to delete (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--force``
  Allow to delete in-use QoS specification(s)

.. _openstack_volume_qos_disassociate:

openstack volume qos disassociate
---------------------------------

.. code-block:: console

   usage: openstack volume qos disassociate [-h]
                                            [--volume-type <volume-type> | --all]
                                            <qos-spec>

Disassociate a QoS specification from a volume type

**Positional arguments:**

``<qos-spec>``
  QoS specification to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--volume-type <volume-type>``
  Volume type to disassociate the QoS from (name or ID)

``--all``
  Disassociate the QoS from every volume type

.. _openstack_volume_qos_list:

openstack volume qos list
-------------------------

.. code-block:: console

   usage: openstack volume qos list [-h] [-f {csv,html,json,table,value,yaml}]
                                    [-c COLUMN] [--max-width <integer>]
                                    [--noindent]
                                    [--quote {all,minimal,none,nonnumeric}]

List QoS specifications

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_volume_qos_set:

openstack volume qos set
------------------------

.. code-block:: console

   usage: openstack volume qos set [-h] [--property <key=value>] <qos-spec>

Set QoS specification properties

**Positional arguments:**

``<qos-spec>``
  QoS specification to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--property <key=value>``
  Property to add or modify for this QoS specification
  (repeat option to set multiple properties)

.. _openstack_volume_qos_show:

openstack volume qos show
-------------------------

.. code-block:: console

   usage: openstack volume qos show [-h] [-f {html,json,shell,table,value,yaml}]
                                    [-c COLUMN] [--max-width <integer>]
                                    [--noindent] [--prefix PREFIX]
                                    <qos-spec>

Display QoS specification details

**Positional arguments:**

``<qos-spec>``
  QoS specification to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_volume_qos_unset:

openstack volume qos unset
--------------------------

.. code-block:: console

   usage: openstack volume qos unset [-h] [--property <key>] <qos-spec>

Unset QoS specification properties

**Positional arguments:**

``<qos-spec>``
  QoS specification to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--property <key>``
  Property to remove from the QoS specification. (repeat
  option to unset multiple properties)

.. _openstack_volume_service_list:

openstack volume service list
-----------------------------

.. code-block:: console

   usage: openstack volume service list [-h]
                                        [-f {csv,html,json,table,value,yaml}]
                                        [-c COLUMN] [--max-width <integer>]
                                        [--noindent]
                                        [--quote {all,minimal,none,nonnumeric}]
                                        [--host <host>] [--service <service>]
                                        [--long]

List service command

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--host <host>``
  List services on specified host (name only)

``--service <service>``
  List only specified service (name only)

``--long``
  List additional fields in output

.. _openstack_volume_set:

openstack volume set
--------------------

.. code-block:: console

   usage: openstack volume set [-h] [--name <name>] [--size <size>]
                               [--description <description>]
                               [--property <key=value>]
                               [--image-property <key=value>] [--state <state>]
                               <volume>

Set volume properties

**Positional arguments:**

``<volume>``
  Volume to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  New volume name

``--size <size>``
  Extend volume size in GB

``--description <description>``
  New volume description

``--property <key=value>``
  Set a property on this volume (repeat option to set
  multiple properties)

``--image-property <key=value>``
  Set an image property on this volume (repeat option to
  set multiple image properties)

``--state <state>``
  New volume state ("available", "error", "creating",
  "deleting", "in-use", "attaching", "detaching",
  "error_deleting" or "maintenance")

.. _openstack_volume_show:

openstack volume show
---------------------

.. code-block:: console

   usage: openstack volume show [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--prefix PREFIX]
                                <volume-id>

Display volume details

**Positional arguments:**

``<volume-id>``
  Volume to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_volume_transfer_request_list:

openstack volume transfer request list
--------------------------------------

.. code-block:: console

   usage: openstack volume transfer request list [-h]
                                                 [-f {csv,html,json,table,value,yaml}]
                                                 [-c COLUMN]
                                                 [--max-width <integer>]
                                                 [--noindent]
                                                 [--quote {all,minimal,none,nonnumeric}]
                                                 [--all-projects]

Lists all volume transfer requests.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Shows detail for all projects. Admin only. (defaults
  to False)

.. _openstack_volume_type_create:

openstack volume type create
----------------------------

.. code-block:: console

   usage: openstack volume type create [-h]
                                       [-f {html,json,shell,table,value,yaml}]
                                       [-c COLUMN] [--max-width <integer>]
                                       [--noindent] [--prefix PREFIX]
                                       [--description <description>]
                                       [--public | --private]
                                       [--property <key=value>]
                                       [--project <project>]
                                       [--project-domain <project-domain>]
                                       <name>

Create new volume type

**Positional arguments:**

``<name>``
  Volume type name

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--description <description>``
  Volume type description

``--public``
  Volume type is accessible to the public

``--private``
  Volume type is not accessible to the public

``--property <key=value>``
  Set a property on this volume type (repeat option to
  set multiple properties)

``--project <project>``
  Allow <project> to access private type (name or ID)
  (Must be used with :option:`--private` option)

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

.. _openstack_volume_type_delete:

openstack volume type delete
----------------------------

.. code-block:: console

   usage: openstack volume type delete [-h] <volume-type> [<volume-type> ...]

Delete volume type(s)

**Positional arguments:**

``<volume-type>``
  Volume type(s) to delete (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_volume_type_list:

openstack volume type list
--------------------------

.. code-block:: console

   usage: openstack volume type list [-h] [-f {csv,html,json,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--noindent]
                                     [--quote {all,minimal,none,nonnumeric}]
                                     [--long] [--public | --private]

List volume types

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--long``
  List additional fields in output

``--public``
  List only public types

``--private``
  List only private types (admin only)

.. _openstack_volume_type_set:

openstack volume type set
-------------------------

.. code-block:: console

   usage: openstack volume type set [-h] [--name <name>] [--description <name>]
                                    [--property <key=value>]
                                    [--project <project>]
                                    [--project-domain <project-domain>]
                                    <volume-type>

Set volume type properties

**Positional arguments:**

``<volume-type>``
  Volume type to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name <name>``
  Set volume type name

``--description <name>``
  Set volume type description

``--property <key=value>``
  Set a property on this volume type (repeat option to
  set multiple properties)

``--project <project>``
  Set volume type access to project (name or ID) (admin
  only)

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

.. _openstack_volume_type_show:

openstack volume type show
--------------------------

.. code-block:: console

   usage: openstack volume type show [-h] [-f {html,json,shell,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--noindent] [--prefix PREFIX]
                                     <volume-type>

Display volume type details

**Positional arguments:**

``<volume-type>``
  Volume type to display (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _openstack_volume_type_unset:

openstack volume type unset
---------------------------

.. code-block:: console

   usage: openstack volume type unset [-h] [--property <key>]
                                      [--project <project>]
                                      [--project-domain <project-domain>]
                                      <volume-type>

Unset volume type properties

**Positional arguments:**

``<volume-type>``
  Volume type to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--property <key>``
  Remove a property from this volume type (repeat option
  to remove multiple properties)

``--project <project>``
  Removes volume type access to project (name or ID)
  (admin only)

``--project-domain <project-domain>``
  Domain the project belongs to (name or ID). This can
  be used in case collisions between project names
  exist.

.. _openstack_volume_unset:

openstack volume unset
----------------------

.. code-block:: console

   usage: openstack volume unset [-h] [--property <key>] [--image-property <key>]
                                 <volume>

Unset volume properties

**Positional arguments:**

``<volume>``
  Volume to modify (name or ID)

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--property <key>``
  Remove a property from volume (repeat option to remove
  multiple properties)

``--image-property <key>``
  Remove an image property from volume (repeat option to
  remove multiple image properties)

.. _openstack_zone_abandon:

openstack zone abandon
----------------------

.. code-block:: console

   usage: openstack zone abandon [-h] [--all-projects] [--edit-managed]
                                 [--sudo-project-id SUDO_PROJECT_ID]
                                 id

Abandon a zone

**Positional arguments:**

``id``
  Zone ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_axfr:

openstack zone axfr
-------------------

.. code-block:: console

   usage: openstack zone axfr [-h] [--all-projects] [--edit-managed]
                              [--sudo-project-id SUDO_PROJECT_ID]
                              id

AXFR a zone

**Positional arguments:**

``id``
  Zone ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_blacklist_create:

openstack zone blacklist create
-------------------------------

.. code-block:: console

   usage: openstack zone blacklist create [-h]
                                          [-f {html,json,shell,table,value,yaml}]
                                          [-c COLUMN] [--max-width <integer>]
                                          [--noindent] [--prefix PREFIX]
                                          --pattern PATTERN
                                          [--description DESCRIPTION]
                                          [--all-projects] [--edit-managed]
                                          [--sudo-project-id SUDO_PROJECT_ID]

Create new blacklist

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--pattern PATTERN``
  Blacklist pattern

``--description DESCRIPTION``
  Description

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_blacklist_delete:

openstack zone blacklist delete
-------------------------------

.. code-block:: console

   usage: openstack zone blacklist delete [-h] [--all-projects] [--edit-managed]
                                          [--sudo-project-id SUDO_PROJECT_ID]
                                          id

Delete blacklist

**Positional arguments:**

``id``
  Blacklist ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_blacklist_list:

openstack zone blacklist list
-----------------------------

.. code-block:: console

   usage: openstack zone blacklist list [-h]
                                        [-f {csv,html,json,table,value,yaml}]
                                        [-c COLUMN] [--max-width <integer>]
                                        [--noindent]
                                        [--quote {all,minimal,none,nonnumeric}]
                                        [--all-projects] [--edit-managed]
                                        [--sudo-project-id SUDO_PROJECT_ID]

List blacklists

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_blacklist_set:

openstack zone blacklist set
----------------------------

.. code-block:: console

   usage: openstack zone blacklist set [-h]
                                       [-f {html,json,shell,table,value,yaml}]
                                       [-c COLUMN] [--max-width <integer>]
                                       [--noindent] [--prefix PREFIX]
                                       [--pattern PATTERN]
                                       [--description DESCRIPTION | --no-description]
                                       [--all-projects] [--edit-managed]
                                       [--sudo-project-id SUDO_PROJECT_ID]
                                       id

Set blacklist properties

**Positional arguments:**

``id``
  Blacklist ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--pattern PATTERN``
  Blacklist pattern

``--description DESCRIPTION``
  Description

``--no-description``

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_blacklist_show:

openstack zone blacklist show
-----------------------------

.. code-block:: console

   usage: openstack zone blacklist show [-h]
                                        [-f {html,json,shell,table,value,yaml}]
                                        [-c COLUMN] [--max-width <integer>]
                                        [--noindent] [--prefix PREFIX]
                                        [--all-projects] [--edit-managed]
                                        [--sudo-project-id SUDO_PROJECT_ID]
                                        id

Show blacklist details

**Positional arguments:**

``id``
  Blacklist ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_create:

openstack zone create
---------------------

.. code-block:: console

   usage: openstack zone create [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--prefix PREFIX] [--email EMAIL] [--type TYPE]
                                [--ttl TTL] [--description DESCRIPTION]
                                [--masters MASTERS [MASTERS ...]]
                                [--all-projects] [--edit-managed]
                                [--sudo-project-id SUDO_PROJECT_ID]
                                name

Create new zone

**Positional arguments:**

``name``
  Zone Name

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--email EMAIL``
  Zone Email

``--type TYPE``
  Zone Type

``--ttl TTL``
  Time To Live (Seconds)

``--description DESCRIPTION``
  Description

``--masters MASTERS [MASTERS ...]``
  Zone Masters

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_delete:

openstack zone delete
---------------------

.. code-block:: console

   usage: openstack zone delete [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>] [--noindent]
                                [--prefix PREFIX] [--all-projects]
                                [--edit-managed]
                                [--sudo-project-id SUDO_PROJECT_ID]
                                id

Delete zone

**Positional arguments:**

``id``
  Zone ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_export_create:

openstack zone export create
----------------------------

.. code-block:: console

   usage: openstack zone export create [-h]
                                       [-f {html,json,shell,table,value,yaml}]
                                       [-c COLUMN] [--max-width <integer>]
                                       [--noindent] [--prefix PREFIX]
                                       [--all-projects] [--edit-managed]
                                       [--sudo-project-id SUDO_PROJECT_ID]
                                       zone_id

Export a Zone

**Positional arguments:**

``zone_id``
  Zone ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_export_delete:

openstack zone export delete
----------------------------

.. code-block:: console

   usage: openstack zone export delete [-h] [--all-projects] [--edit-managed]
                                       [--sudo-project-id SUDO_PROJECT_ID]
                                       zone_export_id

Delete a Zone Export

**Positional arguments:**

``zone_export_id``
  Zone Export ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_export_list:

openstack zone export list
--------------------------

.. code-block:: console

   usage: openstack zone export list [-h] [-f {csv,html,json,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--noindent]
                                     [--quote {all,minimal,none,nonnumeric}]
                                     [--all-projects] [--edit-managed]
                                     [--sudo-project-id SUDO_PROJECT_ID]

List Zone Exports

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_export_show:

openstack zone export show
--------------------------

.. code-block:: console

   usage: openstack zone export show [-h] [-f {html,json,shell,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--noindent] [--prefix PREFIX]
                                     [--all-projects] [--edit-managed]
                                     [--sudo-project-id SUDO_PROJECT_ID]
                                     zone_export_id

Show a Zone Export

**Positional arguments:**

``zone_export_id``
  Zone Export ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_export_showfile:

openstack zone export showfile
------------------------------

.. code-block:: console

   usage: openstack zone export showfile [-h]
                                         [-f {html,json,shell,table,value,yaml}]
                                         [-c COLUMN] [--max-width <integer>]
                                         [--noindent] [--prefix PREFIX]
                                         [--all-projects] [--edit-managed]
                                         [--sudo-project-id SUDO_PROJECT_ID]
                                         zone_export_id

Show the zone file for the Zone Export

**Positional arguments:**

``zone_export_id``
  Zone Export ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_import_create:

openstack zone import create
----------------------------

.. code-block:: console

   usage: openstack zone import create [-h]
                                       [-f {html,json,shell,table,value,yaml}]
                                       [-c COLUMN] [--max-width <integer>]
                                       [--noindent] [--prefix PREFIX]
                                       [--all-projects] [--edit-managed]
                                       [--sudo-project-id SUDO_PROJECT_ID]
                                       zone_file_path

Import a Zone from a file on the filesystem

**Positional arguments:**

``zone_file_path``
  Path to a zone file

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_import_delete:

openstack zone import delete
----------------------------

.. code-block:: console

   usage: openstack zone import delete [-h] [--all-projects] [--edit-managed]
                                       [--sudo-project-id SUDO_PROJECT_ID]
                                       zone_import_id

Delete a Zone Import

**Positional arguments:**

``zone_import_id``
  Zone Import ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_import_list:

openstack zone import list
--------------------------

.. code-block:: console

   usage: openstack zone import list [-h] [-f {csv,html,json,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--noindent]
                                     [--quote {all,minimal,none,nonnumeric}]
                                     [--all-projects] [--edit-managed]
                                     [--sudo-project-id SUDO_PROJECT_ID]

List Zone Imports

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_import_show:

openstack zone import show
--------------------------

.. code-block:: console

   usage: openstack zone import show [-h] [-f {html,json,shell,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--noindent] [--prefix PREFIX]
                                     [--all-projects] [--edit-managed]
                                     [--sudo-project-id SUDO_PROJECT_ID]
                                     zone_import_id

Show a Zone Import

**Positional arguments:**

``zone_import_id``
  Zone Import ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_list:

openstack zone list
-------------------

.. code-block:: console

   usage: openstack zone list [-h] [-f {csv,html,json,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--noindent]
                              [--quote {all,minimal,none,nonnumeric}]
                              [--name NAME] [--email EMAIL] [--type TYPE]
                              [--ttl TTL] [--description DESCRIPTION]
                              [--status STATUS] [--all-projects] [--edit-managed]
                              [--sudo-project-id SUDO_PROJECT_ID]

List zones

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--name NAME``
  Zone Name

``--email EMAIL``
  Zone Email

``--type TYPE``
  Zone Type

``--ttl TTL``
  Time To Live (Seconds)

``--description DESCRIPTION``
  Description

``--status STATUS``
  Zone Status

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_set:

openstack zone set
------------------

.. code-block:: console

   usage: openstack zone set [-h] [-f {html,json,shell,table,value,yaml}]
                             [-c COLUMN] [--max-width <integer>] [--noindent]
                             [--prefix PREFIX] [--email EMAIL] [--ttl TTL]
                             [--description DESCRIPTION | --no-description]
                             [--masters MASTERS [MASTERS ...]] [--all-projects]
                             [--edit-managed] [--sudo-project-id SUDO_PROJECT_ID]
                             id

Set zone properties

**Positional arguments:**

``id``
  Zone ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--email EMAIL``
  Zone Email

``--ttl TTL``
  Time To Live (Seconds)

``--description DESCRIPTION``
  Description

``--no-description``

``--masters MASTERS [MASTERS ...]``
  Zone Masters

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_show:

openstack zone show
-------------------

.. code-block:: console

   usage: openstack zone show [-h] [-f {html,json,shell,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--noindent]
                              [--prefix PREFIX] [--all-projects] [--edit-managed]
                              [--sudo-project-id SUDO_PROJECT_ID]
                              id

Show zone details

**Positional arguments:**

``id``
  Zone ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_transfer_accept_list:

openstack zone transfer accept list
-----------------------------------

.. code-block:: console

   usage: openstack zone transfer accept list [-h]
                                              [-f {csv,html,json,table,value,yaml}]
                                              [-c COLUMN] [--max-width <integer>]
                                              [--noindent]
                                              [--quote {all,minimal,none,nonnumeric}]
                                              [--all-projects] [--edit-managed]
                                              [--sudo-project-id SUDO_PROJECT_ID]

List Zone Transfer Accepts

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_transfer_accept_request:

openstack zone transfer accept request
--------------------------------------

.. code-block:: console

   usage: openstack zone transfer accept request [-h]
                                                 [-f {html,json,shell,table,value,yaml}]
                                                 [-c COLUMN]
                                                 [--max-width <integer>]
                                                 [--noindent] [--prefix PREFIX]
                                                 --transfer-id TRANSFER_ID --key
                                                 KEY [--all-projects]
                                                 [--edit-managed]
                                                 [--sudo-project-id SUDO_PROJECT_ID]

Accept a Zone Transfer Request

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--transfer-id TRANSFER_ID``
  Transfer ID

``--key KEY``
  Transfer Key

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_transfer_accept_show:

openstack zone transfer accept show
-----------------------------------

.. code-block:: console

   usage: openstack zone transfer accept show [-h]
                                              [-f {html,json,shell,table,value,yaml}]
                                              [-c COLUMN] [--max-width <integer>]
                                              [--noindent] [--prefix PREFIX]
                                              [--all-projects] [--edit-managed]
                                              [--sudo-project-id SUDO_PROJECT_ID]
                                              id

Show Zone Transfer Accept

**Positional arguments:**

``id``
  Zone Tranfer Accept ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_transfer_request_create:

openstack zone transfer request create
--------------------------------------

.. code-block:: console

   usage: openstack zone transfer request create [-h]
                                                 [-f {html,json,shell,table,value,yaml}]
                                                 [-c COLUMN]
                                                 [--max-width <integer>]
                                                 [--noindent] [--prefix PREFIX]
                                                 [--target-project-id TARGET_PROJECT_ID]
                                                 [--description DESCRIPTION]
                                                 [--all-projects]
                                                 [--edit-managed]
                                                 [--sudo-project-id SUDO_PROJECT_ID]
                                                 zone_id

Create new zone transfer request

**Positional arguments:**

``zone_id``
  Zone ID to transfer.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--target-project-id TARGET_PROJECT_ID``
  Target Project ID to transfer to.

``--description DESCRIPTION``
  Description

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_transfer_request_delete:

openstack zone transfer request delete
--------------------------------------

.. code-block:: console

   usage: openstack zone transfer request delete [-h] [--all-projects]
                                                 [--edit-managed]
                                                 [--sudo-project-id SUDO_PROJECT_ID]
                                                 id

Delete a Zone Transfer Request

**Positional arguments:**

``id``
  Zone Transfer Request ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_transfer_request_list:

openstack zone transfer request list
------------------------------------

.. code-block:: console

   usage: openstack zone transfer request list [-h]
                                               [-f {csv,html,json,table,value,yaml}]
                                               [-c COLUMN]
                                               [--max-width <integer>]
                                               [--noindent]
                                               [--quote {all,minimal,none,nonnumeric}]
                                               [--all-projects] [--edit-managed]
                                               [--sudo-project-id SUDO_PROJECT_ID]

List Zone Transfer Requests

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_transfer_request_set:

openstack zone transfer request set
-----------------------------------

.. code-block:: console

   usage: openstack zone transfer request set [-h]
                                              [-f {html,json,shell,table,value,yaml}]
                                              [-c COLUMN] [--max-width <integer>]
                                              [--noindent] [--prefix PREFIX]
                                              [--description DESCRIPTION | --no-description]
                                              [--all-projects] [--edit-managed]
                                              [--sudo-project-id SUDO_PROJECT_ID]
                                              id

Set a Zone Transfer Request

**Positional arguments:**

``id``
  Zone Transfer Request ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--description DESCRIPTION``
  Description

``--no-description``

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None

.. _openstack_zone_transfer_request_show:

openstack zone transfer request show
------------------------------------

.. code-block:: console

   usage: openstack zone transfer request show [-h]
                                               [-f {html,json,shell,table,value,yaml}]
                                               [-c COLUMN]
                                               [--max-width <integer>]
                                               [--noindent] [--prefix PREFIX]
                                               [--all-projects] [--edit-managed]
                                               [--sudo-project-id SUDO_PROJECT_ID]
                                               id

Show Zone Transfer Request Details

**Positional arguments:**

``id``
  Zone Tranfer Request ID

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--all-projects``
  Show results from all projects. Default: False

``--edit-managed``
  Edit resources marked as managed. Default: False

``--sudo-project-id SUDO_PROJECT_ID``
  Project ID to impersonate for this command. Default:
  None
