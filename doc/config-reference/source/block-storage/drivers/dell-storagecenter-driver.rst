===================================================
Dell Storage Center Fibre Channel and iSCSI drivers
===================================================

The Dell Storage Center volume driver interacts with configured Storage
Center arrays.

The Dell Storage Center driver manages Storage Center arrays through
the Dell Storage Manager (DSM). DSM connection settings and Storage
Center options are defined in the ``cinder.conf`` file.

Prerequisite: Dell Storage Manager 2015 R1 or later must be used.

Supported operations
~~~~~~~~~~~~~~~~~~~~

The Dell Storage Center volume driver provides the following Cinder
volume operations:

-  Create, delete, attach (map), and detach (unmap) volumes.
-  Create, list, and delete volume snapshots.
-  Create a volume from a snapshot.
-  Copy an image to a volume.
-  Copy a volume to an image.
-  Clone a volume.
-  Extend a volume.
-  Create, delete, list and update a consistency group.
-  Create, delete, and list consistency group snapshots.
-  Manage an existing volume.
-  Failover-host for replicated back ends.
-  Create a replication using Live Volume.

Extra spec options
~~~~~~~~~~~~~~~~~~

Volume type extra specs can be used to enable a variety of Dell Storage
Center options. Selecting Storage Profiles, Replay Profiles, enabling
replication, replication options including Live Volume and Active Replay
replication.

Storage Profiles control how Storage Center manages volume data. For a
given volume, the selected Storage Profile dictates which disk tier
accepts initial writes, as well as how data progression moves data
between tiers to balance performance and cost. Predefined Storage
Profiles are the most effective way to manage data in Storage Center.

By default, if no Storage Profile is specified in the volume extra
specs, the default Storage Profile for the user account configured for
the Block Storage driver is used. The extra spec key
``storagetype:storageprofile`` with the value of the name of the Storage
Profile on the Storage Center can be set to allow to use Storage
Profiles other than the default.

For ease of use from the command line, spaces in Storage Profile names
are ignored. As an example, here is how to define two volume types using
the ``High Priority`` and ``Low Priority`` Storage Profiles:

.. code-block:: console

    $ cinder type-create "GoldVolumeType"
    $ cinder type-key "GoldVolumeType" set storagetype:storageprofile=highpriority
    $ cinder type-create "BronzeVolumeType"
    $ cinder type-key "BronzeVolumeType" set storagetype:storageprofile=lowpriority

Replay Profiles control how often the Storage Center takes a replay of a
given volume and how long those replays are kept. The default profile is
the ``daily`` profile that sets the replay to occur once a day and to
persist for one week.

The extra spec key ``storagetype:replayprofiles`` with the value of the
name of the Replay Profile or profiles on the Storage Center can be set
to allow to use Replay Profiles other than the default ``daily`` profile.

As an example, here is how to define a volume type using the ``hourly``
Replay Profile and another specifying both ``hourly`` and the default
``daily`` profile:

.. code-block:: console

    $ cinder type-create "HourlyType"
    $ cinder type-key "HourlyType" set storagetype:replayprofile=hourly
    $ cinder type-create "HourlyAndDailyType"
    $ cinder type-key "HourlyAndDailyType" set storagetype:replayprofiles=hourly,daily

Note the comma separated string for the ``HourlyAndDailyType``.

Replication for a given volume type is enabled via the extra spec
``replication_enabled``.

To create a volume type that specifies only replication enabled back ends:

.. code-block:: console

    $ cinder type-create "ReplicationType"
    $ cinder type-key "ReplicationType" set replication_enabled='<is> True'

Extra specs can be used to configure replication. In addition to the Replay
Profiles above, ``replication:activereplay`` can be set to enable replication
of the volume's active replay. And the replication type can be changed to
synchronous via the ``replication_type`` extra spec can be set.

To create a volume type that enables replication of the active replay:

.. code-block:: console

    $ cinder type-create "ReplicationType"
    $ cinder type-key "ReplicationType" set replication_enabled='<is> True'
    $ cinder type-key "ReplicationType" set replication:activereplay='<is> True'

To create a volume type that enables synchronous replication :

.. code-block:: console

    $ cinder type-create "ReplicationType"
    $ cinder type-key "ReplicationType" set replication_enabled='<is> True'
    $ cinder type-key "ReplicationType" set replication_type='<in> sync'

To create a volume type that enables replication using Live Volume:

.. code-block:: console

    $ cinder type-create "ReplicationType"
    $ cinder type-key "ReplicationType" set replication_enabled='<is> True'
    $ cinder type-key "ReplicationType" set replication:livevolume='<is> True'

iSCSI configuration
~~~~~~~~~~~~~~~~~~~

Use the following instructions to update the configuration file for iSCSI:

.. code-block:: ini

    default_volume_type = delliscsi
    enabled_backends = delliscsi

    [delliscsi]
    # Name to give this storage back-end
    volume_backend_name = delliscsi
    # The iSCSI driver to load
    volume_driver = cinder.volume.drivers.dell.dell_storagecenter_iscsi.DellStorageCenterISCSIDriver
    # IP address of DSM
    san_ip = 172.23.8.101
    # DSM user name
    san_login = Admin
    # DSM password
    san_password = secret
    # The Storage Center serial number to use
    dell_sc_ssn = 64702

    # ==Optional settings==

    # The DSM API port
    dell_sc_api_port = 3033
    # Server folder to place new server definitions
    dell_sc_server_folder = devstacksrv
    # Volume folder to place created volumes
    dell_sc_volume_folder = devstackvol/Cinder

Fibre Channel configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the following instructions to update the configuration file for fibre
channel:

.. code-block:: ini

    default_volume_type = dellfc
    enabled_backends = dellfc

    [dellfc]
    # Name to give this storage back-end
    volume_backend_name = dellfc
    # The FC driver to load
    volume_driver = cinder.volume.drivers.dell.dell_storagecenter_fc.DellStorageCenterFCDriver
    # IP address of the DSM
    san_ip = 172.23.8.101
    # DSM user name
    san_login = Admin
    # DSM password
    san_password = secret
    # The Storage Center serial number to use
    dell_sc_ssn = 64702

    # ==Optional settings==

    # The DSM API port
    dell_sc_api_port = 3033
    # Server folder to place new server definitions
    dell_sc_server_folder = devstacksrv
    # Volume folder to place created volumes
    dell_sc_volume_folder = devstackvol/Cinder

Dual DSM
~~~~~~~~

It is possible to specify a secondary DSM to use in case the primary DSM fails.

Configuration is done through the cinder.conf. Both DSMs have to be
configured to manage the same set of Storage Centers for this backend. That
means the dell_sc_ssn and any Storage Centers used for replication or Live
Volume.

Add network and credential information to the backend to enable Dual DSM.

.. code-block:: ini

    [dell]
    # The IP address and port of the secondary DSM.
    secondary_san_ip = 192.168.0.102
    secondary_sc_api_port = 3033
    # Specify credentials for the secondary DSM.
    secondary_san_login = Admin
    secondary_san_password = secret

The driver will use the primary until a failure. At that point it will attempt
to use the secondary. It will continue to use the secondary until the volume
service is restarted or the secondary fails at which point it will attempt to
use the primary.

Replication configuration
~~~~~~~~~~~~~~~~~~~~~~~~~

Add the following to the back-end specification to specify another Storage
Center to replicate to.

.. code-block:: ini

    [dell]
    replication_device = target_device_id: 65495, qosnode: cinderqos

The ``target_device_id`` is the SSN of the remote Storage Center and the
``qosnode`` is the QoS Node setup between the two Storage Centers.

Note that more than one ``replication_device`` line can be added. This will
slow things down, however.

A volume is only replicated if the volume is of a volume-type that has
the extra spec ``replication_enabled`` set to ``<is> True``.

Replication notes
~~~~~~~~~~~~~~~~~

This driver supports both standard replication and Live Volume (if supported
and licensed). The main difference is that a VM attached to a Live Volume is
mapped to both Storage Centers. In the case of a failure of the primary Live
Volume still requires a failover-host to move control of the volume to the
second controller.

Existing mappings should work and not require the instance to be remapped but
it might need to be rebooted.

Live Volume is more resource intensive than replication. One should be sure
to plan accordingly.

Failback
~~~~~~~~

The failover-host command is designed for the case where the primary system is
not coming back. If it has been executed and the primary has been restored it
is possible to attempt a failback.

Simply specify default as the backend_id.

.. code-block:: console

    $ cinder failover-host cinder@delliscsi --backend_id default

Non trivial heavy lifting is done by this command. It attempts to recover best
it can but if things have diverged to far it can only do so much. It is also a
one time only command so do not reboot or restart the service in the middle of
it.

Failover and failback are significant operations under OpenStack Cinder. Be
sure to consult with support before attempting.

Server type configuration
~~~~~~~~~~~~~~~~~~~~~~~~~

This option allows one to set a default Server OS type to use when creating
a server definition on the Dell Storage Center.

When attaching a volume to a node the Dell Storage Center driver creates a
server definition on the storage array. This defition includes a Server OS
type. The type used by the Dell Storage Center cinder driver is
"Red Hat Linux 6.x". This is a modern operating system definition that supports
all the features of an OpenStack node.

Add the following to the back-end specification to specify the Server OS to use
when creating a server definition. The server type used must come from the drop
down list in the DSM.

.. code-block:: ini

    [dell]
    default_server_os = 'Red Hat Linux 7.x'

Note that this server definition is created once. Changing this setting after
the fact will not change an existing definition. The selected Server OS does
not have to match the actual OS used on the node.

Driver options
~~~~~~~~~~~~~~

The following table contains the configuration options specific to the
Dell Storage Center volume driver.

.. include:: ../../tables/cinder-dellsc.rst
