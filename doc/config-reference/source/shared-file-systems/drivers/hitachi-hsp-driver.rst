===================================================================
Hitachi Hyper Scale-Out Platform File Services Driver for OpenStack
===================================================================


The Hitachi Hyper Scale-Out Platform File Services Driver for OpenStack
provides the management of file shares, supporting NFS shares with IP based
rules to control access. It has a layer that handles the complexity of the
protocol used to communicate to Hitachi Hyper Scale-Out Platform via a
RESTful API, formatting and sending requests to the backend.


Requirements
~~~~~~~~~~~~

- Hitachi Hyper Scale-Out Platform (HSP) version 1.1.

- HSP user with ``file-system-full-access`` role.

- Established network connection between the HSP interface and OpenStack
  nodes.

Supported shared filesystems and operations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The driver supports NFS shares.

The following operations are supported:

- Create a share.

- Delete a share.

- Extend a share.

- Shrink a share.

- Allow share access.

- Deny share access.

- Manage a share.

- Unmanage a share.

.. note::

    - Only ``IP`` access type is supported
    - Both ``RW`` and ``RO`` access levels supported


Known restrictions
~~~~~~~~~~~~~~~~~~

- The Hitachi HSP allows only 1024 virtual file systems per cluster. This
  determines the limit of shares the driver can provide.

- The Hitachi HSP file systems must have at least 128 GB. This means that
  all shares created by Shared File Systems service should have 128 GB or
  more.

  .. note::
    The driver has an internal filter function that accepts only requests for
    shares size greater than or equal to 128 GB, otherwise the request will
    fail or be redirected to another available storage backend.


Driver options
~~~~~~~~~~~~~~

The following table contains the configuration options specific to the share
driver.

.. include:: ../../tables/manila-hds_hsp.rst

Network approach
~~~~~~~~~~~~~~~~

.. note::

    In the driver mode used by HSP Driver (DHSS = ``False``), the driver does
    not handle network configuration, it is up to the administrator to
    configure it.

* Configure the network of the manila-share, Compute and Networking nodes to
  reach HSP interface. For this, your provider network should be capable of
  reaching HSP Cluster-Virtual-IP. These connections are mandatory so nova
  instances are capable of accessing shares provided by the backend.

* The following image represents a valid scenario:

.. image:: ../../figures/hsp_network.png
   :width: 60%

.. note::

    To HSP, the Virtual IP is the address through which clients access shares
    and the Shared File Systems service sends commands to the management
    interface.
    This IP can be checked in HSP using its CLI:

    .. code-block:: console

       $ hspadm ip-address list

Back end configuration
~~~~~~~~~~~~~~~~~~~~~~

#. Configure HSP driver according to your environment. This example
   shows a valid HSP driver configuration:

   .. code-block:: ini

      [DEFAULT]
      # ...
      enabled_share_backends = hsp1
      enabled_share_protocols = NFS
      # ...

      [hsp1]
      share_backend_name = HITACHI1
      share_driver = manila.share.drivers.hitachi.hsp.driver.HitachiHSPDriver
      driver_handles_share_servers = False
      hitachi_hsp_host = 172.24.47.190
      hitachi_hsp_username = admin
      hitachi_hsp_password = admin_password

#. Configure HSP share type.

   .. note::

       Shared File Systems service requires that the share type includes the
       ``driver_handles_share_servers`` extra-spec. This ensures that the
       share will be created on a backend that supports the requested
       ``driver_handles_share_servers`` capability. Also,
       ``snapshot_support`` extra-spec should be provided if its value
       differs from the default value (``True``), as this driver version
       that currently does not support snapshot operations. For this
       driver both extra-specs must be set to ``False``.

   .. code-block:: console

      $ manila type-create --snapshot_support False hsp False

#. Restart all Shared File Systems services (``manila-share``,
   ``manila-scheduler`` and ``manila-api``).


Manage and unmanage shares
~~~~~~~~~~~~~~~~~~~~~~~~~~

The Shared File Systems service has the ability to manage and unmanage shares.
If there is a share in the storage and it is not in OpenStack, you can manage
that share and use it as a Shared File Systems share. Previous access rules
are not imported by manila. The unmanage operation only unlinks the share from
OpenStack, preserving all data in the share.

In order to manage a HSP share, it must adhere to the following rules:

- File system and share name must not contain spaces.

- Share name must not contain backslashes (`\\`).

To **manage** a share use:

.. code-block:: console

   $ manila manage [--name <name>] [--description <description>]
   [--share_type <share_type>] [--driver_options [<key=value>
   [<key=value> ...]]] <service_host> <protocol> <export_path>

Where:

+--------------------+------------------------------------------------------+
|  **Parameter**     | **Description**                                      |
+====================+======================================================+
|                    | Manila host, backend and share name. For example,    |
|  ``service_host``  | ``ubuntu@hitachi1#hsp1``. The available hosts can    |
|                    | be listed with the command: ``manila pool-list``     |
|                    | (admin only).                                        |
+--------------------+---------------------+--------------------------------+
|  ``protocol``      | Must be **NFS**, the only supported protocol in this |
|                    | driver version.                                      |
+--------------------+------------------------------------------------------+
|  ``export_path``   | The Hitachi Hyper Scale-Out Platform export path of  |
|                    | the share, for example:                              |
|                    | ``172.24.47.190:/some_share_name``                   |
+--------------------+------------------------------------------------------+

| To **unmanage** a share use:

.. code-block:: console

   $ manila unmanage <share>

Where:

+------------------+---------------------------------------------------------+
|  **Parameter**   | **Description**                                         |
+==================+=========================================================+
|  ``share``       | ID or name of the share to be unmanaged. This list can  |
|                  | be fetched with: ``manila list``.                       |
+------------------+---------------------+-----------------------------------+


Additional notes
~~~~~~~~~~~~~~~~

- Shares are thin provisioned. It is reported to manila only the
  real used space in HSP.
- Administrators should manage the tenant’s quota (``manila quota-update``)
  to control the backend usage.
