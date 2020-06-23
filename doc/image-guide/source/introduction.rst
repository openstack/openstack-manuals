============
Introduction
============

An OpenStack Compute cloud is not very useful unless you have virtual
machine images (which some people call "virtual appliances").
This guide describes how to obtain, create, and modify virtual machine
images that are compatible with OpenStack.

To keep things brief, we will sometimes use the term ``image``
instead of virtual machine image.

**What is a virtual machine image?**

A virtual machine image is a single file which contains a virtual disk
that has a bootable operating system installed on it.

Disk and container formats for images
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Virtual machine images come in different *formats*.  A format describes the way
the bits making up a file are arranged on the storage medium.  Knowledge of a
format is required in order for a consumer to interpret the content of the file
correctly (rather than to simply view it as a bunch of bits).

When considering a stored virtual machine image, there are two types of format
that can come into play.

container format
    The stored file may be a *container* that contains the virtual disk.  For
    example, the virtual disk may be contained in a ``tar`` file which must
    be opened before the disk can be retrieved.  It's possible, however, that
    the virtual disk is not contained in a file, but is just stored as-is by
    the Image Service.

disk format
    The virtual disk itself has its bits arranged in some format.  A consuming
    service must know what this format is before it can effectively use the
    virtual disk.

Image metadata
~~~~~~~~~~~~~~

Image metadata (also known as "image properties") provide information about the
virtual disk stored by the Image service.  The metadata is stored as part of
the image record associated with the image data by the Image service.  Image
metadata can help end users determine the nature of an image, and is used by
associated OpenStack components and drivers which interface with the Image
service.

So that image consumers can easily identify the container and disk format of
images, the image service has set aside particular metadata keys for these.
Not surprisingly, these are named ``container_format`` and ``disk_format``.
The legal values for each of these are specified in the Image service's Image
schema, which you can obtain in any OpenStack installation by making the
following API call::

  GET /v2/schemas/image

The supported formats may vary across OpenStack clouds.  The formats accepted
by a particular cloud will be specified in that cloud's get-schema response to
the Images API.

.. note::

   The image schema lists the legal identifiers for container and disk formats.
   To understand what these identifiers refer to, consult the
   `Disk and Container Formats
   <https://docs.openstack.org/glance/latest/user/formats.html>`_
   section of the Glance User Guide.

Image metadata can also determine the scheduling of hosts.  If specific
metadata are set on an image (possible metadata are architecture, hypervisor
type, and virtual machine mode), and Compute is configured so that the
``ImagePropertiesFilter`` scheduler filter is enabled (default), then the
scheduler only considers compute hosts that satisfy the specified properties.

.. note::

   Compute's ``ImagePropertiesFilter`` value is specified in the
   ``enabled_filters`` value in the ``[filter_scheduler]`` section
   of the ``/etc/nova/nova.conf`` file.

Other Compute scheduler filters may also be affected by image metadata.
For a complete list of valid property keys and values, refer to the
`Useful image properties
<https://docs.openstack.org/glance/latest/admin/useful-image-properties.html>`_
section of the Glance Administration Guide.

Adding metadata to an image
~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can add metadata to Image service images by using the
``--property key=value`` parameter with the
:command:`openstack image create` or :command:`openstack image set`
command. More than one property can be specified. For example:

.. code-block:: console

   $ openstack image set --property architecture=arm \
     --property hypervisor_type=qemu image_name_or_id

Common image properties are also specified in the
``/etc/glance/schema-image.json`` file.  Other useful property keys and values,
are listed in the
`Useful image properties
<https://docs.openstack.org/glance/latest/admin/useful-image-properties.html>`_
section of the Glance Administration Guide.

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

Metadata definition (metadefs) service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Images are not the only OpenStack resource that can have metadata associated
with them.  Many other resources (for example, volumes) support setting
metadata on the resources.  As with images, the metadata may be consumed by
humans to understand something about the resource, or may be used by other
OpenStack services so that they can make efficient use of the resource (for
example, the nova filter scheduler using the image ``architecture`` property to
determine an appropriate host on which to build an instance from that image).
Thus it is important that there be a discoverable way for people and services
to determine what metadata properties and values are available throughout an
OpenStack cloud.

To facilitate this, Glance (the OpenStack Image service) hosts a metadata
definition service, which is also known as the *OpenStack metadefs catalog*.

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

There is no special relationship between the Image service and the Metadefs
service. If you want to apply the keys and values defined in the Metadefs
service to images, you must use the Image service API or client tools just as
you would for any other OpenStack service.

For more information about the OpenStack Metadefs catalog, see:

* `Using Glance’s Metadata Definitions Catalog Public APIs
  <https://docs.openstack.org/glance/latest/user/glancemetadefcatalogapi.html>`_
  in the Glance User Guide
* The `Metadata Definitions Service API Reference
  <https://docs.openstack.org/api-ref/image/v2/metadefs-index.html>`_
