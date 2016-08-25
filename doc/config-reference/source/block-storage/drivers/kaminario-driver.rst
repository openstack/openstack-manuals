=========================================================================
Kaminario K2 all-flash array iSCSI and FC OpenStack Block Storage drivers
=========================================================================

Kaminario's K2 all-flash array leverages a unique software-defined
architecture that delivers highly valued predictable performance, scalability
and cost-efficiency.

Kaminario's K2 all-flash iSCSI and FC arrays can be used in
OpenStack Block Storage for providing block storage using
``KaminarioISCSIDriver`` class and ``KaminarioFCDriver`` class respectively.

Driver requirements
~~~~~~~~~~~~~~~~~~~
- Kaminario's K2 all-flash iSCSI and/or FC array

- K2 REST API version >= 2.2.0

- ``krest`` python library should be installed on the Block Storage node
  using :command:`sudo pip install krest`

- The Block Storage Node should also have a data path to the K2 array
  for the following operations:

  - Create a volume from snapshot

  - Clone a volume

  - Copy volume to image

  - Copy image to volume

  - Retype 'dedup without replication'<->'nodedup without replication'

Supported operations
~~~~~~~~~~~~~~~~~~~~~

- Create, delete, attach, and detach volumes.

- Create and delete volume snapshots.

- Create a volume from a snapshot.

- Copy an image to a volume.

- Copy a volume to an image.

- Clone a volume.

- Extend a volume.

- Retype a volume.

- Manage and unmanage a volume.

- Replicate volume with failover and failback support to K2 array.

Configure Kaminario iSCSI/FC back end
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#. Edit the ``/etc/cinder/cinder.conf`` file and define a configuration
   group for iSCSI/FC back end.

   .. code-block:: ini

      [DEFAULT]
      enabled_backends = kaminario

      # Use DriverFilter in combination of other filters to use 'filter_function'
      # scheduler_default_filters = DriverFilter,CapabilitiesFilter

      [kaminario]
      # Management IP of Kaminario K2 All-Flash iSCSI/FC array
      san_ip = 10.0.0.10
      # Management username of Kaminario K2 All-Flash iSCSI/FC array
      san_login = username
      # Management password of Kaminario K2 All-Flash iSCSI/FC array
      san_password = password
      # Enable Kaminario K2 iSCSI/FC driver
      volume_driver = cinder.volume.drivers.kaminario.kaminario_iscsi.KaminarioISCSIDriver
      # volume_driver = cinder.volume.drivers.kaminario.kaminario_fc.KaminarioFCDriver

      # Backend name
      volume_backend_name = kaminario

      # K2 driver calculates max_oversubscription_ratio on setting below
      # option as True. Default value is False
      # auto_calc_max_oversubscription_ratio = False

      # Set a limit on total number of volumes to be created on K2 array, for example:
      # filter_function = "capabilities.total_volumes < 250"

      # For replication, replication_device must be set and the replication peer must be configured
      # on the primary and the secondary K2 arrays
      # Syntax:
      #     replication_device = backend_id:<s-array-ip>,login:<s-username>,password:<s-password>,rpo:<value>
      # where:
      #     s-array-ip is the secondary K2 array IP
      #     rpo must be either 60(1 min) or multiple of 300(5 min)
      # Example:
      # replication_device = backend_id:10.0.0.50,login:kaminario,password:kaminario,rpo:300

      # Suppress requests library SSL certificate warnings on setting this option as True
      # Default value is 'False'
      # suppress_requests_ssl_warnings = False

#. Save the changes to the ``/etc/cinder/cinder.conf`` file and
   restart the ``cinder-volume`` service.

Driver options
~~~~~~~~~~~~~~

The following table contains the configuration options that are specific
to the Kaminario K2 FC and iSCSI Block Storage drivers.

.. include:: ../../tables/cinder-kaminario.rst
