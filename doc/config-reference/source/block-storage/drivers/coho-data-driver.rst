=======================
Coho Data volume driver
=======================

The Coho DataStream Scale-Out Storage allows your Block Storage service to
scale seamlessly. The architecture consists of commodity storage servers
with SDN ToR switches. Leveraging an SDN OpenFlow controller allows you
to scale storage horizontally, while avoiding storage and network bottlenecks
by intelligent load-balancing and parallelized workloads. High-performance
PCIe NVMe flash, paired with traditional hard disk drives (HDD) or solid-state
drives (SSD), delivers low-latency performance even with highly mixed workloads
in large scale environment.

Coho Data's storage features include real-time instance level
granularity performance and capacity reporting via API or UI, and
single-IP storage endpoint access.

Supported operations
~~~~~~~~~~~~~~~~~~~~

* Create, delete, attach, detach, retype, clone, and extend volumes.
* Create, list, and delete volume snapshots.
* Create a volume from a snapshot.
* Copy a volume to an image.
* Copy an image to a volume.
* Create a thin provisioned volume.
* Get volume statistics.

System requirements
~~~~~~~~~~~~~~~~~~~

* NFS client on the Block storage controller.

Coho Data Block Storage driver configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Create cinder volume type.

   .. code-block:: console

      $ cinder type-create coho-1

#. Edit the OpenStack Block Storage service configuration file.
   The following sample, ``/etc/cinder/cinder.conf``, configuration lists the
   relevant settings for a typical Block Storage service using a single
   Coho Data storage:

   .. code-block:: ini

      [DEFAULT]
      enabled_backends = coho-1
      default_volume_type = coho-1

      [coho-1]
      volume_driver = cinder.volume.drivers.coho.CohoDriver
      volume_backend_name = coho-1
      nfs_shares_config = /etc/cinder/coho_shares
      nas_secure_file_operations = 'false'

#. Add your list of Coho Datastream NFS addresses to the file you specified
   with the ``nfs_shares_config`` option. For example, if the value of this
   option was set to ``/etc/cinder/coho_shares``, then:

   .. code-block:: console

      $ cat /etc/cinder/coho_shares
      <coho-nfs-ip>:/<export-path>

#. Restart the ``cinder-volume`` service to enable Coho Data driver.

.. include:: ../../tables/cinder-coho.rst
