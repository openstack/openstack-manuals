=============
Share drivers
=============

.. sort by the drivers by open source software
.. and the drivers for proprietary components

.. toctree::
   :maxdepth: 1

   drivers/generic-driver.rst
   drivers/cephfs-native-driver.rst
   drivers/dell-emc-vmax-driver.rst
   drivers/glusterfs-driver.rst
   drivers/glusterfs-native-driver.rst
   drivers/hdfs-native-driver.rst
   drivers/lvm-driver.rst
   drivers/zfs-on-linux-driver.rst
   drivers/zfssa-manila-driver.rst
   drivers/emc-isilon-driver.rst
   drivers/emc-vnx-driver.rst
   drivers/emc-unity-driver.rst
   drivers/hitachi-hnas-driver.rst
   drivers/hitachi-hsp-driver.rst
   drivers/hpe-3par-share-driver.rst
   drivers/huawei-nas-driver.rst
   drivers/ibm-gpfs-driver.rst
   drivers/maprfs-native-driver.rst
   drivers/netapp-cluster-mode-driver.rst
   drivers/quobyte-driver.rst


To use different share drivers for the Shared File Systems service, use the
parameters described in these sections.

The Shared File Systems service can handle multiple drivers at once.
The configuration for all of them follows a common paradigm:

#. In the configuration file ``manila.conf``, configure the option
   ``enabled_backends`` with the list of names for your configuration.

   For example, if you want to enable two drivers and name them
   ``Driver1`` and ``Driver2``:

   .. code-block:: ini

      [Default]
      # ...
      enabled_backends = Driver1 Driver2

#. Configure a separate section for each driver using these
   names. You need to define in each section at least the option
   ``share_driver`` and assign it the value of your driver. In this
   example it is the generic driver:

   .. code-block:: ini

      [Driver1]
      share_driver = manila.share.drivers.generic.GenericShareDriver
      # ...

      [Driver2]
      share_driver = manila.share.drivers.generic.GenericShareDriver
      # ...

The share drivers are included in the `Shared File Systems repository
<https://git.openstack.org/cgit/openstack/manila/tree/manila/share/drivers>`_.
