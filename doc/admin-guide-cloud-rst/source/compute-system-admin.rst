.. _section_compute-system-admin:

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

-  ``nova-api``: receives XML requests and sends them to the rest of the
   system. A WSGI app routes and authenticates requests. Supports the
   EC2 and OpenStack APIs. A :file:`nova.conf` configuration file is created
   when Compute is installed.

-  ``nova-cert``: manages certificates.

-  ``nova-compute``: manages virtual machines. Loads a Service object, and
   exposes the public methods on ComputeManager through a Remote
   Procedure Call (RPC).

-  ``nova-conductor``: provides database-access support for Compute nodes
   (thereby reducing security risks).10D0-9355

-  ``nova-consoleauth``: manages console authentication.

-  ``nova-objectstore``: a simple file-based storage system for images that
   replicates most of the S3 API. It can be replaced with OpenStack
   Image service and either a simple image manager or OpenStack Object
   Storage as the virtual machine image storage facility. It must exist
   on the same node as nova-compute.

-  ``nova-network``: manages floating and fixed IPs, DHCP, bridging and
   VLANs. Loads a Service object which exposes the public methods on one
   of the subclasses of NetworkManager. Different networking strategies
   are available by changing the ``network_manager`` configuration
   option to ``FlatManager``, ``FlatDHCPManager``, or ``VLANManager``
   (defaults to ``VLANManager`` if nothing is specified).

-  ``nova-scheduler``: dispatches requests for new virtual machines to the
   correct node.

-  ``nova-novncproxy``: provides a VNC proxy for browsers, allowing VNC
   consoles to access virtual machines.

..   note::

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

.. TODO/doc/admin-guide-cloud-rst/source/compute_config-firewalls.rst

.. _admin-password-injection:

Injecting the administrator password
------------------------------------

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

    Users can only :command:`ssh` to the instance by using the admin password
    if the virtual machine image is a Linux distribution, and it has
    been configured to allow users to :command:`ssh` as the root user. This is
    not the case for `Ubuntu cloud images`_ which, by default, does not
    allow users to :command:`ssh` to the root account.

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
----------------

System administrators can use ``nova`` client and ``Euca2ools`` commands
to manage their clouds.

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
-------

Logging module
^^^^^^^^^^^^^^

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

#. Use the ``nova get-serial-proxy`` command to retrieve the websocket URL
   for the serial console on the instance:

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

.. TODO/source/compute_rootwrap.rst - convert this file, add to toc tree
.. TODO/source/compute_configure_migrations.rst - convert this file - toc tree

.. _section_live-migration-usage:

Migrate instances
-----------------

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

.. TODO /source/common/compute_configure_console.rst

.. TODO /source/compute_configure_service_groups.rst
.. TODO /source/compute_security.rst
.. TODO /source/compute_recover_nodes.rst
