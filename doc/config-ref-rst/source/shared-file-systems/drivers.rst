=============
Share drivers
=============

.. toctree::

   drivers/emc-isilon-driver.rst
   drivers/emc-vnx-driver.rst
   drivers/generic-driver.rst
   drivers/glusterfs-driver.rst
   drivers/glusterfs-native-driver.rst
   drivers/hdfs-native-driver.rst
   drivers/hpe-3par-share-driver.rst
   drivers/huawei-nas-driver.rst
   drivers/ibm-gpfs-driver.rst
   drivers/netapp-cluster-mode-driver.rst


To use different share drivers for the Shared File Systems service, use the
parameters described in these sections.

The share drivers are included in the `Shared File Systems repository
<https://git.openstack.org/cgit/openstack/manila/tree/manila/share/drivers>`_.
To set a share driver, use the ``share_driver`` flag. For example, to
use the generic reference driver:

.. code-block:: ini

            share_driver = manila.share.drivers.generic.GenericShareDriver
