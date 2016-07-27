===================
Configure back ends
===================

The Image service supports several back ends for storing virtual machine
images:

* Block Storage service (cinder)
* A directory on a local file system
* HTTP
* Ceph RBD
* Sheepdog
* Object Storage service (swift)
* VMware ESX

.. note::

   You must use only ``raw`` image formats with the Ceph RBD back end.

The following tables detail the options available for each.

.. include:: ../tables/glance-cinder.rst
.. include:: ../tables/glance-filesystem.rst
.. include:: ../tables/glance-http.rst
.. include:: ../tables/glance-rbd.rst
.. include:: ../tables/glance-sheepdog.rst
.. include:: ../tables/glance-swift.rst

Configure vCenter data stores for the Image service back end
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To use vCenter data stores for the Image service back end, you must
update the ``glance-api.conf`` file, as follows:

-  Add data store parameters to the ``VMware Datastore Store Options``
   section.

-  Specify vSphere as the back end.

   .. note::

      You must configure any configured Image service data stores for
      the Compute service.

You can specify vCenter data stores directly by using the data store
name or Storage Policy Based Management (SPBM), which requires vCenter
Server 5.5 or later. For details, see :ref:`glance-backend-vmware-DS`.

.. note::

   If you intend to use multiple data stores for the back end, use the
   SPBM feature.

In the ``glance_store`` section, set the ``stores`` and ``default_store``
options to ``vsphere``, as shown in this code sample:

.. code:: ini

   [glance_store]
   # List of stores enabled. Valid stores are: cinder, file, http, rbd,
   # sheepdog, swift, s3, vsphere (list value)
   stores = file,http,vsphere
   # Which back end scheme should Glance use by default is not specified
   # in a request to add a new image to Glance? Known schemes are determined
   # by the known_stores option below.
   # Default: 'file'
   default_store = vsphere

The following table describes the parameters in the
``VMware Datastore Store Options`` section:

.. include:: ../tables/glance-vmware.rst

The following block of text shows a sample configuration:

.. code:: ini

   # ============ VMware Datastore Store Options =====================
   # ESX/ESXi or vCenter Server target system.
   # The server value can be an IP address or a DNS name
   # e.g. 127.0.0.1, 127.0.0.1:443, www.vmware-infra.com
   vmware_server_host = 192.168.0.10

   # Server username (string value)
   vmware_server_username = ADMINISTRATOR

   # Server password (string value)
   vmware_server_password = password

   # Inventory path to a datacenter (string value)
   # Value optional when vmware_server_ip is an ESX/ESXi host: if specified
   # should be `ha-datacenter`.
   vmware_datacenter_path = DATACENTER

   # Datastore associated with the datacenter (string value)
   vmware_datastore_name = datastore1

   # PBM service WSDL file location URL. e.g.
   # file:///opt/SDK/spbm/wsdl/pbmService.wsdl Not setting this
   # will disable storage policy based placement of images.
   # (string value)
   #vmware_pbm_wsdl_location =

   # The PBM policy. If `pbm_wsdl_location` is set, a PBM policy needs
   # to be specified. This policy will be used to select the datastore
   # in which the images will be stored.
   #vmware_pbm_policy =

   # The interval used for polling remote tasks
   # invoked on VMware ESX/VC server in seconds (integer value)
   vmware_task_poll_interval = 5

   # Absolute path of the folder containing the images in the datastore
   # (string value)
   vmware_store_image_dir = /openstack_glance

   # Allow to perform insecure SSL requests to the target system (boolean value)
   vmware_api_insecure = False

.. _glance-backend-vmware-DS:

Configure vCenter data stores for the back end
----------------------------------------------

You can specify a vCenter data store for the back end by setting the
``vmware_datastore_name`` parameter value to the vCenter name of
the data store. This configuration limits the back end to a single
data store.

If present, comment or delete the ``vmware_pbm_wsdl_location`` and
``vmware_pbm_policy`` parameters.

Uncomment and define the ``vmware_datastore_name`` parameter with the
name of the vCenter data store.

Complete the other vCenter configuration parameters as appropriate.
