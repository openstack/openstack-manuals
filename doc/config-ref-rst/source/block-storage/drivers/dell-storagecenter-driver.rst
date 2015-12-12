===================================================
Dell Storage Center Fibre Channel and iSCSI drivers
===================================================

The Dell Storage Center volume driver interacts with configured Storage
Center arrays.

The Dell Storage Center driver manages Storage Center arrays through
Enterprise Manager. Enterprise Manager connection settings and Storage
Center options are defined in the ``cinder.conf`` file.

Prerequisite: Dell Enterprise Manager 2015 R1 or later must be used.

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

Extra spec options
~~~~~~~~~~~~~~~~~~

Volume type extra specs can be used to select different Storage
Profiles.

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

iSCSI configuration
~~~~~~~~~~~~~~~~~~~

Use the following instructions to update the configuration file for iSCSI:

.. code-block:: ini

    default_volume_type = delliscsi
    enabled_backends = delliscsi

    [delliscsi]
    # Name to give this storage backend
    volume_backend_name = delliscsi
    # The iSCSI driver to load
    volume_driver = cinder.volume.drivers.dell.dell_storagecenter_iscsi.DellStorageCenterISCSIDriver
    # IP address of Enterprise Manager
    san_ip = 172.23.8.101
    # Enterprise Manager user name
    san_login = Admin
    # Enterprise Manager password
    san_password = secret
    # The Storage Center iSCSI IP address
    iscsi_ip_address = 192.168.0.20
    # The Storage Center serial number to use
    dell_sc_ssn = 64702

    # ==Optional settings==
    # The Enterprise Manager API port
    dell_sc_api_port = 3033
    # Server folder to place new server definitions
    dell_sc_server_folder = devstacksrv
    # Volume folder to place created volumes
    dell_sc_volume_folder = devstackvol/Cinder
    # The iSCSI IP port
    iscsi_port = 3260

Fibre Channel configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the following instructions to update the configuration file for fibre
channel:

.. code-block:: ini

    default_volume_type = dellfc
    enabled_backends = dellfc

    [dellfc]
    # Name to give this storage backend
    volume_backend_name = dellfc
    # The FC driver to load
    volume_driver = cinder.volume.drivers.dell.dell_storagecenter_fc.DellStorageCenterFCDriver
    # IP address of Enterprise Manager
    san_ip = 172.23.8.101
    # Enterprise Manager user name
    san_login = Admin
    # Enterprise Manager password
    san_password = secret
    # The Storage Center serial number to use
    dell_sc_ssn = 64702

    # Optional settings

    # The Enterprise Manager API port
    dell_sc_api_port = 3033
    # Server folder to place new server definitions
    dell_sc_server_folder = devstacksrv
    # Volume folder to place created volumes
    dell_sc_volume_folder = devstackvol/Cinder

Driver options
~~~~~~~~~~~~~~

The following table contains the configuration options specific to the
Dell Storage Center volume driver.

.. include:: ../../tables/cinder-dellsc.rst
