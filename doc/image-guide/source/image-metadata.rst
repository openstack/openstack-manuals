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
:command:`glance image-create` or :command:`glance image-update`
command. More than one property can be specified. For example:

.. code-block:: console

   $ glance image-update img-uuid --property architecture=arm \
     --property hypervisor_type=qemu

Common image properties are also specified in the
``/etc/glance/schema-image.json`` file.
For a complete list of valid property keys and values, refer to the
`OpenStack Command-Line Reference
<http://docs.openstack.org/cli-reference/glance.html#image-service-property-keys>`_.

All associated properties for an image can be displayed using the
:command:`glance image-show` command. For example:

.. code-block:: console

   $ glance image-show myCirrosImage
   +---------------------------------------+--------------------------------------+
   | Property                              | Value                                |
   +---------------------------------------+--------------------------------------+
   | Property 'base_image_ref'             | 397e713c-b95b-4186-ad46-6126863ea0a9 |
   | Property 'image_location'             | snapshot                             |
   | Property 'image_state'                | available                            |
   | Property 'image_type'                 | snapshot                             |
   | Property 'instance_type_ephemeral_gb' | 0                                    |
   | Property 'instance_type_flavorid'     | 2                                    |
   | Property 'instance_type_id'           | 5                                    |
   | Property 'instance_type_memory_mb'    | 2048                                 |
   | Property 'instance_type_name'         | m1.small                             |
   | Property 'instance_type_root_gb'      | 20                                   |
   | Property 'instance_type_rxtx_factor'  | 1                                    |
   | Property 'instance_type_swap'         | 0                                    |
   | Property 'instance_type_vcpu_weight'  | None                                 |
   | Property 'instance_type_vcpus'        | 1                                    |
   | Property 'instance_uuid'              | 84c6e57d-a6b1-44b6-81eb-fcb36afd31b5 |
   | Property 'kernel_id'                  | df430cc2-3406-4061-b635-a51c16e488ac |
   | Property 'owner_id'                   | 66265572db174a7aa66eba661f58eb9e     |
   | Property 'ramdisk_id'                 | 3cf852bd-2332-48f4-9ae4-7d926d50945e |
   | Property 'user_id'                    | 376744b5910b4b4da7d8e6cb483b06a8     |
   | checksum                              | 8e4838effa1969ad591655d6485c7ba8     |
   | container_format                      | ami                                  |
   | created_at                            | 2013-07-22T19:45:58                  |
   | deleted                               | False                                |
   | disk_format                           | ami                                  |
   | id                                    | 7e5142af-1253-4634-bcc6-89482c5f2e8a |
   | is_public                             | False                                |
   | min_disk                              | 0                                    |
   | min_ram                               | 0                                    |
   | name                                  | myCirrosImage                        |
   | owner                                 | 66265572db174a7aa66eba661f58eb9e     |
   | protected                             | False                                |
   | size                                  | 14221312                             |
   | status                                | active                               |
   | updated_at                            | 2013-07-22T19:46:42                  |
   +---------------------------------------+--------------------------------------+

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
 * Contains metadata definitons.

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
   ``/etc/metadefs`` directory.
