===========================================
Violin Memory 6000 series AFA volume driver
===========================================

The OpenStack V6000 driver package from Violin Memory adds Block Storage
service support for Violin 6000 Series All Flash Arrays.

The driver package release can be used with any OpenStack Liberty
deployment for all 6000 series all-flash arrays for release 6.3.1 and
later using either Fibre Channel or iSCSI HBAs.

.. warning::

   The Violin 6000 series AFA driver is recommended as an evaluation
   product only, for existing 6000 series customers. The driver will be
   deprecated or removed in the next OpenStack release. Future
   development and support will be focused on the 7000 series FSP
   driver only.

System requirements
~~~~~~~~~~~~~~~~~~~

To use the Violin driver, the following are required:

- Violin 6000 series AFA with:

  - Concerto OS version 6.3.1 or later

  - iSCSI or FC host interfaces

  - Storage network connectivity between all target and initiator ports

- The Violin volume driver: the driver implements the Block Storage API calls.
  Both FC and iSCSI drivers are supported.

- The vmemclient library: This is the Violin Array Communications library to
  the Flash Storage Platform through a REST-like interface.  The client can be
  installed using the python **pip** installer tool.  Further information on
  vmemclient can be found here: `PyPI
  <https://pypi.python.org/pypi/vmemclient/>`__.

  .. code-block:: console

     $ pip install vmemclient

Supported operations
~~~~~~~~~~~~~~~~~~~~

-  Create, delete, attach, and detach volumes.

-  Create, list, and delete volume snapshots.

-  Create a volume from a snapshot.

-  Copy an image to a volume.

-  Copy a volume to an image.

-  Clone a volume.

-  Extend a volume.

.. note::

   All listed operations are supported for both thick and thin LUNs. However,
   over-subscription is not supported.

Array configuration
~~~~~~~~~~~~~~~~~~~

After installing and configuring your V6000 array as per the installation
guide provided with your array, please follow these additional steps to
prepare your array for use with OpenStack.

#. Ensure your client initiator interfaces are all zoned or VLAN'd so that they
   can communicate with ALL of the target ports on the array. See your array
   installation or user guides for more information.

#. Set the array's provisioning threshold value:

   .. code-block:: none

      container set name CONTAINER_NAME provision-threshold hard 100


#. Set the array's used-space threshold value:

   .. code-block:: none

      container set name CONTAINER_NAME usedspace-threshold hard 0

Driver configuration
~~~~~~~~~~~~~~~~~~~~

Once the array is configured, it is simply a matter of editing the ``cinder``
configuration file to add or modify the parameters. Contents will differ
depending on whether you are setting up a fibre channel or iSCSI environment.


Fibre channel configuration
---------------------------

Set the following in your ``cinder.conf`` configuration file for setup of a
fibre channel array, replacing the variables using the guide in the following
section:

.. code-block:: ini

   volume_driver = cinder.volume.drivers.violin.v6000_fcp.V6000FCPDriver
   san_thin_provision = True
   san_ip = VMEM_MGMT_IP
   san_login = VMEM_USER_NAME
   san_password = VMEM_PASSWORD
   gateway_mga = VMEM_MGA_IP
   gateway_mgb = VMEM_MGB_IP

iSCSI configuration
-------------------

Set the following in your ``cinder.conf`` configuration file for setup of an
iSCSI array, replacing the variables using the guide in the following section:

.. code-block:: ini

   volume_driver = cinder.volume.drivers.violin.v6000_iscsi.V6000ISCSIDriver
   san_thin_provision = True
   san_ip = VMEM_MGMT_IP
   san_login = VMEM_USER_NAME
   san_password = VMEM_PASSWORD
   iscsi_target_prefix = iqn.2004-02.com.vmem:
   iscsi_port = 3260
   iscsi_ip_address = CINDER_INITIATOR_IP
   gateway_mga = VMEM_MGA_IP
   gateway_mgb = VMEM_MGB_IP

Configuration parameters
------------------------

Description of configuration value placeholders:

VMEM_MGMT_IP
    Cluster master IP address or hostname of the Violin 6000 Array. Can be an
    IP address or host name.

VMEM_USER_NAME
    Log-in user name for the Violin 6000 Memory Gateways. This user must have
    administrative rights on the array. Typically this is the ``admin`` user.

VMEM_PASSWORD
    Log-in user's password.

CINDER_INITIATOR_IP
    The IP address assigned to the primary iSCSI interface on the
    ``cinder-volume`` client. This IP address must be able to communicate
    with all target ports that are active on the array.

VMEM_MGA_IP
    The IP or host name of the gateway node marked ``A``, commonly referred to
    as ``MG-A``.

VMEM_MGB_IP
    The IP or host name of the gateway node marked ``B``, commonly referred to
    as ``MG-B``.
