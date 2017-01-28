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

===============================
nova-manage command-line client
===============================

The nova-manage client is the command-line interface (CLI) for
Compute service management utility.

This chapter documents :command:`nova-manage` version ``13.0.0``.

For help on a specific :command:`nova-manage` command, enter:

.. code-block:: console

   $ nova-manage COMMAND --help

.. _nova-manage_command_usage:

nova-manage usage
~~~~~~~~~~~~~~~~~

.. code-block:: console

   usage: nova-manage [-h] [--remote_debug-host REMOTE_DEBUG_HOST]
                      [--remote_debug-port REMOTE_DEBUG_PORT] [--config-dir DIR]
                      [--config-file PATH] [--debug] [--log-config-append PATH]
                      [--log-date-format DATE_FORMAT] [--log-dir LOG_DIR]
                      [--log-file PATH] [--nodebug] [--nouse-syslog]
                      [--noverbose] [--nowatch-log-file]
                      [--syslog-log-facility SYSLOG_LOG_FACILITY] [--use-syslog]
                      [--verbose] [--version] [--watch-log-file]
                      {version,bash-completion,project,account,shell,logs,
                      service,cell_v2,db,vm,agent,cell,network,host,floating,
                      fixed,vpn,api_db}
                      ...

.. _nova-manage_command_options:

nova-manage optional arguments
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

``-h, --help``
  show this help message and exit

``--config-dir DIR``
  Path to a config directory to pull ``*.conf`` files from.
  This file set is sorted, so as to provide a
  predictable parse order if individual options are
  over-ridden. The set is parsed after the file(s)
  specified via previous --config-file, arguments hence
  over-ridden options in the directory take precedence.

``--config-file PATH``
  Path to a config file to use. Multiple config files
  can be specified, with values in later files taking
  precedence. Defaults to None.

``--debug, -d``
  If set to true, the logging level will be set to DEBUG
  instead of the default INFO level.

``--log-config-append PATH, --log_config PATH``
  The name of a logging configuration file. This file is
  appended to any existing logging configuration files.
  For details about logging configuration files, see the
  Python logging module documentation. Note that when
  logging configuration files are used then all logging
  configuration is set in the configuration file and
  other logging configuration options are ignored (for
  example, logging_context_format_string).

``--log-date-format DATE_FORMAT``
  Defines the format string for %(asctime)s in log
  records. Default: None . This option is ignored if
  log_config_append is set.

``--log-dir LOG_DIR, --logdir LOG_DIR``
  (Optional) The base directory used for relative
  log_file paths. This option is ignored if
  log_config_append is set.

``--log-file PATH, --logfile PATH``
  (Optional) Name of log file to send logging output to.
  If no default is set, logging will go to stderr as
  defined by use_stderr. This option is ignored if
  log_config_append is set.

``--nodebug``
  The inverse of --debug

``--nouse-syslog``
  The inverse of --use-syslog

``--noverbose``
  The inverse of --verbose

``--nowatch-log-file``
  The inverse of --watch-log-file

``--syslog-log-facility SYSLOG_LOG_FACILITY``
  Syslog facility to receive log lines. This option is
  ignored if log_config_append is set.

``--use-syslog``
  Use syslog for logging. Existing syslog format is
  **DEPRECATED** and will be changed later to honor RFC5424.
  This option is ignored if log_config_append is set.

``--verbose, -v``
  If set to false, the logging level will be set to
  WARNING instead of the default INFO level.

``--version``
  show program's version number and exit

``--watch-log-file``
  Uses logging handler designed to watch file system.
  When log file is moved or removed this handler will
  open a new log file with specified path
  instantaneously. It makes sense only if log_file
  option is specified and Linux platform is used. This
  option is ignored if log_config_append is set.

.. _nova-manage_account:

nova-manage account
-------------------

.. code-block:: console

   usage: nova-manage account [-h] {quota,scrub} ...

**Positional arguments:**

``{quota,scrub}``

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _nova-manage_agent:

nova-manage agent
-----------------

.. code-block:: console

   usage: nova-manage agent [-h] {create,delete,list,modify} ...

**Positional arguments:**

``{create,delete,list,modify}``

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _nova-manage_api_db:

nova-manage api_db
------------------

.. code-block:: console

   usage: nova-manage api_db [-h] {sync,version} ...

**Positional arguments:**

``{sync,version}``

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _nova-manage_cell:

nova-manage cell
----------------

.. code-block:: console

   usage: nova-manage cell [-h] {create,delete,list} ...

**Positional arguments:**

``{create,delete,list}``

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _nova-manage_cell_v2:

nova-manage cell_v2
-------------------

.. code-block:: console

   usage: nova-manage cell_v2 [-h] {map_cell_and_hosts,map_instances} ...

**Positional arguments:**

``{map_cell_and_hosts,map_instances}``

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _nova-manage_db:

nova-manage db
--------------

.. code-block:: console

   usage: nova-manage db [-h]
                         {archive_deleted_rows,null_instance_uuid_scan,online_data_migrations,sync,version}
                         ...

**Positional arguments:**

``{archive_deleted_rows,null_instance_uuid_scan,online_data_migrations,sync,version}``

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _nova-manage_fixed:

nova-manage fixed
-----------------

.. code-block:: console

   usage: nova-manage fixed [-h] {list,reserve,unreserve} ...

**Positional arguments:**

``{list,reserve,unreserve}``

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _nova-manage_floating:

nova-manage floating
--------------------

.. code-block:: console

   usage: nova-manage floating [-h] {address_to_hosts,create,delete,list} ...

**Positional arguments:**

``{address_to_hosts,create,delete,list}``

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _nova-manage_host:

nova-manage host
----------------

.. code-block:: console

   usage: nova-manage host [-h] {list} ...

**Positional arguments:**

``{list}``

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _nova-manage_logs:

nova-manage logs
----------------

.. code-block:: console

   usage: nova-manage logs [-h] {errors,syslog} ...

**Positional arguments:**

``{errors,syslog}``

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _nova-manage_network:

nova-manage network
-------------------

.. code-block:: console

   usage: nova-manage network [-h] {create,delete,list,modify} ...

**Positional arguments:**

``{create,delete,list,modify}``

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _nova-manage_project:

nova-manage project
-------------------

.. code-block:: console

   usage: nova-manage project [-h] {quota,scrub} ...

**Positional arguments:**

``{quota,scrub}``

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _nova-manage_shell:

nova-manage shell
-----------------

.. code-block:: console

   usage: nova-manage shell [-h] {bpython,ipython,python,run,script} ...

**Positional arguments:**

``{bpython,ipython,python,run,script}``

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _nova-manage_vm:

nova-manage vm
--------------

.. code-block:: console

   usage: nova-manage vm [-h] {list} ...

**Positional arguments:**

``{list}``

**Optional arguments:**

``-h, --help``
  show this help message and exit

.. _nova-manage_vpn:

nova-manage vpn
---------------

.. code-block:: console

   usage: nova-manage vpn [-h] {change} ...

**Positional arguments:**

``{change}``

**Optional arguments:**

``-h, --help``
  show this help message and exit
