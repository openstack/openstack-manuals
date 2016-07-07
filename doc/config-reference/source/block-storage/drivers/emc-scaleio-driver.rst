==============================================
EMC ScaleIO Block Storage driver configuration
==============================================

ScaleIO is a software-only solution that uses existing servers' local
disks and LAN to create a virtual SAN that has all of the benefits of
external storage, but at a fraction of the cost and complexity. Using the
driver, Block Storage hosts can connect to a ScaleIO Storage
cluster.

This section explains how to configure and connect the block storage
nodes to a ScaleIO storage cluster.

Support matrix
~~~~~~~~~~~~~~

.. list-table::
   :widths: 10 25
   :header-rows: 1

   * - ScaleIO version
     - Supported Linux operating systems
   * - 1.32
     - CentOS 6.x, CentOS 7.x, SLES 11 SP3, SLES 12
   * - 2.0
     - CentOS 6.x, CentOS 7.x, SLES 11 SP3, SLES 12, Ubuntu 14.04

Deployment prerequisites
~~~~~~~~~~~~~~~~~~~~~~~~

* ScaleIO Gateway must be installed and accessible in the network.
  For installation steps, refer to the Preparing the installation Manager
  and the Gateway section in ScaleIO Deployment Guide. See
  :ref:`scale_io_docs`.

* ScaleIO Data Client (SDC) must be installed on all OpenStack nodes.

.. note:: Ubuntu users must follow the specific instructions in the ScaleIO
          deployment guide for Ubuntu environments. See the Deploying on
          Ubuntu servers section in ScaleIO Deployment Guide. See
          :ref:`scale_io_docs`.

.. _scale_io_docs:

Official documentation
----------------------

To find the ScaleIO documentation:

#. Go to the `ScaleIO product documentation page <https://support.emc.com/products/33925_ScaleIO/Documentation/?source=promotion>`_.

#. From the left-side panel, select the relevant version (1.32 or 2.0).

#. Search for "ScaleIO Installation Guide 1.32" or "ScaleIO 2.0 Deployment
   Guide" accordingly.

Supported operations
~~~~~~~~~~~~~~~~~~~~

* Create, delete, clone, attach, and detach volumes

* Create and delete volume snapshots

* Create a volume from a snapshot

* Copy an image to a volume

* Copy a volume to an image

* Extend a volume

* Get volume statistics

* Manage and unmanage a volume

* Create, list, update, and delete consistency groups

* Create, list, update, and delete consistency group snapshots

ScaleIO QoS support
~~~~~~~~~~~~~~~~~~~~

QoS support for the ScaleIO driver includes the ability to set the
following capabilities in the Block Storage API
``cinder.api.contrib.qos_specs_manage`` QoS specs extension module:

* ``minBWS``

* ``maxBWS``

The QoS keys above must be created and associated with a volume type.
For information about how to set the key-value pairs and associate
them with a volume type, run the following commands:

.. code-block:: console

   $ cinder help qos-create

   $ cinder help qos-key

   $ cinder help qos-associate

``maxBWS``
 The QoS I/O issue bandwidth rate limit in KBs. If not set, the I/O issue
 bandwidth rate has no limit. The setting must be a multiple of 1024.

``maxIOPS``
 The QoS I/O issue bandwidth rate limit in MBs. If not set, the I/O issue
 bandwidth rate has no limit. The setting must be larger than 10.

Since the limits are per SDC, they will be applied after the volume
is attached to an instance, and thus to a compute node/SDC.

ScaleIO thin provisioning support
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Block Storage driver supports creation of thin-provisioned and
thick-provisioned volumes.
The provisioning type settings can be added as an extra specification
of the volume type, as follows:

.. code-block:: ini

   sio:provisioning_type = thin\thick

If provisioning type settings are not specified in the volume type,
the default value is set according to the ``san_thin_provision``
option in the configuration file. The default provisioning type
will be ``thin`` if the option is not specified in the configuration
file. To set the default provisioning type ``thick``, set
the ``san_thin_provision`` option to ``false``
in the configuration file, as follows:

.. code-block:: ini

   san_thin_provision = false

The configuration file is usually located in
``/etc/cinder/cinder.conf``.
For a configuration example, see:
:ref:`cinder.conf <cg_configuration_example_emc>`.

ScaleIO Block Storage driver configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Edit the ``cinder.conf`` file by adding the configuration below under
the ``[DEFAULT]`` section of the file in case of a single back end, or
under a separate section in case of multiple back ends (for example
[ScaleIO]). The configuration file is usually located at
``/etc/cinder/cinder.conf``.

For a configuration example, refer to the example
:ref:`cinder.conf <cg_configuration_example_emc>` .

ScaleIO driver name
-------------------

Configure the driver name by adding the following parameter:

.. code-block:: ini

   volume_driver = cinder.volume.drivers.emc.scaleio.ScaleIODriver

ScaleIO MDM server IP
---------------------

The ScaleIO Meta Data Manager monitors and maintains the available
resources and permissions.

To retrieve the MDM server IP address, use the :command:`drv_cfg --query_mdms`
command.

Configure the MDM server IP address by adding the following parameter:

.. code-block:: ini

   san_ip = ScaleIO GATEWAY IP

ScaleIO Protection Domain name
------------------------------

ScaleIO allows multiple Protection Domains (groups of SDSs that provide
backup for each other).

To retrieve the available Protection Domains, use the command
:command:`scli --query_all` and search for the Protection
Domains section.

Configure the Protection Domain for newly created volumes by adding the
following parameter:

.. code-block:: ini

   sio_protection_domain_name = ScaleIO Protection Domain

ScaleIO Storage Pool name
-------------------------

A ScaleIO Storage Pool is a set of physical devices in a Protection
Domain.

To retrieve the available Storage Pools, use the command
:command:`scli --query_all` and search for available Storage Pools.

Configure the Storage Pool for newly created volumes by adding the
following parameter:

.. code-block:: ini

   sio_storage_pool_name = ScaleIO Storage Pool

ScaleIO Storage Pools
---------------------

Multiple Storage Pools and Protection Domains can be listed for use by
the virtual machines.

To retrieve the available Storage Pools, use the command
:command:`scli --query_all` and search for available Storage Pools.

Configure the available Storage Pools by adding the following parameter:

.. code-block:: ini

   sio_storage_pools = Comma-separated list of protection domain:storage pool name

ScaleIO user credentials
------------------------

Block Storage requires a ScaleIO user with administrative
privileges. ScaleIO recommends creating a dedicated OpenStack user
account that has an administrative user role.

Refer to the ScaleIO User Guide for details on user account management.

Configure the user credentials by adding the following parameters:

.. code-block:: ini

   san_login = ScaleIO username

   san_password = ScaleIO password

Multiple back ends
~~~~~~~~~~~~~~~~~~

Configuring multiple storage back ends allows you to create several back-end
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
   san_thin_provision = false

Configuration options
~~~~~~~~~~~~~~~~~~~~~

The ScaleIO driver supports these configuration options:

.. include:: ../../tables/cinder-emc_sio.rst
