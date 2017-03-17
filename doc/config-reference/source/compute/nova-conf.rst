=====================
Overview of nova.conf
=====================

The ``nova.conf`` configuration file is an
`INI file format <https://en.wikipedia.org/wiki/INI_file>`_
as explained in :doc:`../config-format`.

You can use a particular configuration option file by using the ``option``
(``nova.conf``) parameter when you run one of the ``nova-*`` services.
This parameter inserts configuration option definitions from the
specified configuration file name, which might be useful for debugging
or performance tuning.

For a list of configuration options, see the tables in this guide.

To learn more about the ``nova.conf`` configuration file,
review the general purpose configuration options documented in
the table :ref:`nova-common`.

.. important::

   Do not specify quotes around nova options.

Sections
~~~~~~~~

Configuration options are grouped by section.
The Compute configuration file supports the following sections:

[DEFAULT]
  Contains most configuration options.
  If the documentation for a configuration option does not specify
  its section, assume that it appears in this section.
[baremetal]
  Configures the baremetal hypervisor driver.
[cells]
  Configures cells functionality. For details,
  the section called ":doc:`Cells <cells>`".
[conductor]
  Configures the ``nova-conductor`` service.
[database]
  Configures the database that Compute uses.
[glance]
  Configures how to access the Image service.
[hyperv]
  Configures the Hyper-V hypervisor driver.
[image_file_url]
  Configures additional filesystems to access the Image service.
[keymgr]
  Configures the key manager.
[keystone_authtoken]
  Configures authorization via Identity service.
[libvirt]
  Configures the hypervisor drivers using the
  Libvirt library: KVM, LXC, Qemu, UML, Xen.
[matchmaker_redis]
  Configures a Redis server.
[matchmaker_ring]
  Configures a matchmaker ring.
[metrics]
  Configures weights for the metrics weigher.
[neutron]
  Configures Networking specific options.
[osapi_v3]
  Configures the OpenStack Compute API v3.
[placement]
  Configures the OpenStack Placement API.
[rdp]
  Configures RDP proxying.
[serial_console]
  Configures serial console.
[spice]
  Configures virtual consoles using SPICE.
[ssl]
  Configures certificate authority using SSL.
[trusted_computing]
  Configures the trusted computing pools functionality
  and how to connect to a remote attestation service.
[upgrade_levels]
  Configures version locking on the RPC (message queue)
  communications between the various Compute services
  to allow live upgrading an OpenStack installation.
[vmware]
  Configures the VMware hypervisor driver.
[xenserver]
  Configures the XenServer hypervisor driver.
[zookeeper]
  Configures the ZooKeeper ServiceGroup driver.
