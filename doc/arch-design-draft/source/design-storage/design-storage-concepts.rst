==============
Storage design
==============

Storage is found in many parts of the OpenStack cloud environment. This
section describes persistent storage options you can configure with
your cloud. It is important to understand the distinction between
:term:`ephemeral <ephemeral volume>` storage and
:term:`persistent <persistent volume>` storage.

Ephemeral storage
~~~~~~~~~~~~~~~~~

If you deploy only the OpenStack :term:`Compute service` (nova), by default
your users do not have access to any form of persistent storage. The disks
associated with VMs are ephemeral, meaning that from the user's point
of view they disappear when a virtual machine is terminated.

Persistent storage
~~~~~~~~~~~~~~~~~~

Persistent storage means that the storage resource outlives any other
resource and is always available, regardless of the state of a running
instance.

Today, OpenStack clouds explicitly support three types of persistent
storage: *Object Storage*, *Block Storage*, and *File-Based Storage*.

Object storage
~~~~~~~~~~~~~~

Object storage is implemented in OpenStack by the
OpenStack Object Storage (swift) project. Users access binary objects
through a REST API. If your intended users need to
archive or manage large datasets, you want to provide them with Object
Storage. In addition, OpenStack can store your virtual machine (VM)
images inside of an object storage system, as an alternative to storing
the images on a file system.

OpenStack storage concepts
~~~~~~~~~~~~~~~~~~~~~~~~~~

:ref:`table_openstack_storage` explains the different storage concepts
provided by OpenStack.

.. _table_openstack_storage:

.. list-table:: Table. OpenStack storage
   :widths: 20 20 20 20 20
   :header-rows: 1

   * -
     - Ephemeral storage
     - Block storage
     - Object storage
     - Shared File System storage
   * - Used to…
     - Run operating system and scratch space
     - Add additional persistent storage to a virtual machine (VM)
     - Store data, including VM images
     - Add additional persistent storage to a virtual machine
   * - Accessed through…
     - A file system
     - A block device that can be partitioned, formatted, and mounted
       (such as, /dev/vdc)
     - The REST API
     - A Shared File Systems service share (either manila managed or an
       external one registered in manila) that can be partitioned, formatted
       and mounted (such as /dev/vdc)
   * - Accessible from…
     - Within a VM
     - Within a VM
     - Anywhere
     - Within a VM
   * - Managed by…
     - OpenStack Compute (nova)
     - OpenStack Block Storage (cinder)
     - OpenStack Object Storage (swift)
     - OpenStack Shared File System Storage (manila)
   * - Persists until…
     - VM is terminated
     - Deleted by user
     - Deleted by user
     - Deleted by user
   * - Sizing determined by…
     - Administrator configuration of size settings, known as *flavors*
     - User specification in initial request
     - Amount of available physical storage
     - * User specification in initial request
       * Requests for extension
       * Available user-level quotes
       * Limitations applied by Administrator
   * - Encryption set by…
     - Parameter in nova.conf
     - Admin establishing `encrypted volume type
       <http://docs.openstack.org/admin-guide/dashboard_manage_volumes.html>`_,
       then user selecting encrypted volume
     - Not yet available
     - Shared File Systems service does not apply any additional encryption
       above what the share’s back-end storage provides
   * - Example of typical usage…
     - 10 GB first disk, 30 GB second disk
     - 1 TB disk
     - 10s of TBs of dataset storage
     - Depends completely on the size of back-end storage specified when
       a share was being created. In case of thin provisioning it can be
       partial space reservation (for more details see
       `Capabilities and Extra-Specs
       <http://docs.openstack.org/developer/manila/devref/capabilities_and_extra_specs.html?highlight=extra%20specs#common-capabilities>`_
       specification)

.. note::

   **File-level Storage (for Live Migration)**

   With file-level storage, users access stored data using the operating
   system's file system interface. Most users, if they have used a network
   storage solution before, have encountered this form of networked
   storage. In the Unix world, the most common form of this is NFS. In the
   Windows world, the most common form is called CIFS (previously, SMB).

   OpenStack clouds do not present file-level storage to end users.
   However, it is important to consider file-level storage for storing
   instances under ``/var/lib/nova/instances`` when designing your cloud,
   since you must have a shared file system if you want to support live
   migration.

Choosing storage back ends
~~~~~~~~~~~~~~~~~~~~~~~~~~

Users will indicate different needs for their cloud use cases. Some may
need fast access to many objects that do not change often, or want to
set a time-to-live (TTL) value on a file. Others may access only storage
that is mounted with the file system itself, but want it to be
replicated instantly when starting a new instance. For other systems,
ephemeral storage is the preferred choice. When you select
:term:`storage back ends <storage back end>`,
consider the following questions from user's perspective:

* Do my users need block storage?
* Do my users need object storage?
* Do I need to support live migration?
* Should my persistent storage drives be contained in my compute nodes,
  or should I use external storage?
* What is the platter count I can achieve? Do more spindles result in
  better I/O despite network access?
* Which one results in the best cost-performance scenario I'm aiming for?
* How do I manage the storage operationally?
* How redundant and distributed is the storage? What happens if a
  storage node fails? To what extent can it mitigate my data-loss
  disaster scenarios?

To deploy your storage by using only commodity hardware, you can use a number
of open-source packages, as shown in :ref:`table_persistent_file_storage`.

.. _table_persistent_file_storage:

.. list-table:: Table. Persistent file-based storage support
   :widths: 25 25 25 25
   :header-rows: 1

   * -
     - Object
     - Block
     - File-level
   * - Swift
     - .. image:: /figures/Check_mark_23x20_02.png
          :width: 30%
     -
     -
   * - LVM
     -
     - .. image:: /figures/Check_mark_23x20_02.png
          :width: 30%
     -
   * - Ceph
     - .. image:: /figures/Check_mark_23x20_02.png
          :width: 30%
     - .. image:: /figures/Check_mark_23x20_02.png
          :width: 30%
     - Experimental
   * - Gluster
     - .. image:: /figures/Check_mark_23x20_02.png
          :width: 30%
     - .. image:: /figures/Check_mark_23x20_02.png
          :width: 30%
     - .. image:: /figures/Check_mark_23x20_02.png
          :width: 30%
   * - NFS
     -
     - .. image:: /figures/Check_mark_23x20_02.png
          :width: 30%
     - .. image:: /figures/Check_mark_23x20_02.png
          :width: 30%
   * - ZFS
     -
     - .. image:: /figures/Check_mark_23x20_02.png
          :width: 30%
     -
   * - Sheepdog
     - .. image:: /figures/Check_mark_23x20_02.png
          :width: 30%
     - .. image:: /figures/Check_mark_23x20_02.png
          :width: 30%
     -

This list of open source file-level shared storage solutions is not
exhaustive other open source solutions exist (MooseFS). Your
organization may already have deployed a file-level shared storage
solution that you can use.

.. note::

   **Storage Driver Support**

   In addition to the open source technologies, there are a number of
   proprietary solutions that are officially supported by OpenStack Block
   Storage. You can find a matrix of the functionality provided by all of the
   supported Block Storage drivers on the `OpenStack
   wiki <https://wiki.openstack.org/wiki/CinderSupportMatrix>`_.

Also, you need to decide whether you want to support object storage in
your cloud. The two common use cases for providing object storage in a
compute cloud are:

* To provide users with a persistent storage mechanism
* As a scalable, reliable data store for virtual machine images

