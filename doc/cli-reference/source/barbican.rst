.. ###################################################
.. ##  WARNING  ######################################
.. ##############  WARNING  ##########################
.. ##########################  WARNING  ##############
.. ######################################  WARNING  ##
.. ###################################################
.. ###################################################
.. ##
.. This file is tool-generated. Do not edit manually.
.. http://docs.openstack.org/contributor-guide/
.. doc-tools/cli-reference.html
..                                                  ##
.. ##  WARNING  ######################################
.. ##############  WARNING  ##########################
.. ##########################  WARNING  ##############
.. ######################################  WARNING  ##
.. ###################################################

==================================================
Key Manager service (barbican) command-line client
==================================================

The barbican client is the command-line interface (CLI) for
the Key Manager service (barbican) API and its extensions.

This chapter documents :command:`barbican` version ``4.3.0``.

For help on a specific :command:`barbican` command, enter:

.. code-block:: console

   $ barbican help COMMAND

.. _barbican_command_usage:

barbican usage
~~~~~~~~~~~~~~

.. code-block:: console

   usage: barbican [--version] [-v | -q] [--log-file LOG_FILE] [-h] [--debug]
                   [--no-auth] [--os-identity-api-version <identity-api-version>]
                   [--os-auth-url <auth-url>] [--os-username <auth-user-name>]
                   [--os-user-id <auth-user-id>] [--os-password <auth-password>]
                   [--os-user-domain-id <auth-user-domain-id>]
                   [--os-user-domain-name <auth-user-domain-name>]
                   [--os-tenant-name <auth-tenant-name>]
                   [--os-tenant-id <tenant-id>]
                   [--os-project-id <auth-project-id>]
                   [--os-project-name <auth-project-name>]
                   [--os-project-domain-id <auth-project-domain-id>]
                   [--os-project-domain-name <auth-project-domain-name>]
                   [--os-auth-token <auth-token>] [--endpoint <barbican-url>]
                   [--interface <barbican-interface>]
                   [--service-type <barbican-service-type>]
                   [--service-name <barbican-service-name>]
                   [--region-name <barbican-region-name>]
                   [--barbican-api-version <barbican-api-version>] [--insecure]
                   [--os-cacert <ca-certificate>] [--os-cert <certificate>]
                   [--os-key <key>] [--timeout <seconds>]

.. _barbican_command_options:

barbican optional arguments
~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

``--no-auth, -N``
  Do not use authentication.

``--os-identity-api-version <identity-api-version>``
  Specify Identity API version to use. Defaults to
  ``env[OS_IDENTITY_API_VERSION]`` or 3.

``--os-auth-url <auth-url>, -A <auth-url>``
  Defaults to ``env[OS_AUTH_URL]``.

``--os-username <auth-user-name>, -U <auth-user-name>``
  Defaults to ``env[OS_USERNAME]``.

``--os-user-id <auth-user-id>``
  Defaults to ``env[OS_USER_ID]``.

``--os-password <auth-password>, -P <auth-password>``
  Defaults to ``env[OS_PASSWORD]``.

``--os-user-domain-id <auth-user-domain-id>``
  Defaults to ``env[OS_USER_DOMAIN_ID]``.

``--os-user-domain-name <auth-user-domain-name>``
  Defaults to ``env[OS_USER_DOMAIN_NAME]``.

``--os-tenant-name <auth-tenant-name>, -T <auth-tenant-name>``
  Defaults to ``env[OS_TENANT_NAME]``.

``--os-tenant-id <tenant-id>, -I <tenant-id>``
  Defaults to ``env[OS_TENANT_ID]``.

``--os-project-id <auth-project-id>``
  Another way to specify tenant ID. This option is
  mutually exclusive with --os-tenant-id. Defaults to
  ``env[OS_PROJECT_ID]``.

``--os-project-name <auth-project-name>``
  Another way to specify tenant name. This option is
  mutually exclusive with --os-tenant-name. Defaults to
  ``env[OS_PROJECT_NAME]``.

``--os-project-domain-id <auth-project-domain-id>``
  Defaults to ``env[OS_PROJECT_DOMAIN_ID]``.

``--os-project-domain-name <auth-project-domain-name>``
  Defaults to ``env[OS_PROJECT_DOMAIN_NAME]``.

``--os-auth-token <auth-token>``
  Defaults to ``env[OS_AUTH_TOKEN]``.

``--endpoint <barbican-url>, -E <barbican-url>``
  Defaults to ``env[BARBICAN_ENDPOINT]``.

``--interface <barbican-interface>``
  Defaults to ``env[BARBICAN_INTERFACE]``.

``--service-type <barbican-service-type>``
  Defaults to ``env[BARBICAN_SERVICE_TYPE]``.

``--service-name <barbican-service-name>``
  Defaults to ``env[BARBICAN_SERVICE_NAME]``.

``--region-name <barbican-region-name>``
  Defaults to ``env[BARBICAN_REGION_NAME]``.

``--barbican-api-version <barbican-api-version>``
  Defaults to ``env[BARBICAN_API_VERSION]``.

.. _barbican_acl_delete:

barbican acl delete
-------------------

.. code-block:: console

   usage: barbican acl delete [-h] URI

Delete ACLs for a secret or container as identified by its href.

**Positional arguments:**

``URI``
  The URI reference for the secret or container.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _barbican_acl_get:

barbican acl get
----------------

.. code-block:: console

   usage: barbican acl get [-h] [-f {csv,html,json,table,value,yaml}] [-c COLUMN]
                           [--max-width <integer>] [--print-empty] [--noindent]
                           [--quote {all,minimal,none,nonnumeric}]
                           URI

Retrieve ACLs for a secret or container by providing its href.

**Positional arguments:**

``URI``
  The URI reference for the secret or container.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _barbican_acl_submit:

barbican acl submit
-------------------

.. code-block:: console

   usage: barbican acl submit [-h] [-f {csv,html,json,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--print-empty]
                              [--noindent]
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

.. _barbican_acl_user_add:

barbican acl user add
---------------------

.. code-block:: console

   usage: barbican acl user add [-h] [-f {csv,html,json,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>]
                                [--print-empty] [--noindent]
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

.. _barbican_acl_user_remove:

barbican acl user remove
------------------------

.. code-block:: console

   usage: barbican acl user remove [-h] [-f {csv,html,json,table,value,yaml}]
                                   [-c COLUMN] [--max-width <integer>]
                                   [--print-empty] [--noindent]
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

.. _barbican_ca_get:

barbican ca get
---------------

.. code-block:: console

   usage: barbican ca get [-h] [-f {html,json,shell,table,value,yaml}]
                          [-c COLUMN] [--max-width <integer>] [--print-empty]
                          [--noindent] [--prefix PREFIX]
                          URI

Retrieve a CA by providing its URI.

**Positional arguments:**

``URI``
  The URI reference for the CA.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _barbican_ca_list:

barbican ca list
----------------

.. code-block:: console

   usage: barbican ca list [-h] [-f {csv,html,json,table,value,yaml}] [-c COLUMN]
                           [--max-width <integer>] [--print-empty] [--noindent]
                           [--quote {all,minimal,none,nonnumeric}]
                           [--limit LIMIT] [--offset OFFSET] [--name NAME]

List CAs.

**Optional arguments:**

``-h, --help``
  show this help message and exit

``--limit LIMIT, -l LIMIT``
  specify the limit to the number of items to list per
  page (default: 10; maximum: 100)

``--offset OFFSET, -o OFFSET``
  specify the page offset (default: 0)

``--name NAME, -n NAME``
  specify the ca name (default: None)

.. _barbican_secret_container_create:

barbican secret container create
--------------------------------

.. code-block:: console

   usage: barbican secret container create [-h]
                                           [-f {html,json,shell,table,value,yaml}]
                                           [-c COLUMN] [--max-width <integer>]
                                           [--print-empty] [--noindent]
                                           [--prefix PREFIX] [--name NAME]
                                           [--type TYPE] [--secret SECRET]

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
  multiple times). Example: --secret
  "private_key=https://url.test/v1/secrets/1-2-3-4"

.. _barbican_secret_container_delete:

barbican secret container delete
--------------------------------

.. code-block:: console

   usage: barbican secret container delete [-h] URI

Delete a container by providing its href.

**Positional arguments:**

``URI``
  The URI reference for the container

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _barbican_secret_container_get:

barbican secret container get
-----------------------------

.. code-block:: console

   usage: barbican secret container get [-h]
                                        [-f {html,json,shell,table,value,yaml}]
                                        [-c COLUMN] [--max-width <integer>]
                                        [--print-empty] [--noindent]
                                        [--prefix PREFIX]
                                        URI

Retrieve a container by providing its URI.

**Positional arguments:**

``URI``
  The URI reference for the container.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _barbican_secret_container_list:

barbican secret container list
------------------------------

.. code-block:: console

   usage: barbican secret container list [-h]
                                         [-f {csv,html,json,table,value,yaml}]
                                         [-c COLUMN] [--max-width <integer>]
                                         [--print-empty] [--noindent]
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

.. _barbican_secret_delete:

barbican secret delete
----------------------

.. code-block:: console

   usage: barbican secret delete [-h] URI

Delete a secret by providing its URI.

**Positional arguments:**

``URI``
  The URI reference for the secret

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _barbican_secret_get:

barbican secret get
-------------------

.. code-block:: console

   usage: barbican secret get [-h] [-f {html,json,shell,table,value,yaml}]
                              [-c COLUMN] [--max-width <integer>] [--print-empty]
                              [--noindent] [--prefix PREFIX] [--decrypt]
                              [--payload]
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
  the data type can be specified with
  --payload_content_type.

``--payload, -p``
  if specified, retrieve the unencrypted secret data;
  the data type can be specified with
  --payload_content_type. If the user wishes to only
  retrieve the value of the payload they must add "-f
  value" to format returning only the value of the
  payload

``--payload_content_type PAYLOAD_CONTENT_TYPE, -t PAYLOAD_CONTENT_TYPE``
  the content type of the decrypted secret (default:
  text/plain).

.. _barbican_secret_list:

barbican secret list
--------------------

.. code-block:: console

   usage: barbican secret list [-h] [-f {csv,html,json,table,value,yaml}]
                               [-c COLUMN] [--max-width <integer>]
                               [--print-empty] [--noindent]
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

.. _barbican_secret_order_create:

barbican secret order create
----------------------------

.. code-block:: console

   usage: barbican secret order create [-h]
                                       [-f {html,json,shell,table,value,yaml}]
                                       [-c COLUMN] [--max-width <integer>]
                                       [--print-empty] [--noindent]
                                       [--prefix PREFIX] [--name NAME]
                                       [--algorithm ALGORITHM]
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
  the type of the order (key, asymmetric, certificate)
  to create.

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

.. _barbican_secret_order_delete:

barbican secret order delete
----------------------------

.. code-block:: console

   usage: barbican secret order delete [-h] URI

Delete an order by providing its href.

**Positional arguments:**

``URI``
  The URI reference for the order

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _barbican_secret_order_get:

barbican secret order get
-------------------------

.. code-block:: console

   usage: barbican secret order get [-h] [-f {html,json,shell,table,value,yaml}]
                                    [-c COLUMN] [--max-width <integer>]
                                    [--print-empty] [--noindent]
                                    [--prefix PREFIX]
                                    URI

Retrieve an order by providing its URI.

**Positional arguments:**

``URI``
  The URI reference order.

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _barbican_secret_order_list:

barbican secret order list
--------------------------

.. code-block:: console

   usage: barbican secret order list [-h] [-f {csv,html,json,table,value,yaml}]
                                     [-c COLUMN] [--max-width <integer>]
                                     [--print-empty] [--noindent]
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

.. _barbican_secret_store:

barbican secret store
---------------------

.. code-block:: console

   usage: barbican secret store [-h] [-f {html,json,shell,table,value,yaml}]
                                [-c COLUMN] [--max-width <integer>]
                                [--print-empty] [--noindent] [--prefix PREFIX]
                                [--name NAME] [--payload PAYLOAD]
                                [--secret-type SECRET_TYPE]
                                [--payload-content-type PAYLOAD_CONTENT_TYPE]
                                [--payload-content-encoding PAYLOAD_CONTENT_ENCODING]
                                [--algorithm ALGORITHM] [--bit-length BIT_LENGTH]
                                [--mode MODE] [--expiration EXPIRATION]

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
  --payload is supplied.

``--payload-content-encoding PAYLOAD_CONTENT_ENCODING, -e PAYLOAD_CONTENT_ENCODING``
  required if --payload-content-type is "application
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

.. _barbican_secret_update:

barbican secret update
----------------------

.. code-block:: console

   usage: barbican secret update [-h] URI payload

Update a secret with no payload in Barbican.

**Positional arguments:**

``URI``
  The URI reference for the secret.

``payload``
  the unencrypted secret

**Optional arguments:**

``-h, --help``
  show this help message and exit

