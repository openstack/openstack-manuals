=============================
HDS HNAS iSCSI and NFS driver
=============================

This OpenStack Block Storage volume driver provides iSCSI and NFS support
for `Hitachi NAS Platform <http://www.hds.com/products/file-and-content/
network-attached-storage/>`_ Models 3080, 3090, 4040, 4060, 4080, and 4100.

Supported operations
~~~~~~~~~~~~~~~~~~~~

The NFS and iSCSI drivers support these operations:

* Create, delete, attach, and detach volumes.
* Create, list, and delete volume snapshots.
* Create a volume from a snapshot.
* Copy an image to a volume.
* Copy a volume to an image.
* Clone a volume.
* Extend a volume.
* Get volume statistics.
* Manage and unmanage a volume.

HNAS storage requirements
~~~~~~~~~~~~~~~~~~~~~~~~~

Before using iSCSI and NFS services, use the HNAS configuration and
management GUI (SMU) or SSC CLI to create storage pool(s), file system(s),
and assign an EVS. Make sure that the file system used is not created as
a ``replication target``. Additionally:

For NFS:
  Create NFS exports, choose a path for them (it must be different from
  ``/``) and set the :guilabel:`Show snapshots` option to
  ``hide and disable access``.

  Also, in the ``Access Configuration`` set the option ``norootsquash``,
  For example, ``"* (rw, norootsquash)"``, so HNAS cinder driver can change
  the permissions of its volumes.

  In order to use the hardware accelerated features of NFS HNAS,
  we recommend setting ``max-nfs-version`` to 3. Refer to the HNAS
  command-line reference to see how to configure this option.

For iSCSI:
  You need to set an iSCSI domain.

Block Storage host requirements
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The HNAS driver is supported for Red Hat Enterprise Linux OpenStack Platform,
SUSE OpenStack Cloud, and Ubuntu OpenStack.
The following packages must be installed:

* ``nfs-utils`` for Red Hat Enterprise Linux OpenStack Platform
* ``nfs-client`` for SUSE OpenStack Cloud
* ``nfs-common``, ``libc6-i386`` for Ubuntu OpenStack

If you are not using SSH, you need the HDS SSC to communicate with an HNAS
array using the :command:`SSC` commands. This utility package is available
in the RPM package distributed with the hardware through physical media or
it can be manually copied from the SMU to the Block Storage host.

Package installation
--------------------

If you are installing the driver from an RPM or DEB package,
follow the steps below:

#. Install the dependencies:

   In Red Hat:

   .. code-block:: console

      # yum install nfs-utils nfs-utils-lib

   Or in Ubuntu:

   .. code-block:: console

      # apt-get install nfs-common

   Or in SUSE:

   .. code-block:: console

      # zypper install nfs-client

   If you are using Ubuntu 12.04, you also need to install ``libc6-i386``

   .. code-block:: console

      # apt-get install libc6-i386

#. Configure the driver as described in the
   :ref:`hds-hnas-driver-configuration` section.

#. Restart all cinder services (volume, scheduler and backup).

.. _hds-hnas-driver-configuration:

Driver configuration
~~~~~~~~~~~~~~~~~~~~

The HDS driver supports the concept of differentiated services (also
referred as :term:`quality of service (QoS)`) by mapping volume types to
services provided through HNAS.

HNAS supports a variety of storage options and file system capabilities,
which are selected through the definition of volume types and the use of
multiple back ends. The driver maps up to four volume types into
separated exports or file systems, and can support any number if using
multiple back ends.

The configuration for the driver is read from an XML-formatted file
(one per back end), which you need to create and set its path in the
``cinder.conf`` configuration file. Below are the settings needed
in the ``cinder.conf`` configuration file [#]_:

.. code-block:: ini

   [DEFAULT]
   enabled_backends = hnas_iscsi1, hnas_nfs1

For HNAS iSCSI driver create this section:

.. code-block:: ini

   [hnas_iscsi1]
   volume_driver = cinder.volume.drivers.hitachi.hnas_iscsi.HDSISCSIDriver
   hds_hnas_iscsi_config_file = /path/to/config/hnas_config_file.xml
   volume_backend_name = HNAS-ISCSI

For HNAS NFS driver create this section:

.. code-block:: ini

   [hnas_nfs1]
   volume_driver = cinder.volume.drivers.hitachi.hnas_nfs.HDSNFSDriver
   hds_hnas_nfs_config_file = /path/to/config/hnas_config_file.xml
   volume_backend_name = HNAS-NFS

The XML file has the following format:

.. code-block:: ini

   <?xml version = "1.0" encoding = "UTF-8" ?>
     <config>
       <mgmt_ip0>172.24.44.15</mgmt_ip0>
       <hnas_cmd>ssc</hnas_cmd>
       <chap_enabled>False</chap_enabled>
       <ssh_enabled>False</ssh_enabled>
       <cluster_admin_ip0>10.1.1.1</cluster_admin_ip0>
       <username>supervisor</username>
       <password>supervisor</password>
       <svc_0>
         <volume_type>default</volume_type>
         <iscsi_ip>172.24.44.20</iscsi_ip>
         <hdp>fs01-husvm</hdp>
       </svc_0>
       <svc_1>
         <volume_type>platinum</volume_type>
         <iscsi_ip>172.24.44.20</iscsi_ip>
         <hdp>fs01-platinum</hdp>
       </svc_1>
     </config>

HNAS volume driver XML configuration options
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

An OpenStack Block Storage node using HNAS drivers can have up to four
services. Each service is defined by a ``svc_n`` tag (``svc_0``,
``svc_1``, ``svc_2``, or ``svc_3`` [#]_, for example).
These are the configuration options available for each service label:

.. list-table:: Configuration options for service labels
   :header-rows: 1
   :widths: 25, 10, 15, 50

   * - Option
     - Type
     - Default
     - Description
   * - ``volume_type``
     - Required
     - ``default``
     - When a ``create_volume`` call with a certain volume type happens,
       the volume type will try to be matched up with this tag. In each
       configuration file you must define the ``default`` volume type in
       the service labels and, if no volume type is specified, the
       ``default`` is used. Other labels are case sensitive and should
       match exactly. If no configured volume types match the incoming
       requested type, an error occurs in the volume creation.
   * - ``iscsi_ip``
     - Required only for iSCSI
     -
     - An iSCSI IP address dedicated to the service.
   * - hdp
     - Required
     -
     - For iSCSI driver: virtual file system label associated with the
       service.

       For NFS driver: path to the volume (<ip_address>:/<path>) associated
       with the service.

       Additionally, this entry must be added in the file used to list
       available NFS shares. This file is located, by default, in
       ``/etc/cinder/nfs_shares`` or you can specify the location in the
       ``nfs_shares_config`` option in the ``cinder.conf`` configuration file.

These are the configuration options available to the ``config`` section of
the XML configuration file:

.. list-table:: Configuration options
   :header-rows: 1
   :widths: 25, 10, 15, 50

   * - Option
     - Type
     - Default
     - Description
   * - ``mgmt_ip0``
     - Required
     -
     - Management Port 0 IP address. Should be the IP address of the
       ``Admin`` EVS.
   * - ``hnas_cmd``
     - Optional
     - ssc
     - Command to communicate to HNAS array.
   * - ``chap_enabled``
     - Optional (iSCSI only)
     - ``True``
     - Boolean tag used to enable CHAP authentication protocol.
   * - ``username``
     - Required
     - supervisor
     - User name is always required on HNAS.
   * - ``password``
     - Required
     - supervisor
     - Password is always required on HNAS.
   * - ``svc_0``, ``svc_1``, ``svc_2``, ``svc_3``
     - Optional
     - (at least one label has to be defined)
     - Service labels: these four predefined names help four different sets of
       configuration options. Each can specify HDP and a unique volume type.
   * - cluster_admin_ip0
     - Optional if ``ssh_enabled`` is ``True``
     -
     - The address of HNAS cluster admin.
   * - ``ssh_enabled``
     - Optional
     - ``False``
     - Enables SSH authentication between Block Storage host and the SMU.
   * - ``ssh_private_key``
     - Required if ``ssh_enabled`` is ``True``
     - ``False``
     - Path to the SSH private key used to authenticate in HNAS SMU.
       The public key must be uploaded to HNAS SMU using
       ``ssh-register-public-key`` (this is an SSH subcommand).
       Note that copying the public key HNAS using ``ssh-copy-id`` does
       not work properly as the SMU periodically wipe out those keys.

Service labels
~~~~~~~~~~~~~~

HNAS driver supports differentiated types of service using the service
labels. It is possible to create up to four types of them, as gold,
platinum, silver, and ssd, for example.

After creating the services in the XML configuration file, you must
configure one ``volume_type`` per service. Each ``volume_type`` must
have the metadata ``service_label`` with the same name configured in
the ``<volume_type>`` section of that service. If this is not set,
the Block Storage service will schedule the volume creation to the pool
with largest available free space or other criteria configured in volume
filters.

.. code-block:: console

   $ cinder type-create default
   $ cinder type-key default set service_label=default
   $ cinder type-create platinum-tier
   $ cinder type-key platinum set service_label=platinum

Multiple back-end configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you use multiple back ends and intend to enable the creation of a
volume in a specific back end, you must configure volume types to set
the ``volume_backend_name`` option to the appropriate back end. Then,
create ``volume_type`` configurations with the same ``volume_backend_name``.

.. code-block:: console

   $ cinder type-create 'iscsi'
   $ cinder type-key 'iscsi' set volume_backend_name = 'HNAS-ISCSI'
   $ cinder type-create 'nfs'
   $ cinder type-key 'nfs' set volume_backend_name = 'HNAS-NFS'

You can deploy multiple OpenStack HNAS driver instances that each control
a separate HNAS array. Each service (``svc_0``, ``svc_1``, ``svc_2``,
``svc_3``) on the instance need to have a ``volume_type`` and
``service_label`` metadata associated with it.
If no metadata is associated with a pool, the Block Storage filtering
algorithm selects the pool with the largest available free space.

SSH configuration
~~~~~~~~~~~~~~~~~

Instead of using :command:`SSC` commands on the Block Storage host and
storing its credentials in the XML configuration file, the HNAS driver
supports :command:`SSH` authentication. To configure that:

#. If you don't have a pair of public keys already generated,
   create one on the Block Storage host (leave the pass-phrase empty):

   .. code-block:: console

      $ mkdir -p /opt/hds/ssh
      $ ssh-keygen -f /opt/hds/ssh/hnaskey

#. Change the owner of the key to ``cinder`` (or the user under which
   the volume service will be run):

   .. code-block:: console

      # chown -R cinder.cinder /opt/hds/ssh

#. Create the directory ``ssh_keys`` in the SMU server:

   .. code-block:: console

      $ ssh [manager|supervisor]@<smu-ip> 'mkdir -p /var/opt/mercury-main/home/[manager|supervisor]/ssh_keys/'

#. Copy the public key to the ``ssh_keys`` directory:

   .. code-block:: console

      $ scp /opt/hds/ssh/hnaskey.pub [manager|supervisor]@<smu-ip>:/var/opt/mercury-main/home/[manager|supervisor]/ssh_keys/

#. Access the SMU server:

   .. code-block:: console

      $ ssh [manager|supervisor]@<smu-ip>

#. Run the command to register the SSH keys:

   .. code-block:: console

      $ ssh-register-public-key -u [manager|supervisor] -f ssh_keys/hnaskey.pub

#. Check the communication with HNAS on the Block Storage host:

   .. code-block:: console

      $ ssh -i /opt/hds/ssh/hnaskey [manager|supervisor]@<smu-ip> 'ssc <cluster_admin_ip0> df -a'

``<cluster_admin_ip0>`` is ``localhost`` for single node deployments.
This should return a list of available file systems on HNAS.

Edit the XML configuration file
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Set the ``username``.

#. Enable SSH by adding the line ``<ssh_enabled>True</ssh_enabled>``
   under the ``<config>`` section.

#. Set the private key path:
   ``<ssh_private_key>/opt/hds/ssh/hnaskey</ssh_private_key>``
   under the ``<config>`` section.

#. If the HNAS is in a multi-cluster configuration set
   ``<cluster_admin_ip0>`` to the cluster node admin IP.
   In a single node HNAS, leave it empty.

#. Restart the cinder services.

.. warning::

   Note that copying the public key HNAS using ssh-copy-id does not work
   properly as the SMU periodically wipes out those keys.

Manage and unmanage
~~~~~~~~~~~~~~~~~~~

Manage and unmanage are two new API extensions that add some new
features to the driver. The manage action on an existing volume is very
similar to a volume creation. It creates a volume entry in the Block Storage
database, but instead of creating a new volume in the back end, it only adds
a link to an existing volume. Volume name, description, volume_type,
metadata, and availability_zone are supported as in a normal volume creation.

The unmanage action on an existing volume removes the volume from the Block
Storage database, but keeps the actual volume in the back-end.
From a Block Storage perspective the volume would be deleted,
but it would still exist for outside use.

Manage
------

On the Dashboard:

For NFS:

#. Under the :menuselection:`System > Volumes` tab,
   choose the option :guilabel:`Manage Volume`.

#. Fill the fields :guilabel:`Identifier`, :guilabel:`Host`,
   :guilabel:`Volume Name`, and :guilabel:`Volume Type` with volume
   information to be managed:

   * :guilabel:`Identifier`: ip:/type/volume_name Example:
     172.24.44.34:/silver/volume-test
   * :guilabel:`Host`: host@backend-name#pool_name Example:
     ubuntu@hnas-nfs#test_silver
   * :guilabel:`Volume Name`: volume_name Example: volume-test
   * :guilabel:`Volume Type`: choose a type of volume Example: silver

For iSCSI:

#. Under the :menuselection:`System > Volumes` tab,
   choose the option :guilabel:`Manage Volume`.

#. Fill the fields :guilabel:`Identifier`, :guilabel:`Host`,
   :guilabel:`Volume Name`, and :guilabel:`Volume Type` with volume
   information to be managed:

   * :guilabel:`Identifier`: filesystem-name/volume-name Example:
     filesystem-test/volume-test
   * :guilabel:`Host`: host@backend-name#pool_name Example:
     ubuntu@hnas-iscsi#test_silver
   * :guilabel:`Volume Name`: volume_name Example: volume-test
   * :guilabel:`Volume Type`: choose a type of volume Example: silver

By CLI:

.. code-block:: console

   $ cinder --os-volume-api-version 2 manage [--source-name <source-name>][--id-type <id-type>]
     [--name <name>][--description <description>][--volume-type <volume-type>]
     [--availability-zone <availability-zone>][--metadata [<key=value> [<key=value> ...]]][--bootable]
     <host> [<key=value> [<key=value> ...]]

Example:

For NFS:

.. code-block:: console

   $ cinder --os-volume-api-version 2 manage --name <volume-test> --volume-type <silver>
     --source-name <172.24.44.34:/silver/volume-test> <ubuntu@hnas-nfs#test_silver>

For iSCSI:

.. code-block:: console

   $ cinder --os-volume-api-version 2 manage --name <volume-test> --volume-type <silver>
     --source-name <filesystem-test/volume-test> <ubuntu@hnas-iscsi#test_silver>

Unmanage
--------

On the Dashboard:

#. Under the :menuselection:`System > Volumes` tab, choose a volume.

#. On the volume options, choose :guilabel:`Unmanage Volume`.

#. Check the data and confirm.

By CLI:

.. code-block:: console

   $ cinder --os-volume-api-version 2 unmanage <volume>

Example:

.. code-block:: console

   $ cinder --os-volume-api-version 2 unmanage <voltest>

Additional notes
~~~~~~~~~~~~~~~~

* The ``get_volume_stats()`` function always provides the available
  capacity based on the combined sum of all the HDPs that are used in
  these services labels.

* After changing the configuration on the storage node, the Block Storage
  driver must be restarted.

* On Red Hat, if the system is configured to use SELinux, you need to
  set ``virt_use_nfs = on`` for NFS driver work properly.

  .. code-block:: console

     # setsebool -P virt_use_nfs on

* It is not possible to manage a volume if there is a slash ('/') or
  a colon (':') in the volume name.

.. rubric:: Footnotes

.. [#] The configuration file location may differ.

.. [#] There is no relative precedence or weight among these four labels.
