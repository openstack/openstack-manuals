.. _swift-storage:

Install and configure the storage nodes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section describes how to install and configure storage nodes
that operate the account, container, and object services. For
simplicity, this configuration references two storage nodes, each
containing two empty local block storage devices. The instructions
use ``/dev/sdb`` and ``/dev/sdc``, but you can substitute different
values for your particular nodes.

Although Object Storage supports any file system with
:term:`extended attributes (xattr)`, testing and benchmarking
indicate the best performance and reliability on :term:`XFS`. For
more information on horizontally scaling your environment, see the
`Deployment Guide <http://docs.openstack.org/developer/swift/deployment_guide.html>`_.

Prerequisites
-------------

Before you install and configure the Object Storage service on the
storage nodes, you must prepare the storage devices.

.. note::

   Perform these steps on each storage node.

#. Install the supporting utility packages:

   .. only:: ubuntu or debian

      .. code-block:: console

         # apt-get install xfsprogs rsync

   .. only:: rdo

      .. code-block:: console

         # yum install xfsprogs rsync

   .. only:: obs

      .. code-block:: console

         # zypper install xfsprogs rsync

#. Format the ``/dev/sdb`` and ``/dev/sdc`` devices as XFS:

   .. code-block:: console

      # mkfs.xfs /dev/sdb
      # mkfs.xfs /dev/sdc

#. Create the mount point directory structure:

   .. code-block:: console

      # mkdir -p /srv/node/sdb
      # mkdir -p /srv/node/sdc

#. Edit the ``/etc/fstab`` file and add the following to it:

   .. code-block:: ini

        /dev/sdb /srv/node/sdb xfs noatime,nodiratime,nobarrier,logbufs=8 0 2
        /dev/sdc /srv/node/sdc xfs noatime,nodiratime,nobarrier,logbufs=8 0 2

#. Mount the devices:

   .. code-block:: console

      # mount /srv/node/sdb
      # mount /srv/node/sdc

#. Create or edit the ``/etc/rsyncd.conf`` file to contain the following:

   .. code-block:: ini

      uid = swift
      gid = swift
      log file = /var/log/rsyncd.log
      pid file = /var/run/rsyncd.pid
      address = MANAGEMENT_INTERFACE_IP_ADDRESS

      [account]
      max connections = 2
      path = /srv/node/
      read only = False
      lock file = /var/lock/account.lock

      [container]
      max connections = 2
      path = /srv/node/
      read only = False
      lock file = /var/lock/container.lock

      [object]
      max connections = 2
      path = /srv/node/
      read only = False
      lock file = /var/lock/object.lock

   Replace ``MANAGEMENT_INTERFACE_IP_ADDRESS`` with the IP address of the
   management network on the storage node.

   .. note::

      The ``rsync`` service requires no authentication, so consider running
      it on a private network in production environments.

.. only:: ubuntu or debian

   7. Edit the ``/etc/default/rsync`` file and enable the ``rsync``
      service:

      .. code-block:: ini

         RSYNC_ENABLE=true

   8. Start the ``rsync`` service:

      .. code-block:: console

         # service rsync start

.. only:: obs or rdo

   7. Start the ``rsyncd`` service and configure it to start when the
      system boots:

      .. code-block:: console

         # systemctl enable rsyncd.service
         # systemctl start rsyncd.service

Install and configure components
--------------------------------

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

   2. Obtain the accounting, container, and object service configuration
      files from the Object Storage source repository:

      .. code-block:: console

         # curl -o /etc/swift/account-server.conf https://git.openstack.org/cgit/openstack/swift/plain/etc/account-server.conf-sample?h=mitaka-eol
         # curl -o /etc/swift/container-server.conf https://git.openstack.org/cgit/openstack/swift/plain/etc/container-server.conf-sample?h=mitaka-eol
         # curl -o /etc/swift/object-server.conf https://git.openstack.org/cgit/openstack/swift/plain/etc/object-server.conf-sample?h=mitaka-eol

   3.  .. include:: swift-storage-include1.txt
   4.  .. include:: swift-storage-include2.txt
   5.  .. include:: swift-storage-include3.txt
   6. Ensure proper ownership of the mount point directory structure:

      .. code-block:: console

         # chown -R swift:swift /srv/node

   7. Create the ``recon`` directory and ensure proper ownership of it:

      .. code-block:: console

         # mkdir -p /var/cache/swift
         # chown -R root:swift /var/cache/swift
         # chmod -R 775 /var/cache/swift

.. only:: obs

   2. .. include:: swift-storage-include1.txt
   3. .. include:: swift-storage-include2.txt
   4. .. include:: swift-storage-include3.txt
   5. Ensure proper ownership of the mount point directory structure:

      .. code-block:: console

         # chown -R swift:swift /srv/node
