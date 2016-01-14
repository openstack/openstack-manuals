==================
IPAM configuration
==================

Starting with the Liberty release, OpenStack Networking includes a pluggable
interface for the IP Address Management (IPAM) function. This interface creates
a driver framework for the allocation and de-allocation of subnets and IP
addresses, enabling the integration of alternate IPAM implementations or
third-party IP Address Management systems.

The basics
~~~~~~~~~~

The IPAM implementation within OpenStack Networking provides two basic
flavors (pluggable IPAM, non-pluggable IPAM). By default, the non-pluggable
IPAM is enabled. This provides backward compatibility with older releases. In
contrast, the pluggable implementation will require a database migration to
support upgraded systems. This migration is planned for the Mitaka release.

The reference driver for the pluggable implementation is considered
experimental at this time. It does not provide additional functionality
beyond the non-pluggable implementation, but does provide a basis for custom
or third-party developed drivers. This can enable, for example, development
of drivers that use different algorithms to allocate an IP address.

To enable the pluggable implementation, you must specify the driver to
use in the ``neutron.conf`` file. The ``internal`` driver refers to the
reference implementation.

.. code-block:: ini

   ipam_driver = internal

The documentation for any alternate drivers will include the value to
use when specifying that driver.

Known limitations
~~~~~~~~~~~~~~~~~

* The driver interface is designed to allow separate drivers for each
  subnet pool. However, the current implementation allows only a single
  IPAM driver system-wide.
* Database migrations are not available to convert existing OpenStack
  installations to the new reference implementation of the pluggable
  IPAM. This migration is planned for the Mitaka release.
* Third-party drivers must provide their own migration mechanisms to convert
  existing OpenStack installations to their IPAM.
