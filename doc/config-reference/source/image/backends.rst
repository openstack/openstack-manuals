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

-  Add data store parameters to VMware Datastore Store.

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
options as shown in this code sample:

.. code:: ini

   [glance_store]
   # List of stores enabled. Valid stores are: cinder, file, http, rbd,
   # sheepdog, swift, vmware (list value)
   stores = file,http,vmware
   # Which back end scheme should Glance use by default is not specified
   # in a request to add a new image to Glance? Known schemes are determined
   # by the known_stores option below.
   # Default: 'file'
   default_store = vsphere

The following table describes the parameters of VMware Datastore Store:

.. include:: ../tables/glance-vmware.rst

The following block of text shows a sample configuration:

.. code:: ini

   #
   # Address of the ESX/ESXi or vCenter Server target system.
   #
   # This configuration option sets the address of the ESX/ESXi or vCenter
   # Server target system. This option is required when using the VMware
   # storage backend. The address can contain an IP address (127.0.0.1) or
   # a DNS name (www.my-domain.com).
   #
   # Possible Values:
   #     * A valid IPv4 or IPv6 address
   #     * A valid DNS name
   #
   # Related options:
   #     * vmware_server_username
   #     * vmware_server_password
   #
   #  (string value)
   vmware_server_host = 127.0.0.1

   #
   # Server username.
   #
   # This configuration option takes the username for authenticating with
   # the VMware ESX/ESXi or vCenter Server. This option is required when
   # using the VMware storage backend.
   #
   # Possible Values:
   #     * Any string that is the username for a user with appropriate
   #       privileges
   #
   # Related options:
   #     * vmware_server_host
   #     * vmware_server_password
   #
   #  (string value)
   vmware_server_username = root

   #
   # Server password.
   #
   # This configuration option takes the password for authenticating with
   # the VMware ESX/ESXi or vCenter Server. This option is required when
   # using the VMware storage backend.
   #
   # Possible Values:
   #     * Any string that is a password corresponding to the username
   #       specified using the "vmware_server_username" option
   #
   # Related options:
   #     * vmware_server_host
   #     * vmware_server_username
   #
   #  (string value)
   vmware_server_password = vmware

   #
   # The number of VMware API retries.
   #
   # This configuration option specifies the number of times the VMware
   # ESX/VC server API must be retried upon connection related issues or
   # server API call overload. It is not possible to specify 'retry
   # forever'.
   #
   # Possible Values:
   #     * Any positive integer value
   #
   # Related options:
   #     * None
   #
   #  (integer value)
   # Minimum value: 1
   vmware_api_retry_count = 10

   #
   # Interval in seconds used for polling remote tasks invoked on VMware
   # ESX/VC server.
   #
   # This configuration option takes in the sleep time in seconds for polling an
   # on-going async task as part of the VMWare ESX/VC server API call.
   #
   # Possible Values:
   #     * Any positive integer value
   #
   # Related options:
   #     * None
   #
   #  (integer value)
   # Minimum value: 1
   vmware_task_poll_interval = 5

   #
   # The directory where the glance images will be stored in the datastore.
   #
   # This configuration option specifies the path to the directory where the
   # glance images will be stored in the VMware datastore. If this option
   # is not set,  the default directory where the glance images are stored
   # is openstack_glance.
   #
   # Possible Values:
   #     * Any string that is a valid path to a directory
   #
   # Related options:
   #     * None
   #
   #  (string value)
   vmware_store_image_dir = /openstack_glance

   #
   # Set verification of the ESX/vCenter server certificate.
   #
   # This configuration option takes a boolean value to determine
   # whether or not to verify the ESX/vCenter server certificate. If this
   # option is set to True, the ESX/vCenter server certificate is not
   # verified. If this option is set to False, then the default CA
   # truststore is used for verification.
   #
   # This option is ignored if the "vmware_ca_file" option is set. In that
   # case, the ESX/vCenter server certificate will then be verified using
   # the file specified using the "vmware_ca_file" option .
   #
   # Possible Values:
   #     * True
   #     * False
   #
   # Related options:
   #     * vmware_ca_file
   #
   #  (boolean value)
   # Deprecated group/name - [glance_store]/vmware_api_insecure
   vmware_insecure = false

   #
   # Absolute path to the CA bundle file.
   #
   # This configuration option enables the operator to use a custom
   # Cerificate Authority File to verify the ESX/vCenter certificate.
   #
   # If this option is set, the "vmware_insecure" option will be ignored
   # and the CA file specified will be used to authenticate the ESX/vCenter
   # server certificate and establish a secure connection to the server.
   #
   # Possible Values:
   #     * Any string that is a valid absolute path to a CA file
   #
   # Related options:
   #     * vmware_insecure
   #
   #  (string value)
   vmware_ca_file = /etc/ssl/certs/ca-certificates.crt

   #
   # The datastores where the image can be stored.
   #
   # This configuration option specifies the datastores where the image can
   # be stored in the VMWare store backend. This option may be specified
   # multiple times for specifying multiple datastores. The datastore name
   # should be specified after its datacenter path, separated by ":". An
   # optional weight may be given after the datastore name, separated again
   # by ":" to specify the priority. Thus, the required format becomes
   # <datacenter_path>:<datastore_name>:<optional_weight>.
   #
   # When adding an image, the datastore with highest weight will be
   # selected unless there is not enough free space available in cases
   # where the image size is already known. If no weight is given, it is
   # assumed to be zero and the directory will be considered for selection
   # last. If multiple datastores have the same weight, then the datastore
   # with the most free space available is selected.
   #
   # Possible Values:
   #     * Any string of the format:
   #       <datacenter_path>:<datastore_name>:<optional_weight>
   #
   # Related options:
   #    * None
   #
   #  (multi valued)
   vmware_datastores = DATACENTER:datastore1

.. _glance-backend-vmware-DS:

Configure vCenter data stores for the back end
----------------------------------------------

You can specify a vCenter data store for the back end by setting the
``vmware_datastores`` parameter value to the vCenter name of
the data store. This option may be specified multiple times for
specifying multiple datastores.

Uncomment and define the ``vmware_datastores`` parameter with the
name of the vCenter and data store.

Complete the other vCenter configuration parameters as appropriate.
