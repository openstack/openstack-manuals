.. _cinder-storage:

Install and configure a storage node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section describes how to install and configure storage nodes
for the Block Storage service. For simplicity, this configuration
references one storage node with an empty local block storage device.
The instructions use ``/dev/sdb``, but you can substitute a different
value for your particular node.

The service provisions logical volumes on this device using the
:term:`LVM <Logical Volume Manager (LVM)>` driver and provides them
to instances via :term:`iSCSI` transport. You can follow these
instructions with minor modifications to horizontally scale your
environment with additional storage nodes.

Prerequisites
-------------

Before you install and configure the Block Storage service on the
storage node, you must prepare the storage device.

.. note::

   Perform these steps on the storage node.

#. Install the supporting utility packages:

   .. only:: obs

      * Install the LVM packages:

        .. code-block:: console

           # zypper install lvm2

      * (Optional) If you intend to use non-raw image types such as QCOW2
        and VMDK, install the QEMU package:

        .. code-block:: console

           # zypper install qemu

   .. only:: rdo

      * Install the LVM packages:

        .. code-block:: console

           # yum install lvm2

      * Start the LVM metadata service and configure it to start when the
        system boots:

        .. code-block:: console

           # systemctl enable lvm2-lvmetad.service
           # systemctl start lvm2-lvmetad.service

   .. only:: ubuntu

        .. code-block:: console

           # apt-get install lvm2

   .. note::

      Some distributions include LVM by default.

#. Create the LVM physical volume ``/dev/sdb``:

   .. code-block:: console

      # pvcreate /dev/sdb
      Physical volume "/dev/sdb" successfully created

#. Create the LVM volume group ``cinder-volumes``:

   .. code-block:: console

      # vgcreate cinder-volumes /dev/sdb
      Volume group "cinder-volumes" successfully created

   The Block Storage service creates logical volumes in this volume group.

#. Only instances can access Block Storage volumes. However, the
   underlying operating system manages the devices associated with
   the volumes. By default, the LVM volume scanning tool scans the
   ``/dev`` directory for block storage devices that
   contain volumes. If projects use LVM on their volumes, the scanning
   tool detects these volumes and attempts to cache them which can cause
   a variety of problems with both the underlying operating system
   and project volumes. You must reconfigure LVM to scan only the devices
   that contain the ``cinder-volume`` volume group. Edit the
   ``/etc/lvm/lvm.conf`` file and complete the following actions:

   * In the ``devices`` section, add a filter that accepts the
     ``/dev/sdb`` device and rejects all other devices:

     .. code-block:: ini

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
        if the ``/dev/sda`` device contains the operating system:

        .. code-block:: ini

           filter = [ "a/sda/", "a/sdb/", "r/.*/"]

        Similarly, if your compute nodes use LVM on the operating
        system disk, you must also modify the filter in the
        ``/etc/lvm/lvm.conf`` file on those nodes to include only
        the operating system disk. For example, if the ``/dev/sda``
        device contains the operating system:

        .. code-block:: ini

           filter = [ "a/sda/", "r/.*/"]

Install and configure components
--------------------------------

.. only:: obs

   #. Install the packages:

      .. code-block:: console

         # zypper install openstack-cinder-volume tgt

.. only:: rdo

   #. Install the packages:

      .. code-block:: console

         # yum install openstack-cinder targetcli python-keystone

.. only:: ubuntu or debian

   #. Install the packages:

      .. code-block:: console

        # apt-get install cinder-volume

2. Edit the ``/etc/cinder/cinder.conf`` file
   and complete the following actions:

   * In the ``[database]`` section, configure database access:

     .. code-block:: ini

        [database]
        ...
        connection = mysql+pymysql://cinder:CINDER_DBPASS@controller/cinder

     Replace ``CINDER_DBPASS`` with the password you chose for
     the Block Storage database.

   * In the ``[DEFAULT]`` and ``[oslo_messaging_rabbit]`` sections,
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

   * In the ``[DEFAULT]`` and ``[keystone_authtoken]`` sections,
     configure Identity service access:

     .. code-block:: ini

        [DEFAULT]
        ...
        auth_strategy = keystone

        [keystone_authtoken]
        ...
        auth_uri = http://controller:5000
        auth_url = http://controller:35357
        memcached_servers = controller:11211
        auth_type = password
        project_domain_name = default
        user_domain_name = default
        project_name = service
        username = cinder
        password = CINDER_PASS

     Replace ``CINDER_PASS`` with the password you chose for the
     ``cinder`` user in the Identity service.

     .. note::

        Comment out or remove any other options in the
        ``[keystone_authtoken]`` section.

   * In the ``[DEFAULT]`` section, configure the ``my_ip`` option:

     .. code-block:: ini

        [DEFAULT]
        ...
        my_ip = MANAGEMENT_INTERFACE_IP_ADDRESS

     Replace ``MANAGEMENT_INTERFACE_IP_ADDRESS`` with the IP address
     of the management network interface on your storage node,
     typically 10.0.0.41 for the first node in the
     :ref:`example architecture <overview-example-architectures>`.

   .. only:: obs or ubuntu

      * In the ``[lvm]`` section, configure the LVM back end with the
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

      * In the ``[lvm]`` section, configure the LVM back end with the
        LVM driver, ``cinder-volumes`` volume group, iSCSI protocol,
        and appropriate iSCSI service:

        .. code-block:: ini

           [lvm]
           ...
           volume_driver = cinder.volume.drivers.lvm.LVMVolumeDriver
           volume_group = cinder-volumes
           iscsi_protocol = iscsi
           iscsi_helper = lioadm

   * In the ``[DEFAULT]`` section, enable the LVM back end:

     .. code-block:: ini

        [DEFAULT]
        ...
        enabled_backends = lvm

     .. note::

        Back-end names are arbitrary. As an example, this guide
        uses the name of the driver as the name of the back end.

   * In the ``[DEFAULT]`` section, configure the location of the
     Image service API:

     .. code-block:: ini

        [DEFAULT]
        ...
        glance_api_servers = http://controller:9292

   * In the ``[oslo_concurrency]`` section, configure the lock path:

     .. code-block:: ini

        [oslo_concurrency]
        ...
        lock_path = /var/lib/cinder/tmp

Finalize installation
---------------------

.. only:: obs

   * Start the Block Storage volume service including its dependencies
     and configure them to start when the system boots:

     .. code-block:: console

        # systemctl enable openstack-cinder-volume.service tgtd.service
        # systemctl start openstack-cinder-volume.service tgtd.service

.. only:: rdo

   * Start the Block Storage volume service including its dependencies
     and configure them to start when the system boots:

     .. code-block:: console

        # systemctl enable openstack-cinder-volume.service target.service
        # systemctl start openstack-cinder-volume.service target.service

.. only:: ubuntu or debian

   #. Restart the Block Storage volume service including its dependencies:

      .. code-block:: console

         # service tgt restart
         # service cinder-volume restart
