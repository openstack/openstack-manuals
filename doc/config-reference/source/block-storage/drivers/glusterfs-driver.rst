================
GlusterFS driver
================

GlusterFS is an open-source scalable distributed file system that is able
to grow to petabytes and beyond in size. More information can be found on
`Gluster's homepage <http://www.gluster.org/>`_.

This driver enables the use of GlusterFS in a similar fashion as NFS.
It supports basic volume operations, including snapshot and clone.

To use Block Storage with GlusterFS, first set the ``volume_driver`` in
the ``cinder.conf`` file:

.. code-block:: ini

   volume_driver = cinder.volume.drivers.glusterfs.GlusterfsDriver

The following table contains the configuration options supported by
the GlusterFS driver.

.. include:: ../../tables/cinder-storage_glusterfs.rst
