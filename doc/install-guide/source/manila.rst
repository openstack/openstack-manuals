.. _manila:

===========================
Shared File Systems service
===========================

.. toctree::

    common/get-started-shared-file-systems.rst
    manila-controller-install.rst
    manila-share-install.rst
    manila-verify.rst
    manila-next-steps.rst

The Shared File Systems service (manila) provides coordinated access to
shared or distributed file systems. The method in which the share is
provisioned and consumed is determined by the Shared File Systems driver, or
drivers in the case of a multi-driver configuration. There are a variety of
drivers that support NFS, CIFS, HDFS and/or protocols as well.

The Shared File Systems API and scheduler services typically run on the
controller nodes. Depending upon the drivers used, the share service can run
on controllers, compute nodes, or storage nodes.

For more information, see the `Configuration Reference <http://docs.openstack.org/mitaka/config-reference/shared-file-systems/drivers.html>`__.
