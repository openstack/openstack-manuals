.. _cinder-backup-install:

Install and configure the backup service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Optionally, install and configure the backup service. For simplicity,
this configuration uses the Block Storage node and the Object Storage
(swift) driver, thus depending on the
`Object Storage service <http://docs.openstack.org/project-install-guide/newton/object-storage>`_.

.. note::

   You must :ref:`install and configure a storage node <cinder-storage>` prior
   to installing and configuring the backup service.

Install and configure components
--------------------------------

.. note::

   Perform these steps on the Block Storage node.

.. only:: obs

   #. Install the packages:

      .. code-block:: console

         # zypper install openstack-cinder-backup

.. only:: rdo

   #. Install the packages:

      .. code-block:: console

         # yum install openstack-cinder

.. only:: ubuntu or debian

   #. Install the packages:

      .. code-block:: console

        # apt-get install cinder-backup

2. Edit the ``/etc/cinder/cinder.conf`` file
   and complete the following actions:

   * In the ``[DEFAULT]`` section, configure backup options:

     .. code-block:: ini

        [DEFAULT]
        ...
        backup_driver = cinder.backup.drivers.swift
        backup_swift_url = SWIFT_URL

     Replace ``SWIFT_URL`` with the URL of the Object Storage service, typically
     ``http://10.0.0.51:8080/v1/AUTH_`` if using the installation guide
     architecture.

Finalize installation
---------------------

.. only:: obs or rdo

   Start the Block Storage backup service and configure it to
   start when the system boots:

   .. code-block:: console

      # systemctl enable openstack-cinder-backup.service
      # systemctl start openstack-cinder-backup.service

.. only:: ubuntu or debian

   Restart the Block Storage backup service:

   .. code-block:: console

      # service cinder-backup restart
