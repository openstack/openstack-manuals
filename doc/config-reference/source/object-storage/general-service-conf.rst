============================================
Object Storage general service configuration
============================================

Object Storage service uses multiple configuration files for multiple services
and background daemons, and ``paste.deploy`` to manage server configurations.
For more information about ``paste.deploy``, see: http://pythonpaste.org/deploy/.

Default configuration options are set in the ``[DEFAULT]`` section, and any
options specified there can be overridden in any of the other sections when the
syntax ``set option_name = value`` is in place.

Configuration for servers and daemons can be expressed together in the same
file for each type of server, or separately. If a required section for the
service trying to start is missing, there will be an error. Sections not used
by the service are ignored.

Consider the example of an Object Storage node. By convention configuration for
the ``object-server``, ``object-updater``, ``object-replicator``, and
``object-auditor`` exist in a single file ``/etc/swift/object-server.conf``:

.. code-block:: ini

    [DEFAULT]

    [pipeline:main]
    pipeline = object-server

    [app:object-server]
    use = egg:swift#object

    [object-replicator]
    reclaim_age = 259200

    [object-updater]

    [object-auditor]

.. note::

   Default constraints can be overridden in ``swift.conf``. For example,
   you can change the maximum object size and other variables.


Object Storage services expect a configuration path as the first argument:

.. code-block:: console

    $ swift-object-auditor
    Usage: swift-object-auditor CONFIG [options]

    Error: missing config path argument

If you omit the object-auditor section, this file cannot be used as the
configuration path when starting the ``swift-object-auditor`` daemon:

.. code-block:: console

    $ swift-object-auditor /etc/swift/object-server.conf
    Unable to find object-auditor config section in /etc/swift/object-server.conf

If the configuration path is a directory instead of a file, all of the files in
the directory with the file extension ``.conf`` will be combined to generate
the configuration object which is delivered to the Object Storage service. This
is referred to generally as directory-based configuration.

Directory-based configuration leverages ``ConfigParser``'s native multi-file
support. Files ending in ``.conf`` in the given directory are parsed in
lexicographical order. File names starting with ``.`` are ignored. A mixture of
file and directory configuration paths is not supported. If the configuration
path is a file, only that file will be parsed.

The Object Storage service management tool ``swift-init`` has adopted the
convention of looking for ``/etc/swift/{type}-server.conf.d/`` if the file
``/etc/swift/{type}-server.conf`` file does not exist.

When using directory-based configuration, if the same option under the same
section appears more than once in different files, the last value parsed is
said to override previous occurrences. You can ensure proper override
precedence by prefixing the files in the configuration directory with numerical
values, as in the following example file layout:

.. code-block:: none

    /etc/swift/
        default.base
        object-server.conf.d/
            000_default.conf -> ../default.base
            001_default-override.conf
            010_server.conf
            020_replicator.conf
            030_updater.conf
            040_auditor.conf

You can inspect the resulting combined configuration object using the
``swift-config`` command-line tool.

All the services of an Object Store deployment share a common configuration in
the ``[swift-hash]`` section of the ``/etc/swift/swift.conf`` file. The
``swift_hash_path_suffix`` and ``swift_hash_path_prefix`` values must be
identical on all the nodes.

.. include:: ../tables/swift-swift-swift-hash.rst
