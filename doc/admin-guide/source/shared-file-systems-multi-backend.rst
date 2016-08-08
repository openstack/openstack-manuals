.. _shared_file_systems_multi_backend:

===========================
Multi-storage configuration
===========================

The Shared File Systems service can provide access to multiple file storage
back ends. In general, the workflow with multiple back ends looks similar
to the Block Storage service one, see :ref:`Configure multiple-storage back
ends in Block Storage service <multi_backend>`.

Using ``manila.conf``, you can spawn multiple share services. To do it, you
should set the `enabled_share_backends` flag in the ``manila.conf`` file. This
flag defines the comma-separated names of the configuration stanzas for the
different back ends. One name is associated to one configuration group for a
back end.

The following example runs three configured share services:

.. code-block:: ini
   :linenos:

   [DEFAULT]
   enabled_share_backends=backendEMC2,backendGeneric1,backendNetApp

   [backendGeneric1]
   share_driver=manila.share.drivers.generic.GenericShareDriver
   share_backend_name=one_name_for_two_backends
   service_instance_user=ubuntu_user
   service_instance_password=ubuntu_user_password
   service_image_name=ubuntu_image_name
   path_to_private_key=/home/foouser/.ssh/id_rsa
   path_to_public_key=/home/foouser/.ssh/id_rsa.pub

   [backendEMC2]
   share_driver=manila.share.drivers.emc.driver.EMCShareDriver
   share_backend_name=backendEMC2
   emc_share_backend=vnx
   emc_nas_server=1.1.1.1
   emc_nas_password=password
   emc_nas_login=user
   emc_nas_server_container=server_3
   emc_nas_pool_name="Pool 2"

   [backendNetApp]
   share_driver = manila.share.drivers.netapp.common.NetAppDriver
   driver_handles_share_servers = True
   share_backend_name=backendNetApp
   netapp_login=user
   netapp_password=password
   netapp_server_hostname=1.1.1.1
   netapp_root_volume_aggregate=aggr01

To spawn separate groups of share services, you can use separate configuration
files. If it is necessary to control each back end in a separate way, you
should provide a single configuration file per each back end.

.. toctree::

   shared-file-systems-scheduling.rst
   shared-file-systems-services-manage.rst
