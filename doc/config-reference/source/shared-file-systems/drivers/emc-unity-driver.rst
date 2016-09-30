================
EMC Unity driver
================

The EMC Shared File Systems service driver framework (EMCShareDriver)
utilizes the EMC storage products to provide the shared file systems to
OpenStack. The EMC driver is a plug-in based driver which is designed to
use different plug-ins to manage different EMC storage products.

The Unity plug-in manages the Unity system to provide shared filesystems.
The EMC driver framework with the Unity plug-in is referred to as the
Unity driver in this document.

This driver performs the operations on Unity through RESTful APIs. Each back
end manages one Storage Processor of Unity. Configure multiple Shared File
Systems service back ends to manage multiple Unity systems.

Requirements
~~~~~~~~~~~~

- Unity OE 4.0.1 or higher.

- StorOps 0.2.17 or higher is installed on Manila node.

- Following licenses are activated on Unity:

  - CIFS/SMB Support

  - Network File System (NFS)

  - Thin Provisioning


Supported shared filesystems and operations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The driver supports CIFS and NFS shares.

The following operations are supported:

-  Create a share.

-  Delete a share.

-  Allow share access.

-  Deny share access.

-  Create a snapshot.

-  Delete a snapshot.

-  Create a share from a snapshot.

-  Extend a share.


Supported network types
~~~~~~~~~~~~~~~~~~~~~~~

- Flat

- VLAN


Pre-configurations
~~~~~~~~~~~~~~~~~~

On manila node
--------------

Python library ``storops`` is required to run Unity driver.
Install it with the ``pip`` command.
You may need root privilege to install python libraries.

.. code-block:: console

    pip install storops


On Unity system
---------------

#. Configure system level NTP server.

   Open ``Unisphere`` of your Unity system and navigate to:

   .. code-block:: console

      Unisphere -> Settings -> Management -> System Time and NTP

   Select ``Enable NTP synchronization`` and add your NTP server(s).

   The time on the Unity system and the Active Directory domains
   used in security services should be in sync. We recommend
   using the same NTP server on both the Unity system and Active
   Directory domains.

#. Configure system level DNS server.

   Open ``Unisphere`` of your Unity system and navigate to:

   .. code-block:: console

      Unisphere -> Settings -> Management -> DNS Server

   Select ``Configure DNS server address manually`` and add your DNS server(s).


Back end configurations
~~~~~~~~~~~~~~~~~~~~~~~

Following configurations need to be configured in ``/etc/manila/manila.conf``
for the Unity driver.

.. code-block:: ini

    share_driver = manila.share.drivers.emc.driver.EMCShareDriver
    emc_share_backend = unity
    emc_nas_server = <management IP address of the Unity system>
    emc_nas_login = <user with administrator privilege>
    emc_nas_password = <password>
    emc_nas_server_container = [SPA|SPB]
    emc_nas_server_pool = <pool name>
    emc_nas_pool_names = <comma separated pool names>
    emc_interface_ports = <comma separated ports list>
    driver_handles_share_servers = True

- ``emc_share_backend``
    The plugin name. Set it to `unity` for the Unity driver.

- ``emc_nas_server``
    The management IP for Unity.

- ``emc_nas_server_container``
    The SP to be used as NAS server container.

- ``emc_nas_server_pool``
    The name of the pool to persist the meta-data of NAS server.

- ``emc_nas_pool_names``
    Comma separated list specifying the name of the pools to be used
    by this back end. Do not set this option if all storage pools
    on the system can be used.
    Wild card character is supported.

    Examples: pool_1, pool_*, *

- ``emc_interface_ports``
    Comma separated list specifying the ethernet ports of Unity system
    that can be used for share. Do not set this option if all ethernet ports
    can be used.
    Wild card character is supported.

    Examples: spa_eth1, spa_*, *

- ``driver_handles_share_servers``
    Unity driver requires this option to be as ``True``.


Restart of :term:`manila-share` service is needed for the configuration
changes to take effect.


Restrictions
~~~~~~~~~~~~

The Unity driver has following restrictions.

- EMC Unity does not support the same IP in different VLANs.

- Only Active Directory security service is supported and it is
  required to create CIFS shares.


Driver options
~~~~~~~~~~~~~~

Configuration options specific to this driver are documented in
:ref:`manila-emc`.
