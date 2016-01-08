==============
Volume drivers
==============

.. toctree::
   :maxdepth: 1

   drivers/blockbridge-eps-driver.rst
   drivers/ceph-rbd-volume-driver.rst
   drivers/dell-equallogic-driver.rst
   drivers/dell-storagecenter-driver.rst
   drivers/dothill-driver.rst
   drivers/emc-scaleio-driver.rst
   drivers/emc-vmax-driver.rst
   drivers/emc-vnx-driver.rst
   drivers/emc-xtremio-driver.rst
   drivers/glusterfs-driver.rst
   drivers/hds-hnas-driver.rst
   drivers/hitachi-storage-volume-driver.rst
   drivers/hpe-3par-driver.rst
   drivers/hpe-lefthand-driver.rst
   drivers/hp-msa-driver.rst
   drivers/huawei-storage-driver.rst
   drivers/ibm-gpfs-volume-driver.rst
   drivers/ibm-storwize-svc-driver.rst
   drivers/ibm-xiv-volume-driver.rst
   drivers/ibm-flashsystem-volume-driver.rst
   drivers/lenovo-driver.rst
   drivers/lvm-volume-driver.rst
   drivers/netapp-volume-driver.rst
   drivers/nimble-volume-driver.rst
   drivers/nfs-volume-driver.rst
   drivers/prophetstor-dpl-driver.rst
   drivers/pure-storage-driver.rst
   drivers/quobyte-driver.rst
   drivers/scality-sofs-driver.rst
   drivers/sheepdog-driver.rst
   drivers/smbfs-volume-driver.rst
   drivers/solidfire-volume-driver.rst
   drivers/tintri-volume-driver.rst
   drivers/violin-v6000-driver.rst
   drivers/violin-v7000-driver.rst
   drivers/vmware-vmdk-driver.rst
   drivers/windows-iscsi-volume-driver.rst
   drivers/xio-volume-driver.rst
   drivers/zfssa-iscsi-driver.rst
   drivers/zfssa-nfs-driver.rst

To use different volume drivers for the cinder-volume service, use the
parameters described in these sections.

The volume drivers are included in the `Block Storage repository
<https://git.openstack.org/cgit/openstack/cinder/>`_. To set a volume
driver, use the ``volume_driver`` flag. The default is:

.. code-block:: ini

    volume_driver = cinder.volume.drivers.lvm.LVMVolumeDriver
