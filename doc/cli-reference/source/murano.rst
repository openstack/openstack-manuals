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

========================================================
Application Catalog service (murano) command-line client
========================================================

The murano client is the command-line interface (CLI) for
the Application Catalog service (murano) API and its extensions.

This chapter documents :command:`murano` version ``0.13.0``.

For help on a specific :command:`murano` command, enter:

.. code-block:: console

   $ murano help COMMAND

.. _murano_command_usage:

murano usage
~~~~~~~~~~~~

.. code-block:: console

   usage: murano [--version] [-d] [-v] [--cert-file OS_CERT] [--key-file OS_KEY]
                 [--ca-file OS_CACERT] [--api-timeout API_TIMEOUT]
                 [--os-tenant-id OS_TENANT_ID] [--os-tenant-name OS_TENANT_NAME]
                 [--os-region-name OS_REGION_NAME]
                 [--os-auth-token OS_AUTH_TOKEN] [--os-no-client-auth]
                 [--murano-url MURANO_URL] [--glance-url GLANCE_URL]
                 [--glare-url GLARE_URL]
                 [--murano-api-version MURANO_API_VERSION]
                 [--os-service-type OS_SERVICE_TYPE]
                 [--os-endpoint-type OS_ENDPOINT_TYPE] [--include-password]
                 [--murano-repo-url MURANO_REPO_URL]
                 [--murano-packages-service {murano,glance,glare}] [--insecure]
                 [--os-cacert <ca-certificate>] [--os-cert <certificate>]
                 [--os-key <key>] [--timeout <seconds>]
                 [--os-auth-url OS_AUTH_URL] [--os-domain-id OS_DOMAIN_ID]
                 [--os-domain-name OS_DOMAIN_NAME]
                 [--os-project-id OS_PROJECT_ID]
                 [--os-project-name OS_PROJECT_NAME]
                 [--os-project-domain-id OS_PROJECT_DOMAIN_ID]
                 [--os-project-domain-name OS_PROJECT_DOMAIN_NAME]
                 [--os-trust-id OS_TRUST_ID] [--os-user-id OS_USER_ID]
                 [--os-username OS_USERNAME]
                 [--os-user-domain-id OS_USER_DOMAIN_ID]
                 [--os-user-domain-name OS_USER_DOMAIN_NAME]
                 [--os-password OS_PASSWORD]
                 <subcommand> ...

**Subcommands:**

``app-show``
  List applications, added to specified environment.

``bundle-import``
  Import a bundle.

``bundle-save``
  Save a bundle.

``category-create``
  Create a category.

``category-delete``
  Delete a category.

``category-list``
  List all available categories.

``category-show``
  Display category details.

``class-schema``
  Display class schema

``deployment-list``
  List deployments for an environment or multiple
  environments.

``env-template-add-app``
  Add application to the environment template.

``env-template-clone``
  Create a new template, cloned from template.

``env-template-create``
  Create an environment template.

``env-template-create-env``
  Create a new environment from template.

``env-template-del-app``
  Delete application from the environment template.

``env-template-delete``
  Delete an environment template.

``env-template-list``
  List the environments templates.

``env-template-show``
  Display environment template details.

``env-template-update``
  Update an environment template.

``environment-action-call``
  Call action \`ACTION\` in environment \`ID\`.

``environment-action-get-result``
  Get result of \`TASK\` in environment \`ID\`.

``environment-apps-edit``
  Edit environment's object model.

``environment-create``
  Create an environment.

``environment-delete``
  Delete an environment.

``environment-deploy``
  Start deployment of a murano environment session.

``environment-list``
  List the environments.

``environment-model-edit``
  Edit an environment's object model.

``environment-model-show``
  Display an environment's object model.

``environment-rename``
  Rename an environment.

``environment-session-create``
  Creates a new configuration session for environment
  ID.

``environment-show``
  Display environment details.

``package-create``
  Create an application package.

``package-delete``
  Delete a package.

``package-download``
  Download a package to a filename or stdout.

``package-import``
  Import a package.

``package-list``
  List available packages.

``package-save``
  Save a package.

``package-show``
  Display details for a package.

``package-update``
  Update an existing package.

``static-action-call``
  Call static method \`METHOD\` of the class \`CLASS\` with
  \`ARGUMENTS\`.

``bash-completion``
  Prints all of the commands and options to stdout.

``help``
  Display help about this program or one of its
  subcommands.

.. _murano_command_options:

murano optional arguments
~~~~~~~~~~~~~~~~~~~~~~~~~

``--version``
  Show program's version number and exit.

``-d, --debug``
  Defaults to ``env[MURANOCLIENT_DEBUG]``.

``-v, --verbose``
  Print more verbose output.

``--cert-file OS_CERT``
  **DEPRECATED!** Use --os-cert.

``--key-file OS_KEY``
  **DEPRECATED!** Use --os-key.

``--ca-file OS_CACERT``
  **DEPRECATED!** Use --os-cacert.

``--api-timeout API_TIMEOUT``
  Number of seconds to wait for an API response,
  defaults to system socket timeout.

``--os-tenant-id OS_TENANT_ID``
  Defaults to ``env[OS_TENANT_ID]``.

``--os-tenant-name OS_TENANT_NAME``
  Defaults to ``env[OS_TENANT_NAME]``.

``--os-region-name OS_REGION_NAME``
  Defaults to ``env[OS_REGION_NAME]``.

``--os-auth-token OS_AUTH_TOKEN``
  Defaults to ``env[OS_AUTH_TOKEN]``.

``--os-no-client-auth``
  Do not contact keystone for a token. Defaults to
  ``env[OS_NO_CLIENT_AUTH]``.

``--murano-url MURANO_URL``
  Defaults to ``env[MURANO_URL]``.

``--glance-url GLANCE_URL``
  Defaults to ``env[GLANCE_URL]``.

``--glare-url GLARE_URL``
  Defaults to ``env[GLARE_URL]``.

``--murano-api-version MURANO_API_VERSION``
  Defaults to ``env[MURANO_API_VERSION]`` or 1.

``--os-service-type OS_SERVICE_TYPE``
  Defaults to ``env[OS_SERVICE_TYPE]``.

``--os-endpoint-type OS_ENDPOINT_TYPE``
  Defaults to ``env[OS_ENDPOINT_TYPE]``.

``--include-password``
  Send os-username and os-password to murano.

``--murano-repo-url MURANO_REPO_URL``
  Defaults to ``env[MURANO_REPO_URL]`` or
  http://apps.openstack.org/api/v1/murano_repo/liberty/

``--murano-packages-service {murano,glance,glare}``
  Specifies if murano-api ("murano") or Glance Artifact
  Repository ("glare") should be used to store murano
  packages. Defaults to ``env[MURANO_PACKAGES_SERVICE]`` or
  to "murano"

``--insecure``
  Explicitly allow client to perform "insecure" TLS
  (https) requests. The server's certificate will not be
  verified against any certificate authorities. This
  option should be used with caution.

``--os-cacert <ca-certificate>``
  Specify a CA bundle file to use in verifying a TLS
  (https) server certificate. Defaults to
  ``env[OS_CACERT]``.

``--os-cert <certificate>``
  Defaults to ``env[OS_CERT]``.

``--os-key <key>``
  Defaults to ``env[OS_KEY]``.

``--timeout <seconds>``
  Set request timeout (in seconds).

``--os-auth-url OS_AUTH_URL``
  Authentication URL

``--os-domain-id OS_DOMAIN_ID``
  Domain ID to scope to

``--os-domain-name OS_DOMAIN_NAME``
  Domain name to scope to

``--os-project-id OS_PROJECT_ID``
  Project ID to scope to

``--os-project-name OS_PROJECT_NAME``
  Project name to scope to

``--os-project-domain-id OS_PROJECT_DOMAIN_ID``
  Domain ID containing project

``--os-project-domain-name OS_PROJECT_DOMAIN_NAME``
  Domain name containing project

``--os-trust-id OS_TRUST_ID``
  Trust ID

``--os-user-id OS_USER_ID``
  User ID

``--os-username OS_USERNAME, --os-user-name OS_USERNAME, --os-user_name OS_USERNAME``
  Username

``--os-user-domain-id OS_USER_DOMAIN_ID``
  User's domain id

``--os-user-domain-name OS_USER_DOMAIN_NAME``
  User's domain name

``--os-password OS_PASSWORD``
  User's password

.. _murano_app-show:

murano app-show
---------------

.. code-block:: console

   usage: murano app-show [-p <PATH>] <ID>

List applications, added to specified environment.

**Positional arguments:**

``<ID>``
  Environment ID to show applications from.

**Optional arguments:**

``-p <PATH>, --path <PATH>``
  Level of detalization to show. Leave empty to browse
  all applications in the environment.

.. _murano_bundle-import:

murano bundle-import
--------------------

.. code-block:: console

   usage: murano bundle-import [--is-public] [--exists-action {a,s,u}]
                               <FILE> [<FILE> ...]

Import
a
bundle.
\`FILE\`
can
be
either
a
path
to
a
zip
file,
URL,
or
name
from
repo. If \`FILE\` is a local file, treat names of packages in a bundle as file
names, relative to location of the bundle file. Requirements are first
searched in the same directory.

**Positional arguments:**

``<FILE>``
  Bundle URL, bundle name, or path to the bundle file.

**Optional arguments:**

``--is-public``
  Make packages available to users from other tenants.

``--exists-action {a,s,u}``
  Default action when a package already exists.

.. _murano_bundle-save:

murano bundle-save
------------------

.. code-block:: console

   usage: murano bundle-save [-p <PATH>] [--no-images] <BUNDLE>

Save a bundle. This will download a bundle of packages with all dependencies
to specified path. If path doesn't exist it will be created.

**Positional arguments:**

``<BUNDLE>``
  Bundle URL, bundle name, or path to the bundle file.

**Optional arguments:**

``-p <PATH>, --path <PATH>``
  Path to the directory to store packages. If not set
  will use current directory.

``--no-images``
  If set will skip images downloading.

.. _murano_category-create:

murano category-create
----------------------

.. code-block:: console

   usage: murano category-create <CATEGORY_NAME>

Create a category.

**Positional arguments:**

``<CATEGORY_NAME>``
  Category name.

.. _murano_category-delete:

murano category-delete
----------------------

.. code-block:: console

   usage: murano category-delete <ID> [<ID> ...]

Delete a category.

**Positional arguments:**

``<ID>``
  ID of a category(ies) to delete.

.. _murano_category-list:

murano category-list
--------------------

.. code-block:: console

   usage: murano category-list

List all available categories.

.. _murano_category-show:

murano category-show
--------------------

.. code-block:: console

   usage: murano category-show <ID>

Display category details.

**Positional arguments:**

``<ID>``
  ID of a category(s) to show.

.. _murano_class-schema:

murano class-schema
-------------------

.. code-block:: console

   usage: murano class-schema [--package-name PACKAGE_NAME]
                              [--class-version CLASS_VERSION]
                              <CLASS> [<METHOD> [<METHOD> ...]]

Display class schema

**Positional arguments:**

``<CLASS>``
  Class FQN

``<METHOD>``
  Method name

**Optional arguments:**

``--package-name PACKAGE_NAME``
  FQN of the package where the class is located

``--class-version CLASS_VERSION``
  Class version or version range (version spec)

.. _murano_deployment-list:

murano deployment-list
----------------------

.. code-block:: console

   usage: murano deployment-list [--all-environments] [<ID>]

List deployments for an environment or multiple environments.

**Positional arguments:**

``<ID>``
  Environment ID for which to list deployments.

**Optional arguments:**

``--all-environments``
  Lists all deployments for all environments in user's
  tenant.

.. _murano_env-template-add-app:

murano env-template-add-app
---------------------------

.. code-block:: console

   usage: murano env-template-add-app <ENV_TEMPLATE_ID> <FILE>

Add application to the environment template.

**Positional arguments:**

``<ENV_TEMPLATE_ID>``
  Environment template ID.

``<FILE>``
  Path to the template.

.. _murano_env-template-clone:

murano env-template-clone
-------------------------

.. code-block:: console

   usage: murano env-template-clone <ID> <ENV_TEMPLATE_NAME>

Create a new template, cloned from template.

**Positional arguments:**

``<ID>``
  Environment template ID.

``<ENV_TEMPLATE_NAME>``
  New environment template name.

.. _murano_env-template-create:

murano env-template-create
--------------------------

.. code-block:: console

   usage: murano env-template-create [--is-public] <ENV_TEMPLATE_NAME>

Create an environment template.

**Positional arguments:**

``<ENV_TEMPLATE_NAME>``
  Environment template name.

**Optional arguments:**

``--is-public``
  Make the template available for users from other
  tenants.

.. _murano_env-template-create-env:

murano env-template-create-env
------------------------------

.. code-block:: console

   usage: murano env-template-create-env [--region <REGION_NAME>] <ID> <ENV_NAME>

Create a new environment from template.

**Positional arguments:**

``<ID>``
  Environment template ID.

``<ENV_NAME>``
  New environment name.

**Optional arguments:**

``--region <REGION_NAME>``
  Name of the target OpenStack region.

.. _murano_env-template-del-app:

murano env-template-del-app
---------------------------

.. code-block:: console

   usage: murano env-template-del-app <ENV_TEMPLATE_ID> <ENV_TEMPLATE_APP_ID>

Delete application from the environment template.

**Positional arguments:**

``<ENV_TEMPLATE_ID>``
  Environment template ID.

``<ENV_TEMPLATE_APP_ID>``
  Application ID.

.. _murano_env-template-delete:

murano env-template-delete
--------------------------

.. code-block:: console

   usage: murano env-template-delete <ID> [<ID> ...]

Delete an environment template.

**Positional arguments:**

``<ID>``
  ID of environment(s) template to delete.

.. _murano_env-template-list:

murano env-template-list
------------------------

.. code-block:: console

   usage: murano env-template-list

List the environments templates.

.. _murano_env-template-show:

murano env-template-show
------------------------

.. code-block:: console

   usage: murano env-template-show <ID>

Display environment template details.

**Positional arguments:**

``<ID>``
  Environment template ID.

.. _murano_env-template-update:

murano env-template-update
--------------------------

.. code-block:: console

   usage: murano env-template-update <ID> <ENV_TEMPLATE_NAME>

Update an environment template.

**Positional arguments:**

``<ID>``
  Environment template ID.

``<ENV_TEMPLATE_NAME>``
  Environment template name.

.. _murano_environment-action-call:

murano environment-action-call
------------------------------

.. code-block:: console

   usage: murano environment-action-call --action-id <ACTION>
                                         [--arguments [<KEY=VALUE> [<KEY=VALUE> ...]]]
                                         id

Call
action
\`ACTION\`
in
environment
\`ID\`.
Returns
id
of
an
asynchronous
task,
that executes the action. Actions can only be called on a \`deployed\`
environment. To view actions available in a given environment use
\`environment-show\` command.

**Positional arguments:**

``id``
  ID of Environment to call action against.

**Optional arguments:**

``--action-id <ACTION>``
  ID of action to run.

``--arguments [<KEY=VALUE> [<KEY=VALUE> ...]]``
  Action arguments.

.. _murano_environment-action-get-result:

murano environment-action-get-result
------------------------------------

.. code-block:: console

   usage: murano environment-action-get-result --task-id <TASK> <ID>

Get result of \`TASK\` in environment \`ID\`.

**Positional arguments:**

``<ID>``
  ID of Environment where task is being executed.

**Optional arguments:**

``--task-id <TASK>``
  ID of action to run.

.. _murano_environment-apps-edit:

murano environment-apps-edit
----------------------------

.. code-block:: console

   usage: murano environment-apps-edit --session-id <SESSION_ID> <ID> [FILE]

Edit environment's object model. \`FILE\` is path to a file, that contains
jsonpatch, that describes changes to be made to environment's object-model. [
{ "op": "add", "path": "/-", "value": { ... your-app object model here ... }
}, { "op": "replace", "path": "/0/?/name", "value": "new_name" }, ] NOTE:
Values '===id1===', '===id2===', etc. in the resulting object-model will be
substituted with uuids. For more info on jsonpatch see RFC 6902

**Positional arguments:**

``<ID>``
  ID of Environment to edit.

``FILE``
  File to read jsonpatch from (defaults to stdin).

**Optional arguments:**

``--session-id <SESSION_ID>``
  Id of a config session.

.. _murano_environment-create:

murano environment-create
-------------------------

.. code-block:: console

   usage: murano environment-create [--join-net-id <NET_ID>]
                                    [--join-subnet-id <SUBNET_ID>]
                                    [--region <REGION_NAME>]
                                    <ENVIRONMENT_NAME>

Create an environment.

**Positional arguments:**

``<ENVIRONMENT_NAME>``
  Environment name.

**Optional arguments:**

``--join-net-id <NET_ID>``
  Network id to join.

``--join-subnet-id <SUBNET_ID>``
  Subnetwork id to join.

``--region <REGION_NAME>``
  Name of the target OpenStack region.

.. _murano_environment-delete:

murano environment-delete
-------------------------

.. code-block:: console

   usage: murano environment-delete [--abandon] <NAME or ID> [<NAME or ID> ...]

Delete an environment.

**Positional arguments:**

``<NAME or ID>``
  Id or name of environment(s) to delete.

**Optional arguments:**

``--abandon``
  If set will abandon environment without deleting any of its
  resources.

.. _murano_environment-deploy:

murano environment-deploy
-------------------------

.. code-block:: console

   usage: murano environment-deploy --session-id <SESSION> <ID>

Start deployment of a murano environment session.

**Positional arguments:**

``<ID>``
  ID of Environment to deploy.

**Optional arguments:**

``--session-id <SESSION>``
  ID of configuration session to deploy.

.. _murano_environment-list:

murano environment-list
-----------------------

.. code-block:: console

   usage: murano environment-list [--all-tenants] [--tenant <TENANT_ID>]

List the environments.

**Optional arguments:**

``--all-tenants``
  Allows to list environments from all tenants (admin
  only).

``--tenant <TENANT_ID>``
  Allows to list environments for a given tenant (admin
  only).

.. _murano_environment-model-edit:

murano environment-model-edit
-----------------------------

.. code-block:: console

   usage: murano environment-model-edit --session-id <SESSION_ID> <ID> [<FILE>]

Edit an environment's object model.

**Positional arguments:**

``<ID>``
  ID of Environment to edit.

``<FILE>``
  File to read JSON-patch from (defaults to stdin).

**Optional arguments:**

``--session-id <SESSION_ID>``
  Id of a config session.

.. _murano_environment-model-show:

murano environment-model-show
-----------------------------

.. code-block:: console

   usage: murano environment-model-show [--path <PATH>]
                                        [--session-id <SESSION_ID>]
                                        <ID>

Display an environment's object model.

**Positional arguments:**

``<ID>``
  ID of Environment to show.

**Optional arguments:**

``--path <PATH>``
  Path to Environment model section. Defaults to '/'.

``--session-id <SESSION_ID>``
  Id of a config session.

.. _murano_environment-rename:

murano environment-rename
-------------------------

.. code-block:: console

   usage: murano environment-rename <NAME or ID> <ENVIRONMENT_NAME>

Rename an environment.

**Positional arguments:**

``<NAME or ID>``
  Environment ID or name.

``<ENVIRONMENT_NAME>``
  A name to which the environment will be renamed.

.. _murano_environment-session-create:

murano environment-session-create
---------------------------------

.. code-block:: console

   usage: murano environment-session-create <ID>

Creates a new configuration session for environment ID.

**Positional arguments:**

``<ID>``
  ID of Environment to add session to.

.. _murano_environment-show:

murano environment-show
-----------------------

.. code-block:: console

   usage: murano environment-show [--session-id <SESSION_ID>] [--only-apps]
                                  <NAME or ID>

Display environment details.

**Positional arguments:**

``<NAME or ID>``
  Environment ID or name.

**Optional arguments:**

``--session-id <SESSION_ID>``
  Id of a config session.

``--only-apps``
  Only print apps of the environment (useful for
  automation).

.. _murano_package-create:

murano package-create
---------------------

.. code-block:: console

   usage: murano package-create [-t <HEAT_TEMPLATE>] [-c <CLASSES_DIRECTORY>]
                                [-r <RESOURCES_DIRECTORY>] [-n <DISPLAY_NAME>]
                                [-f <full-name>] [-a <AUTHOR>]
                                [--tags [<TAG1 TAG2> [<TAG1 TAG2> ...]]]
                                [-d <DESCRIPTION>] [-o <PACKAGE_NAME>]
                                [-u <UI_DEFINITION>] [--type TYPE] [-l <LOGO>]

Create an application package.

**Optional arguments:**

``-t <HEAT_TEMPLATE>, --template <HEAT_TEMPLATE>``
  Path to the Heat template to import as an Application
  Definition.

``-c <CLASSES_DIRECTORY>, --classes-dir <CLASSES_DIRECTORY>``
  Path to the directory containing application classes.

``-r <RESOURCES_DIRECTORY>, --resources-dir <RESOURCES_DIRECTORY>``
  Path to the directory containing application
  resources.

``-n <DISPLAY_NAME>, --name <DISPLAY_NAME>``
  Display name of the Application in Catalog.

``-f <full-name>, --full-name <full-name>``
  Fully-qualified name of the Application in Catalog.

``-a <AUTHOR>, --author <AUTHOR>``
  Name of the publisher.

``--tags [<TAG1 TAG2> [<TAG1 TAG2> ...]]``
  A list of keywords connected to the application.

``-d <DESCRIPTION>, --description <DESCRIPTION>``
  Detailed description for the Application in Catalog.

``-o <PACKAGE_NAME>, --output <PACKAGE_NAME>``
  The name of the output file archive to save locally.

``-u <UI_DEFINITION>, --ui <UI_DEFINITION>``
  Dynamic UI form definition.

``--type TYPE``
  Package type. Possible values: Application or Library.

``-l <LOGO>, --logo <LOGO>``
  Path to the package logo.

.. _murano_package-delete:

murano package-delete
---------------------

.. code-block:: console

   usage: murano package-delete <ID> [<ID> ...]

Delete a package.

**Positional arguments:**

``<ID>``
  Package ID to delete.

.. _murano_package-download:

murano package-download
-----------------------

.. code-block:: console

   usage: murano package-download <ID> [file]

Download a package to a filename or stdout.

**Positional arguments:**

``<ID>``
  Package ID to download.

``file``
  Filename to save package to. If it is not specified and there is no
  stdout redirection the package won't be saved.

.. _murano_package-import:

murano package-import
---------------------

.. code-block:: console

   usage: murano package-import [-c [<CATEGORY> [<CATEGORY> ...]]] [--is-public]
                                [--package-version PACKAGE_VERSION]
                                [--exists-action {a,s,u}]
                                [--dep-exists-action {a,s,u}]
                                <FILE> [<FILE> ...]

Import a package. \`FILE\` can be either a path to a zip file, url or a FQPN.
You
can
use
\`--\`
to
separate
\`FILE\`s
from
other
arguments.
Categories
have
to
be separated with a space and have to be already present in murano.

**Positional arguments:**

``<FILE>``
  URL of the murano zip package, FQPN, path to zip
  package or path to directory with package.

**Optional arguments:**

``-c [<CATEGORY> [<CATEGORY> ...]], --categories [<CATEGORY> [<CATEGORY> ...]]``
  Category list to attach.

``--is-public``
  Make the package available for users from other
  tenants.

``--package-version PACKAGE_VERSION``
  Version of the package to use from repository (ignored
  when importing with multiple packages).

``--exists-action {a,s,u}``
  Default action when a package already exists: (s)kip,
  (u)pdate, (a)bort.

``--dep-exists-action {a,s,u}``
  Default action when a dependency package already
  exists: (s)kip, (u)pdate, (a)bort.

.. _murano_package-list:

murano package-list
-------------------

.. code-block:: console

   usage: murano package-list [--limit LIMIT] [--marker MARKER]
                              [--include-disabled] [--owned]
                              [--search <SEARCH_KEYS>] [--name <PACKAGE_NAME>]
                              [--fqn <PACKAGE_FULLY_QUALIFIED_NAME>]
                              [--type <PACKAGE_TYPE>]
                              [--category <PACKAGE_CATEGORY>]
                              [--class_name <PACKAGE_CLASS_NAME>]
                              [--tag <PACKAGE_TAG>]

List available packages.

**Optional arguments:**

``--limit LIMIT``
  Show limited number of packages

``--marker MARKER``
  Show packages starting from package with id excluding
  it

``--include-disabled``

``--owned``

``--search <SEARCH_KEYS>``
  Show packages, that match search keys fuzzily

``--name <PACKAGE_NAME>``
  Show packages, whose name match parameter exactly

``--fqn <PACKAGE_FULLY_QUALIFIED_NAME>``
  Show packages, whose fully qualified name match
  parameter exactly

``--type <PACKAGE_TYPE>``
  Show packages, whose type match parameter exactly

``--category <PACKAGE_CATEGORY>``
  Show packages, whose categories include parameter

``--class_name <PACKAGE_CLASS_NAME>``
  Show packages, whose class name match parameter
  exactly

``--tag <PACKAGE_TAG>``
  Show packages, whose tags include parameter

.. _murano_package-save:

murano package-save
-------------------

.. code-block:: console

   usage: murano package-save [-p <PATH>] [--package-version PACKAGE_VERSION]
                              [--no-images]
                              <PACKAGE> [<PACKAGE> ...]

Save a package. This will download package(s) with all dependencies to
specified path. If path doesn't exist it will be created.

**Positional arguments:**

``<PACKAGE>``
  Package URL or name.

**Optional arguments:**

``-p <PATH>, --path <PATH>``
  Path to the directory to store package. If not set
  will use current directory.

``--package-version PACKAGE_VERSION``
  Version of the package to use from repository (ignored
  when saving with multiple packages).

``--no-images``
  If set will skip images downloading.

.. _murano_package-show:

murano package-show
-------------------

.. code-block:: console

   usage: murano package-show <ID>

Display details for a package.

**Positional arguments:**

``<ID>``
  Package ID to show.

.. _murano_package-update:

murano package-update
---------------------

.. code-block:: console

   usage: murano package-update [--is-public {true|false}]
                                [--enabled {true|false}] [--name NAME]
                                [--description DESCRIPTION]
                                [--tags [<TAG> [<TAG> ...]]]
                                <ID>

Update an existing package.

**Positional arguments:**

``<ID>``
  Package ID to update.

**Optional arguments:**

``--is-public {true|false}``
  Make package available to users from other tenants.

``--enabled {true|false}``
  Make package active and available for deployments.

``--name NAME``
  New name for the package.

``--description DESCRIPTION``
  New package description.

``--tags [<TAG> [<TAG> ...]]``
  A list of keywords connected to the application.

.. _murano_static-action-call:

murano static-action-call
-------------------------

.. code-block:: console

   usage: murano static-action-call [--arguments [<KEY=VALUE> [<KEY=VALUE> ...]]]
                                    [--package-name <PACKAGE>]
                                    [--class-version CLASS_VERSION]
                                    <CLASS> <METHOD>

Call
static
method
\`METHOD\`
of
the
class
\`CLASS\`
with
\`ARGUMENTS\`.
Returns
the
result
of
the
method
execution.
\`PACKAGE\`
and
\`CLASS_VERSION\`
can
be
specified
optionally to find class in a particular package and to look for the specific
version of a class respectively.

**Positional arguments:**

``<CLASS>``
  FQN of the class with static method

``<METHOD>``
  Static method to run

**Optional arguments:**

``--arguments [<KEY=VALUE> [<KEY=VALUE> ...]]``
  Method arguments. No arguments by default

``--package-name <PACKAGE>``
  Optional FQN of the package to look for the class in

``--class-version CLASS_VERSION``
  Optional version of the class, otherwise version =0 is
  used

