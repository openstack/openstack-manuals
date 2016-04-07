==========================
Fibre Channel Zone Manager
==========================

The Fibre Channel Zone Manager allows FC SAN Zone/Access control
management in conjunction with Fibre Channel block storage. The
configuration of Fibre Channel Zone Manager and various zone drivers are
described in this section.

Configure Block Storage to use Fibre Channel Zone Manager
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If Block Storage is configured to use a Fibre Channel volume driver that
supports Zone Manager, update ``cinder.conf`` to add the following
configuration options to enable Fibre Channel Zone Manager.

Make the following changes in the ``/etc/cinder/cinder.conf`` file.

.. include:: ../tables/cinder-zoning.rst

To use different Fibre Channel Zone Drivers, use the parameters
described in this section.

.. note::

    When multi backend configuration is used, provide the
    ``zoning_mode`` configuration option as part of the volume driver
    configuration where ``volume_driver`` option is specified.

.. note::

    Default value of ``zoning_mode`` is ``None`` and this needs to be
    changed to ``fabric`` to allow fabric zoning.

.. note::

    ``zoning_policy`` can be configured as ``initiator-target`` or
    ``initiator``

Brocade Fibre Channel Zone Driver
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Brocade Fibre Channel Zone Driver performs zoning operations
through HTTP, HTTPS, or SSH.

Configure SAN fabric parameters in the form of fabric groups as
described in the example below:

.. include:: ../tables/cinder-zoning_fabric.rst

.. note::

    Define a fabric group for each fabric using the fabric names used in
    ``fc_fabric_names`` configuration option as group name.

.. note::

    To define a fabric group for a switch which has Virtual Fabrics
    enabled, include the ``fc_virtual_fabric_id`` configuration option
    and ``fc_southbound_protocol`` configuration option set to ``HTTP``
    or ``HTTPS`` in the fabric group. Zoning on VF enabled fabric using
    ``SSH`` southbound protocol is not supported.

System requirements
-------------------

Brocade Fibre Channel Zone Driver requires firmware version FOS v6.4 or
higher.

As a best practice for zone management, use a user account with
``zoneadmin`` role. Users with ``admin`` role (including the default
``admin`` user account) are limited to a maximum of two concurrent SSH
sessions.

For information about how to manage Brocade Fibre Channel switches, see
the Brocade Fabric OS user documentation.

