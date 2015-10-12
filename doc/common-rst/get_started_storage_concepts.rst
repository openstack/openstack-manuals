================
Storage concepts
================

The OpenStack stack uses the following storage types:

.. list-table:: Storage types
   :header-rows: 1
   :widths: 30 30 30 30

   * - On-instance / ephemeral
     - Block storage (cinder)
     - Object Storage (swift)
     - File Storage (manila)
   * - Runs operating systems and provides scratch space
     - Used for adding additional persistent storage to a virtual machine (VM)
     - Used for storing virtual machine images and data
     - Used for providing file shares to a virtual machine
   * - Persists until VM is terminated
     - Persists until deleted
     - Persists until deleted
     - Persists until deleted
   * - Access associated with a VM
     - Access associated with a VM
     - Available from anywhere
     - Access can be provided to a VM
   * - Implemented as a filesystem underlying OpenStack Compute
     - Mounted via OpenStack Block Storage controlled protocol (for example, iSCSI)
     - REST API
     - Provides Shared File System service via nfs, cifs, glusterfs, or hdfs protocol
   * - Encryption is available
     - Encryption is available
     - Work in progress - expected for the Mitaka release
     - Encryption is not available yet
   * - Administrator configures size setting, based on flavors
     - Sizings based on need
     - Easily scalable for future growth
     - Sizing based on need
   * - Example: 10 GB first disk, 30 GB/core second disk
     - Example: 1 TB "extra hard drive"
     - Example: 10s of TBs of data set storage
     - Example: 1 TB of file share

.. note::

   - *You cannot use OpenStack Object Storage like a traditional hard
     drive.* The Object Storage relaxes some of the constraints of a
     POSIX-style file system to get other gains. You can access the
     objects through an API which uses HTTP. Subsequently you don't have
     to provide atomic operations (that is, relying on eventual
     consistency), you can scale a storage system easily and avoid a
     central point of failure.

   - *The OpenStack Image service is used to manage the virtual machine
     images in an OpenStack cluster, not store them.* It provides an
     abstraction to different methods for storage - a bridge to the
     storage, not the storage itself.

   - *The OpenStack Object Storage can function on its own.* The Object
     Storage (swift) product can be used independently of the Compute
     (nova) product.
