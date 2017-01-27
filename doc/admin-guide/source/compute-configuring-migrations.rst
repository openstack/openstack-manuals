.. _section_configuring-compute-migrations:

====================
Configure migrations
====================

.. :ref:`_configuring-migrations-kvm-libvirt`
.. :ref:`_configuring-migrations-xenserver`

.. note::

   Only administrators can perform live migrations. If your cloud
   is configured to use cells, you can perform live migration within
   but not between cells.

Migration enables an administrator to move a virtual-machine instance
from one compute host to another. This feature is useful when a compute
host requires maintenance. Migration can also be useful to redistribute
the load when many VM instances are running on a specific physical
machine.

The migration types are:

-  **Non-live migration** (sometimes referred to simply as 'migration').
   The instance is shut down for a period of time to be moved to another
   hypervisor. In this case, the instance recognizes that it was
   rebooted.

-  **Live migration** (or 'true live migration'). Almost no instance
   downtime. Useful when the instances must be kept running during the
   migration. The different types of live migration are:

   -  **Shared storage-based live migration**. Both hypervisors have
      access to shared storage.

   -  **Block live migration**. No shared storage is required.
      Incompatible with read-only devices such as CD-ROMs and
      `Configuration Drive (config\_drive) <https://docs.openstack.org/user-guide/cli-config-drive.html>`_.

   -  **Volume-backed live migration**. Instances are backed by volumes
      rather than ephemeral disk, no shared storage is required, and
      migration is supported (currently only available for libvirt-based
      hypervisors).

The following sections describe how to configure your hosts and compute
nodes for migrations by using the KVM and XenServer hypervisors.

.. _configuring-migrations-kvm-libvirt:

KVM-Libvirt
~~~~~~~~~~~

.. :ref:`_configuring-migrations-kvm-shared-storage`
.. :ref:`_configuring-migrations-kvm-block-migration`

.. _configuring-migrations-kvm-shared-storage:

Shared storage
--------------

.. :ref:`_section_example-compute-install`
.. :ref:`_true-live-migration-kvm-libvirt`

**Prerequisites**

-  **Hypervisor:** KVM with libvirt

-  **Shared storage:** ``NOVA-INST-DIR/instances/`` (for example,
   ``/var/lib/nova/instances``) has to be mounted by shared storage.
   This guide uses NFS but other options, including the
   `OpenStack Gluster Connector <http://gluster.org/community/documentation//index.php/OSConnect>`_
   are available.

-  **Instances:** Instance can be migrated with iSCSI-based volumes.

**Notes**

-  Because the Compute service does not use the libvirt live
   migration functionality by default, guests are suspended before
   migration and might experience several minutes of downtime. For
   details, see `Enabling true live migration`.

-  Compute calculates the amount of downtime required using the RAM size of
   the disk being migrated, in accordance with the ``live_migration_downtime``
   configuration parameters. Migration downtime is measured in steps, with an
   exponential backoff between each step. This means that the maximum
   downtime between each step starts off small, and is increased in ever
   larger amounts as Compute waits for the migration to complete. This gives
   the guest a chance to complete the migration successfully, with a minimum
   amount of downtime.

-  This guide assumes the default value for ``instances_path`` in
   your ``nova.conf`` file (``NOVA-INST-DIR/instances``). If you
   have changed the ``state_path`` or ``instances_path`` variables,
   modify the commands accordingly.

-  You must specify ``vncserver_listen=0.0.0.0`` or live migration
   will not work correctly.

-  You must specify the ``instances_path`` in each node that runs
   ``nova-compute``. The mount point for ``instances_path`` must be the
   same value for each node, or live migration will not work
   correctly.

.. _section_example-compute-install:

Example Compute installation environment
----------------------------------------

-  Prepare at least three servers. In this example, we refer to the
   servers as ``HostA``, ``HostB``, and ``HostC``:

   -  ``HostA`` is the Cloud Controller, and should run these services:
      ``nova-api``, ``nova-scheduler``, ``nova-network``, ``cinder-volume``,
      and ``nova-objectstore``.

   -  ``HostB`` and ``HostC`` are the compute nodes that run
      ``nova-compute``.

   Ensure that ``NOVA-INST-DIR`` (set with ``state_path`` in the
   ``nova.conf`` file) is the same on all hosts.

-  In this example, ``HostA`` is the NFSv4 server that exports
   ``NOVA-INST-DIR/instances`` directory. ``HostB`` and ``HostC`` are
   NFSv4 clients that mount ``HostA``.

**Configuring your system**

#. Configure your DNS or ``/etc/hosts`` and ensure it is consistent across
   all hosts. Make sure that the three hosts can perform name resolution
   with each other. As a test, use the :command:`ping` command to ping each host
   from one another:

   .. code-block:: console

      $ ping HostA
      $ ping HostB
      $ ping HostC

#. Ensure that the UID and GID of your Compute and libvirt users are
   identical between each of your servers. This ensures that the
   permissions on the NFS mount works correctly.

#. Ensure you can access SSH without a password and without
   StrictHostKeyChecking between ``HostB`` and ``HostC`` as ``nova``
   user (set with the owner of ``nova-compute`` service). Direct access
   from one compute host to another is needed to copy the VM file
   across. It is also needed to detect if the source and target
   compute nodes share a storage subsystem.

#. Export ``NOVA-INST-DIR/instances`` from ``HostA``, and ensure it is
   readable and writable by the Compute user on ``HostB`` and ``HostC``.

   For more information, see: `SettingUpNFSHowTo <https://help.ubuntu.com/community/SettingUpNFSHowTo>`_
   or `CentOS/Red Hat: Setup NFS v4.0 File Server <http://www.cyberciti.biz/faq/centos-fedora-rhel-nfs-v4-configuration/>`_

#. Configure the NFS server at ``HostA`` by adding the following line to
   the ``/etc/exports`` file:

   .. code-block:: ini

      NOVA-INST-DIR/instances HostA/255.255.0.0(rw,sync,fsid=0,no_root_squash)

   Change the subnet mask (``255.255.0.0``) to the appropriate value to
   include the IP addresses of ``HostB`` and ``HostC``. Then restart the
   ``NFS`` server:

   .. code-block:: console

      # /etc/init.d/nfs-kernel-server restart
      # /etc/init.d/idmapd restart

#. On both compute nodes, enable the ``execute/search`` bit on your shared
   directory to allow qemu to be able to use the images within the
   directories. On all hosts, run the following command:

   .. code-block:: console

      $ chmod o+x NOVA-INST-DIR/instances

#. Configure NFS on ``HostB`` and ``HostC`` by adding the following line to
   the ``/etc/fstab`` file

   .. code-block:: console

      HostA:/ /NOVA-INST-DIR/instances nfs4 defaults 0 0

   Ensure that you can mount the exported directory

   .. code-block:: console

      $ mount -a -v

   Check that ``HostA`` can see the ``NOVA-INST-DIR/instances/``
   directory

   .. code-block:: console

      $ ls -ld NOVA-INST-DIR/instances/
      drwxr-xr-x 2 nova nova 4096 2012-05-19 14:34 nova-install-dir/instances/

   Perform the same check on ``HostB`` and ``HostC``, paying special
   attention to the permissions (Compute should be able to write)

   .. code-block:: console

      $ ls -ld NOVA-INST-DIR/instances/
      drwxr-xr-x 2 nova nova 4096 2012-05-07 14:34 nova-install-dir/instances/

      $ df -k
      Filesystem           1K-blocks      Used Available Use% Mounted on
      /dev/sda1            921514972   4180880 870523828   1% /
      none                  16498340      1228  16497112   1% /dev
      none                  16502856         0  16502856   0% /dev/shm
      none                  16502856       368  16502488   1% /var/run
      none                  16502856         0  16502856   0% /var/lock
      none                  16502856         0  16502856   0% /lib/init/rw
      HostA:               921515008 101921792 772783104  12% /var/lib/nova/instances  ( <--- this line is important.)

#. Update the libvirt configurations so that the calls can be made
   securely. These methods enable remote access over TCP and are not
   documented here.

   -  SSH tunnel to libvirtd's UNIX socket

   -  libvirtd TCP socket, with GSSAPI/Kerberos for auth+data encryption

   -  libvirtd TCP socket, with TLS for encryption and x509 client certs
      for authentication

   -  libvirtd TCP socket, with TLS for encryption and Kerberos for
      authentication

   Restart ``libvirt``. After you run the command, ensure that libvirt is
   successfully restarted

   .. code-block:: console

      # stop libvirt-bin && start libvirt-bin
      $ ps -ef | grep libvirt
      root 1145 1 0 Nov27 ? 00:00:03 /usr/sbin/libvirtd -d -l\

#. Configure your firewall to allow libvirt to communicate between nodes.
   By default, libvirt listens on TCP port 16509, and an ephemeral TCP
   range from 49152 to 49261 is used for the KVM communications. Based on
   the secure remote access TCP configuration you chose, be careful which
   ports you open, and always understand who has access. For information
   about ports that are used with libvirt,
   see the `libvirt documentation <http://libvirt.org/remote.html#Remote_libvirtd_configuration>`_.

#. Configure the downtime required for the migration by adjusting these
   parameters in the ``nova.conf`` file:

   .. code-block:: ini

      live_migration_downtime = 500
      live_migration_downtime_steps = 10
      live_migration_downtime_delay = 75

   The ``live_migration_downtime`` parameter sets the maximum permitted
   downtime for a live migration, in milliseconds. This setting defaults to
   500 milliseconds.

   The ``live_migration_downtime_steps`` parameter sets the total number of
   incremental steps to reach the maximum downtime value. This setting
   defaults to 10 steps.

   The ``live_migration_downtime_delay`` parameter sets the amount of time
   to wait between each step, in seconds. This setting defaults to 75 seconds.

#. You can now configure other options for live migration. In most cases, you
   will not need to configure any options. For advanced configuration options,
   see the `OpenStack Configuration Reference Guide <https://docs.openstack.org/
   liberty/config-reference/content/list-of-compute-config-options.html
   #config_table_nova_livemigration>`_.

.. _true-live-migration-kvm-libvirt:

Enabling true live migration
----------------------------

Prior to the Kilo release, the Compute service did not use the libvirt
live migration function by default. To enable this function, add the
following line to the ``[libvirt]`` section of the ``nova.conf`` file:

.. code-block:: ini

   live_migration_flag=VIR_MIGRATE_UNDEFINE_SOURCE,VIR_MIGRATE_PEER2PEER,VIR_MIGRATE_LIVE,VIR_MIGRATE_TUNNELLED

On versions older than Kilo, the Compute service does not use libvirt's
live migration by default because there is a risk that the migration
process will never end. This can happen if the guest operating system
uses blocks on the disk faster than they can be migrated.

.. _configuring-migrations-kvm-block-migration:

Block migration
---------------

Configuring KVM for block migration is exactly the same as the above
configuration in :ref:`configuring-migrations-kvm-shared-storage`
the section called shared storage, except that ``NOVA-INST-DIR/instances``
is local to each host rather than shared. No NFS client or server
configuration is required.

.. note::

   -  To use block migration, you must use the ``--block-migrate``
      parameter with the live migration command.

   -  Block migration is incompatible with read-only devices such as
      CD-ROMs and `Configuration Drive (config_drive) <https://docs.openstack.org/user-guide/cli-config-drive.html>`_.

   -  Since the ephemeral drives are copied over the network in block
      migration, migrations of instances with heavy I/O loads may never
      complete if the drives are writing faster than the data can be
      copied over the network.

.. _configuring-migrations-xenserver:

XenServer
~~~~~~~~~

.. :ref:Shared Storage
.. :ref:Block migration

.. _configuring-migrations-xenserver-shared-storage:

Shared storage
--------------

**Prerequisites**

-  **Compatible XenServer hypervisors**. For more information, see the
   `Requirements for Creating Resource Pools <http://docs.vmd.citrix.com/XenServer/6.0.0/1.0/en_gb/reference.html#pooling_homogeneity_requirements>`_ section of the XenServer
   Administrator's Guide.

-  **Shared storage**. An NFS export, visible to all XenServer hosts.

   .. note::

      For the supported NFS versions, see the
      `NFS VHD <http://docs.vmd.citrix.com/XenServer/6.0.0/1.0/en_gb/reference.html#id1002701>`_
      section of the XenServer Administrator's Guide.

To use shared storage live migration with XenServer hypervisors, the
hosts must be joined to a XenServer pool. To create that pool, a host
aggregate must be created with specific metadata. This metadata is used
by the XAPI plug-ins to establish the pool.

**Using shared storage live migrations with XenServer Hypervisors**

#. Add an NFS VHD storage to your master XenServer, and set it as the
   default storage repository. For more information, see NFS VHD in the
   XenServer Administrator's Guide.

#. Configure all compute nodes to use the default storage repository
   (``sr``) for pool operations. Add this line to your ``nova.conf``
   configuration files on all compute nodes:

   .. code-block:: ini

      sr_matching_filter=default-sr:true

#. Create a host aggregate. This command creates the aggregate, and then
   displays a table that contains the ID of the new aggregate

   .. code-block:: console

      $ openstack aggregate create --zone AVAILABILITY_ZONE POOL_NAME

   Add metadata to the aggregate, to mark it as a hypervisor pool

   .. code-block:: console

      $ openstack aggregate set --property hypervisor_pool=true AGGREGATE_ID

      $ openstack aggregate set --property operational_state=created AGGREGATE_ID

   Make the first compute node part of that aggregate

   .. code-block:: console

      $ openstack aggregate add host AGGREGATE_ID MASTER_COMPUTE_NAME

   The host is now part of a XenServer pool.

#. Add hosts to the pool

   .. code-block:: console

      $ openstack aggregate add host AGGREGATE_ID COMPUTE_HOST_NAME

   .. note::

      The added compute node and the host will shut down to join the host
      to the XenServer pool. The operation will fail if any server other
      than the compute node is running or suspended on the host.

.. _configuring-migrations-xenserver-block-migration:

Block migration
---------------

-  **Compatible XenServer hypervisors**.
   The hypervisors must support the Storage XenMotion feature.
   See your XenServer manual to make sure your edition
   has this feature.

   .. note::

      -  To use block migration, you must use the ``--block-migrate``
         parameter with the live migration command.

      -  Block migration works only with EXT local storage storage
         repositories, and the server must not have any volumes attached.
