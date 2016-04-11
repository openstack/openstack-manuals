Shared File Systems Option 2: Driver support for share servers management
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For simplicity, this configuration references the same storage node
configuration for the Block Storage service.

.. note::

   This guide describes how to configure the Shared File Systems service to
   use the ``generic`` driver with the driver handles share server mode
   (DHSS) enabled. This mode requires Compute (nova), Networking (neutron) and
   Block storage (cinder) services for managing share servers. The information
   used for creating share servers is configured as share networks. Generic
   driver with DHSS enabled also requires network to be attached to a public
   router.

Prerequisites
-------------

Before you proceed, verify operation of the Compute, Networking, and Block
Storage services. This options requires implementation of Networking option 2
and requires installation of some Networking service components on the storage
node.

* Install the Networking service components:

  .. only:: obs

     .. code-block:: console

        # zypper install --no-recommends openstack-neutron-linuxbridge-agent

  .. only:: rdo

     .. code-block:: console

        # yum install openstack-neutron openstack-neutron-linuxbridge ebtables

  .. only:: ubuntu

     .. code-block:: console

        # apt-get install neutron-plugin-linuxbridge-agent

Configure components
--------------------

.. include:: shared/note_configuration_vary_by_distribution.rst

#. Edit the ``/etc/manila/manila.conf`` file and complete the following
   actions:

   * In the ``[DEFAULT]`` section, enable the generic driver and the NFS/CIFS
     protocols:

     .. code-block:: ini

        [DEFAULT]
        ...
        enabled_share_backends = generic
        enabled_share_protocols = NFS,CIFS

     .. note::

        Back end names are arbitrary. As an example, this guide uses the name
        of the driver.

   * In the ``[neutron]``, ``[nova]``, and ``[cinder]`` sections, enable
     authentication for those services:

     .. code-block:: ini

        [neutron]
        ...
        url = http://controller:9696
        auth_uri = http://controller:5000
        auth_url = http://controller:35357
        memcached_servers = controller:11211
        auth_type = password
        project_domain_name = default
        user_domain_name = default
        region_name = RegionOne
        project_name = service
        username = neutron
        password = NEUTRON_PASS

        [nova]
        ...
        auth_uri = http://controller:5000
        auth_url = http://controller:35357
        memcached_servers = controller:11211
        auth_type = password
        project_domain_name = default
        user_domain_name = default
        region_name = RegionOne
        project_name = service
        username = nova
        password = NOVA_PASS

        [cinder]
        ...
        auth_uri = http://controller:5000
        auth_url = http://controller:35357
        memcached_servers = controller:11211
        auth_type = password
        project_domain_name = default
        user_domain_name = default
        region_name = RegionOne
        project_name = service
        username = cinder
        password = CINDER_PASS

   * In the ``[generic]`` section, configure the generic driver:

     .. code-block:: ini

        [generic]
        share_backend_name = GENERIC
        share_driver = manila.share.drivers.generic.GenericShareDriver
        driver_handles_share_servers = True
        service_instance_flavor_id = 100
        service_image_name = manila-service-image
        service_instance_user = manila
        service_instance_password = manila
        interface_driver = manila.network.linux.interface.BridgeInterfaceDriver

     .. note::

        You can also use SSH keys instead of password authentication for
        service instance credentials.

Return to :ref:`Finalize installation <manila-share-finalize-install>`.
