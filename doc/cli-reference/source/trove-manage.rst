.. This file is manually generated, unlike many of the other chapters.

================================
trove-manage command-line client
================================

The :command:`trove-manage` client is the command-line interface (CLI)
for the Database Management Utility API and its extensions.

This chapter documents :command:`trove-manage` version ``4.0.0``.

For help on a specific :command:`trove-manage` command, enter:

.. code-block:: console

   $ trove-manage COMMAND --help

.. _trove-manage_command_usage:

trove-manage usage
~~~~~~~~~~~~~~~~~~

.. code-block:: console

   usage: trove-manage [-h] [--config-dir DIR] [--config-file PATH] [--debug]
                       [--log-config-append PATH] [--log-date-format DATE_FORMAT]
                       [--log-dir LOG_DIR] [--log-file PATH]
                       [--log-format FORMAT] [--nodebug] [--nouse-syslog]
                       [--nouse-syslog-rfc-format] [--noverbose]
                       [--syslog-log-facility SYSLOG_LOG_FACILITY] [--use-syslog]
                       [--use-syslog-rfc-format] [--verbose] [--version]
                       {db_sync,db_upgrade,db_downgrade,datastore_update,datastore_version_update,db_recreate,db_load_datastore_config_parameters,datastore_version_flavor_add,datastore_version_flavor_delete}
                       ...

.. _trove-manage_command_options:

trove-manage optional arguments
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``-h, --help``
  show this help message and exit

``--config-dir DIR``
  Path to a config directory to pull ``*.conf`` files from.
  This file set is sorted, so as to provide a predictable parse order
  if individual options are over-ridden. The set is parsed after
  the file(s) specified via previous :option:`--config-file`,
  arguments hence over-ridden options in the directory take precedence.

``--config-file PATH``
  Path to a config file to use. Multiple config files can be specified,
  with values in later files taking precedence.
  The default files used are: ``None``.

``--debug, -d``
  Print debugging output (set logging level to ``DEBUG``
  instead of default ``INFO`` level).

``--log-config-append PATH, --log_config PATH``
  The name of a logging configuration file. This file is
  appended to any existing logging configuration files.
  For details about logging configuration files,
  see the Python logging module documentation.

``--log-date-format DATE_FORMAT``
  Format string for ``%(asctime)s`` in log records. Default: ``None``.

``--log-dir LOG_DIR, --logdir LOG_DIR``
  (Optional) The base directory used for relative ``--log-file`` paths.

``--log-file PATH, --logfile PATH``
  (Optional) Name of log file to output to.
  If no default is set, logging will go to stdout.

``--log-format FORMAT``
  **DEPRECATED**. A logging.Formatter log message format string which
  may use any of the available ``logging.LogRecord`` attributes.
  This option is deprecated. Please use ``logging_context_format_string``
  and ``logging_default_format_string`` instead.

``--nodebug``
  The inverse of :option:`--debug`

``--nouse-syslog``
  The inverse of :option:`--use-syslog`

``--nouse-syslog-rfc-format``
  The inverse of :option:`--use-syslog-rfc-format`

``--noverbose``
  The inverse of :option:`--verbose`

``--syslog-log-facility SYSLOG_LOG_FACILITY``
  Syslog facility to receive log lines.

``--use-syslog``
  Use syslog for logging. Existing syslog format is
  **DEPRECATED** and will be changed later to honor RFC5424.

``--use-syslog-rfc-format``
  (Optional) Enables or disables syslog rfc5424 format for logging.
  If enabled, prefixes the MSG part of the syslog message with
  APP-NAME (RFC5424). The format without the APP-NAME is **deprecated**
  in Kilo, and will be removed in Mitaka, along with this option.

``--verbose, -v``
  If set to false, will disable ``INFO`` logging level,
  making ``WARNING`` the default.

``--version``
  show program's version number and exit

trove-manage datastore_update
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

   usage: trove-manage datastore_update [-h] datastore_name default_version

Add or update a datastore.
If the datastore already exists, the default version will be updated.

Positional arguments
--------------------

``datastore_name``
  Name of the datastore.

``default_version``
  Name or ID of an existing datastore version to set as the default.
  When adding a new datastore, use an empty string.

Optional arguments
------------------

``-h, --help``
  show this help message and exit

trove-manage datastore_version_flavor_add
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

   usage: trove-manage datastore_version_flavor_add [-h]
                                                    datastore_name
                                                    datastore_version_name
                                                    flavor_ids

Positional arguments
--------------------

``datastore_name``
  Name of the datastore.

``datastore_version_name``
  Name of the datastore version.

``flavor_ids``
        Comma separated list of flavor ids.

Optional arguments
------------------

``-h, --help``
  show this help message and exit

trove-manage datastore_version_flavor_delete
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

   usage: trove-manage datastore_version_flavor_delete [-h]
                                                       datastore_name
                                                       datastore_version_name
                                                       flavor_id

Positional arguments
--------------------

``datastore_name``
  Name of the datastore.

``datastore_version_name``
  Name of the datastore version.

``flavor_id``
  The flavor to be deleted for a given datastore and datastore version.

Optional arguments
------------------

``-h, --help``
        show this help message and exit

trove-manage datastore_version_update
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

   usage: trove-manage datastore_version_update [-h]
                                                datastore version_name manager
                                                image_id packages active

Add or update a datastore version. If the datastore version already exists,
all values except the datastore name and version will be updated.

Positional arguments
--------------------

``datastore``
  Name of the datastore.

``version_name``
  Name of the datastore version.

``manager``
  Name of the manager that will administer the datastore version.

``image_id``
  ID of the image used to create an instance of the datastore version.

``packages``
  Packages required by the datastore version that are installed on
  the guest image.

``active``
  Whether the datastore version is active or not.
  Accepted values are ``0`` and ``1``.

Optional arguments
------------------

``-h, --help``
  show this help message and exit

trove-manage db_downgrade
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

   usage: trove-manage db_downgrade [-h] [--repo_path REPO_PATH] version

Downgrade the database to the specified version.

Positional arguments
--------------------

``version``
  Target version.

Optional arguments
------------------

``-h, --help``
  show this help message and exit

``--repo_path REPO_PATH``
  SQLAlchemy Migrate repository path.

trove-manage db_load_datastore_config_parameters
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

   usage: trove-manage db_load_datastore_config_parameters [-h]
                                                           datastore
                                                           datastore_version
                                                           config_file_location

Loads configuration group parameter validation rules for a datastore version
into the database.

Positional arguments
--------------------

``datastore``
  Name of the datastore.

``datastore_version``
  Name of the datastore version.

``config_file_location``
  Fully qualified file path to the configuration group
  parameter validation rules.

Optional arguments
------------------

``-h, --help``
  show this help message and exit

trove-manage db_recreate
~~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

   usage: trove-manage db_recreate [-h] [--repo_path REPO_PATH]

Drop the database and recreate it.

Optional arguments
------------------

``-h, --help``
  show this help message and exit

``--repo_path REPO_PATH``
  SQLAlchemy Migrate repository path.

trove-manage db_sync
~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

   usage: trove-manage db_sync [-h] [--repo_path REPO_PATH]

Populate the database structure

Optional arguments
------------------

``-h, --help``
  show this help message and exit

``--repo_path REPO_PATH``
  SQLAlchemy Migrate repository path.

trove-manage db_upgrade
~~~~~~~~~~~~~~~~~~~~~~~

.. code-block:: console

   usage: trove-manage db_upgrade [-h] [--version VERSION]
                                  [--repo_path REPO_PATH]

Upgrade the database to the specified version.

Optional arguments
------------------

``-h, --help``
  show this help message and exit

``--version VERSION``
  Target version. Defaults to the latest version.

``--repo_path REPO_PATH``
  SQLAlchemy Migrate repository path.
