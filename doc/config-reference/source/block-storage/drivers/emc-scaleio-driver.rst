==============================================
EMC ScaleIO Block Storage driver configuration
==============================================

ScaleIO is a software-only solution that uses existing servers' local
disks and LAN to create a virtual SAN that has all of the benefits of
external storage but at a fraction of the cost and complexity. Using the
driver, Block Storage hosts can connect to a ScaleIO Storage
cluster.

This section explains how to configure and connect the block storage
nodes to a ScaleIO storage cluster.

Support matrix
~~~~~~~~~~~~~~

- ScaleIO: Version 1.32

Supported operations
~~~~~~~~~~~~~~~~~~~~

- Create, delete, clone, attach, and detach volumes

- Create and delete volume snapshots

- Create a volume from a snapshot

- Copy an image to a volume

- Copy a volume to an image

- Extend a volume

- Get volume statistics

ScaleIO Block Storage driver configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Edit the ``cinder.conf`` file by adding the configuration below under
the ``[DEFAULT]`` section of the file in case of a single back end or
under a separate section in case of multiple back ends (for example
[ScaleIO]). The configuration file is usually located at
``/etc/cinder/cinder.conf``.

For a configuration example, refer to the
:ref:`cinder.conf <cg_configuration_example_emc>` example.

ScaleIO driver name
-------------------

Configure the driver name by adding the following parameter:

.. code-block:: ini

    volume_driver = cinder.volume.drivers.emc.scaleio.ScaleIODriver

ScaleIO MDM server IP
---------------------

The ScaleIO Meta Data Manager monitors and maintains the available
resources and permissions.

To retrieve the MDM server IP, use the :command:`drv_cfg --query_mdms`
command.

Configure the MDM server IP by adding the following parameter:

.. code-block:: ini

    san_ip = ScaleIO GATEWAY IP

ScaleIO protection domain name
------------------------------

ScaleIO allows multiple protection domains (groups of SDSs that provide
backup for each other).

To retrieve the available protection domains, use the
:command:`scli --query_all` command and search for the protection
domains section.

Configure the protection domain for newly created volumes by adding the
following parameter:

.. code-block:: ini

    sio_protection_domain_name = ScaleIO Protection Domain

ScaleIO storage pool name
-------------------------

A ScaleIO storage pool is a set of physical devices in a protection
domain.

To retrieve the available storage pools, use the :command:`scli --query_all`
command and search for available storage pools.

Configure the storage pool for newly created volumes by adding the
following parameter:

.. code-block:: ini

    sio_storage_pool_name = ScaleIO Storage Pool

ScaleIO storage pools
---------------------

Multiple storage pools and protection domains can be listed for use by
the virtual machines.

To retrieve the available storage pools, use the :command:`scli --query_all`
command and search for available storage pools.

Configure the available storage pools by adding the following parameter:

.. code-block:: ini

    sio_storage_pools = Comma separated list of protection domain:storage pool name

ScaleIO user credentials
------------------------

Block Storage requires a ScaleIO user with administrative
privileges. ScaleIO recommends creating a dedicated OpenStack user
account that holds an administrative user role.

Refer to the ScaleIO User Guide for details on user account management.

Configure the user credentials by adding the following parameters:

.. code-block:: ini

    san_login = ScaleIO username

    san_password = ScaleIO password

Multiple back ends
~~~~~~~~~~~~~~~~~~

Configuring multiple storage back ends enables you to create several back-end
storage solutions that serve the same Compute resources.

When a volume is created, the scheduler selects the appropriate back end
to handle the request, according to the specified volume type.

.. _cg_configuration_example_emc:

Configuration example
~~~~~~~~~~~~~~~~~~~~~

**cinder.conf example file**

You can update the ``cinder.conf`` file by editing the necessary
parameters as follows:

.. code-block:: ini

    [Default]
    enabled_backends = scaleio

    [scaleio]
    volume_driver = cinder.volume.drivers.emc.scaleio.ScaleIODriver
    volume_backend_name = scaleio
    san_ip = GATEWAY_IP
    sio_protection_domain_name = Default_domain
    sio_storage_pool_name = Default_pool
    sio_storage_pools = Domain1:Pool1,Domain2:Pool2
    san_login = SIO_USER
    san_password = SIO_PASSWD

Configuration options
~~~~~~~~~~~~~~~~~~~~~

The ScaleIO driver supports these configuration options:

.. include:: ../../tables/cinder-emc_sio.rst
