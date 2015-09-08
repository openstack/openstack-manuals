====================================
Install and configure a storage node
====================================

This section describes how to install and configure storage nodes
for the Block Storage service. For simplicity, this configuration
references one storage node with an empty local block storage device
:file:`/dev/sdb` that contains a suitable partition table with
one partition :file:`/dev/sdb1` occupying the entire device.
The service provisions logical volumes on this device using the
:term:`LVM <Logical Volume Manager (LVM)>` driver and provides them
to instances via :term:`iSCSI` transport. You can follow these
instructions with minor modifications to horizontally scale your
environment with additional storage nodes.

To configure prerequisites
~~~~~~~~~~~~~~~~~~~~~~~~~~

You must configure the storage node before you install and
configure the volume service on it. Similar to the controller node,
the storage node contains one network interface on the
:term:`management network`. The storage node also
needs an empty block storage device of suitable size for your
environment. For more information, see :ref:`environment`.

1. Configure the management interface:

   IP address: 10.0.0.41

   Network mask: 255.255.255.0 (or /24)

   Default gateway: 10.0.0.1

2. Set the hostname of the node to ``block1``.

3. Copy the contents of the :file:`/etc/hosts` file from the
   controller node to the storage node and add the following to it::

      # block1
      10.0.0.41       block1

   Also add this content to the :file:`/etc/hosts` file
   on all other nodes in your environment.

4. Install and configure :term:`NTP` using the instructions in
   :ref:`environment-ntp`.

.. only:: obs

   5. If you intend to use non-raw image types such as QCOW2 and VMDK,
      install the QEMU support package:

      .. code-block:: console

         # zypper install qemu

   6. Install the LVM packages:

.. only:: rdo

   5. If you intend to use non-raw image types such as QCOW2 and VMDK,
      install the QEMU support package:

      .. code-block:: console

         # yum install qemu

   6. Install the LVM packages:

      .. code-block:: console

         # yum install lvm2

      .. note::

         Some distributions include LVM by default.

      Start the LVM metadata service and configure it to start when the
      system boots:

      .. code-block:: console

         # systemctl enable lvm2-lvmetad.service
         # systemctl start lvm2-lvmetad.service

.. only:: ubuntu

   5. If you intend to use non-raw image types such as QCOW2 and VMDK,
      install the QEMU support package:

      .. code-block:: console

         # apt-get install qemu

      .. note::

         Some distributions include LVM by default.

   6. Install the LVM packages:

      .. code-block:: console

         # apt-get install lvm2

      .. note::

         Some distributions include LVM by default.


7. Create the LVM physical volume :file:`/dev/sdb1`:

   .. code-block:: console

      # pvcreate /dev/sdb1
      Physical volume "/dev/sdb1" successfully created

   .. note::

      If your system uses a different device name, adjust these
      steps accordingly.

8. Create the LVM volume group ``cinder-volumes``:

   .. code-block:: console

      # vgcreate cinder-volumes /dev/sdb1
      Volume group "cinder-volumes" successfully created

   The Block Storage service creates logical volumes in this volume group.

9. Only instances can access Block Storage volumes. However, the
   underlying operating system manages the devices associated with
   the volumes. By default, the LVM volume scanning tool scans the
   :file:`/dev` directory for block storage devices that
   contain volumes. If projects use LVM on their volumes, the scanning
   tool detects these volumes and attempts to cache them which can cause
   a variety of problems with both the underlying operating system
   and project volumes. You must reconfigure LVM to scan only the devices
   that contain the ``cinder-volume`` volume group. Edit the
   :file:`/etc/lvm/lvm.conf` file and complete the following actions:

   a. In the ``devices`` section, add a filter that accepts the
      :file:`/dev/sdb` device and rejects all other devices::

        devices {
        ...
        filter = [ "a/sdb/", "r/.*/"]

      Each item in the filter array begins with ``a`` for **accept** or
      ``r`` for **reject** and includes a regular expression for the
      device name. The array must end with ``r/.*/`` to reject any
      remaining devices. You can use the :command:`vgs -vvvv` command
      to test filters.

      .. warning::

         If your storage nodes use LVM on the operating system disk, you
         must also add the associated device to the filter. For example,
         if the :file:`/dev/sda` device contains the operating system:

         .. code-block:: ini

            filter = [ "a/sda/", "a/sdb/", "r/.*/"]

         Similarly, if your compute nodes use LVM on the operating
         system disk, you must also modify the filter in the
         :file:`/etc/lvm/lvm.conf` file on those nodes to include only
         the operating system disk. For example, if the :file:`/dev/sda`
         device contains the operating system:

         .. code-block:: ini

            filter = [ "a/sda/", "r/.*/"]

Install and configure Block Storage volume components
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. only:: obs

   1. Install the packages:

      .. code-block:: console

         # zypper install openstack-cinder-volume tgt python-mysql

.. only:: rdo

   1. Install the packages:

      .. code-block:: console

         # yum install openstack-cinder targetcli python-oslo-db \
           python-oslo-log PyMySQL

      .. Temporary workaround for bug:
         https://bugzilla.redhat.com/show_bug.cgi?id=1212899

.. only:: ubuntu

   1. Install the packages:

      .. code-block:: console

        # apt-get install cinder-volume python-mysqldb

2. Edit the :file:`/etc/cinder/cinder.conf` file
   and complete the following actions:

   a. In the ``[database]`` section, configure database access:

      .. code-block:: ini

         [database]
         ...
         connection = mysql+pymysql://cinder:CINDER_DBPASS@controller/cinder

      Replace ``CINDER_DBPASS`` with the password you chose for
      the Block Storage database.

   b. In the ``[DEFAULT]`` and ``[oslo_messaging_rabbit]`` sections,
      configure ``RabbitMQ`` message queue access:

      .. code-block:: ini

         [DEFAULT]
         ...
         rpc_backend = rabbit

         [oslo_messaging_rabbit]
         ...
         rabbit_host = controller
         rabbit_userid = openstack
         rabbit_password = RABBIT_PASS

      Replace ``RABBIT_PASS`` with the password you chose for
      the ``openstack`` account in ``RabbitMQ``.

   c. In the ``[DEFAULT]`` and ``[keystone_authtoken]`` sections,
      configure Identity service access:

      .. code-block:: ini

         [DEFAULT]
         ...
         auth_strategy = keystone

         [keystone_authtoken]
         ...
         auth_uri = http://controller:5000
         auth_url = http://controller:35357
         auth_plugin = password
         project_domain_id = default
         user_domain_id = default
         project_name = service
         username = cinder
         password = CINDER_PASS

      Replace ``CINDER_PASS`` with the password you chose for the
      ``cinder`` user in the Identity service.

      .. note::

         Comment out or remove any other options in the
         ``[keystone_authtoken]`` section.

   d. In the ``[DEFAULT]`` section, configure the ``my_ip`` option:

      .. code-block:: ini

         [DEFAULT]
         ...
         my_ip = MANAGEMENT_INTERFACE_IP_ADDRESS

      Replace ``MANAGEMENT_INTERFACE_IP_ADDRESS`` with the IP address
      of the management network interface on your storage node,
      typically 10.0.0.41 for the first node in the
      :ref:`example architecture <overview-example-architectures>`.

   .. only:: obs or ubuntu

      e. In the ``[lvm]`` section, configure the LVM back end with the
         LVM driver, ``cinder-volumes`` volume group, iSCSI protocol,
         and appropriate iSCSI service:

         .. code-block:: ini

            [lvm]
            ...
            volume_driver = cinder.volume.drivers.lvm.LVMVolumeDriver
            volume_group = cinder-volumes
            iscsi_protocol = iscsi
            iscsi_helper = tgtadm

   .. only:: rdo

      e. In the ``[lvm]`` section, configure the LVM back end with the
         LVM driver, ``cinder-volumes`` volume group, iSCSI protocol,
         and appropriate iSCSI service:

         .. code-block:: ini

            [lvm]
            ...
            volume_driver = cinder.volume.drivers.lvm.LVMVolumeDriver
            volume_group = cinder-volumes
            iscsi_protocol = iscsi
            iscsi_helper = lioadm

   f. In the ``[DEFAULT]`` section, enable the LVM back end:

      .. code-block:: ini

         [DEFAULT]
         ...
         enabled_backends = lvm

      .. note::

         Back-end names are arbitrary. As an example, this guide
         uses the name of the driver as the name of the back end.

   g. In the ``[DEFAULT]`` section, configure the location of the
      Image service:

      .. code-block:: ini

         [DEFAULT]
         ...
         glance_host = controller

   h. In the ``[oslo_concurrency]`` section, configure the lock path:

      .. code-block:: ini

         [oslo_concurrency]
         ...
         lock_path = /var/lock/cinder

   i. (Optional) To assist with troubleshooting, enable verbose logging
      in the ``[DEFAULT]`` section:

      .. code-block:: ini

         [DEFAULT]
         ...
         verbose = True

To finalize installation
~~~~~~~~~~~~~~~~~~~~~~~~

.. only:: obs

   1. Start the Block Storage volume service including its dependencies
      and configure them to start when the system boots:

      .. code-block:: console

         # systemctl enable openstack-cinder-volume.service tgtd.service
         # systemctl start openstack-cinder-volume.service tgtd.service

.. only:: rdo

   1. Start the Block Storage volume service including its dependencies
      and configure them to start when the system boots:

      .. code-block:: console

         # systemctl enable openstack-cinder-volume.service target.service
         # systemctl start openstack-cinder-volume.service target.service

.. only:: ubuntu

   1. Restart the Block Storage volume service including its dependencies:

      .. code-block:: console

         # service tgt restart
         # service cinder-volume restart

   2. By default, the Ubuntu packages create an SQLite database.
      Because this configuration uses an SQL database server,
      remove the SQLite database file:

      .. code-block:: console

         # rm -f /var/lib/cinder/cinder.sqlite
