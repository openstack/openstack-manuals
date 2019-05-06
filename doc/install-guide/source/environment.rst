===========
Environment
===========

This section explains how to configure the controller node and one compute
node using the example architecture.

Although most environments include Identity, Image service, Compute, at least
one networking service, and the Dashboard, the Object Storage service can
operate independently. If your use case only involves Object Storage, you can
skip to

* `Object Storage Installation Guide for Stein <https://docs.openstack.org/swift/stein/install/>`_

* `Object Storage Installation Guide for Rocky <https://docs.openstack.org/swift/rocky/install/>`_

* `Object Storage Installation Guide for Queens <https://docs.openstack.org/swift/queens/install/>`_

* `Object Storage Installation Guide for Pike <https://docs.openstack.org/swift/pike/install/>`_

after configuring the appropriate nodes for it.

You must use an account with administrative privileges to configure each node.
Either run the commands as the ``root`` user or configure the ``sudo``
utility.

.. note::

  The :command:`systemctl enable` call on openSUSE outputs a warning
  message when the service uses SysV Init scripts instead of native
  systemd files. This warning can be ignored.


For best performance, we recommend that your environment meets or exceeds
the hardware requirements in :ref:`figure-hwreqs`.

The following minimum requirements should support a proof-of-concept
environment with core services and several :term:`CirrOS` instances:

*  Controller Node: 1 processor, 4 GB memory, and 5 GB storage

*  Compute Node: 1 processor, 2 GB memory, and 10 GB storage

As the number of OpenStack services and virtual machines increase, so do the
hardware requirements for the best performance. If performance degrades after
enabling additional services or virtual machines, consider adding hardware
resources to your environment.

To minimize clutter and provide more resources for OpenStack, we recommend
a minimal installation of your Linux distribution. Also, you must install a
64-bit version of your distribution on each node.

A single disk partition on each node works for most basic installations.
However, you should consider :term:`Logical Volume Manager (LVM)` for
installations with optional services such as Block Storage.

For first-time installation and testing purposes, many users select to build
each host as a :term:`virtual machine (VM)`. The primary benefits of VMs
include the following:

*  One physical server can support multiple nodes, each with almost any
   number of network interfaces.

*  Ability to take periodic "snap shots" throughout the installation
   process and "roll back" to a working configuration in the event of a
   problem.

However, VMs will reduce performance of your instances, particularly if
your hypervisor and/or processor lacks support for hardware acceleration
of nested VMs.

.. note::

   If you choose to install on VMs, make sure your hypervisor provides
   a way to disable MAC address filtering on the provider network
   interface.

For more information about system requirements, see the
`OpenStack Pike Administrator Guides <https://docs.openstack.org/pike/admin/>`_,
the
`OpenStack Queens Administrator Guides <https://docs.openstack.org/queens/admin/>`_,
or the
`OpenStack Rocky Administrator Guides <https://docs.openstack.org/rocky/admin/>`_.

.. toctree::
   :maxdepth: 1

   environment-security.rst
   environment-networking.rst
   environment-ntp.rst
   environment-packages.rst
   environment-sql-database.rst
   environment-messaging.rst
   environment-memcached.rst
   environment-etcd.rst
