.. ##  WARNING  #####################################
.. This file is tool-generated. Do not edit manually.
.. Because of a tool bug, temporary edited manually.
.. ##################################################

==================================================
Object Storage service (swift) command-line client
==================================================

The swift client is the command-line interface (CLI) for
the Object Storage service API and its extensions.

This chapter documents :command:`swift` version ``3.2.0``.

For help on a specific :command:`swift` command, enter:

.. code-block:: console

   $ swift COMMAND --help

.. _swift_command_usage:

swift usage
~~~~~~~~~~~

.. code-block:: console

   Usage: swift [--version] [--help] [--os-help] [--snet] [--verbose]
                [--debug] [--info] [--quiet] [--auth <auth_url>]
                [--auth-version <auth_version> |
                    --os-identity-api-version <auth_version> ]
                [--user <username>]
                [--key <api_key>] [--retries <num_retries>]
                [--os-username <auth-user-name>] [--os-password <auth-password>]
                [--os-user-id <auth-user-id>]
                [--os-user-domain-id <auth-user-domain-id>]
                [--os-user-domain-name <auth-user-domain-name>]
                [--os-tenant-id <auth-tenant-id>]
                [--os-tenant-name <auth-tenant-name>]
                [--os-project-id <auth-project-id>]
                [--os-project-name <auth-project-name>]
                [--os-project-domain-id <auth-project-domain-id>]
                [--os-project-domain-name <auth-project-domain-name>]
                [--os-auth-url <auth-url>] [--os-auth-token <auth-token>]
                [--os-storage-url <storage-url>] [--os-region-name <region-name>]
                [--os-service-type <service-type>]
                [--os-endpoint-type <endpoint-type>]
                [--os-cacert <ca-certificate>] [--insecure]
                [--os-cert <client-certificate-file>]
                [--os-key <client-certificate-key-file>]
                [--no-ssl-compression]
                <subcommand> [--help] [<subcommand options>]

**Subcommands:**

``delete``
  Delete a container or objects within a container.

``download``
  Download objects from containers.

``list``
  Lists the containers for the account or the objects
  for a container.

``post``
  Updates meta information for the account, container,
  or object; creates containers if not present.

``copy``
  Copies object, optionally adds meta

``stat``
  Displays information for the account, container,
  or object.

``upload``
  Uploads files or directories to the given container.

``capabilities``
  List cluster capabilities.

``tempurl``
  Create a temporary URL.

``auth``
  Display auth related environment variables.

.. _swift_examples:

swift examples
~~~~~~~~~~~~~~

.. code-block:: console

   swift download --help

   swift -A https://auth.api.rackspacecloud.com/v1.0 -U user -K api_key stat -v

   swift --os-auth-url https://api.example.com/v2.0 \
         --os-tenant-name tenant --os-username user --os-password password list

   swift --os-auth-url https://api.example.com/v3 --auth-version 3 \
         --os-project-name project1 --os-project-domain-name domain1 \
         --os-username user --os-user-domain-name domain1 \
         --os-password password list

   swift --os-auth-url https://api.example.com/v3 --auth-version 3 \
         --os-project-id 0123456789abcdef0123456789abcdef \
         --os-user-id abcdef0123456789abcdef0123456789 \
         --os-password password list

   swift --os-auth-token 6ee5eb33efad4e45ab46806eac010566 \
         --os-storage-url https://10.1.5.2:8080/v1/AUTH_ced809b6a4baea7aeab61a \
         list

   swift list --lh

.. _swift_command_options:

swift optional arguments
~~~~~~~~~~~~~~~~~~~~~~~~

``--version``
  show program's version number and exit

``-h, --help``
  show this help message and exit

``--os-help``
  Show OpenStack authentication options.

``-s, --snet``
  Use SERVICENET internal network.

``-v, --verbose``
  Print more info.

``--debug``
  Show the curl commands and results of all http queries
  regardless of result status.

``--info``
  Show the curl commands and results of all http queries
  which return an error.

``-q, --quiet``
  Suppress status output.

``-A AUTH, --auth=AUTH``
  URL for obtaining an auth token.

``-V AUTH_VERSION, --auth-version=AUTH_VERSION, --os-identity-api-version=AUTH_VERSION``
  Specify a version for authentication. Defaults to
  ``env[ST_AUTH_VERSION]``, ``env[OS_AUTH_VERSION]``,
  ``env[OS_IDENTITY_API_VERSION]`` or 1.0.

``-U USER, --user=USER``
  User name for obtaining an auth token.

``-K KEY, --key=KEY``
  Key for obtaining an auth token.

``-R RETRIES, --retries=RETRIES``
  The number of times to retry a failed connection.

``--insecure``
  Allow swiftclient to access servers without having to
  verify the SSL certificate. Defaults to
  ``env[SWIFTCLIENT_INSECURE]`` (set to 'true' to enable).

``--no-ssl-compression``
  This option is deprecated and not used anymore. SSL
  compression should be disabled by default by the
  system SSL library.

.. _swift_auth:

swift auth
----------

.. code-block:: console

   Usage: swift auth

Display auth related authentication variables in shell friendly format.

Commands to run to export storage url and auth token into
``OS_STORAGE_URL`` and ``OS_AUTH_TOKEN``:

.. code-block:: console

   $ swift auth

Commands to append to a runcom file (e.g. ~/.bashrc, /etc/profile) for
automatic authentication:

.. code-block:: console

   $ swift auth -v -U test:tester -K testing -A http://localhost:8080/auth/v1.0

.. _swift_capabilities:

swift capabilities
------------------

.. code-block:: console

   Usage: swift capabilities

Retrieve capability of the proxy.

**Optional positional arguments:**

``<proxy_url>``
  Proxy URL of the cluster to retrieve capabilities.

``--json``
  Print the cluster capabilities in JSON format.

.. _swift_delete:

swift delete
------------

.. code-block:: console

   Usage: swift delete

Delete a container or objects within a container.

**Positional arguments:**

``[<container>]``
  Name of container to delete from.

``[<object>]``
  Name of object to delete. Specify multiple times
  for multiple objects.

**Optional arguments:**

``-a, --all``
  Delete all containers and objects.

``--leave-segments``
  Do not delete segments of manifest objects.

``--object-threads <threads>``
  Number of threads to use for deleting objects.
  Default is 10.

``--container-threads <threads>``
  Number of threads to use for deleting containers.
  Default is 10.

.. _swift_download:

swift download
--------------

.. code-block:: console

   Usage: swift download

Download objects from containers.

**Positional arguments:**

``<container>``
  Name of container to download from. To download a
  whole account, omit this and specify --all.

``<object>``
  Name of object to download. Specify multiple times
  for multiple objects. Omit this to download all
  objects from the container.

**Optional arguments:**

``-a, --all``
  Indicates that you really want to download
  everything in the account.

``-m, --marker <marker>``
  Marker to use when starting a container or account
  download.

``-p, --prefix <prefix>``
  Only download items beginning with <prefix>

``-r, --remove-prefix``
  An optional flag for --prefix <prefix>, use this
  option to download items without <prefix>

``-o, --output <out_file>``
  For a single file download, stream the output to
  <out_file>. Specifying "-" as <out_file> will
  redirect to stdout.

``-D, --output-dir <out_directory>``
  An optional directory to which to store objects.
  By default, all objects are recreated in the current
  directory.

``--object-threads <threads>``
  Number of threads to use for downloading objects.
  Default is 10.

``--container-threads <threads>``
  Number of threads to use for downloading containers.
  Default is 10.

``--no-download``
  Perform download(s), but don't actually write anything
  to disk.

``-H, --header <header:value>``
  Adds a customized request header to the query, like
  "Range" or "If-Match". This option may be repeated.
  Example: --header "content-type:text/plain"

``--skip-identical``
  Skip downloading files that are identical on both
  sides.

``--ignore-checksum``
  Turn off checksum validation for downloads.

``--no-shuffle``
  By default, when downloading a complete account or
  container, download order is randomised in order to
  reduce the load on individual drives when multiple
  clients are executed simultaneously to download the
  same set of objects (e.g. a nightly automated download
  script to multiple servers). Enable this option to
  submit download jobs to the thread pool in the order
  they are listed in the object store.

.. _swift_list:

swift list
----------

.. code-block:: console

   Usage: swift list

Lists the containers for the account or the objects for a container.

**Positional arguments:**

``[container]``
  Name of container to list object in.

**Optional arguments:**

``-l, --long``
  Long listing format, similar to ls -l.

``--lh``
  Report sizes in human readable format similar to
  ls -lh.

``-t, --totals``
  Used with -l or --lh, only report totals.

``-p <prefix>, --prefix <prefix>``
  Only list items beginning with the prefix.

``-d <delim>, --delimiter <delim>``
  Roll up items with the given delimiter. For containers
  only. See OpenStack Swift API documentation for what
  this means.

.. _swift_post:

swift post
----------

.. code-block:: console

   Usage: swift post

Updates meta information for the account, container, or object.
If the container is not found, it will be created automatically.

**Positional arguments:**

``[container]``
  Name of container to post to.

``[object]``
  Name of object to post.

**Optional arguments:**

``-r, --read-acl <acl>``
  Read ACL for containers. Quick summary of ACL syntax:
  ``.r:*``, ``.r:-.example.com``, ``.r:www.example.com``, ``account1``,
  ``account2:user2``

``-w, --write-acl <acl>``
  Write ACL for containers. Quick summary of ACL syntax:
  account1 account2:user2

``-t, --sync-to <sync-to>``
  Sync To for containers, for multi-cluster replication.

``-k, --sync-key <sync-key>``
  Sync Key for containers, for multi-cluster replication.

``-m, --meta <name:value>``
  Sets a meta data item. This option may be repeated.
  Example: -m Color:Blue -m Size:Large

``-H, --header <header:value>``
  Adds a customized request header.
  This option may be repeated. Example
  -H "content-type:text/plain" -H "Content-Length: 4000"

.. _swift_stat:

swift stat
----------

.. code-block:: console

   Usage: swift stat

Displays information for the account, container, or object.

**Positional arguments:**

``[container]``
  Name of container to stat from.

``[object]``
  Name of object to stat.

**Optional arguments:**

``--lh``
  Report sizes in human readable format similar to
  ls -lh.

.. _swift_tempurl:

swift tempurl
-------------

.. code-block:: console

   Usage: swift tempurl

Generates a temporary URL for a Swift object.

**Positional arguments:**

``<method>``
  An HTTP method to allow for this temporary URL.
  Usually 'GET' or 'PUT'.

``<seconds>``
  The amount of time in seconds the temporary URL will be
  valid for; or, if --absolute is passed, the Unix
  timestamp when the temporary URL will expire.

``<path>``
  The full path to the Swift object. Example:
  /v1/AUTH_account/c/o.

``<key>``
  The secret temporary URL key set on the Swift cluster.
  To set a key, run 'swift post -m
  "Temp-URL-Key:b3968d0207b54ece87cccc06515a89d4"'

**Optional arguments:**

``--absolute``
  Interpret the <seconds> positional argument as a Unix
  timestamp rather than a number of seconds in the
  future.

.. _swift_upload:

swift upload
------------

.. code-block:: console

   Usage: swift upload

Uploads specified files and directories to the given container.

**Positional arguments:**

``<container>``
  Name of container to upload to.

``<file_or_directory>``
  Name of file or directory to upload. Specify multiple
  times for multiple uploads.

**Optional arguments:**

``-c, --changed``
  Only upload files that have changed since the last
  upload.

``--skip-identical``
  Skip uploading files that are identical on both sides.

``-S, --segment-size <size>``
  Upload files in segments no larger than <size> (in
  Bytes) and then create a "manifest" file that will
  download all the segments as if it were the original
  file.

``--segment-container <container>``
  Upload the segments into the specified container. If
  not specified, the segments will be uploaded to a
  <container>_segments container to not pollute the
  main <container> listings.

``--leave-segments``
  Indicates that you want the older segments of manifest
  objects left alone (in the case of overwrites).

``--object-threads <threads>``
  Number of threads to use for uploading full objects.
  Default is 10.

``--segment-threads <threads>``
  Number of threads to use for uploading object segments.
  Default is 10.

``-H, --header <header:value>``
  Adds a customized request header. This option may be
  repeated. Example: -H "content-type:text/plain"
  -H "Content-Length: 4000".

``--use-slo``
  When used in conjunction with --segment-size it will
  create a Static Large Object instead of the default
  Dynamic Large Object.

``--object-name <object-name>``
  Upload file and name object to <object-name> or upload
  dir and use <object-name> as object prefix instead of
  folder name.

``--ignore-checksum``
  Turn off checksum validation for uploads.
