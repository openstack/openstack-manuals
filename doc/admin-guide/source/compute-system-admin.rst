.. _compute-trusted-pools.rst:

=====================
System administration
=====================

.. toctree::
   :maxdepth: 2

   compute-manage-users.rst
   compute-manage-volumes.rst
   compute-flavors.rst
   compute-default-ports.rst
   compute-admin-password-injection.rst
   compute-manage-the-cloud.rst
   compute-manage-logs.rst
   compute-root-wrap-reference.rst
   compute-configuring-migrations.rst
   compute-live-migration-usage.rst
   compute-remote-console-access.rst
   compute-service-groups.rst
   compute-security.rst
   compute-node-down.rst
   compute-adv-config.rst

To effectively administer Compute, you must understand how the different
installed nodes interact with each other. Compute can be installed in
many different ways using multiple servers, but generally multiple
compute nodes control the virtual servers and a cloud controller node
contains the remaining Compute services.

The Compute cloud works using a series of daemon processes named ``nova-*``
that exist persistently on the host machine. These binaries can all run
on the same machine or be spread out on multiple boxes in a large
deployment. The responsibilities of services and drivers are:

**Services**

``nova-api``
   receives XML requests and sends them to the rest of the
   system. A WSGI app routes and authenticates requests. Supports the
   EC2 and OpenStack APIs. A ``nova.conf`` configuration file is created
   when Compute is installed.

``nova-cert``
   manages certificates.

``nova-compute``
   manages virtual machines. Loads a Service object, and
   exposes the public methods on ComputeManager through a Remote
   Procedure Call (RPC).

``nova-conductor``
   provides database-access support for Compute nodes
   (thereby reducing security risks).

``nova-consoleauth``
   manages console authentication.

``nova-objectstore``
   a simple file-based storage system for images that
   replicates most of the S3 API. It can be replaced with OpenStack
   Image service and either a simple image manager or OpenStack Object
   Storage as the virtual machine image storage facility. It must exist
   on the same node as ``nova-compute``.

``nova-network``
   manages floating and fixed IPs, DHCP, bridging and
   VLANs. Loads a Service object which exposes the public methods on one
   of the subclasses of NetworkManager. Different networking strategies
   are available by changing the ``network_manager`` configuration
   option to ``FlatManager``, ``FlatDHCPManager``, or ``VLANManager``
   (defaults to ``VLANManager`` if nothing is specified).

``nova-scheduler``
   dispatches requests for new virtual machines to the
   correct node.

``nova-novncproxy``
   provides a VNC proxy for browsers, allowing VNC
   consoles to access virtual machines.

.. note::

   Some services have drivers that change how the service implements
   its core functionality. For example, the ``nova-compute`` service
   supports drivers that let you choose which hypervisor type it can
   use. ``nova-network`` and ``nova-scheduler`` also have drivers.
