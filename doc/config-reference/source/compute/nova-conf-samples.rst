=====================================
Example nova.conf configuration files
=====================================

The following sections describe the configuration options in the
``nova.conf`` file. You must copy the ``nova.conf`` file to each
compute node. The sample ``nova.conf`` files show examples of
specific configurations.

Small, private cloud
~~~~~~~~~~~~~~~~~~~~

This example ``nova.conf`` file configures a small private cloud
with cloud controller services, database server, and messaging
server on the same server. In this case, ``CONTROLLER_IP`` represents
the IP address of a central server, ``BRIDGE_INTERFACE`` represents
the bridge such as br100, the ``NETWORK_INTERFACE`` represents an
interface to your VLAN setup, and passwords are represented as
``DB_PASSWORD_COMPUTE`` for your Compute (nova) database password,
and ``RABBIT PASSWORD`` represents the password to your message
queue installation.

.. literalinclude:: nova.conf
   :language: ini

KVM, Flat, MySQL, and Glance, OpenStack or EC2 API
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This example ``nova.conf`` file, from an internal Rackspace test
system, is used for demonstrations.

.. literalinclude:: nova.conf
   :language: ini

.. figure:: ../figures/nova-conf-kvm-flat.png
   :width: 100%
   :alt: KVM, Flat, MySQL, and Glance, OpenStack or EC2 API


XenServer, Flat networking, MySQL, and Glance, OpenStack API
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This example ``nova.conf`` file is from an internal Rackspace test system.

.. code-block:: ini

   verbose
   nodaemon
   network_manager=nova.network.manager.FlatManager
   image_service=nova.image.glance.GlanceImageService
   flat_network_bridge=xenbr0
   compute_driver=xenapi.XenAPIDriver
   xenapi_connection_url=https://&lt;XenServer IP&gt;
   xenapi_connection_username=root
   xenapi_connection_password=supersecret
   xenapi_image_upload_handler=nova.virt.xenapi.image.glance.GlanceStore
   rescue_timeout=86400
   use_ipv6=true

   # To enable flat_injected, currently only works on Debian-based systems
   flat_injected=true
   ipv6_backend=account_identifier
   ca_path=./nova/CA

   # Add the following to your conf file if you're running on Ubuntu Maverick
   xenapi_remap_vbd_dev=true
   [database]
   connection=mysql+pymysql://root:&lt;password&gt;@127.0.0.1/nova

.. figure:: ../figures/nova-conf-xen-flat.png
   :width: 100%
   :alt: XenServer, Flat networking, MySQL, and Glance, OpenStack API
