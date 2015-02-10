=============
Manage images
=============

When working with images in the SDK, you will call both ``glance`` and
``nova`` methods.

.. _list-images:

List images
~~~~~~~~~~~

To list the available images, call the
``glanceclient.v2.images.Controller.list`` method:

.. code:: python

    import glanceclient.v2.client as glclient
    glance = glclient.Client(...)
    images = glance.images.list()

The images method returns a Python generator, as shown in the following
interaction with the Python interpreter:

::

    >>> images = glance.images.list()
    >>> images
    <generator object list at 0x105e9c2d0>
    >>> list(images)
    [{u'checksum': u'f8a2eeee2dc65b3d9b6e63678955bd83',
      u'container_format': u'ami',
      u'created_at': u'2013-10-20T14:28:10Z',
      u'disk_format': u'ami',
      u'file': u'/v2/images/dbc9b2db-51d7-403d-b680-3f576380b00c/file',
      u'id': u'dbc9b2db-51d7-403d-b680-3f576380b00c',
      u'kernel_id': u'c002c82e-2cfa-4952-8461-2095b69c18a6',
      u'min_disk': 0,
      u'min_ram': 0,
      u'name': u'cirros-0.3.2-x86_64-uec',
      u'protected': False,
      u'ramdisk_id': u'4c1c9b4f-3fe9-425a-a1ec-1d8fd90b4db3',
      u'schema': u'/v2/schemas/image',
      u'size': 25165824,
      u'status': u'active',
      u'tags': [],
      u'updated_at': u'2013-10-20T14:28:11Z',
      u'visibility': u'public'},
     {u'checksum': u'69c33642f44ca552ba4bb8b66ad97e85',
      u'container_format': u'ari',
      u'created_at': u'2013-10-20T14:28:09Z',
      u'disk_format': u'ari',
      u'file': u'/v2/images/4c1c9b4f-3fe9-425a-a1ec-1d8fd90b4db3/file',
      u'id': u'4c1c9b4f-3fe9-425a-a1ec-1d8fd90b4db3',
      u'min_disk': 0,
      u'min_ram': 0,
      u'name': u'cirros-0.3.2-x86_64-uec-ramdisk',
      u'protected': False,
      u'schema': u'/v2/schemas/image',
      u'size': 3714968,
      u'status': u'active',
      u'tags': [],
      u'updated_at': u'2013-10-20T14:28:10Z',
      u'visibility': u'public'},
     {u'checksum': u'c352f4e7121c6eae958bc1570324f17e',
      u'container_format': u'aki',
      u'created_at': u'2013-10-20T14:28:08Z',
      u'disk_format': u'aki',
      u'file': u'/v2/images/c002c82e-2cfa-4952-8461-2095b69c18a6/file',
      u'id': u'c002c82e-2cfa-4952-8461-2095b69c18a6',
      u'min_disk': 0,
      u'min_ram': 0,
      u'name': u'cirros-0.3.2-x86_64-uec-kernel',
      u'protected': False,
      u'schema': u'/v2/schemas/image',
      u'size': 4955792,
      u'status': u'active',
      u'tags': [],
      u'updated_at': u'2013-10-20T14:28:09Z',
      u'visibility': u'public'}]

.. _get-image-id:

Get image by ID
~~~~~~~~~~~~~~~

To retrieve an image object from its ID, call the
``glanceclient.v2.images.Controller.get`` method:

.. code:: python

    import glanceclient.v2.client as glclient
    image_id = 'c002c82e-2cfa-4952-8461-2095b69c18a6'
    glance = glclient.Client(...)
    image = glance.images.get(image_id)

.. _get-image-name:

Get image by name
~~~~~~~~~~~~~~~~~

The Image Service Python bindings do not support the retrieval of an
image object by name. However, the Compute Python bindings enable you to
get an image object by name. To get an image object by name, call the
``novaclient.v1\_1.images.ImageManager.find`` method:

.. code:: python

    import novaclient.v1_1.client as nvclient
    name = "cirros"
    nova = nvclient.Client(...)
    image = nova.images.find(name=name)

.. _upload-image:

Upload an image
~~~~~~~~~~~~~~~

To upload an image, call the ``glanceclient.v2.images.ImageManager.create``
method:

.. code:: python

    import glanceclient.v2.client as glclient
    imagefile = "/tmp/myimage.img"
    glance = glclient.Client(...)
    with open(imagefile) as fimage:
      glance.images.create(name="myimage", is_public=False, disk_format="qcow2",
                           container_format="bare", data=fimage)
