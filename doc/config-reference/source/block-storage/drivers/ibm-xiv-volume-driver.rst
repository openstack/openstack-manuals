================================
IBM Storage volume driver
================================

The IBM Storage Driver for OpenStack is a Block Storage driver that
supports IBM XIV, IBM Spectrum Accelerate, IBM FlashSystem A9000,
IBM FlashSystem A9000R and IBM DS8000 storage systems over Fiber channel
and iSCSI.

Set the following in your ``cinder.conf`` file, and use the following options
to configure it.

.. code-block:: ini

   volume_driver = cinder.volume.drivers.xiv_ds8k.XIVDS8KDriver

.. include:: ../../tables/cinder-xiv.rst

.. note::

   To use the IBM Storage Driver for OpenStack you must download and
   install the package. For more information, see `IBM Support Portal -
   Select Fixes <http://www.ibm.com/support/fixcentral/swg/selectFi
   xes?parent=Enterprise%2BStorage%2BServers&product=ibm/Storage_Disk/XIV+Storage+System+%282810,+2812%
   29&release=All&platform=All&function=all>`_.

For full documentation, see `IBM Knowledge Center <http://www.ibm.com/support/knowledgecenter/>`_.
