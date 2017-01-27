.. _cinder:

=====================
Block Storage service
=====================

.. toctree::

   common/get-started-block-storage.rst
   cinder-controller-install.rst
   cinder-storage-install.rst
   cinder-verify.rst
   cinder-next-steps.rst

The Block Storage service (cinder) provides block storage devices
to guest instances. The method in which the storage is provisioned and
consumed is determined by the Block Storage driver, or drivers
in the case of a multi-backend configuration. There are a variety of
drivers that are available: NAS/SAN, NFS, iSCSI, Ceph, and more.

The Block Storage API and scheduler services typically run on the controller
nodes. Depending upon the drivers used, the volume service can run
on controller nodes, compute nodes, or standalone storage nodes.

For more information, see the
`Configuration Reference <https://docs.openstack.org/newton/config-reference/block-storage/volume-drivers.html>`_.
