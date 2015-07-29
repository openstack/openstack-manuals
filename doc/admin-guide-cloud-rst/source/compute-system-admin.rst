.. _compute-trusted-pools.rst:

=====================
System administration
=====================

To effectively administer Compute, you must understand how the different
installed nodes interact with each other. Compute can be installed in
many different ways using multiple servers, but generally multiple
compute nodes control the virtual servers and a cloud controller node
contains the remaining Compute services.

The Compute cloud works using a series of daemon processes named nova-\*
that exist persistently on the host machine. These binaries can all run
on the same machine or be spread out on multiple boxes in a large
deployment. The responsibilities of services and drivers are:

**Services**

``nova-api``
   receives XML requests and sends them to the rest of the
   system. A WSGI app routes and authenticates requests. Supports the
   EC2 and OpenStack APIs. A :file:`nova.conf` configuration file is created
   when Compute is installed.

``nova-cert``
   manages certificates.

``nova-compute``
   manages virtual machines. Loads a Service object, and
   exposes the public methods on ComputeManager through a Remote
   Procedure Call (RPC).

``nova-conductor``
   provides database-access support for Compute nodes
   (thereby reducing security risks).

``nova-consoleauth``
   manages console authentication.

``nova-objectstore``
   a simple file-based storage system for images that
   replicates most of the S3 API. It can be replaced with OpenStack
   Image service and either a simple image manager or OpenStack Object
   Storage as the virtual machine image storage facility. It must exist
   on the same node as nova-compute.

``nova-network``
   manages floating and fixed IPs, DHCP, bridging and
   VLANs. Loads a Service object which exposes the public methods on one
   of the subclasses of NetworkManager. Different networking strategies
   are available by changing the ``network_manager`` configuration
   option to ``FlatManager``, ``FlatDHCPManager``, or ``VLANManager``
   (defaults to ``VLANManager`` if nothing is specified).

``nova-scheduler``
   dispatches requests for new virtual machines to the
   correct node.

``nova-novncproxy``
   provides a VNC proxy for browsers, allowing VNC
   consoles to access virtual machines.

.. note::

   Some services have drivers that change how the service implements
   its core functionality. For example, the nova-compute service
   supports drivers that let you choose which hypervisor type it can
   use. nova-network and nova-scheduler also have drivers.

.. _section_manage-compute-users:

Manage Compute users
~~~~~~~~~~~~~~~~~~~~

Access to the Euca2ools (ec2) API is controlled by an access key and a
secret key. The user's access key needs to be included in the request,
and the request must be signed with the secret key. Upon receipt of API
requests, Compute verifies the signature and runs commands on behalf of
the user.

To begin using Compute, you must create a user with the Identity
Service.

Manage Volumes
~~~~~~~~~~~~~~

Depending on the setup of your cloud provider, they may give you an
endpoint to use to manage volumes, or there may be an extension under
the covers. In either case, you can use the ``nova`` CLI to manage
volumes.

.. list-table:: nova volume commands
   :header-rows: 1

   * - Command
     - Description
   * - volume-attach
     - Attach a volume to a server.
   * - volume-create
     - Add a new volume.
   * - volume-delete
     - Remove a volume.
   * - volume-detach
     - Detach a volume from a server.
   * - volume-list
     - List all the volumes.
   * - volume-show
     - Show details about a volume.
   * - volume-snapshot-create
     - Add a new snapshot.
   * - volume-snapshot-delete
     - Remove a snapshot.
   * - volume-snapshot-list
     - List all the snapshots.
   * - volume-snapshot-show
     - Show details about a snapshot.
   * - volume-type-create
     - Create a new volume type.
   * - volume-type-delete
     - Delete a specific flavor
   * - volume-type-list
     - Print a list of available 'volume types'.
   * - volume-update
     - Update an attached volume.

|

For example, to list IDs and names of Compute volumes, run:

.. code:: console

    $ nova volume-list
    +-----------+-----------+--------------+------+-------------+-------------+
    | ID        | Status    | Display Name | Size | Volume Type | Attached to |
    +-----------+-----------+--------------+------+-------------+-------------+
    | 1af4cb9...| available | PerfBlock    | 1    | Performance |             |
    +-----------+-----------+--------------+------+-------------+-------------+

.. _compute-flavors:

Flavors
~~~~~~~

Admin users can use the :command:`nova flavor-` commands to customize and
manage flavors. To see the available flavor-related commands, run:

.. code:: console

   $ nova help | grep flavor-
     flavor-access-add     Add flavor access for the given tenant.
     flavor-access-list    Print access information about the given flavor.
     flavor-access-remove  Remove flavor access for the given tenant.
     flavor-create         Create a new flavor
     flavor-delete         Delete a specific flavor
     flavor-key            Set or unset extra_spec for a flavor.
     flavor-list           Print a list of available 'flavors' (sizes of
     flavor-show           Show details about the given flavor.

.. note::

   -  Configuration rights can be delegated to additional users by
      redefining the access controls for
      ``compute_extension:flavormanage`` in :file:`/etc/nova/policy.json`
      on the nova-api server.

   -  To modify an existing flavor in the dashboard, you must delete
      the flavor and create a modified one with the same name.

Flavors define these elements:

**Identity Service configuration file sections**

+-------------+---------------------------------------------------------------+
| Element     | Description                                                   |
+=============+===============================================================+
| Name        | A descriptive name. XX.SIZE_NAME is typically not required,   |
|             | though some third party tools may rely on it.                 |
+-------------+---------------------------------------------------------------+
| Memory_MB   | Virtual machine memory in megabytes.                          |
+-------------+---------------------------------------------------------------+
| Disk        | Virtual root disk size in gigabytes. This is an ephemeral di\ |
|             | sk that the base image is copied into. When booting from a p\ |
|             | ersistent volume it is not used. The "0" size is a special c\ |
|             | ase which uses the native base image size as the size of the  |
|             | ephemeral root volume.                                        |
+-------------+---------------------------------------------------------------+
| Ephemeral   | Specifies the size of a secondary ephemeral data disk. This   |
|             | is an empty, unformatted disk and exists only for the life o\ |
|             | f the instance.                                               |
+-------------+---------------------------------------------------------------+
| Swap        | Optional swap space allocation for the instance.              |
+-------------+---------------------------------------------------------------+
| VCPUs       | Number of virtual CPUs presented to the instance.             |
+-------------+---------------------------------------------------------------+
| RXTX_Factor | Optional property allows created servers to have a different  |
|             | bandwidth cap than that defined in the network they are att\  |
|             | ached to. This factor is multiplied by the rxtx_base propert\ |
|             | y of the network. Default value is 1.0. That is, the same as  |
|             | attached network. This parameter is only available for Xen    |
|             | or NSX based systems.                                         |
+-------------+---------------------------------------------------------------+
| Is_Public   | Boolean value, whether flavor is available to all users or p\ |
|             | rivate to the tenant it was created in. Defaults to True.     |
+-------------+---------------------------------------------------------------+
| extra_specs | Key and value pairs that define on which compute nodes a fla\ |
|             | vor can run. These pairs must match corresponding pairs on t\ |
|             | he compute nodes. Use to implement special resources, such a\ |
|             | s flavors that run on only compute nodes with GPU hardware.   |
+-------------+---------------------------------------------------------------+

|

Flavor customization can be limited by the hypervisor in use. For
example the libvirt driver enables quotas on CPUs available to a VM,
disk tuning, bandwidth I/O, watchdog behavior, random number generator
device control, and instance VIF traffic control.

CPU limits
    You can configure the CPU limits with control parameters with the
    ``nova`` client. For example, to configure the I/O limit, use:

    .. code:: console

        $ nova flavor-key m1.small set quota:read_bytes_sec=10240000
        $ nova flavor-key m1.small set quota:write_bytes_sec=10240000

    Use these optional parameters to control weight shares, enforcement
    intervals for runtime quotas, and a quota for maximum allowed
    bandwidth:

    -  ``cpu_shares``. Specifies the proportional weighted share for the
       domain. If this element is omitted, the service defaults to the
       OS provided defaults. There is no unit for the value; it is a
       relative measure based on the setting of other VMs. For example,
       a VM configured with value 2048 gets twice as much CPU time as a
       VM configured with value 1024.

    -  ``cpu_period``. Specifies the enforcement interval (unit:
       microseconds) for QEMU and LXC hypervisors. Within a period, each
       VCPU of the domain is not allowed to consume more than the quota
       worth of runtime. The value should be in range ``[1000, 1000000]``.
       A period with value 0 means no value.

    -  ``cpu_limit``. Specifies the upper limit for VMware machine CPU
       allocation in MHz. This parameter ensures that a machine never
       uses more than the defined amount of CPU time. It can be used to
       enforce a limit on the machine's CPU performance.

    -  ``cpu_reservation``. Specifies the guaranteed minimum CPU
       reservation in MHz for VMware. This means that if needed, the
       machine will definitely get allocated the reserved amount of CPU
       cycles.

    -  ``cpu_quota``. Specifies the maximum allowed bandwidth (unit:
       microseconds). A domain with a negative-value quota indicates
       that the domain has infinite bandwidth, which means that it is
       not bandwidth controlled. The value should be in range ``[1000,
       18446744073709551]`` or less than 0. A quota with value 0 means no
       value. You can use this feature to ensure that all vCPUs run at the
       same speed. For example:

       .. code:: console

           $ nova flavor-key m1.low_cpu set quota:cpu_quota=10000
           $ nova flavor-key m1.low_cpu set quota:cpu_period=20000

       In this example, the instance of ``m1.low_cpu`` can only consume
       a maximum of 50% CPU of a physical CPU computing capability.

Disk tuning
    Using disk I/O quotas, you can set maximum disk write to 10 MB per
    second for a VM user. For example:

    .. code:: console

        $ nova flavor-key m1.medium set quota:disk_write_bytes_sec=10485760

    The disk I/O options are:

    -  disk\_read\_bytes\_sec

    -  disk\_read\_iops\_sec

    -  disk\_write\_bytes\_sec

    -  disk\_write\_iops\_sec

    -  disk\_total\_bytes\_sec

    -  disk\_total\_iops\_sec

Bandwidth I/O
    The vif I/O options are:

    -  vif\_inbound\_ average

    -  vif\_inbound\_burst

    -  vif\_inbound\_peak

    -  vif\_outbound\_ average

    -  vif\_outbound\_burst

    -  vif\_outbound\_peak

    Incoming and outgoing traffic can be shaped independently. The
    bandwidth element can have at most, one inbound and at most, one
    outbound child element. If you leave any of these child elements
    out, no quality of service (QoS) is applied on that traffic
    direction. So, if you want to shape only the network's incoming
    traffic, use inbound only (and vice versa). Each element has one
    mandatory attribute average, which specifies the average bit rate on
    the interface being shaped.

    There are also two optional attributes (integer): ``peak``, which
    specifies the maximum rate at which a bridge can send data
    (kilobytes/second), and ``burst``, the amount of bytes that can be
    burst at peak speed (kilobytes). The rate is shared equally within
    domains connected to the network.

    Below example sets network traffic bandwidth limits for existing
    flavor as follow:

    -  Outbound traffic:

       -  average: 256 Mbps (32768 kilobytes/second)

       -  peak: 512 Mbps (65536 kilobytes/second)

       -  burst: 100 ms

    -  Inbound traffic:

       -  average: 256 Mbps (32768 kilobytes/second)

       -  peak: 512 Mbps (65536 kilobytes/second)

       -  burst: 100 ms

    .. code:: console

        $ nova flavor-key nlimit set quota:vif_outbound_average=32768
        $ nova flavor-key nlimit set quota:vif_outbound_peak=65536
        $ nova flavor-key nlimit set quota:vif_outbound_burst=6553
        $ nova flavor-key nlimit set quota:vif_inbound_average=16384
        $ nova flavor-key nlimit set quota:vif_inbound_peak=32768
        $ nova flavor-key nlimit set quota:vif_inbound_burst=3276


    .. note::

       All the speed limit values in above example are specified in
       kilobytes/second. And burst values are in kilobytes.

Watchdog behavior
    For the libvirt driver, you can enable and set the behavior of a
    virtual hardware watchdog device for each flavor. Watchdog devices
    keep an eye on the guest server, and carry out the configured
    action, if the server hangs. The watchdog uses the i6300esb device
    (emulating a PCI Intel 6300ESB). If ``hw:watchdog_action`` is not
    specified, the watchdog is disabled.

    To set the behavior, use:

    .. code:: console

        $ nova flavor-key FLAVOR-NAME set hw:watchdog_action=ACTION

    Valid ACTION values are:

    -  ``disabled``—(default) The device is not attached.

    -  ``reset``—Forcefully reset the guest.

    -  ``poweroff``—Forcefully power off the guest.

    -  ``pause``—Pause the guest.

    -  ``none``—Only enable the watchdog; do nothing if the server
       hangs.

    .. note::

        Watchdog behavior set using a specific image's properties will
        override behavior set using flavors.

Random-number generator
    If a random-number generator device has been added to the instance
    through its image properties, the device can be enabled and
    configured using:

    .. code:: console

        $ nova flavor-key FLAVOR-NAME set hw_rng:allowed=True
        $ nova flavor-key FLAVOR-NAME set hw_rng:rate_bytes=RATE-BYTES
        $ nova flavor-key FLAVOR-NAME set hw_rng:rate_period=RATE-PERIOD

    Where:

    -  RATE-BYTES—(Integer) Allowed amount of bytes that the guest can
       read from the host's entropy per period.

    -  RATE-PERIOD—(Integer) Duration of the read period in seconds.

CPU toplogy
    For the libvirt driver, you can define the topology of the processors
    in the virtual machine using properties. The properties with ``max``
    limit the number that can be selected by the user with image properties.

    .. code:: console

        $ nova flavor-key FLAVOR-NAME set hw:cpu_sockets=FLAVOR-SOCKETS
        $ nova flavor-key FLAVOR-NAME set hw:cpu_cores=FLAVOR-CORES
        $ nova flavor-key FLAVOR-NAME set hw:cpu_threads=FLAVOR-THREADS
        $ nova flavor-key FLAVOR-NAME set hw:cpu_max_sockets=FLAVOR-SOCKETS
        $ nova flavor-key FLAVOR-NAME set hw:cpu_max_cores=FLAVOR-CORES
        $ nova flavor-key FLAVOR-NAME set hw:cpu_max_threads=FLAVOR-THREADS

    Where:

    -  FLAVOR-SOCKETS—(Integer) The number of sockets for the guest VM. By
       this is set to the number of vCPUs requested.

    -  FLAVOR-CORES—(Integer) The number of cores per socket for the guest VM. By
       this is set to 1.

    -  FLAVOR-THREADS—(Integer) The number of threads per core for the guest VM. By
       this is set to 1.

Project private flavors
    Flavors can also be assigned to particular projects. By default, a
    flavor is public and available to all projects. Private flavors are
    only accessible to those on the access list and are invisible to
    other projects. To create and assign a private flavor to a project,
    run these commands:

    .. code:: console

        $ nova flavor-create --is-public false p1.medium auto 512 40 4
        $ nova flavor-access-add 259d06a0-ba6d-4e60-b42d-ab3144411d58 86f94150ed744e08be565c2ff608eef9


.. _default_ports:

Compute service node firewall requirements
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Console connections for virtual machines, whether direct or through a
proxy, are received on ports ``5900`` to ``5999``. The firewall on each
Compute service node must allow network traffic on these ports.

This procedure modifies the iptables firewall to allow incoming
connections to the Compute services.

**Configuring the service-node firewall**

#. Log in to the server that hosts the Compute service, as root.

#. Edit the :file:`/etc/sysconfig/iptables` file, to add an INPUT rule that
   allows TCP traffic on ports from ``5900`` to ``5999``. Make sure the new
   rule appears before any INPUT rules that REJECT traffic:

   .. code:: ini

      -A INPUT -p tcp -m multiport --dports 5900:5999 -j ACCEPT

#. Save the changes to :file:`/etc/sysconfig/iptables` file, and restart the
   iptables service to pick up the changes:

   .. code:: console

      $ service iptables restart

#. Repeat this process for each Compute service node.

.. _admin-password-injection:

Injecting the administrator password
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Compute can generate a random administrator (root) password and inject
that password into an instance. If this feature is enabled, users can
run :command:`ssh` to an instance without an :command:`ssh` keypair.
The random password appears in the output of the :command:`nova boot` command.
You can also view and set the admin password from the dashboard.

**Password injection using the dashboard**

By default, the dashboard will display the ``admin`` password and allow
the user to modify it.

If you do not want to support password injection, disable the password
fields by editing the dashboard's :file:`local_settings` file. On
Fedora/RHEL/CentOS, the file location is
:file:`/etc/openstack-dashboard/local_settings`. On Ubuntu and Debian, it is
:file:`/etc/openstack-dashboard/local_settings.py`. On openSUSE and SUSE
Linux Enterprise Server, it is
:file:`/srv/www/openstack-dashboard/openstack_dashboard/local/local_settings.py`

.. code:: ini

    OPENSTACK_HYPERVISOR_FEATURE = {
    ...
        'can_set_password': False,
    }

**Password injection on libvirt-based hypervisors**

For hypervisors that use the libvirt back end (such as KVM, QEMU, and
LXC), admin password injection is disabled by default. To enable it, set
this option in :file:`/etc/nova/nova.conf`:

.. code:: ini

    [libvirt]
    inject_password=true

When enabled, Compute will modify the password of the admin account by
editing the :file:`/etc/shadow` file inside the virtual machine instance.

..  note::

    Users can only use :command:`ssh` to access the instance by using the admin
    password if the virtual machine image is a Linux distribution, and it has
    been configured to allow users to use :command:`ssh` as the root user. This
    is not the case for `Ubuntu cloud images`_ which, by default, does not
    allow users to use :command:`ssh` to access the root account.

**Password injection and XenAPI (XenServer/XCP)**

When using the XenAPI hypervisor back end, Compute uses the XenAPI agent
to inject passwords into guests. The virtual machine image must be
configured with the agent for password injection to work.

**Password injection and Windows images (all hypervisors)**

.. _Ubuntu cloud images: #

For Windows virtual machines, configure the Windows image to retrieve
the admin password on boot by installing an agent such as
`cloudbase-init`_.

.. _cloudbase-init: #

.. _section_manage-the-cloud:

Manage the cloud
~~~~~~~~~~~~~~~~

System administrators can use :command:`nova` client and :command:`Euca2ools`
commands to manage their clouds.

``nova`` client and ``euca2ools`` can be used by all users, though
specific commands might be restricted by Role Based Access Control in
the Identity Service.

**Managing the cloud with nova client**

#. The python-novaclient package provides a ``nova`` shell that enables
   Compute API interactions from the command line. Install the client, and
   provide your user name and password (which can be set as environment
   variables for convenience), for the ability to administer the cloud from
   the command line.

   To install python-novaclient, download the tarball from
   `http://pypi.python.org/pypi/python-novaclient/#downloads <http://pypi.python.org/pypi/python-novaclient/#downloads>`__ and then
   install it in your favorite Python environment:

   ..  code:: console

       $ curl -O http://pypi.python.org/packages/source/p/python-novaclient/python-novaclient-2.6.3.tar.gz
       $ tar -zxvf python-novaclient-2.6.3.tar.gz
       $ cd python-novaclient-2.6.3

   As root, run:

   ..  code:: console

       # python setup.py install

#. Confirm the installation was successful:

   ..  code:: console

       $ nova help
       usage: nova [--version] [--debug] [--os-cache] [--timings]
                   [--timeout SECONDS] [--os-username AUTH_USER_NAME]
                   [--os-password AUTH_PASSWORD]
                   [--os-tenant-name AUTH_TENANT_NAME]
                   [--os-tenant-id AUTH_TENANT_ID] [--os-auth-url AUTH_URL]
                   [--os-region-name REGION_NAME] [--os-auth-system AUTH_SYSTEM]
                   [--service-type SERVICE_TYPE] [--service-name SERVICE_NAME]
                   [--volume-service-name VOLUME_SERVICE_NAME]
                   [--endpoint-type ENDPOINT_TYPE]
                   [--os-compute-api-version COMPUTE_API_VERSION]
                   [--os-cacert CA_CERTIFICATE] [--insecure]
                   [--bypass-url BYPASS_URL]
                   SUBCOMMAND ...

   Running :command:`nova help` returns a list of ``nova`` commands and
   parameters. To get help for a subcommand, run:

   ..  code:: console

       $ nova help SUBCOMMAND

   For a complete list of ``nova`` commands and parameters, see the
   `OpenStack Command-Line Reference <http://docs.openstack.org/cli-reference/content/>`__.

#. Set the required parameters as environment variables to make running
   commands easier. For example, you can add :option:`--os-username` as a
   ``nova`` option, or set it as an environment variable. To set the user
   name, password, and tenant as environment variables, use:

   ..  code:: console

       $ export OS_USERNAME=joecool
       $ export OS_PASSWORD=coolword
       $ export OS_TENANT_NAME=coolu

#. The Identity service will give you an authentication endpoint,
   which Compute recognizes as ``OS_AUTH_URL``:

   .. code:: console

      $ export OS_AUTH_URL=http://hostname:5000/v2.0
      $ export NOVA_VERSION=1.1

.. _section_euca2ools:

Managing the cloud with euca2ools
---------------------------------

The ``euca2ools`` command-line tool provides a command line interface to
EC2 API calls. For more information about ``euca2ools``, see
`http://open.eucalyptus.com/wiki/Euca2oolsGuide\_v1.3 <http://open.eucalyptus.com/wiki/Euca2oolsGuide_v1.3>`__.

.. TODOcommon/cli_nova_usage_statistics.rst

.. _section_manage-logs:

Logging
~~~~~~~

Logging module
--------------

Logging behavior can be changed by creating a configuration file. To
specify the configuration file, add this line to the
:file:`/etc/nova/nova.conf` file:

.. code:: ini

   log-config=/etc/nova/logging.conf

To change the logging level, add ``DEBUG``, ``INFO``, ``WARNING``, or
``ERROR`` as a parameter.

The logging configuration file is an INI-style configuration file, which
must contain a section called ``logger_nova``. This controls the
behavior of the logging facility in the ``nova-*`` services. For
example:

.. code:: ini

   [logger_nova]
   level = INFO
   handlers = stderr
   qualname = nova

This example sets the debugging level to ``INFO`` (which is less verbose
than the default ``DEBUG`` setting).

For more about the logging configuration syntax, including the
``handlers`` and ``quaname`` variables, see the
`Python documentation <http://docs.python.org/release/2.7/library/logging.html#configuration-file-format>`__
on logging configuration files.

For an example :file:`logging.conf` file with various defined handlers, see
the `OpenStack Configuration Reference <http://docs.openstack.org/kilo/config-reference/content/>`__.

Syslog
------

OpenStack Compute services can send logging information to syslog. This
is useful if you want to use rsyslog to forward logs to a remote
machine. Separately configure the Compute service (nova), the Identity
service (keystone), the Image service (glance), and, if you are using
it, the Block Storage service (cinder) to send log messages to syslog.
Open these configuration files:

-  :file:`/etc/nova/nova.conf`

-  :file:`/etc/keystone/keystone.conf`

-  :file:`/etc/glance/glance-api.conf`

-  :file:`/etc/glance/glance-registry.conf`

-  :file:`/etc/cinder/cinder.conf`

In each configuration file, add these lines:

.. code:: ini

    verbose = False
    debug = False
    use_syslog = True
    syslog_log_facility = LOG_LOCAL0

In addition to enabling syslog, these settings also turn off verbose and
debugging output from the log.

..  note::

    Although this example uses the same local facility for each service
    (``LOG_LOCAL0``, which corresponds to syslog facility ``LOCAL0``),
    we recommend that you configure a separate local facility for each
    service, as this provides better isolation and more flexibility. For
    example, you can capture logging information at different severity
    levels for different services. syslog allows you to define up to
    eight local facilities, ``LOCAL0, LOCAL1, ..., LOCAL7``. For more
    information, see the syslog documentation.

Rsyslog
-------

rsyslog is useful for setting up a centralized log server across
multiple machines. This section briefly describe the configuration to
set up an rsyslog server. A full treatment of rsyslog is beyond the
scope of this book. This section assumes rsyslog has already been
installed on your hosts (it is installed by default on most Linux
distributions).

This example provides a minimal configuration for :file:`/etc/rsyslog.conf`
on the log server host, which receives the log files

..  code:: console

    # provides TCP syslog reception
    $ModLoad imtcp
    $InputTCPServerRun 1024

Add a filter rule to :file:`/etc/rsyslog.conf` which looks for a host name.
This example uses COMPUTE_01 as the compute host name:

..  code:: ini

    :hostname, isequal, "COMPUTE_01" /mnt/rsyslog/logs/compute-01.log

On each compute host, create a file named
:file:`/etc/rsyslog.d/60-nova.conf`, with the following content:

..  code:: console

    # prevent debug from dnsmasq with the daemon.none parameter
    *.*;auth,authpriv.none,daemon.none,local0.none -/var/log/syslog
    # Specify a log level of ERROR
    local0.error    @@172.20.1.43:1024

Once you have created the file, restart the rsyslog service. Error-level
log messages on the compute hosts should now be sent to the log server.

Serial console
--------------

The serial console provides a way to examine kernel output and other
system messages during troubleshooting if the instance lacks network
connectivity.

OpenStack Icehouse and earlier supports read-only access using the
serial console using the ``os-GetSerialOutput`` server action. Most
cloud images enable this feature by default. For more information, see
troubleshooting Compute.

.. TODO :ref:`section_compute-empty-log-output`_ added here.

OpenStack Juno and later supports read-write access using the serial
console using the ``os-GetSerialConsole`` server action. This feature
also requires a websocket client to access the serial console.

**Configuring read-write serial console access**

#. On a compute node, edit the :file:`/etc/nova/nova.conf` file:

   In the ``[serial_console]`` section, enable the serial console:

   ..  code:: ini

       [serial_console]
       ...
       enabled = true

#. In the ``[serial_console]`` section, configure the serial console proxy
   similar to graphical console proxies:

   ..  code:: ini

       [serial_console]
       ...
       base_url = ws://controller:6083/
       listen = 0.0.0.0
       proxyclient_address = MANAGEMENT_INTERFACE_IP_ADDRESS

   The ``base_url`` option specifies the base URL that clients receive from
   the API upon requesting a serial console. Typically, this refers to the
   host name of the controller node.

   The ``listen`` option specifies the network interface nova-compute
   should listen on for virtual console connections. Typically, 0.0.0.0
   will enable listening on all interfaces.

   The ``proxyclient_address`` option specifies which network interface the
   proxy should connect to. Typically, this refers to the IP address of the
   management interface.

   When you enable read-write serial console access, Compute will add
   serial console information to the Libvirt XML file for the instance. For
   example:

   ..  code:: xml

       <console type='tcp'>
         <source mode='bind' host='127.0.0.1' service='10000'/>
         <protocol type='raw'/>
         <target type='serial' port='0'/>
         <alias name='serial0'/>
       </console>

**Accessing the serial console on an instance**

#. Use the :command:`nova get-serial-proxy` command to retrieve the websocket
   URL for the serial console on the instance:

   .. code: console

      $ nova get-serial-proxy INSTANCE_NAME

   .. list-table::
      :header-rows: 0
      :widths: 9 65

      * - Type
        - Url
      * - serial
        - ws://127.0.0.1:6083/?token=18510769-71ad-4e5a-8348-4218b5613b3d

   Alternatively, use the API directly:

   .. code:: console

      $ curl -i 'http://<controller>:8774/v2/<tenant_uuid>/servers/
        <instance_uuid>/action' \
        -X POST \
        -H "Accept: application/json" \
        -H "Content-Type: application/json" \
        -H "X-Auth-Project-Id: <project_id>" \
        -H "X-Auth-Token: <auth_token>" \
        -d '{"os-getSerialConsole": {"type": "serial"}}'

#. Use Python websocket with the URL to generate ``.send``, ``.recv``, and
   ``.fileno`` methods for serial console access. For example:

   ..  code:: python

       import websocket
       ws = websocket.create_connection(
           'ws://127.0.0.1:6083/?token=18510769-71ad-4e5a-8348-4218b5613b3d',
           subprotocols=['binary', 'base64'])

Alternatively, use a `Python websocket client <https://github.com/larsks/novaconsole/>`__.

.. note::

   When you enable the serial console, typical instance logging using
   the :command:`nova console-log` command is disabled. Kernel output
   and other system messages will not be visible unless you are
   actively viewing the serial console.

.. _root-wrap-reference:

Secure with rootwrap
~~~~~~~~~~~~~~~~~~~~

Rootwrap allows unprivileged users to safely run Compute actions as the
root user. Compute previously used :command:`sudo` for this purpose, but this
was difficult to maintain, and did not allow advanced filters. The
:command:`rootwrap` command replaces :command:`sudo` for Compute.

To use rootwrap, prefix the Compute command with :command:`nova-rootwrap`. For
example:

..  code:: console

    $ sudo nova-rootwrap /etc/nova/rootwrap.conf command

A generic ``sudoers`` entry lets the Compute user run :command:`nova-rootwrap`
as root. The :command:`nova-rootwrap` code looks for filter definition
directories in its configuration file, and loads command filters from
them. It then checks if the command requested by Compute matches one of
those filters and, if so, executes the command (as root). If no filter
matches, it denies the request.

..  note::

    Be aware of issues with using NFS and root-owned files. The NFS
    share must be configured with the ``no_root_squash`` option enabled,
    in order for rootwrap to work correctly.

Rootwrap is fully controlled by the root user. The root user
owns the sudoers entry which allows Compute to run a specific
rootwrap executable as root, and only with a specific
configuration file (which should also be owned by root).
The :command:`nova-rootwrap` command imports the Python
modules it needs from a cleaned, system-default PYTHONPATH.
The root-owned configuration file points to root-owned
filter definition directories, which contain root-owned
filters definition files. This chain ensures that the Compute
user itself is not in control of the configuration or modules
used by the :command:`nova-rootwrap` executable.

Rootwrap is configured using the :file:`rootwrap.conf` file. Because
it's in the trusted security path, it must be owned and writable
by only the root user. The file's location is specified in both
the sudoers entry and in the :file:`nova.conf` configuration file
with the ``rootwrap_config=entry`` parameter.

The :file:`rootwrap.conf` file uses an INI file format with these
sections and parameters:

.. list-table:: rootwrap.conf configuration options
   :widths: 64 31

   * - Configuration option=Default value
     - (Type) Description
   * - [DEFAULT]
       filters\_path=/etc/nova/rootwrap.d,/usr/share/nova/rootwrap
     - (ListOpt) Comma-separated list of directories
       containing filter definition files.
       Defines where rootwrap filters are stored.
       Directories defined on this line should all
       exist, and be owned and writable only by the
       root user.

If the root wrapper is not performing correctly, you can add a
workaround option into the :file:`nova.conf` configuration file. This
workaround re-configures the root wrapper configuration to fall back to
running commands as sudo, and is a Kilo release feature.

Including this workaround in your configuration file safeguards your
environment from issues that can impair root wrapper performance. Tool
changes that have impacted
`Python Build Reasonableness (PBR) <https://git.openstack.org/cgit/openstack-dev/pbr/>`__
for example, are a known issue that affects root wrapper performance.

To set up this workaround, configure the ``disable_rootwrap`` option in
the ``[workaround]`` section of the :file:`nova.conf` configuration file.

The filters definition files contain lists of filters that rootwrap will
use to allow or deny a specific command. They are generally suffixed by
``.filters`` . Since they are in the trusted security path, they need to
be owned and writable only by the root user. Their location is specified
in the :file:`rootwrap.conf` file.

Filter definition files use an INI file format with a ``[Filters]``
section and several lines, each with a unique parameter name, which
should be different for each filter you define:

.. list-table:: filters configuration options
   :widths: 72 39


   * - Configuration option=Default value
     - (Type) Description
   * - [Filters]
       filter\_name=kpartx: CommandFilter, /sbin/kpartx, root
     - (ListOpt) Comma-separated list containing the filter class to
       use, followed by the Filter arguments (which vary depending
       on the Filter class selected).

.. _section_configuring-compute-migrations:

Configure migrations
~~~~~~~~~~~~~~~~~~~~

.. :ref:`_configuring-migrations-kvm-libvirt`
.. :ref:`_configuring-migrations-xenserver`

..  note::

    Only cloud administrators can perform live migrations. If your cloud
    is configured to use cells, you can perform live migration within
    but not between cells.

Migration enables an administrator to move a virtual-machine instance
from one compute host to another. This feature is useful when a compute
host requires maintenance. Migration can also be useful to redistribute
the load when many VM instances are running on a specific physical
machine.

The migration types are:

-  **Non-live migration** (sometimes referred to simply as 'migration').
   The instance is shut down for a period of time to be moved to another
   hypervisor. In this case, the instance recognizes that it was
   rebooted.

-  **Live migration** (or 'true live migration'). Almost no instance
   downtime. Useful when the instances must be kept running during the
   migration. The different types of live migration are:

   -  **Shared storage-based live migration**. Both hypervisors have
      access to shared storage.

   -  **Block live migration**. No shared storage is required.
      Incompatible with read-only devices such as CD-ROMs and
      `Configuration Drive (config\_drive) <http://docs.openstack.org/user-guide/cli_config_drive.html>`_.

   -  **Volume-backed live migration**. Instances are backed by volumes
      rather than ephemeral disk, no shared storage is required, and
      migration is supported (currently only available for libvirt-based
      hypervisors).

The following sections describe how to configure your hosts and compute
nodes for migrations by using the KVM and XenServer hypervisors.

.. _configuring-migrations-kvm-libvirt:

KVM-Libvirt
-----------

.. :ref:`_configuring-migrations-kvm-shared-storage`
.. :ref:`_configuring-migrations-kvm-block-migration`

.. _configuring-migrations-kvm-shared-storage:

Shared storage
^^^^^^^^^^^^^^

.. :ref:`_section_example-compute-install`
.. :ref:`_true-live-migration-kvm-libvirt`

**Prerequisites**

-  **Hypervisor:** KVM with libvirt

-  **Shared storage:** :file:`NOVA-INST-DIR/instances/` (for example,
   :file:`/var/lib/nova/instances`) has to be mounted by shared storage.
   This guide uses NFS but other options, including the
   `OpenStack Gluster Connector <http://gluster.org/community/documentation//index.php/OSConnect>`_
   are available.

-  **Instances:** Instance can be migrated with iSCSI-based volumes.

.. note::

    -  Because the Compute service does not use the libvirt live
       migration functionality by default, guests are suspended before
       migration and might experience several minutes of downtime. For
       details, see :ref:Enabling True Live Migration.

    -  This guide assumes the default value for ``instances_path`` in
       your :file:`nova.conf` file (:file:`NOVA-INST-DIR/instances`). If you
       have changed the ``state_path`` or ``instances_path`` variables,
       modify the commands accordingly.

    -  You must specify ``vncserver_listen=0.0.0.0`` or live migration
       will not work correctly.

    -  You must specify the ``instances_path`` in each node that runs
       nova-compute. The mount point for ``instances_path`` must be the
       same value for each node, or live migration will not work
       correctly.

.. _section_example-compute-install:

Example Compute installation environment
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-  Prepare at least three servers. In this example, we refer to the
   servers as ``HostA``, ``HostB``, and ``HostC``:

   -  ``HostA`` is the Cloud Controller, and should run these services:
      nova-api, nova-scheduler, ``nova-network``, cinder-volume, and
      ``nova-objectstore``.

   -  ``HostB`` and ``HostC`` are the compute nodes that run
      nova-compute.

   Ensure that ``NOVA-INST-DIR`` (set with ``state_path`` in the
   :file:`nova.conf` file) is the same on all hosts.

-  In this example, ``HostA`` is the NFSv4 server that exports
   ``NOVA-INST-DIR/instances`` directory. ``HostB`` and ``HostC`` are
   NFSv4 clients that mount ``HostA``.

**Configuring your system**

#. Configure your DNS or ``/etc/hosts`` and ensure it is consistent across
   all hosts. Make sure that the three hosts can perform name resolution
   with each other. As a test, use the :command:`ping` command to ping each host
   from one another:

   .. code:: console

      $ ping HostA
      $ ping HostB
      $ ping HostC

#. Ensure that the UID and GID of your Compute and libvirt users are
   identical between each of your servers. This ensures that the
   permissions on the NFS mount works correctly.

#. Export ``NOVA-INST-DIR/instances`` from ``HostA``, and ensure it is
   readable and writable by the Compute user on ``HostB`` and ``HostC``.

   For more information, see: `SettingUpNFSHowTo <https://help.ubuntu.com/community/SettingUpNFSHowTo>`_
   or `CentOS/Red Hat: Setup NFS v4.0 File Server <http://www.cyberciti.biz/faq/centos-fedora-rhel-nfs-v4-configuration/>`_

#. Configure the NFS server at ``HostA`` by adding the following line to
   the :file:`/etc/exports` file:

   .. code:: ini

      NOVA-INST-DIR/instances HostA/255.255.0.0(rw,sync,fsid=0,no_root_squash)

   Change the subnet mask (``255.255.0.0``) to the appropriate value to
   include the IP addresses of ``HostB`` and ``HostC``. Then restart the
   NFS server:

   .. code:: console

      # /etc/init.d/nfs-kernel-server restart
      # /etc/init.d/idmapd restart

#. On both compute nodes, enable the 'execute/search' bit on your shared
   directory to allow qemu to be able to use the images within the
   directories. On all hosts, run the following command:

   .. code:: console

      $ chmod o+x NOVA-INST-DIR/instances

#. Configure NFS on ``HostB`` and ``HostC`` by adding the following line to
   the :file:`/etc/fstab` file

   .. code:: console

      HostA:/ /NOVA-INST-DIR/instances nfs4 defaults 0 0

   Ensure that you can mount the exported directory

   .. code:: console

      $ mount -a -v

   Check that ``HostA`` can see the :file:`NOVA-INST-DIR/instances/`
   directory

   .. code:: console

      $ ls -ld NOVA-INST-DIR/instances/
      drwxr-xr-x 2 nova nova 4096 2012-05-19 14:34 nova-install-dir/instances/

   Perform the same check on ``HostB`` and ``HostC``, paying special
   attention to the permissions (Compute should be able to write)

   .. code-block:: console
      :linenos:

      $ ls -ld NOVA-INST-DIR/instances/
      drwxr-xr-x 2 nova nova 4096 2012-05-07 14:34 nova-install-dir/instances/

      $ df -k
      Filesystem           1K-blocks      Used Available Use% Mounted on
      /dev/sda1            921514972   4180880 870523828   1% /
      none                  16498340      1228  16497112   1% /dev
      none                  16502856         0  16502856   0% /dev/shm
      none                  16502856       368  16502488   1% /var/run
      none                  16502856         0  16502856   0% /var/lock
      none                  16502856         0  16502856   0% /lib/init/rw
      HostA:               921515008 101921792 772783104  12% /var/lib/nova/instances  ( <--- this line is important.)

#. Update the libvirt configurations so that the calls can be made
   securely. These methods enable remote access over TCP and are not
   documented here.

   -  SSH tunnel to libvirtd's UNIX socket

   -  libvirtd TCP socket, with GSSAPI/Kerberos for auth+data encryption

   -  libvirtd TCP socket, with TLS for encryption and x509 client certs
      for authentication

   -  libvirtd TCP socket, with TLS for encryption and Kerberos for
      authentication

   Restart libvirt. After you run the command, ensure that libvirt is
   successfully restarted

   .. code:: console

      # stop libvirt-bin && start libvirt-bin
      $ ps -ef | grep libvirt
      root 1145 1 0 Nov27 ? 00:00:03 /usr/sbin/libvirtd -d -l\

#. Configure your firewall to allow libvirt to communicate between nodes.
   By default, libvirt listens on TCP port 16509, and an ephemeral TCP
   range from 49152 to 49261 is used for the KVM communications. Based on
   the secure remote access TCP configuration you chose, be careful which
   ports you open, and always understand who has access. For information
   about ports that are used with libvirt,
   see `the libvirt documentation <http://libvirt.org/remote.html#Remote_libvirtd_configuration>`_.

#. You can now configure options for live migration. In most cases, you
   will not need to configure any options. The following chart is for
   advanced users only.

.. TODO :include :: /../../common/tables/nova-livemigration.xml/

.. _true-live-migration-kvm-libvirt:

Enabling true live migration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Prior to the Kilo release, the Compute service did not use the libvirt
live migration function by default. To enable this function, add the
following line to the ``[libvirt]`` section of the :file:`nova.conf` file:

.. code:: ini

   live_migration_flag=VIR_MIGRATE_UNDEFINE_SOURCE,VIR_MIGRATE_PEER2PEER,VIR_MIGRATE_LIVE,VIR_MIGRATE_TUNNELLED

On versions older than Kilo, the Compute service does not use libvirt's
live migration by default because there is a risk that the migration
process will never end. This can happen if the guest operating system
uses blocks on the disk faster than they can be migrated.

.. _configuring-migrations-kvm-block-migration:

Block Migration
^^^^^^^^^^^^^^^

Configuring KVM for block migration is exactly the same as the above
configuration in :ref:`configuring-migrations-kvm-shared-storage`
the section called shared storage, except that ``NOVA-INST-DIR/instances``
is local to each host rather than shared. No NFS client or server
configuration is required.

..  note::

    -  To use block migration, you must use the :option:`--block-migrate`
       parameter with the live migration command.

    -  Block migration is incompatible with read-only devices such as
       CD-ROMs and `Configuration Drive (config_drive) <http://docs.openstack.org/user-guide/cli_config_drive.html>`_.

    -  Since the ephemeral drives are copied over the network in block
       migration, migrations of instances with heavy I/O loads may never
       complete if the drives are writing faster than the data can be
       copied over the network.

.. _configuring-migrations-xenserver:

XenServer
---------

.. :ref:Shared Storage
.. :ref:Block migration

.. _configuring-migrations-xenserver-shared-storage:

Shared storage
^^^^^^^^^^^^^^

**Prerequisites**

-  **Compatible XenServer hypervisors**. For more information, see the
   `Requirements for Creating Resource Pools <http://docs.vmd.citrix.com/XenServer/6.0.0/1.0/en_gb/reference.html#pooling_homogeneity_requirements>`_ section of the XenServer
   Administrator's Guide.

-  **Shared storage**. An NFS export, visible to all XenServer hosts.

   ..  note::

       For the supported NFS versions, see the
       `NFS VHD <http://docs.vmd.citrix.com/XenServer/6.0.0/1.0/en_gb/reference.html#id1002701>`_
       section of the XenServer Administrator's Guide.

To use shared storage live migration with XenServer hypervisors, the
hosts must be joined to a XenServer pool. To create that pool, a host
aggregate must be created with specific metadata. This metadata is used
by the XAPI plug-ins to establish the pool.

**Using shared storage live migrations with XenServer Hypervisors**

#. Add an NFS VHD storage to your master XenServer, and set it as the
   default storage repository. For more information, see NFS VHD in the
   XenServer Administrator's Guide.

#. Configure all compute nodes to use the default storage repository
   (``sr``) for pool operations. Add this line to your :file:`nova.conf`
   configuration files on all compute nodes:

   .. code:: ini

      sr_matching_filter=default-sr:true

#. Create a host aggregate. This command creates the aggregate, and then
   displays a table that contains the ID of the new aggregate

   .. code:: console

      $ nova aggregate-create POOL_NAME AVAILABILITY_ZONE

   Add metadata to the aggregate, to mark it as a hypervisor pool

   .. code:: console

      $ nova aggregate-set-metadata AGGREGATE_ID hypervisor_pool=true

      $ nova aggregate-set-metadata AGGREGATE_ID operational_state=created

   Make the first compute node part of that aggregate

   .. code:: console

      $ nova aggregate-add-host AGGREGATE_ID MASTER_COMPUTE_NAME

   The host is now part of a XenServer pool.

#. Add hosts to the pool

   .. code:: console

      $ nova aggregate-add-host AGGREGATE_ID COMPUTE_HOST_NAME

   .. note::

      The added compute node and the host will shut down to join the host
      to the XenServer pool. The operation will fail if any server other
      than the compute node is running or suspended on the host.

.. _configuring-migrations-xenserver-block-migration:

Block migration
^^^^^^^^^^^^^^^

-  **Compatible XenServer hypervisors**.
   The hypervisors must support the Storage XenMotion feature.
   See your XenServer manual to make sure your edition
   has this feature.

   .. note::

      -  To use block migration, you must use the :option:`--block-migrate`
         parameter with the live migration command.

      -  Block migration works only with EXT local storage storage
         repositories, and the server must not have any volumes attached.


.. _section_live-migration-usage:

Migrate instances
~~~~~~~~~~~~~~~~~

This section discusses how to migrate running instances from one
OpenStack Compute server to another OpenStack Compute server.

Before starting a migration, review the Configure migrations section.

.. `_section_configuring-compute-migrations`:ref:

    .. note::

       Although the :command:`nova` command is called :command:`live-migration`,
       under the default Compute configuration options, the instances
       are suspended before migration. For more information, see
       `Configure migrations <http://docs.openstack.org/kilo/config-reference/content/list-of-compute-config-options.html>`_.
       in the OpenStack Configuration Reference.

**Migrating instances**

#. Check the ID of the instance to be migrated:

   ..  code:: console

       $ nova list

   ..  list-table::
       :header-rows: 1
       :widths: 46 12 13 22

       * - ID
         - Name
         - Status
         - Networks
       * - d1df1b5a-70c4-4fed-98b7-423362f2c47c
         - vm1
         - ACTIVE
         - private=a.b.c.d
       * - d693db9e-a7cf-45ef-a7c9-b3ecb5f22645
         - vm2
         - ACTIVE
         - private=e.f.g.h

#. Check the information associated with the instance. In this example,
   ``vm1`` is running on ``HostB``:

   ..  code:: console

       $ nova show d1df1b5a-70c4-4fed-98b7-423362f2c47c

   ..  list-table::
       :widths: 30 45
       :header-rows: 1

       * - Property
         - Value
       * - ...

           OS-EXT-SRV-ATTR:host

           ...

           flavor

           id


           name

           private network

           status

           ...


         - ...

           HostB

           ...

           m1.tiny

           d1df1b5a-70c4-4fed-98b7-423362f2c47c

           vm1

           a.b.c.d

           ACTIVE

           ...

#. Select the compute node the instance will be migrated to. In this
   example, we will migrate the instance to ``HostC``, because
   nova-compute is running on it:

   .. list-table:: nova service-list
      :widths: 20 9 12 11 9 30 24
      :header-rows: 1

      * - Binary
        - Host
        - Zone
        - Status
        - State
        - Updated_at
        - Disabled Reason
      * - nova-consoleauth
        - HostA
        - internal
        - enabled
        - up
        - 2014-03-25T10:33:25.000000
        - -
      * - nova-scheduler
        - HostA
        - internal
        - enabled
        - up
        - 2014-03-25T10:33:25.000000
        - -
      * - nova-conductor
        - HostA
        - internal
        - enabled
        - up
        - 2014-03-25T10:33:27.000000
        - -
      * - nova-compute
        - HostB
        - nova
        - enabled
        - up
        - 2014-03-25T10:33:31.000000
        - -
      * - nova-compute
        - HostC
        - nova
        - enabled
        - up
        - 2014-03-25T10:33:31.000000
        - -
      * - nova-cert
        - HostA
        - internal
        - enabled
        - up
        - 2014-03-25T10:33:31.000000
        - -

#. Check that ``HostC`` has enough resources for migration:

   ..  code:: console

       # nova host-describe HostC

   ..  list-table::
       :header-rows: 1
       :widths: 14 14 7 15 12

       * - HOST
         - PROJECT
         - cpu
         - memory_mb
         - disk_bg
       * - HostC
         - HostC
         - HostC
         - HostC
         - HostC
       * - (total)
         - (used_now)
         - (used_max)
         - p1
         - p2
       * - 32232
         - 21284
         - 21284
         - 21284
         - 21284
       * - 878
         - 442
         - 422
         - 422
         - 422

   -  ``cpu``: Number of CPUs

   -  ``memory_mb``: Total amount of memory, in MB

   -  ``disk_gb``: Total amount of space for NOVA-INST-DIR/instances, in GB

   In this table, the first row shows the total amount of resources
   available on the physical server. The second line shows the currently
   used resources. The third line shows the maximum used resources. The
   fourth line and below shows the resources available for each project.

#. Migrate the instances using the :command:`nova live-migration` command:

   .. code:: console

      $ nova live-migration SERVER HOST_NAME

   In this example, SERVER can be the ID or name of the instance. Another
   example:

   .. code:: console

      $ nova live-migration d1df1b5a-70c4-4fed-98b7-423362f2c47c HostC
      Migration of d1df1b5a-70c4-4fed-98b7-423362f2c47c initiated.

..   warning::

     When using live migration to move workloads between
     Icehouse and Juno compute nodes, it may cause data loss
     because libvirt live migration with shared block storage
     was buggy (potential loss of data) before version 3.32.
     This issue can be solved when we upgrade to RPC API version 4.0.

#. Check the instances have been migrated successfully, using
   :command:`nova list`. If instances are still running on ``HostB``,
   check the log files at :file:`src/dest` for nova-compute and nova-scheduler)
   to determine why.

.. _configuring-compute-service-groups:

Configure Compute service groups
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Compute service must know the status of each compute node to
effectively manage and use them. This can include events like a user
launching a new VM, the scheduler sending a request to a live node, or a
query to the ServiceGroup API to determine if a node is live.

When a compute worker running the nova-compute daemon starts, it calls
the join API to join the compute group. Any service (such as the
scheduler) can query the group's membership and the status of its nodes.
Internally, the ServiceGroup client driver automatically updates the
compute worker status.

.. _database-servicegroup-driver:

Database ServiceGroup driver
----------------------------

By default, Compute uses the database driver to track if a node is live.
In a compute worker, this driver periodically sends a ``db update``
command to the database, saying “I'm OK” with a timestamp. Compute uses
a pre-defined timeout (``service_down_time``) to determine if a node is
dead.

The driver has limitations, which can be problematic depending on your
environment. If a lot of compute worker nodes need to be checked, the
database can be put under heavy load, which can cause the timeout to
trigger, and a live node could incorrectly be considered dead. By
default, the timeout is 60 seconds. Reducing the timeout value can help
in this situation, but you must also make the database update more
frequently, which again increases the database workload.

The database contains data that is both transient (such as whether the
node is alive) and persistent (such as entries for VM owners). With the
ServiceGroup abstraction, Compute can treat each type separately.

.. _zookeeper-servicegroup-driver:

ZooKeeper ServiceGroup driver
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The ZooKeeper ServiceGroup driver works by using ZooKeeper ephemeral
nodes. ZooKeeper, unlike databases, is a distributed system, with its
load divided among several servers. On a compute worker node, the driver
can establish a ZooKeeper session, then create an ephemeral znode in the
group directory. Ephemeral znodes have the same lifespan as the session.
If the worker node or the nova-compute daemon crashes, or a network
partition is in place between the worker and the ZooKeeper server
quorums, the ephemeral znodes are removed automatically. The driver
can be given group membership by running the :command:`ls` command in the
group directory.

The ZooKeeper driver requires the ZooKeeper servers and client
libraries. Setting up ZooKeeper servers is outside the scope of this
guide (for more information, see `Apache Zookeeper <http://zookeeper.apache.org/>`_). These client-side
Python libraries must be installed on every compute node:

**python-zookeeper**

  The official Zookeeper Python binding

**evzookeeper**

  This library makes the binding work with the eventlet threading model.

This example assumes the ZooKeeper server addresses and ports are
``192.168.2.1:2181``, ``192.168.2.2:2181``, and ``192.168.2.3:2181``.

These values in the :file:`/etc/nova/nova.conf` file are required on every
node for the ZooKeeper driver:

.. code:: ini

   # Driver for the ServiceGroup service
   servicegroup_driver="zk"

   [zookeeper]
   address="192.168.2.1:2181,192.168.2.2:2181,192.168.2.3:2181"

To customize the Compute Service groups, use these configuration option
settings:

.. TODO ../../common/tables/nova-zookeeper.xml

.. _memcache-servicegroup-driver:

Memcache ServiceGroup driver
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The memcache ServiceGroup driver uses memcached, a distributed memory
object caching system that is used to increase site performance. For
more details, see `memcached.org <http://memcached.org/>`_.

To use the memcache driver, you must install memcached. You might
already have it installed, as the same driver is also used for the
OpenStack Object Storage and OpenStack dashboard. If you need to install
memcached, see the instructions in the `OpenStack Installation Guide <http://docs.openstack.org/>`_.

These values in the :file:`/etc/nova/nova.conf` file are required on every
node for the memcache driver:

.. code:: ini

    # Driver for the ServiceGroup service
    servicegroup_driver="mc"

    # Memcached servers. Use either a list of memcached servers to use for
    caching (list value),
    # or "<None>" for in-process caching (default).
    memcached_servers=<None>

    # Timeout; maximum time since last check-in for up service
    (integer value).
    # Helps to define whether a node is dead
    service_down_time=60

.. _section-compute-security:

Security hardening
~~~~~~~~~~~~~~~~~~

OpenStack Compute can be integrated with various third-party
technologies to increase security. For more information, see the
`OpenStack Security Guide <http://docs.openstack.org/sec/>`_.

Trusted compute pools
---------------------

Administrators can designate a group of compute hosts as trusted using
trusted compute pools. The trusted hosts use hardware-based security
features, such as the Intel Trusted Execution Technology (TXT), to
provide an additional level of security. Combined with an external
stand-alone, web-based remote attestation server, cloud providers can
ensure that the compute node runs only software with verified
measurements and can ensure a secure cloud stack.

Trusted compute pools provide the ability for cloud subscribers to
request services run only on verified compute nodes.

The remote attestation server performs node verification like this:

1. Compute nodes boot with Intel TXT technology enabled.

2. The compute node BIOS, hypervisor, and operating system are measured.

3. When the attestation server challenges the compute node, the measured
   data is sent to the attestation server.

4. The attestation server verifies the measurements against a known good
   database to determine node trustworthiness.

A description of how to set up an attestation service is beyond the
scope of this document. For an open source project that you can use to
implement an attestation service, see the `Open
Attestation <https://github.com/OpenAttestation/OpenAttestation>`__
project.

|image0|

**Configuring Compute to use trusted compute pools**

#. Enable scheduling support for trusted compute pools by adding these
   lines to the ``DEFAULT`` section of the :file:`/etc/nova/nova.conf` file:

   .. code:: ini

      [DEFAULT]
      compute_scheduler_driver=nova.scheduler.filter_scheduler.FilterScheduler
      scheduler_available_filters=nova.scheduler.filters.all_filters
      scheduler_default_filters=AvailabilityZoneFilter,RamFilter,ComputeFilter,TrustedFilter

#. Specify the connection information for your attestation service by
   adding these lines to the ``trusted_computing`` section of the
   :file:`/etc/nova/nova.conf` file:

   .. code-block:: ini
      :linenos:

      [trusted_computing]
      attestation_server = 10.1.71.206
      attestation_port = 8443
      # If using OAT v2.0 after, use this port:
      # attestation_port = 8181
      attestation_server_ca_file = /etc/nova/ssl.10.1.71.206.crt
      # If using OAT v1.5, use this api_url:
      attestation_api_url = /AttestationService/resources
      # If using OAT pre-v1.5, use this api_url:
      # attestation_api_url = /OpenAttestationWebServices/V1.0
      attestation_auth_blob = i-am-openstack

   In this example:

   server
     Host name or IP address of the host that runs the attestation
     service

   port
     HTTPS port for the attestation service

   server_ca_file
     Certificate file used to verify the attestation server's identity

   api_url
     The attestation service's URL path

   auth_blob
     An authentication blob, required by the attestation service.

#. Save the file, and restart the nova-compute and nova-scheduler services
   to pick up the changes.

To customize the trusted compute pools, use these configuration option
settings:

.. list-table:: Description of trusted computing configuration options
   :header-rows: 2

   * - Configuration option = Default value
     - Description
   * - [trusted_computing]
     -
   * - attestation_api_url = /OpenAttestationWebServices/V1.0
     - (StrOpt) Attestation web API URL
   * - attestation_auth_blob = None
     - (StrOpt) Attestation authorization blob - must change
   * - attestation_auth_timeout = 60
     - (IntOpt) Attestation status cache valid period length
   * - attestation_insecure_ssl = False
     - (BoolOpt) Disable SSL cert verification for Attestation service
   * - attestation_port = 8443
     - (StrOpt) Attestation server port
   * - attestation_server = None
     - (StrOpt) Attestation server HTTP
   * - attestation_server_ca_file = None
     - (StrOpt) Attestation server Cert file for Identity verification

**Specifying trusted flavors**

#. Flavors can be designated as trusted using the ``nova flavor-key set``
   command. In this example, the ``m1.tiny`` flavor is being set as
   trusted:

   .. code:: console

      $ nova flavor-key m1.tiny set trust:trusted_host=trusted

#. You can request that your instance is run on a trusted host by
   specifying a trusted flavor when booting the instance:

   .. code:: console

      $ nova boot --flavor m1.tiny --key_name myKeypairName --image myImageID newInstanceName

|Trusted compute pool|

.. |image0| image:: ../../common/figures/OpenStackTrustedComputePool1.png
.. |Trusted compute pool| image:: ../../common/figures/OpenStackTrustedComputePool2.png


Encrypt Compute metadata traffic
--------------------------------

**Enabling SSL encryption**

OpenStack supports encrypting Compute metadata traffic with HTTPS.
Enable SSL encryption in the :file:`metadata_agent.ini` file.

#. Enable the HTTPS protocol::

    nova_metadata_protocol = https

#. Determine whether insecure SSL connections are accepted for Compute
   metadata server requests. The default value is ``False``::

    nova_metadata_insecure = False

#. Specify the path to the client certificate::

    nova_client_cert = PATH_TO_CERT

#. Specify the path to the private key::

    nova_client_priv_key = PATH_TO_KEY

.. _section_nova-compute-node-down:

Recover from a failed compute node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If Compute is deployed with a shared file system, and a node fails,
there are several methods to quickly recover from the failure. This
section discusses manual recovery.

.. TODO ../../common/section_cli_nova_evacuate.xml

.. _nova-compute-node-down-manual-recovery:

Manual Recovery
---------------

To recover a KVM or libvirt compute node, see
the section called :ref:`nova-compute-node-down-manual-recovery`. For
all other hypervisors, use this procedure:

**Recovering from a failed compute node manually**

#. Identify the VMs on the affected hosts. To do this, you can use a
   combination of :command:`nova list` and :command:`nova show` or
   :command:`euca-describe-instances`. For example, this command displays
   information about instance i-000015b9 that is running on node np-rcc54:

   ..  code:: console

       $ euca-describe-instances
       i-000015b9 at3-ui02 running nectarkey (376, np-rcc54) 0 m1.xxlarge 2012-06-19T00:48:11.000Z 115.146.93.60

#. Query the Compute database to check the status of the host. This example
   converts an EC2 API instance ID into an OpenStack ID. If you use the
   :command:`nova` commands, you can substitute the ID directly (the output in
   this example has been truncated):

   .. code:: ini

      mysql> SELECT * FROM instances WHERE id = CONV('15b9', 16, 10) \G;
      *************************** 1. row ***************************
      created_at: 2012-06-19 00:48:11
      updated_at: 2012-07-03 00:35:11
      deleted_at: NULL
      ...
      id: 5561
      ...
      power_state: 5
      vm_state: shutoff
      ...
      hostname: at3-ui02
      host: np-rcc54
      ...
      uuid: 3f57699a-e773-4650-a443-b4b37eed5a06
      ...
      task_state: NULL
      ...

   ..  note::

       The credentials for your database can be found in :file:`/etc/nova.conf`.

#. Decide which compute host the affected VM should be moved to, and run
   this database command to move the VM to the new host:

   .. code:: console

      mysql> UPDATE instances SET host = 'np-rcc46' WHERE uuid = '3f57699a-e773-4650-a443-b4b37eed5a06';

#. If you are using a hypervisor that relies on libvirt (such as KVM),
   update the :file:`libvirt.xml` file (found in
   :file:`/var/lib/nova/instances/[instance ID]`) with these changes:

   -  Change the ``DHCPSERVER`` value to the host IP address of the new
      compute host.

   -  Update the VNC IP to `0.0.0.0`

#. Reboot the VM:

   .. code:: console

      $ nova reboot 3f57699a-e773-4650-a443-b4b37eed5a06

The database update and :command:`nova reboot` command should be all that is
required to recover a VM from a failed host. However, if you continue to
have problems try recreating the network filter configuration using
``virsh``, restarting the Compute services, or updating the ``vm_state``
and ``power_state`` in the Compute database.

.. _section_nova-uid-mismatch:

Recover from a UID/GID mismatch
-------------------------------

In some cases, files on your compute node can end up using the wrong UID
or GID. This can happen when running OpenStack Compute, using a shared
file system, or with an automated configuration tool. This can cause a
number of problems, such as inability to perform live migrations, or
start virtual machines.

This procedure runs on nova-compute hosts, based on the KVM hypervisor:

#. Set the nova UID in :file:`/etc/passwd` to the same number on all hosts (for
   example, 112).

    .. note::

       Make sure you choose UIDs or GIDs that are not in use for other
       users or groups.

#. Set the ``libvirt-qemu`` UID in :file:`/etc/passwd` to the same number on
   all hosts (for example, 119).

#. Set the ``nova`` group in :file:`/etc/group` file to the same number on all
   hosts (for example, 120).

#. Set the ``libvirtd`` group in :file:`/etc/group` file to the same number on
   all hosts (for example, 119).

#. Stop the services on the compute node.

#. Change all the files owned by user or group nova. For example:

    .. code:: console

       # find / -uid 108 -exec chown nova {} \;
       # note the 108 here is the old nova UID before the change
       # find / -gid 120 -exec chgrp nova {} \;

#. Repeat all steps for the :file:`libvirt-qemu` files, if required.

#. Restart the services.

#. Run the :command:`find` command to verify that all files use the correct
   identifiers.

.. _section_nova-disaster-recovery-process:

Recover cloud after disaster
----------------------------

This section covers procedures for managing your cloud after a disaster,
and backing up persistent storage volumes. Backups are mandatory, even
outside of disaster scenarios.

For a definition of a disaster recovery plan (DRP), see
`http://en.wikipedia.org/wiki/Disaster\_Recovery\_Plan <http://en.wikipedia.org/wiki/Disaster_Recovery_Plan>`_.

A disaster could happen to several components of your architecture (for
example, a disk crash, network loss, or a power failure). In this
example, the following components are configured:

-  A cloud controller (nova-api, nova-objectstore, nova-network)

-  A compute node (nova-compute)

-  A storage area network (SAN) used by OpenStack Block Storage
   (cinder-volumes)

The worst disaster for a cloud is power loss, which applies to all three
components. Before a power loss:

-  Create an active iSCSI session from the SAN to the cloud controller
   (used for the ``cinder-volumes`` LVM's VG).

-  Create an active iSCSI session from the cloud controller to the compute
   node (managed by cinder-volume).

-  Create an iSCSI session for every volume (so 14 EBS volumes requires 14
   iSCSI sessions).

-  Create iptables or ebtables rules from the cloud controller to the
   compute node. This allows access from the cloud controller to the
   running instance.

-  Save the current state of the database, the current state of the running
   instances, and the attached volumes (mount point, volume ID, volume
   status, etc), at least from the cloud controller to the compute node.

After power is recovered and all hardware components have restarted:

-  The iSCSI session from the SAN to the cloud no longer exists.

-  The iSCSI session from the cloud controller to the compute node no
   longer exists.

-  The iptables and ebtables from the cloud controller to the compute
   node are recreated. This is because nova-network reapplies
   configurations on boot.

-  Instances are no longer running.

   Note that instances will not be lost, because neither ``destroy`` nor
   ``terminate`` was invoked. The files for the instances will remain on
   the compute node.

-  The database has not been updated.

**Begin recovery**

..  warning::

    Do not add any extra steps to this procedure, or perform the steps
    out of order.

#. Check the current relationship between the volume and its instance, so
   that you can recreate the attachment.

   This information can be found using the :command:`nova volume-list` command.
   Note that the ``nova`` client also includes the ability to get volume
   information from OpenStack Block Storage.

#. Update the database to clean the stalled state. Do this for every
   volume, using these queries:

   .. code:: console

      mysql> use cinder;
      mysql> update volumes set mountpoint=NULL;
      mysql> update volumes set status="available" where status <>"error_deleting";
      mysql> update volumes set attach_status="detached";
      mysql> update volumes set instance_id=0;

   Use :command:`nova volume-list` commands to list all volumes.

#. Restart the instances using the :command:`nova reboot INSTANCE` command.

   .. important::

      Some instances will completely reboot and become reachable, while
      some might stop at the plymouth stage. This is expected behavior, DO
      NOT reboot a second time.

      Instance state at this stage depends on whether you added an
      `/etc/fstab` entry for that volume. Images built with the
      cloud-init package remain in a ``pending`` state, while others skip
      the missing volume and start. This step is performed in order to ask
      Compute to reboot every instance, so that the stored state is
      preserved. It does not matter if not all instances come up
      successfully. For more information about cloud-init, see
      `help.ubuntu.com/community/CloudInit/ <https://help.ubuntu.com/community/CloudInit/>`__.

#. Reattach the volumes to their respective instances, if required, using
   the :command:`nova volume-attach` command. This example uses a file of
   listed volumes to reattach them:

   .. code:: bash

      #!/bin/bash

      while read line; do
          volume=`echo $line | $CUT -f 1 -d " "`
          instance=`echo $line | $CUT -f 2 -d " "`
          mount_point=`echo $line | $CUT -f 3 -d " "`
              echo "ATTACHING VOLUME FOR INSTANCE - $instance"
          nova volume-attach $instance $volume $mount_point
          sleep 2
      done < $volumes_tmp_file

   Instances that were stopped at the plymouth stage will now automatically
   continue booting and start normally. Instances that previously started
   successfully will now be able to see the volume.

#. Log in to the instances with SSH and reboot them.

   If some services depend on the volume, or if a volume has an entry in
   fstab, you should now be able to restart the instance. Restart directly
   from the instance itself, not through ``nova``:

   .. code:: console

      # shutdown -r now

   When you are planning for and performing a disaster recovery, follow
   these tips:

-  Use the ``errors=remount`` parameter in the :file:`fstab` file to prevent
   data corruption.

   This parameter will cause the system to disable the ability to write
   to the disk if it detects an I/O error. This configuration option
   should be added into the cinder-volume server (the one which performs
   the iSCSI connection to the SAN), and into the instances' :file:`fstab`
   files.

-  Do not add the entry for the SAN's disks to the cinder-volume's
   :file:`fstab` file.

   Some systems hang on that step, which means you could lose access to
   your cloud-controller. To re-run the session manually, run this
   command before performing the mount:

   .. code:: console

      # iscsiadm -m discovery -t st -p $SAN_IP $ iscsiadm -m node --target-name $IQN -p $SAN_IP -l

-  On your instances, if you have the whole ``/home/`` directory on the
   disk, leave a user's directory with the user's bash files and the
   :file:`authorized_keys` file (instead of emptying the ``/home`` directory
   and mapping the disk on it).

   This allows you to connect to the instance even without the volume
   attached, if you allow only connections through public keys.

If you want to script the disaster recovery plan (DRP), a bash script is
available from `https://github.com/Razique <https://github.com/Razique/BashStuff/blob/master/SYSTEMS/OpenStack/SCR_5006_V00_NUAC-OPENSTACK-DRP-OpenStack.sh>`_
which performs the following steps:

#. An array is created for instances and their attached volumes.

#. The MySQL database is updated.

#. All instances are restarted with euca2ools.

#. The volumes are reattached.

#. An SSH connection is performed into every instance using Compute
   credentials.

The script includes a ``test mode``, which allows you to perform that
whole sequence for only one instance.

To reproduce the power loss, connect to the compute node which runs that
instance and close the iSCSI session. Do not detach the volume using the
:command:`nova volume-detach` command, manually close the iSCSI session.
This example closes an iSCSI session with the number 15:

..  code:: console

    # iscsiadm -m session -u -r 15

Do not forget the ``-r`` flag. Otherwise, you will close all sessions.
