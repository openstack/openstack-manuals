.. _large-object-creation:

=============
Large objects
=============

To discover whether your Object Storage system supports this feature, see
:ref:`discoverability` or check with your service provider.

By default, the content of an object cannot be greater than 5 GB.
However, you can use a number of smaller objects to construct a large
object. The large object is comprised of two types of objects:

* ``Segment objects`` store the object content. You can divide your content
  into segments and upload each segment into its own segment object. Segment
  objects do not have any special features. You create, update, download, and
  delete segment objects just as you do with normal objects.

* A ``manifest object`` links the segment objects into one logical large
  object. When you download a manifest object, Object Storage concatenates and
  returns the contents of the segment objects in the response body. This
  behavior extends to the response headers returned by ``GET`` and ``HEAD``
  requests. The ``Content-Length`` response header contains the total size of
  all segment objects.

  Object Storage takes the ``ETag`` value of each segment, concatenates them
  together, and returns the MD5 checksum of the result to calculate the
  ``ETag`` response header value. The manifest object types are:

  Static large objects
    The manifest object content is an ordered list of the names of
    the segment objects in JSON format. See :ref:`static_large_objects`.

  Dynamic large objects
    The manifest object has no content but it has a
    ``X-Object-Manifest`` metadata header. The value of this header
    is ``CONTAINER/PREFIX``, where ``CONTAINER`` is the name of
    the container where the segment objects are stored, and
    ``PREFIX`` is a string that all segment objects have in common.
    See :ref:`dynamic_large_objects`.

.. note::

   If you use a manifest object as the source of a ``COPY`` request, the
   new object is a normal, and not a segment, object. If the total size of the
   source segment objects exceeds 5 GB, the ``COPY`` request fails. However,
   you can make a duplicate of the manifest object and this new object can be
   larger than 5 GB.

.. _static_large_objects:

Static large objects
~~~~~~~~~~~~~~~~~~~~

To create a static large object, divide your content into pieces and create
(upload) a segment object to contain each piece.

You must record the ``ETag`` response header value that the ``PUT`` operation
returns. Alternatively, you can calculate the MD5 checksum of the segment
before you perform the upload and include this value in the ``ETag`` request
header. This action ensures that the upload cannot corrupt your data.

List the name of each segment object along with its size and MD5
checksum in order.

Create a manifest object. Include the ``?multipart-manifest=put``
query string at the end of the manifest object name to indicate that
this is a manifest object.

The body of the ``PUT`` request on the manifest object comprises a JSON
list where each element contains these attributes:

path
  The container and object name in the format:
  ``CONTAINER_NAME/OBJECT_NAME``.

etag
  The MD5 checksum of the content of the segment object. This value
  must match the ``ETag`` of that object.

size_bytes
  The size of the segment object. This value must match the
  ``Content-Length`` of that object.

Static large object manifest list
---------------------------------

This example shows three segment objects. You can use several containers
and the object names do not have to conform to a specific pattern, in
contrast to dynamic large objects.

.. code-block:: json

    [
        {
            "path": "mycontainer/objseg1",
            "etag": "0228c7926b8b642dfb29554cd1f00963",
            "size_bytes": 1468006
        },
        {
            "path": "mycontainer/pseudodir/seg-obj2",
            "etag": "5bfc9ea51a00b790717eeb934fb77b9b",
            "size_bytes": 1572864
        },
        {
            "path": "other-container/seg-final",
            "etag": "b9c3da507d2557c1ddc51f27c54bae51",
            "size_bytes": 256
        }
    ]

|

The ``Content-Length`` request header must contain the length of the
JSON content and not the length of the segment objects. However, after the
``PUT`` operation completes, the ``Content-Length`` metadata is set to
the total length of all the object segments. A similar situation applies
to the ``ETag``. If used in the ``PUT`` operation, it must contain the
MD5 checksum of the JSON content. The ``ETag`` metadata value is then
set to be the MD5 checksum of the concatenated ``ETag`` values of the
object segments. You can also set the ``Content-Type`` request header
and custom object metadata.

When the ``PUT`` operation sees the ``?multipart-manifest=put`` query
parameter, it reads the request body and verifies that each segment
object exists and that the sizes and ETags match. If there is a
mismatch, the ``PUT`` operation fails.

If everything matches, the API creates the manifest object and sets the
``X-Static-Large-Object`` metadata to ``true`` to indicate that the manifest is
a static object manifest.

Normally when you perform a ``GET`` operation on the manifest object, the
response body contains the concatenated content of the segment objects. To
download the manifest list, use the ``?multipart-manifest=get`` query
parameter. The list in the response is not formatted the same as the manifest
that you originally used in the ``PUT`` operation.

If you use the ``DELETE`` operation on a manifest object, the manifest
object is deleted. The segment objects are not affected. However, if you
add the ``?multipart-manifest=delete`` query parameter, the segment
objects are deleted and if all are successfully deleted, the manifest
object is also deleted.

To change the manifest, use a ``PUT`` operation with the
``?multipart-manifest=put`` query parameter. This request creates a
manifest object. You can also update the object metadata in the usual
way.

.. _dynamic_large_objects:

Dynamic large objects
~~~~~~~~~~~~~~~~~~~~~

Before you can upload objects that are larger than 5 GB, you must segment
them. You upload the segment objects like you do with any other object and
create a dynamic large manifest object. The manifest object tells Object
Storage how to find the segment objects that comprise the large object. You
can still access each segment individually, but when you retrieve the manifest
object, the API concatenates the segments. You can include any number of
segments in a single large object.

To ensure the download works correctly, you must upload all the object
segments to the same container and prefix each object name so that the
segments sort in correct concatenation order.

You also create and upload a manifest file. The manifest file is a zero-byte
file with the extra ``X-Object-Manifest`` ``CONTAINER/PREFIX`` header. The
``CONTAINER`` is the container the object segments are in and ``PREFIX`` is
the common prefix for all the segments. You must UTF-8-encode and then
URL-encode the container and common prefix in the ``X-Object-Manifest`` header.

It is best to upload all the segments first and then create or update
the manifest. With this method, the full object is not available for
downloading until the upload is complete. Also, you can upload a new set
of segments to a second location and update the manifest to point to
this new location. During the upload of the new segments, the original
manifest is still available to download the first set of segments.

Upload segment of large object request: HTTP
--------------------------------------------

.. code-block:: console

   PUT /API_VERSION/ACCOUNT/CONTAINER/OBJECT HTTP/1.1
   Host: storage.example.com
   X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
   ETag: 8a964ee2a5e88be344f36c22562a6486
   Content-Length: 1
   X-Object-Meta-PIN: 1234

No response body is returned.

The 2``nn`` response code indicates a successful write. ``nn`` is a value from
00 to 99.

The ``Length Required (411)`` response code indicates that the request does
not include a required ``Content-Length`` or ``Content-Type`` header.

The ``Unprocessable Entity (422)`` response code indicates that the MD5
checksum of the data written to the storage system does NOT match the optional
ETag value.

You can continue to upload segments, like this example shows, before you
upload the manifest.

Upload next segment of large object request: HTTP
-------------------------------------------------

.. code-block:: console

   PUT /API_VERSION/ACCOUNT/CONTAINER/OBJECT HTTP/1.1
   Host: storage.example.com
   X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
   ETag: 8a964ee2a5e88be344f36c22562a6486
   Content-Length: 1
   X-Object-Meta-PIN: 1234

Next, upload the manifest. This manifest specifies the container where the
object segments reside. Note that if you upload additional segments after you
create the manifest, the concatenated object becomes that much larger but you
do not need to recreate the manifest file for subsequent additional segments.

Upload manifest request: HTTP
-----------------------------

.. code-block:: console

   PUT /API_VERSION/ACCOUNT/CONTAINER/OBJECT HTTP/1.1
   Host: storage.clouddrive.com
   X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
   Content-Length: 0
   X-Object-Meta-PIN: 1234
   X-Object-Manifest: CONTAINER/PREFIX

Upload manifest response: HTTP
------------------------------
.. code-block:: console

    [...]

A ``GET`` or ``HEAD`` request on the manifest returns a ``Content-Type``
response header value that is the same as the ``Content-Type`` request header
value in the ``PUT`` request that created the manifest. To change the
``Content- Type``, reissue the ``PUT`` request.

Extra transaction information
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can use the ``X-Trans-Id-Extra`` request header to include extra
information to help you debug any errors that might occur with large object
upload and other Object Storage transactions.

The Object Storage API appends the first 32 characters of the
``X-Trans-Id-Extra`` request header value to the transaction ID value in the
generated ``X-Trans-Id`` response header. You must UTF-8-encode and then
URL-encode the extra transaction information before you include it in
the ``X-Trans-Id-Extra`` request header.

For example, you can include extra transaction information when you upload
large objects such as images.

When you upload each segment and the manifest, include the same value in the
``X-Trans-Id-Extra`` request header. If an error occurs, you can find all
requests that are related to the large object upload in the Object Storage
logs.

You can also use ``X-Trans-Id-Extra`` strings to help operators debug requests
that fail to receive responses. The operator can search for the extra
information in the logs.

Comparison of static and dynamic large objects
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

While static and dynamic objects have similar behavior, this table describes
their differences:

.. list-table::
   :header-rows: 1
   :widths: 20 25 25
   :stub-columns: 1

   * - Description
     - Static large object
     - Dynamic large object
   * - End-to-end integrity
     - Assured. The list of segments includes the MD5 checksum
       (``ETag``) of each segment. You cannot upload the manifest
       object if the ``ETag`` in the list differs from the uploaded
       segment object. If a segment is somehow lost, an attempt to
       download the manifest object results in an error.
     - Not guaranteed. The eventual consistency model means that
       although you have uploaded a segment object, it might not
       appear in the container listing until later. If you download
       the manifest before it appears in the container, it does not
       form part of the content returned in response to a ``GET``
       request.
   * - Upload order
     - You must upload the segment objects before upload the manifest
       object.
     - You can upload manifest and segment objects in any order. You
       are recommended to upload the manifest object after the
       segments in case a premature download of the manifest occurs.
       However, this is not enforced.
   * - Removal or addition of segment objects
     - You cannot add or remove segment objects from the manifest.
       However, you can create a completely new manifest object of the
       same name with a different manifest list.
     - You can upload new segment objects or remove existing segments.
       The names must simply match the ``PREFIX`` supplied in
       ``X-Object-Manifest``.
   * - Segment object size and number
     - Segment objects must be at least 1 MB in size (by default). The
       final segment object can be any size. At most, 1000 segments
       are supported (by default).
     - Segment objects can be any size.
   * - Segment object container name
     - The manifest list includes the container name of each object.
       Segment objects can be in different containers.
     - All segment objects must be in the same container.
   * - Manifest object metadata
     - The object has ``X-Static-Large-Object`` set to ``true``. You
       do not set this metadata directly. Instead the system sets it
       when you ``PUT`` a static manifest object.
     - The ``X-Object-Manifest`` value is the ``CONTAINER/PREFIX``,
       which indicates where the segment objects are located. You
       supply this request header in the ``PUT`` operation.
   * - Copying the manifest object
     - Include the ``?multipart-manifest=get`` query string in the
       ``COPY`` request. The new object contains the same manifest as
       the original. The segment objects are not copied. Instead, both
       the original and new manifest objects share the same set of
       segment objects.
     - The ``COPY`` operation does not create a manifest object. To
       duplicate a manifest object, use the ``GET`` operation to read
       the value of ``X-Object-Manifest`` and use this value in the
       ``X-Object-Manifest`` request header in a ``PUT`` operation.
       This creates a new manifest object that shares the same set of
       segment objects as the original manifest object.

Upload large objects with python-swiftclient
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can use ``python-swiftclient`` to easily upload large objects.

*  Upload a large file by specifying the segment size with the
   ``--segment-size`` or ``-S`` arguments:

   .. code-block:: console

      $ swift upload CONTAINER OBJECT_FILENAME --segment-size <bytes>

   This will automatically break the file into the desired segment size
   and upload segments to a container named ``<container>_segments``.

*  After upload has completed, you can download the large object as a
   single file:

   .. code-block:: console

      $ swift download CONTAINER OBJECT_FILENAME

*  Additional large object arguments can be found by using ``--help``:

   .. code-block:: console

      $ swift upload --help
