.. _cinder:

=====================
Block Storage service
=====================

.. toctree::

   common/get_started_block_storage.rst
   cinder-controller-install.rst
   cinder-storage-install.rst
   cinder-verify.rst
   cinder-next-steps.rst

The OpenStack Block Storage service provides block storage devices
to guest instances. The method in which the storage is provisioned and
consumed is determined by the Block Storage driver, or drivers
in the case of a multi-backend configuration. There are a variety of
drivers that are available: NAS/SAN, NFS, iSCSI, Ceph, and more.
The Block Storage API and scheduler services typically run on the controller
nodes. Depending upon the drivers used, the volume service can run
on controllers, compute nodes, or standalone storage nodes.
For more information, see the
`Configuration Reference <http://docs.openstack.org/liberty/
config-reference/content/section_volume-drivers.html>`__.

.. note::

   This chapter omits the backup manager because it depends on the
   Object Storage service.
