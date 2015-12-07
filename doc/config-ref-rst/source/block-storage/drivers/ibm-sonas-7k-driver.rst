==========================================
IBM SONAS and Storwise V7000 volume driver
==========================================

The IBM Storage Driver for OpenStack is a Block Storage driver that
supports IBM SONAS and V7000 storage systems over NFS.

Set the following in your ``cinder.conf`` file, and use the table of options
to configure it.

.. code:: ini

   volume_driver = cinder.volume.drivers.ibm.ibmnas

.. include:: ../../tables/cinder-ibmnas.rst
