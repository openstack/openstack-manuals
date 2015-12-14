===================================================
Pure Storage iSCSI and Fibre Channel volume drivers
===================================================

The Pure Storage FlashArray volume drivers for OpenStack Block Storage
interact with configured Pure Storage arrays and support various
operations.

Support for iSCSI storage protocol is available with the PureISCSIDriver
Volume Driver class, and Fibre Channel with PureFCDriver.

All drivers are compatible with Purity FlashArrays that support the REST
API version 1.2, 1.3, or 1.4 (Purity 4.0.0 and newer).

Limitations and known issues
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you do not set up the nodes hosting instances to use multipathing,
all network connectivity will use a single physical port on the array.
In addition to significantly limiting the available bandwidth, this
means you do not have the high-availability and non-disruptive upgrade
benefits provided by FlashArray. Multipathing must be used to take advantage
of these benefits.

Supported operations
~~~~~~~~~~~~~~~~~~~~

* Create, delete, attach, detach, retype, clone, and extend volumes.

* Create a volume from snapshot.

* Create, list, and delete volume snapshots.

* Create, list, update, and delete consistency groups.

* Create, list, and delete consistency group snapshots.

* Manage and unmanage a volume.

* Manage and unmanage a snapshot.

* Get volume statistics.

* Create a thin provisioned volume.

Configure OpenStack and Purity
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You need to configure both your Purity array and your OpenStack cluster.

.. note::

   These instructions assume that the ``cinder-api`` and ``cinder-scheduler``
   services are installed and configured in your OpenStack cluster.

Configure the OpenStack Block Storage service
---------------------------------------------

In these steps, you will edit the ``cinder.conf`` file to configure the
OpenStack Block Storage service to enable multipathing and to use the
Pure Storage FlashArray as back-end storage.

#. Retrieve an API token from Purity.
   The OpenStack Block Storage service configuration requires an API token
   from Purity. Actions performed by the volume driver use this token for
   authorization. Also, Purity logs the volume driver's actions as being
   performed by the user who owns this API token.

   If you created a Purity user account that is dedicated to managing your
   OpenStack Block Storage volumes, copy the API token from that user
   account.

   Use the appropriate create or list command below to display and copy the
   Purity API token:

   * To create a new API token:

     .. code-block:: console

        $ pureadmin create --api-token USER

     The following is an example output:

     .. code-block:: console

        $ pureadmin create --api-token pureuser
        Name      API Token                             Created
        pureuser  902fdca3-7e3f-d2e4-d6a6-24c2285fe1d9  2014-08-04 14:50:30

   * To list an existing API token:

     .. code-block:: console

        $ pureadmin list --api-token --expose USER

     The following is an example output:

     .. code-block:: console

        $ pureadmin list --api-token --expose pureuser
        Name      API Token                             Created
        pureuser  902fdca3-7e3f-d2e4-d6a6-24c2285fe1d9  2014-08-04 14:50:30

#. Copy the API token retrieved (``902fdca3-7e3f-d2e4-d6a6-24c2285fe1d9`` from
   the examples above) to use in the next step.

#. Edit the OpenStack Block Storage service configuration file.
   The following sample ``/etc/cinder/cinder.conf`` configuration lists the
   relevant settings for a typical Block Storage service using a single
   Pure Storage array:

   .. code-block:: ini

      [DEFAULT]
      enabled_backends = puredriver-1
      default_volume_type = puredriver-1

      [puredriver-1]
      volume_backend_name = puredriver-1
      volume_driver = PURE_VOLUME_DRIVER
      san_ip = IP_PURE_MGMT
      pure_api_token = PURE_API_TOKEN
      use_multipath_for_image_xfer = True

   Replace the following variables accordingly:

   PURE_VOLUME_DRIVER
       Use either ``cinder.volume.drivers.pure.PureISCSIDriver`` for iSCSI or
       ``cinder.volume.drivers.pure.PureFCDriver`` for Fibre Channel
       connectivity.

   IP_PURE_MGMT
       The IP address of the Pure Storage array's management interface or a
       domain name that resolves to that IP address.

   PURE_API_TOKEN
       The Purity Authorization token that the volume driver uses to
       perform volume management on the Pure Storage array.

.. note::

   The volume driver automatically creates Purity host objects for
   initiators as needed. If CHAP authentication is enabled via the
   ``use_chap_auth`` setting, you must ensure there are no manually
   created host objects with IQN's that will be used by the OpenStack
   Block Storage service. The driver will only modify credentials on hosts that
   it manages.

.. note::

   If using the PureFCDriver it is recommended to use the OpenStack
   Block Storage Fibre Channel Zone Manager.
