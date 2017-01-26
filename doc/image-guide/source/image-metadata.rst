==============
Image metadata
==============

Image metadata can help end users determine the nature of an image,
and is used by associated OpenStack components and drivers which
interface with the Image service.

Metadata can also determine the scheduling of hosts.
If the ``property`` option is set on an image, and Compute is
configured so that the ``ImagePropertiesFilter`` scheduler filter
is enabled (default), then the scheduler only considers compute
hosts that satisfy that property.

.. note::

   Compute's ``ImagePropertiesFilter`` value is specified in the
   ``scheduler_default_filter`` value in the ``/etc/nova/nova.conf`` file.

You can add metadata to Image service images by using the
``--property key=value`` parameter with the
:command:`openstack image create` or :command:`openstack image set`
command. More than one property can be specified. For example:

.. code-block:: console

   $ openstack image set --property architecture=arm \
     --property hypervisor_type=qemu image_name_or_id

Common image properties are also specified in the
``/etc/glance/schema-image.json`` file.
For a complete list of valid property keys and values, refer to the
`OpenStack Command-Line Reference
<http://docs.openstack.org/cli-reference/glance.html#image-service-property-keys>`_.

All associated properties for an image can be displayed using the
:command:`openstack image show` command. For example:

.. code-block:: console

   $ openstack image show cirros
   +------------------+------------------------------------------------------+
   | Field            | Value                                                |
   +------------------+------------------------------------------------------+
   | checksum         | ee1eca47dc88f4879d8a229cc70a07c6                     |
   | container_format | bare                                                 |
   | created_at       | 2016-04-15T13:57:38Z                                 |
   | disk_format      | qcow2                                                |
   | file             | /v2/images/55f0907f-70a5-4376-a346-432e4ec509ed/file |
   | id               | 55f0907f-70a5-4376-a346-432e4ec509ed                 |
   | min_disk         | 0                                                    |
   | min_ram          | 0                                                    |
   | name             | cirros                                               |
   | owner            | f9574e69042645d6b5539035cb8c00bf                     |
   | properties       | architecture='arm', hypervisor_type='qemu'           |
   | protected        | False                                                |
   | schema           | /v2/schemas/image                                    |
   | size             | 13287936                                             |
   | status           | active                                               |
   | tags             |                                                      |
   | updated_at       | 2016-04-15T13:57:57Z                                 |
   | virtual_size     | None                                                 |
   | visibility       | public                                               |
   +------------------+------------------------------------------------------+

.. note::

   **Volume-from-Image properties**

   When creating Block Storage volumes from images, also consider your
   configured image properties. If you alter the core image properties,
   you should also update your Block Storage configuration.
   Amend ``glance_core_properties`` in the ``/etc/cinder/cinder.conf``
   file on all controller nodes to match the core properties you have
   set in the Image service.

Metadata definition service
~~~~~~~~~~~~~~~~~~~~~~~~~~~

With this service you can define:

Namespace
 * Contains metadata definitions.

 * Specifies the access controls for everything defined in the namespace.
   These access controls determine who can define and use the definitions
   in the namespace.

 * Associates the definitions with different types of resources.

Property
 A single property and its primitive constraints. Each property can only
 be a primitive type. For example, string, integer, number, boolean, or array.

Object
 Describes a group of one to many properties and their primitive
 constraints. Each property in the group can only be a primitive type. For
 example, string, integer, number, boolean, or array.

 The object may optionally define required properties under the semantic
 understanding that if you use the object, you should provide all required
 properties.

Resource type association
 Specifies the relationship between resource types and the namespaces
 that are applicable to them. This information can be used to drive UI
 and CLI views. For example, the same namespace of objects, properties,
 and tags may be used for images, snapshots, volumes, and flavors.
 Or a namespace may only apply to images.

The Image service has predefined namespaces for the metadata definitions
catalog. To load files from this directory into the database:

.. code-block:: console

   $ glance-manage db_load_metadefs

To unload the files from the database:

.. code-block:: console

   $ glance-manage db_unload_metadefs

To export the definitions in JSON format:

.. code-block:: console

   $ glance-manage db_export_metadefs

.. note::

   By default, files are loaded from and exported to the Image service's
   ``/etc/glance/metadefs`` directory.
