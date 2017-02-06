====================
CephFS Native driver
====================

The CephFS Native driver enables the Shared File Systems service to export
shared file systems to guests using the Ceph network protocol. Guests require a
Ceph client in order to mount the file system.

Access is controlled via Ceph's cephx authentication system. When a user
requests share access for an ID, Ceph creates a corresponding Ceph auth ID and
a secret key, if they do not already exist, and authorizes the ID to access
the share. The client can then mount the share using the ID and the secret
key.

To learn more about configuring Ceph clients to access the shares created
using this driver, please see the Ceph documentation (
http://docs.ceph.com/docs/master/cephfs/). If you choose to use the kernel
client rather than the FUSE client, the share size limits set in the
Shared File Systems service may not be obeyed.

Supported shared file systems and operations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The driver supports CephFS shares.

The following operations are supported with CephFS back end:

- Create a share.

- Delete a share.

- Allow share access.

  - ``read-only`` access level is supported.

  - ``read-write`` access level is supported.


  Note the following limitation for CephFS shares:

  - Only ``cephx`` access type is supported.

- Deny share access.

- Create a snapshot.

- Delete a snapshot.

- Create a consistency group (CG).

- Delete a CG.

- Create a CG snapshot.

- Delete a CG snapshot.

Requirements
~~~~~~~~~~~~

- Mitaka or later versions of manila.

- Jewel or later versions of Ceph.

- A Ceph cluster with a file system configured (
  http://docs.ceph.com/docs/master/cephfs/createfs/)

- ``ceph-common`` package installed in the servers running the
  ``manila-share`` service.

- Ceph client installed in the guest, preferably the FUSE based client,
  ``ceph-fuse``.

- Network connectivity between your Ceph cluster's public network and the
  servers running the ``manila-share`` service.

- Network connectivity between your Ceph cluster's public network and guests.

.. important:: A manila share backed onto CephFS is only as good as the
               underlying file system. Take care when configuring your Ceph
               cluster, and consult the latest guidance on the use of
               CephFS in the Ceph documentation (
               http://docs.ceph.com/docs/master/cephfs/).

Authorize the driver to communicate with Ceph
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Run the following commands to create a Ceph identity for the Shared File
Systems service to use:

.. code-block:: console

    read -d '' MON_CAPS << EOF
    allow r,
    allow command "auth del",
    allow command "auth caps",
    allow command "auth get",
    allow command "auth get-or-create"
    EOF

    ceph auth get-or-create client.manila -o manila.keyring \
    mds 'allow *' \
    osd 'allow rw' \
    mon "$MON_CAPS"


``manila.keyring``, along with your ``ceph.conf`` file, then needs to be placed
on the server running the ``manila-share`` service.

Enable snapshots in Ceph if you want to use them in the Shared File Systems
service:

.. code-block:: console

    ceph mds set allow_new_snaps true --yes-i-really-mean-it

In the server running the ``manila-share`` service, you can place the
``ceph.conf`` and ``manila.keyring`` files in the ``/etc/ceph`` directory. Set
the same owner for the ``manila-share`` process and the ``manila.keyring``
file. Add the following section to the ``ceph.conf`` file.

.. code-block:: ini

    [client.manila]
    client mount uid = 0
    client mount gid = 0
    log file = /opt/stack/logs/ceph-client.manila.log
    admin socket = /opt/stack/status/stack/ceph-$name.$pid.asok
    keyring = /etc/ceph/manila.keyring

It is advisable to modify the Ceph client's admin socket file and log file
locations so that they are co-located with the Shared File Systems services'
pid files and log files respectively.


Configure CephFS back end in ``manila.conf``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Add CephFS to ``enabled_share_protocols`` (enforced at the Shared File
   Systems service's API layer). In this example we leave NFS and CIFS enabled,
   although you can remove these if you only use CephFS:

   .. code-block:: ini

       enabled_share_protocols = NFS,CIFS,CEPHFS

#. Refer to the following table for the list of all the ``cephfs_native``
   driver-specific configuration options.

   .. include:: ../../tables/manila-cephfs.rst

   Create a section to define a CephFS back end:

   .. code-block:: ini

       [cephfs1]
       driver_handles_share_servers = False
       share_backend_name = CEPHFS1
       share_driver = manila.share.drivers.cephfs.cephfs_native.CephFSNativeDriver
       cephfs_conf_path = /etc/ceph/ceph.conf
       cephfs_auth_id = manila
       cephfs_cluster_name = ceph
       cephfs_enable_snapshots = True

   Set ``cephfs_enable_snapshots`` to ``True`` in the section to let the driver
   perform snapshot-related operations. Also set the
   ``driver-handles-share-servers`` to ``False`` as the driver does not manage
   the lifecycle of ``share-servers``.

#. Edit ``enabled_share_backends`` to point to the driver's back-end section
   using the section name. In this example we are also including another
   back end (``generic1``), you would include whatever other back ends you have
   configured.

   .. code-block:: ini

       enabled_share_backends = generic1,cephfs1


Creating shares
~~~~~~~~~~~~~~~

The default share type may have ``driver_handles_share_servers`` set to
``True``. Configure a share type suitable for CephFS:

.. code-block:: console

     manila type-create cephfstype false

     manila type-set cephfstype set share_backend_name='CEPHFS1'

Then create a share:

.. code-block:: console

    manila create --share-type cephfstype --name cephshare1 cephfs 1

Note the export location of the share:

.. code-block:: console

    manila share-export-location-list cephshare1

The export location of the share contains the Ceph monitor (mon) addresses and
ports, and the path to be mounted. It is of the form,
``{mon ip addr:port}[,{mon ip addr:port}]:{path to be mounted}``


Allowing access to shares
~~~~~~~~~~~~~~~~~~~~~~~~~

Allow Ceph auth ID ``alice`` access to the share using ``cephx`` access type.

.. code-block:: console

    manila access-allow cephshare1 cephx alice

Note the access status and the secret access key of ``alice``.

.. code-block:: console

    manila access-list cephshare1


Mounting shares using FUSE client
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Using the secret key of the authorized ID ``alice``, create a keyring file
``alice.keyring``.

.. code-block:: ini

    [client.alice]
            key = AQA8+ANW/4ZWNRAAOtWJMFPEihBA1unFImJczA==

Using the monitor IP addresses from the share's export location, create a
configuration file, ``ceph.conf``:

.. code-block:: ini

    [client]
            client quota = true
            mon host = 192.168.1.7:6789, 192.168.1.8:6789, 192.168.1.9:6789

Finally, mount the file system, substituting the file names of the keyring and
configuration files you just created, and substituting the path to be mounted
from the share's export location:

.. code-block:: console

    sudo ceph-fuse ~/mnt \
    --id=alice \
    --conf=./ceph.conf \
    --keyring=./alice.keyring \
    --client-mountpoint=/volumes/_nogroup/4c55ad20-9c55-4a5e-9233-8ac64566b98c


Known restrictions
~~~~~~~~~~~~~~~~~~

Consider the driver as a building block for supporting multi-tenant workloads
in the future. However, it can be used in private cloud deployments.

- The guests have direct access to Ceph's public network.

- The snapshot support of the driver is disabled by default.
  ``cephfs_enable_snapshots`` configuration option needs to be set to ``True``
  to allow snapshot operations.

- Snapshots are read-only. A user can read a snapshot's contents from the
  ``.snap/{manila-snapshot-id}_{unknown-id}`` folder within the mounted
  share.

- To restrict share sizes, CephFS uses quotas that are enforced in the client
  side. The CephFS clients are relied on to respect quotas.


Security
~~~~~~~~

- Each share's data is mapped to a distinct Ceph RADOS namespace. A guest is
  restricted to access only that particular RADOS namespace.

- An additional level of resource isolation can be provided by mapping a
  share's contents to a separate RADOS pool. This layout would be preferred
  only for cloud deployments with a limited number of shares needing strong
  resource separation. You can do this by setting a share type specification,
  ``cephfs:data_isolated`` for the share type used by the cephfs driver.

  .. code-block:: console

       manila type-key cephfstype set cephfs:data_isolated=True

- Untrusted manila guests pose security risks to the Ceph storage cluster as
  they would have direct access to the cluster's public network.
