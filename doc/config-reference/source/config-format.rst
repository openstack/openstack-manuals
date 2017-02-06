=========================
Configuration file format
=========================

OpenStack uses the INI file format for configuration files.
An INI file is a simple text file that specifies options as
``key=value`` pairs, grouped into sections.
The ``DEFAULT`` section contains most of the configuration options.
Lines starting with a hash sign (``#``) are comment lines.
For example:

.. code-block:: ini

   [DEFAULT]
   # Print debugging output (set logging level to DEBUG instead
   # of default WARNING level). (boolean value)
   debug = true

   [database]
   # The SQLAlchemy connection string used to connect to the
   # database (string value)
   connection = mysql+pymysql://keystone:KEYSTONE_DBPASS@controller/keystone

Options can have different types for values.
The comments in the sample config files always mention these and the
tables mention the ``Opt`` value as first item like ``(BoolOpt) Toggle...``.
The following types are used by OpenStack:

boolean value (``BoolOpt``)
 Enables or disables an option. The allowed values are ``true`` and ``false``.

 .. code-block:: ini

    # Enable the experimental use of database reconnect on
    # connection lost (boolean value)
    use_db_reconnect = false

floating point value (``FloatOpt``)
 A floating point number like ``0.25`` or ``1000``.

 .. code-block:: ini

    # Sleep time in seconds for polling an ongoing async task
    # (floating point value)
    task_poll_interval = 0.5

integer value (``IntOpt``)
 An integer number is a number without fractional components,
 like ``0`` or ``42``.

 .. code-block:: ini

    # The port which the OpenStack Compute service listens on.
    # (integer value)
    compute_port = 8774

IP address (``IPOpt``)
 An IPv4 or IPv6 address.

 .. code-block:: ini

    # Address to bind the server. Useful when selecting a particular network
    # interface. (ip address value)
    bind_host = 0.0.0.0

key-value pairs (``DictOpt``)
 A key-value pairs, also known as a dictionary. The key value pairs are
 separated by commas and a colon is used to separate key and value.
 Example: ``key1:value1,key2:value2``.

 .. code-block:: ini

    # Parameter for l2_l3 workflow setup. (dict value)
    l2_l3_setup_params = data_ip_address:192.168.200.99, \
       data_ip_mask:255.255.255.0,data_port:1,gateway:192.168.200.1,ha_port:2

list value (``ListOpt``)
 Represents values of other types, separated by commas.
 As an example, the following sets ``allowed_rpc_exception_modules``
 to a list containing the four elements ``oslo.messaging.exceptions``,
 ``nova.exception``, ``cinder.exception``, and ``exceptions``:

 .. code-block:: ini

    # Modules of exceptions that are permitted to be recreated
    # upon receiving exception data from an rpc call. (list value)
    allowed_rpc_exception_modules = oslo.messaging.exceptions,nova.exception

multi valued (``MultiStrOpt``)
 A multi-valued option is a string value and can be given
 more than once, all values will be used.

 .. code-block:: ini

    # Driver or drivers to handle sending notifications. (multi valued)
    notification_driver = nova.openstack.common.notifier.rpc_notifier
    notification_driver = ceilometer.compute.nova_notifier

port value (``PortOpt``)
 A TCP/IP port number.  Ports can range from 1 to 65535.

 .. code-block:: ini

   # Port to which the UDP socket is bound. (port value)
   # Minimum value: 1
   # Maximum value: 65535
   udp_port = 4952

string value (``StrOpt``)
 Strings can be optionally enclosed with single or double quotes.

 .. code-block:: ini

    # Enables or disables publication of error events. (boolean value)
    publish_errors = false

    # The format for an instance that is passed with the log message.
    # (string value)
    instance_format = "[instance: %(uuid)s] "

Sections
~~~~~~~~

Configuration options are grouped by section.
Most configuration files support at least the following sections:

[DEFAULT]
 Contains most configuration options.
 If the documentation for a configuration option does not
 specify its section, assume that it appears in this section.

[database]
 Configuration options for the database that stores
 the state of the OpenStack service.

Substitution
~~~~~~~~~~~~

The configuration file supports variable substitution.
After you set a configuration option, it can be referenced
in later configuration values when you precede it with
a ``$``, like ``$OPTION``.

The following example uses the values of ``rabbit_host`` and
``rabbit_port`` to define the value of the ``rabbit_hosts``
option, in this case as ``controller:5672``.

.. code-block:: ini

   # The RabbitMQ broker address where a single node is used.
   # (string value)
   rabbit_host = controller

   # The RabbitMQ broker port where a single node is used.
   # (integer value)
   rabbit_port = 5672

   # RabbitMQ HA cluster host:port pairs. (list value)
   rabbit_hosts = $rabbit_host:$rabbit_port

To avoid substitution, use ``$$``, it is replaced by a single ``$``.
For example, if your LDAP DNS password is ``$xkj432``, specify it, as follows:

.. code-block:: ini

   ldap_dns_password = $$xkj432

The code uses the Python ``string.Template.safe_substitute()``
method to implement variable substitution.
For more details on how variable substitution is resolved, see
https://docs.python.org/2/library/string.html#template-strings
and `PEP 292 <https://www.python.org/dev/peps/pep-0292/>`_.

Whitespace
~~~~~~~~~~

To include whitespace in a configuration value, use a quoted string.
For example:

.. code-block:: ini

   ldap_dns_password='a password with spaces'

Define an alternate location for a config file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Most services and the ``*-manage`` command-line clients load
the configuration file.
To define an alternate location for the configuration file,
pass the ``--config-file CONFIG_FILE`` parameter
when you start a service or call a ``*-manage`` command.
