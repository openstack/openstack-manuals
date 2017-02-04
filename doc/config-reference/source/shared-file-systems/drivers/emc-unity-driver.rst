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

- Unity OE 4.1.x or higher.

- StorOps 0.4.3 or higher is installed on Manila node.

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

- ``Flat``

  This type is fully supported by Unity share driver, however flat networks are
  restricted due to the limited number of tenant networks that can be created
  from them.

- ``VLAN``

  We recommend this type of network topology in Manila.
  In most use cases, VLAN is used to isolate the different tenants and provide
  an isolated network for each tenant. To support this function, an
  administrator needs to set a slot connected with Unity Ethernet port in
  ``Trunk`` mode or allow multiple VLANs from the slot.

- ``VXLAN``

  Unity native VXLAN is still unavailable. However, with the `HPB
  <http://specs.openstack.org/openstack/neutron-specs/specs/kilo/ml2-hierarchical-port-binding.html>`_
  (Hierarchical Port Binding) in Networking and Shared file system services,
  it is possible that Unity co-exists with VXLAN enabled network environment.

Supported MTU size
~~~~~~~~~~~~~~~~~~

Unity currently only supports 1500 and 9000 as the mtu size, the user can
change the above mtu size from Unity Unisphere:

#. In the Unisphere, go to `Settings`, `Access`, and then `Ethernet`.
#. Double click the ethernet port.
#. Select the `MTU` size from the drop down list.

The Unity driver will select the port where mtu is equal to the mtu
of share network during share server creation.


Supported security services
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Unity share driver provides ``IP`` based authentication method support for
``NFS`` shares and ``user`` based authentication method for ``CIFS`` shares
respectively. For ``CIFS`` share, Microsoft Active Directory is the only
supported security services.

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

    share_driver = manila.share.drivers.dell_emc.driver.EMCShareDriver
    emc_share_backend = unity
    emc_nas_server = <management IP address of the Unity system>
    emc_nas_login = <user with administrator privilege>
    emc_nas_password = <password>
    unity_server_meta_pool = <pool name>
    unity_share_data_pools = <comma separated pool names>
    unity_ethernet_ports = <comma separated ports list>
    driver_handles_share_servers = True

- ``emc_share_backend``
    The plugin name. Set it to `unity` for the Unity driver.

- ``emc_nas_server``
    The management IP for Unity.

- ``emc_nas_login``
    The user with administrator privilege.

- ``emc_nas_passowrd``
    Password for the user.

- ``unity_server_meta_pool``
    The name of the pool to persist the meta-data of NAS server.

- ``unity_share_data_pools``
    Comma separated list specifying the name of the pools to be used
    by this back end. Do not set this option if all storage pools
    on the system can be used.
    Wild card character is supported.

    Examples:

    .. code-block:: ini

       # Only use pool_1
       unity_share_data_pools = pool_1
       # Only use pools whose name stars from pool_
       unity_share_data_pools = pool_*
       # Use all pools on Unity
       unity_share_data_pools = *

- ``unity_ethernet_ports``
    Comma separated list specifying the ethernet ports of Unity system
    that can be used for share. Do not set this option if all ethernet ports
    can be used.
    Wild card character is supported. Both the normal ethernet port and link
    aggregation port can be used by Unity share driver.


    Examples:

    .. code-block:: ini

       # Only use spa_eth1
       unity_ethernet_ports = spa_eth1
       # Use port whose name stars from spa_
       unity_ethernet_ports = spa_*
       # Use all Link Aggregation ports
       unity_ethernet_ports = sp*_la_*
       # Use all available ports
       unity_ethernet_ports = *


   .. note::

      Refer to :ref:`unity_file_io_load_balance` for performance
      impact.

- ``driver_handles_share_servers``
    Unity driver requires this option to be as ``True``.


Restart of ``manila-share`` service is needed for the configuration
changes to take effect.


.. _unity_file_io_load_balance:


IO Load balance
~~~~~~~~~~~~~~~

The Unity driver automatically distributes the file interfaces per storage
processor based on the option ``unity_ethernet_ports``. This balances IO
traffic. The recommended configuration for ``unity_ethernet_ports`` specifies
balanced ports per storage processor. For example:

.. code-block:: ini

   # Use eth2 from both SPs
   unity_ethernet_ports = spa_eth2, spb_eth2


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
