=================
EMC Isilon driver
=================

The EMC Shared File Systems driver framework (EMCShareDriver) utilizes
EMC storage products to provide shared file systems to OpenStack. The
EMC driver is a plug-in based driver which is designed to use different
plug-ins to manage different EMC storage products.

The Isilon driver is a plug-in for the EMC framework which allows the
Shared File Systems service to interface with an Isilon back end to
provide a shared filesystem. The EMC driver framework with the Isilon
plug-in is referred to as the "Isilon Driver" in this document.

This Isilon Driver interfaces with an Isilon cluster via the REST Isilon
Platform API (PAPI) and the RESTful Access to Namespace API (RAN).

Requirements
~~~~~~~~~~~~

- Isilon cluster running OneFS 7.2 or higher

Supported operations
~~~~~~~~~~~~~~~~~~~~

The following operations are supported on an Isilon cluster:

- Create CIFS/NFS share.

- Delete CIFS/NFS share.

- Allow CIFS/NFS share access.

   - Only IP access type is supported for NFS and CIFS.

   - Only RW access is supported.

- Deny CIFS/NFS share access

- Create snapshot

- Delete snapshot

- Create share from snapshot

Backend configuration
~~~~~~~~~~~~~~~~~~~~~

The following parameters need to be configured in the Shared File
Systems service configuration file for the Isilon driver:

.. code-block:: ini

    share_driver = manila.share.drivers.emc.driver.EMCShareDriver
    emc_share_backend = isilon
    emc_nas_server = <IP address of Isilon cluster>
    emc_nas_login = <username>
    emc_nas_password = <password>
    isilon_share_root_dir = <directory on Isilon where shares will be created>

Restart of manila-share service is needed for the configuration changes
to take effect.

Restrictions
~~~~~~~~~~~~

The Isilon driver has the following restrictions:

-  Only IP access type is supported for NFS and CIFS.

-  Only FLAT network is supported.

-  Quotas are not yet supported.

Driver configuration options
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Configuration options specific to this driver are documented here:

.. include:: ../../tables/manila-emc.rst
