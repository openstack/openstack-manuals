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
plug-in is referred to as the ``Isilon Driver`` in this document.

This Isilon Driver interfaces with an Isilon cluster via the REST Isilon
Platform API (PAPI) and the RESTful Access to Namespace API (RAN).

Requirements
~~~~~~~~~~~~

- Isilon cluster running OneFS 7.2 or higher

Supported shared filesystems and operations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The drivers supports CIFS and NFS shares.

The following operations are supported:

- Create a share.

- Delete a share.

- Allow share access.

  Note the following limitations:

  - Only IP access type is supported.
  - Only read-write access is supported.

- Deny share access.

- Create a snapshot.

- Delete a snapshot.

- Create a share from a snapshot.

Back end configuration
~~~~~~~~~~~~~~~~~~~~~~

The following parameters need to be configured in the Shared File
Systems service configuration file for the Isilon driver:

.. code-block:: ini

   share_driver = manila.share.drivers.emc.driver.EMCShareDriver
   emc_share_backend = isilon
   emc_nas_server = <IP address of Isilon cluster>
   emc_nas_login = <username>
   emc_nas_password = <password>

Restrictions
~~~~~~~~~~~~

The Isilon driver has the following restrictions:

-  Only IP access type is supported for NFS and CIFS.

-  Only FLAT network is supported.

-  Quotas are not yet supported.

Driver options
~~~~~~~~~~~~~~

The following table contains the configuration options specific to the
share driver.

.. include:: ../../tables/manila-emc.rst
