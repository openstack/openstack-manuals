======
Tintri
======

Tintri VMstore is a smart storage that sees, learns, and adapts for cloud and
virtualization. The Tintri Block Storage driver interacts with configured
VMstore running Tintri OS 4.0 and above. It supports various operations using
Tintri REST APIs and NFS protocol.

To configure the use of a Tintri VMstore with Block Storage, perform the
following actions:

#. Edit the ``etc/cinder/cinder.conf`` file and set the
   ``cinder.volume.drivers.tintri`` options:

   .. code-block:: ini

      volume_driver=cinder.volume.drivers.tintri.TintriDriver
      # Mount options passed to the nfs client. See section of the
      # nfs man page for details. (string value)
      nfs_mount_options = vers=3,lookupcache=pos

      #
      # Options defined in cinder.volume.drivers.tintri
      #

      # The hostname (or IP address) for the storage system (string
      # value)
      tintri_server_hostname = {Tintri VMstore Management IP}

      # User name for the storage system (string value)
      tintri_server_username = {username}

      # Password for the storage system (string value)
      tintri_server_password = {password}

      # API version for the storage system (string value)
      #tintri_api_version = v310

      # Following options needed for NFS configuration
      # File with the list of available nfs shares (string value)
      #nfs_shares_config = /etc/cinder/nfs_shares

#. Edit the ``/etc/nova/nova.conf`` file and set the ``nfs_mount_options``:

   .. code-block:: ini

      nfs_mount_options = vers=3

#. Edit the ``/etc/cinder/nfs_shares`` file and add the Tintri VMstore mount
   points associated with the configured VMstore management IP in the
   ``cinder.conf`` file:

   .. code-block:: none

      {vmstore_data_ip}:/tintri/{submount1}
      {vmstore_data_ip}:/tintri/{submount2}


.. include:: ../../tables/cinder-tintri.rst
