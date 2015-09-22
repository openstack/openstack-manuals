=======================================
Install and configure the storage nodes
=======================================

This section describes how to install and configure storage nodes
that operate the account, container, and object services. For
simplicity, this configuration references two storage nodes, each
containing two empty local block storage devices. Each of the
devices, :file:`/dev/sdb` and :file:`/dev/sdc`, must contain a
suitable partition table with one partition occupying the entire
device. Although the Object Storage service supports any file system
with :term:`extended attributes (xattr)`, testing and benchmarking
indicate the best performance and reliability on :term:`XFS`. For
more information on horizontally scaling your environment, see the
`Deployment Guide <http://docs.openstack.org/developer/swift/deployment_guide.html>`_.

To configure prerequisites
~~~~~~~~~~~~~~~~~~~~~~~~~~

You must configure each storage node before you install and configure
the Object Storage service on it. Similar to the controller node, each
storage node contains one network interface on the :term:`management network`.
Optionally, each storage node can contain a second network interface on
a separate network for replication. For more information, see
:ref:`environment`.

#. Configure unique items on the first storage node:

   Configure the management interface:

   * IP address: ``10.0.0.51``
   * Network mask: ``255.255.255.0`` (or ``/24``)
   * Default gateway: ``10.0.0.1``

   Set the hostname of the node to ``object1``.

#. Configure unique items on the second storage node:

   Configure the management interface:

   * IP address: ``10.0.0.52``
   * Network mask: ``255.255.255.0`` (or ``/24``)
   * Default gateway: ``10.0.0.1``

   Set the hostname of the node to ``object2``.

#. Configure shared items on both storage nodes:

   * Copy the contents of the :file:`/etc/hosts` file from the controller
     node and add the following to it:

     .. code-block:: ini
        :linenos:

        # object1
        10.0.0.51        object1

        # object2
        10.0.0.52        object2

     Also add this content to the :file:`/etc/hosts` file on all other
     nodes in your environment.

   * Install and configure :term:`NTP` using the instructions in
     :ref:`environment-ntp`.

   * Install the supporting utility packages:

     .. only:: ubuntu or debian

       .. code-block:: console

          # apt-get install xfsprogs rsync

     .. only:: rdo

       .. code-block:: console

          # yum install xfsprogs rsync

     .. only:: obs

       .. code-block:: console

          # zypper install xfsprogs rsync

   * Format the :file:`/dev/sdb1` and :file:`/dev/sdc1` partitions as XFS:

     .. code-block:: console

        # mkfs.xfs /dev/sdb1
        # mkfs.xfs /dev/sdc1

   * Create the mount point directory structure:

     .. code-block:: console

        # mkdir -p /srv/node/sdb1
        # mkdir -p /srv/node/sdc1

   * Edit the :file:`/etc/fstab` file and add the following to it:

     .. code-block:: ini
        :linenos:

        /dev/sdb1 /srv/node/sdb1 xfs noatime,nodiratime,nobarrier,logbufs=8 0 2
        /dev/sdc1 /srv/node/sdc1 xfs noatime,nodiratime,nobarrier,logbufs=8 0 2

   * Mount the devices:

     .. code-block:: console

        # mount /srv/node/sdb1
        # mount /srv/node/sdc1

#. Edit the :file:`/etc/rsyncd.conf` file and add the following to it:

   .. code-block:: ini
      :linenos:

      uid = swift
      gid = swift
      log file = /var/log/rsyncd.log
      pid file = /var/run/rsyncd.pid
      address = MANAGEMENT_INTERFACE_IP_ADDRESS

      [account]
      max connections = 2
      path = /srv/node/
      read only = false
      lock file = /var/lock/account.lock

      [container]
      max connections = 2
      path = /srv/node/
      read only = false
      lock file = /var/lock/container.lock

      [object]
      max connections = 2
      path = /srv/node/
      read only = false
      lock file = /var/lock/object.lock

   Replace ``MANAGEMENT_INTERFACE_IP_ADDRESS`` with the IP address of the
   management network on the storage node.

   .. note::

      The ``rsync`` service requires no authentication, so consider running
      it on a private network.

.. only:: ubuntu or debian

   5. Edit the :file:`/etc/default/rsync` file and enable the ``rsync``
      service:

      .. code-block:: ini
         :linenos:

         RSYNC_ENABLE=true

   6. Start the ``rsync`` service:

      .. code-block:: console

         # service rsync start

.. only:: obs or rdo

   5. Start the ``rsyncd`` service and configure it to start when the
      system boots:

      .. code-block:: console

         # systemctl enable rsyncd.service
         # systemctl start rsyncd.service

Install and configure storage node components
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. include:: shared/note_configuration_vary_by_distribution.rst

.. note::

   Perform these steps on each storage node.

#. Install the packages:

   .. only:: ubuntu or debian

      .. code-block:: console

         # apt-get install swift swift-account swift-container swift-object

   .. only:: rdo

      .. code-block:: console

         # yum install openstack-swift-account openstack-swift-container \
           openstack-swift-object

   .. only:: obs

      .. code-block:: console

         # zypper install openstack-swift-account \
           openstack-swift-container openstack-swift-object python-xml

.. only:: ubuntu or rdo or debian

   2. Obtain the accounting, container, object, container-reconciler, and
      object-expirer service configuration files from the Object Storage
      source repository:

      .. code-block:: console

         # curl -o /etc/swift/account-server.conf \
           https://git.openstack.org/cgit/openstack/swift/plain/etc/account-server.conf-sample?h=stable/kilo
         # curl -o /etc/swift/container-server.conf \
           https://git.openstack.org/cgit/openstack/swift/plain/etc/container-server.conf-sample?h=stable/kilo
         # curl -o /etc/swift/object-server.conf \
           https://git.openstack.org/cgit/openstack/swift/plain/etc/object-server.conf-sample?h=stable/kilo
         # curl -o /etc/swift/container-reconciler.conf \
           https://git.openstack.org/cgit/openstack/swift/plain/etc/container-reconciler.conf-sample?h=stable/kilo
         # curl -o /etc/swift/object-expirer.conf \
           https://git.openstack.org/cgit/openstack/swift/plain/etc/object-expirer.conf-sample?h=stable/kilo

   3.  .. include:: swift-storage-node-include1.txt
   4.  .. include:: swift-storage-node-include2.txt
   5.  .. include:: swift-storage-node-include3.txt
   6. Ensure proper ownership of the mount point directory structure:

      .. code-block:: console

         # chown -R swift:swift /srv/node

   7. Create the :file:`recon` directory and ensure proper ownership of it:

      .. code-block:: console

         # mkdir -p /var/cache/swift
         # chown -R swift:swift /var/cache/swift

.. only:: obs

   2. .. include:: swift-storage-node-include1.txt
   3. .. include:: swift-storage-node-include2.txt
   4. .. include:: swift-storage-node-include3.txt
   5. Ensure proper ownership of the mount point directory structure:

      .. code-block:: console

         # chown -R swift:swift /srv/node

   6. Create the :file:`recon` directory and ensure proper ownership of it:

      .. code-block:: console

         # mkdir -p /var/cache/swift
         # chown -R swift:swift /var/cache/swift
