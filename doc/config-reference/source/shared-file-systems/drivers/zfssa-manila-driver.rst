===================================
Oracle ZFS Storage Appliance driver
===================================
The Oracle ZFS Storage Appliance driver, version 1.0.0, enables the
Oracle ZFS Storage Appliance (ZFSSA) to be used seamlessly as a shared
storage resource for the OpenStack File System service (manila). The driver
provides the ability to create and manage NFS and CIFS shares
on the appliance, allowing virtual machines to access the shares
simultaneously and securely.

Requirements
~~~~~~~~~~~~
Oracle ZFS Storage Appliance Software version 2013.1.2.0 or later.

Supported operations
~~~~~~~~~~~~~~~~~~~~

- Create NFS and CIFS shares.
- Delete NFS and CIFS shares.
- Allow or deny IP access to NFS shares.
- Create snapshots of a share.
- Delete snapshots of a share.
- Create share from snapshot.

Restrictions
~~~~~~~~~~~~

- Access to CIFS shares are open and cannot be changed from manila.
- Version 1.0.0 of the driver only supports Single SVM networking mode.

Appliance configuration
~~~~~~~~~~~~~~~~~~~~~~~

#. Enable RESTful service on the ZFSSA Storage Appliance.

#. Create a new user on the appliance with the following authorizations:

   .. code-block:: none

      scope=stmf - allow_configure=true
      scope=nas - allow_clone=true, allow_createProject=true, allow_createShare=true, allow_changeSpaceProps=true, allow_changeGeneralProps=true, allow_destroy=true, allow_rollback=true, allow_takeSnap=true

   You can create a role with authorizations as follows:

   .. code-block:: none

      zfssa:> configuration roles
      zfssa:configuration roles> role OpenStackRole
      zfssa:configuration roles OpenStackRole (uncommitted)> set description="OpenStack Manila Driver"
      zfssa:configuration roles OpenStackRole (uncommitted)> commit
      zfssa:configuration roles> select OpenStackRole
      zfssa:configuration roles OpenStackRole> authorizations create
      zfssa:configuration roles OpenStackRole auth (uncommitted)> set scope=stmf
      zfssa:configuration roles OpenStackRole auth (uncommitted)> set allow_configure=true
      zfssa:configuration roles OpenStackRole auth (uncommitted)> commit

   You can create a user with a specific role as follows:

   .. code-block:: none

      zfssa:> configuration users
      zfssa:configuration users> user cinder
      zfssa:configuration users cinder (uncommitted)> set fullname="OpenStack Manila Driver"
      zfssa:configuration users cinder (uncommitted)> set initial_password=12345
      zfssa:configuration users cinder (uncommitted)> commit
      zfssa:configuration users> select cinder set roles=OpenStackRole

#. Create a storage pool.

   An existing pool can also be used if required. You can create a pool
   as follows:

   .. code-block:: none

      zfssa:> configuration storage
      zfssa:configuration storage> config pool
      zfssa:configuration storage verify> set data=2
      zfssa:configuration storage verify> done
      zfssa:configuration storage config> done

#. Create a new project.

   You can create a project as follows:

   .. code-block:: none

      zfssa:> shares
      zfssa:shares> project proj
      zfssa:shares proj (uncommitted)> commit

#. Create a new or use an existing data IP address.

   You can create an interface as follows:

   .. code-block:: none

      zfssa:> configuration net interfaces ip
      zfssa:configuration net interfaces ip (uncommitted)> set v4addrs=127.0.0.1/24
                           v4addrs = 127.0.0.1/24 (uncommitted)
      zfssa:configuration net interfaces ip (uncommitted)> set links=vnic1
                             links = vnic1 (uncommitted)
      zfssa:configuration net interfaces ip (uncommitted)> set admin=false
                             admin = false (uncommitted)
      zfssa:configuration net interfaces ip (uncommitted)> commit

   It is required that both interfaces used for data and management are
   configured properly. The data interface must be different from the
   management interface.

#. Configure the cluster.

   If a cluster is used as the manila storage resource, the following
   verifications are required:

   - Verify that both the newly created pool and the network interface are of
     type singleton and are not locked to the current controller.
     This approach ensures that the pool and the interface used for data
     always belong to the active controller, regardless of the current state
     of the cluster.

   - Verify that the management IP, data IP and storage pool belong to the
     same head.

   .. note::

      A short service interruption occurs during failback or takeover,
      but once the process is complete, manila should be able
      to access the pool through the data IP.

Driver options
~~~~~~~~~~~~~~

The Oracle ZFSSA driver supports these options:

.. include:: ../../tables/manila-zfssa.rst
