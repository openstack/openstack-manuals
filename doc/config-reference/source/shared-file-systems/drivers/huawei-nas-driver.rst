=============
Huawei driver
=============

Huawei NAS driver is a plug-in based on the Shared File Systems service.
The Huawei NAS driver can be used to provide functions such as the share
and snapshot for virtual machines, or instances, in OpenStack. Huawei
NAS driver enables the OceanStor V3 series V300R002 storage system to
provide only network filesystems for OpenStack.

Requirements
~~~~~~~~~~~~

-  The OceanStor V3 series V300R002 storage system.

-  The following licenses should be activated on V3 for File: CIFS, NFS,
   HyperSnap License (for snapshot).

Supported shared filesystems and operations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The driver supports CIFS and NFS shares.

The following operations are supported:

- Create a share.

- Delete a share.

- Allow share access.

  Note the following limitations:

  - Only IP access type is supported for NFS.

  - Only user access is supported for CIFS.

- Deny share access.

- Create a snapshot.

- Delete a snapshot.

- Support pools in one backend.

- Extend a share.

- Shrink a share.

- Create a replica.

- Delete a replica.

- Promote a replica.

- Update a replica state.

Pre-configurations on Huawei
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Create a driver configuration file. The driver configuration file
   name must be the same as the ``manila_huawei_conf_file`` item in the
   ``manila_conf`` configuration file.

#. Configure the product. Product indicates the storage system type.
   For the OceanStor V3 series V300R002 storage systems, the driver
   configuration file is as follows:

   .. code-block:: xml

      <?xml version='1.0' encoding='UTF-8'?>
      <Config>
          <Storage>
              <Product>V3</Product>
              <LogicalPortIP>x.x.x.x</LogicalPortIP>
              <RestURL>https://x.x.x.x:8088/deviceManager/rest/</RestURL>
              <UserName>xxxxxxxxx</UserName>
              <UserPassword>xxxxxxxxx</UserPassword>
          </Storage>
          <Filesystem>
              <Thin_StoragePool>xxxxxxxxx</Thin_StoragePool>
              <Thick_StoragePool>xxxxxxxxx</Thick_StoragePool>
              <WaitInterval>3</WaitInterval>
              <Timeout>60</Timeout>
          </Filesystem>
      </Config>

   The options are:

   -  ``Product`` is a type of storage product. Set it to ``V3``.

   -  ``LogicalPortIP`` is the IP address of the logical port.

   -  ``RestURL`` is an access address of the REST interface.
      Multiple RestURLs can be configured in ``<RestURL>``,
      separated by ";". The driver will automatically retry another
      ``RestURL`` if one fails to connect.

   -  ``UserName`` is the user name of an administrator.

   -  ``UserPassword`` is the password of an administrator.

   -  ``Thin_StoragePool`` is the name of a thin storage pool to be used.

   -  ``Thick_StoragePool`` is the name of a thick storage pool to be used.

   -  ``WaitInterval`` is the interval time of querying the file
      system status.

   -  ``Timeout`` is the timeout period for waiting command
      execution of a device to complete.

Back end configuration
~~~~~~~~~~~~~~~~~~~~~~

Modify the ``manila.conf`` Shared File Systems service configuration
file and add ``share_driver`` and ``manila_huawei_conf_file`` items.
Here is an example for configuring a storage system:

.. code-block:: ini

   share_driver = manila.share.drivers.huawei.huawei_nas.HuaweiNasDriver
   manila_huawei_conf_file = /etc/manila/manila_huawei_conf.xml
   driver_handles_share_servers = False

Driver options
~~~~~~~~~~~~~~

The following table contains the configuration options specific to the
share driver.

.. include:: ../../tables/manila-huawei.rst
