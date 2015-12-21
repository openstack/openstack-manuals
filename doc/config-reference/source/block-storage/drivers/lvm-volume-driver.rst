===
LVM
===

The default volume back end uses local volumes managed by LVM.

This driver supports different transport protocols to attach volumes,
currently iSCSI and iSER.

Set the following in your ``cinder.conf`` configuration file, and use
the following options to configure for iSCSI transport:

.. code-block:: ini

   volume_driver = cinder.volume.drivers.lvm.LVMVolumeDriver
   iscsi_protocol = iscsi

Use the following options to configure for the iSER transport:

.. code-block:: ini

   volume_driver = cinder.volume.drivers.lvm.LVMVolumeDriver
   iscsi_protocol = iser

.. include:: ../../tables/cinder-lvm.rst
