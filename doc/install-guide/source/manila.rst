.. _manila:

===========================
Shared File Systems service
===========================

.. toctree::

    common/get_started_file_storage.rst
    manila-controller-install.rst
    manila-share-install.rst
    manila-verify.rst
    manila-next-steps.rst

The OpenStack Shared File Systems service provides coordinated access to
shared or distributed file systems. The method in which the share is
provisioned and consumed is determined by the Shared File Systems driver, or
drivers in the case of a multi-backend configuration. There are a variety of
drivers that support NFS, CIFS, HDFS and/or protocols as well.
The Shared File Systems API and scheduler services typically run on the
controller nodes. Depending upon the drivers used, the share service can run
on controllers, compute nodes, or storage nodes.

.. important::

    For simplicity, this guide describes configuring the Shared File Systems
    service to use the ``generic`` back end with the driver handles share
    server mode (DHSS) enabled that uses Compute (nova), Networking (neutron)
    and Block storage (cinder) services.
    Networking service configuration requires the capability of networks being
    attached to a public router in order to create share networks.

    Before you proceed, ensure that Compute, Networking and Block storage
    services are properly working. For networking service, ensure that option
    2 is properly configured.

For more information, see the `Configuration Reference <http://docs.openstack.org/mitaka/config-reference/content/section_share-drivers.html>`__.
