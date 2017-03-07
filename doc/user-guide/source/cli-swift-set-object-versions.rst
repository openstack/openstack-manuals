=================
Object versioning
=================

You can store multiple versions of your content so that you can recover
from unintended overwrites. Object versioning is an easy way to
implement version control, which you can use with any type of content.

.. note::

   You cannot version a large-object manifest file, but the large-object
   manifest file can point to versioned segments.

We strongly recommend that you put non-current objects in a different
container than the container where current object versions reside.

To enable and use object versioning
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. To enable object versioning, ask your cloud provider to set the
   ``allow_versions`` option to ``TRUE`` in the container configuration
   file.

#. Create an ``archive`` container to store older versions of objects:

   .. code-block:: console

      $ curl -i $publicURL/archive -X PUT -H "Content-Length: 0" -H "X-Auth-Token: $token"

   .. code-block:: console

      HTTP/1.1 201 Created
      Content-Length: 0
      Content-Type: text/html; charset=UTF-8
      X-Trans-Id: tx46f8c29050834d88b8d7e-0052e1859d
      Date: Thu, 23 Jan 2014 21:11:57 GMT

#. Create a ``current`` container to store current versions of objects.

   Include the ``X-Versions-Location`` header. This header defines the
   container that holds the non-current versions of your objects. You
   must UTF-8-encode and then URL-encode the container name before you
   include it in the ``X-Versions-Location`` header. This header enables
   object versioning for all objects in the ``current`` container.
   Changes to objects in the ``current`` container automatically create
   non-current versions in the ``archive`` container.

   .. code-block:: console

      $ curl -i $publicURL/current -X PUT -H "Content-Length: 0" -H \
        ”X-Auth-Token: $token" -H "X-Versions-Location: archive"

   .. code-block:: console

      HTTP/1.1 201 Created
      Content-Length: 0
      Content-Type: text/html; charset=UTF-8
      X-Trans-Id: txb91810fb717347d09eec8-0052e18997
      Date: Thu, 23 Jan 2014 21:28:55 GMT

#. Create the first version of an object in the ``current`` container:

   .. code-block:: console

      $ curl -i $publicURL/current/my_object --data-binary 1 -X PUT -H \
        ”Content-Length: 0" -H "X-Auth-Token: $token"

   .. code-block:: console

      HTTP/1.1 201 Created
      Last-Modified: Thu, 23 Jan 2014 21:31:22 GMT
      Content-Length: 0
      Etag: d41d8cd98f00b204e9800998ecf8427e
      Content-Type: text/html; charset=UTF-8
      X-Trans-Id: tx5992d536a4bd4fec973aa-0052e18a2a
      Date: Thu, 23 Jan 2014 21:31:22 GMT

   Nothing is written to the non-current version container when you
   initially ``PUT`` an object in the ``current`` container. However,
   subsequent ``PUT`` requests that edit an object trigger the creation
   of a version of that object in the ``archive`` container.

   These non-current versions are named as follows:

   .. code-block:: console

      <length><object_name><timestamp>

   Where ``length`` is the 3-character, zero-padded hexadecimal
   character length of the object, ``<object_name>`` is the object name,
   and ``<timestamp>`` is the time when the object was initially created
   as a current version.

#. Create a second version of the object in the ``current`` container:

   .. code-block:: console

      $ curl -i $publicURL/current/my_object --data-binary 2 -X PUT -H \
        “Content-Length: 0" -H "X-Auth-Token: $token"

   .. code-block:: console

      HTTP/1.1 201 Created
      Last-Modified: Thu, 23 Jan 2014 21:41:32 GMT
      Content-Length: 0
      Etag: d41d8cd98f00b204e9800998ecf8427e
      Content-Type: text/html; charset=UTF-8
      X-Trans-Id: tx468287ce4fc94eada96ec-0052e18c8c
      Date: Thu, 23 Jan 2014 21:41:32 GMT

#. Issue a ``GET`` request to a versioned object to get the current
   version of the object. You do not have to do any request redirects or
   metadata lookups.

   List older versions of the object in the ``archive`` container:

   .. code-block:: console

      $ curl -i $publicURL/archive?prefix=009my_object -X GET -H \
        "X-Auth-Token: $token"

   .. code-block:: console

      HTTP/1.1 200 OK
      Content-Length: 30
      X-Container-Object-Count: 1
      Accept-Ranges: bytes
      X-Timestamp: 1390513280.79684
      X-Container-Bytes-Used: 0
      Content-Type: text/plain; charset=utf-8
      X-Trans-Id: tx9a441884997542d3a5868-0052e18d8e
      Date: Thu, 23 Jan 2014 21:45:50 GMT

        009my_object/1390512682.92052

   .. note::

      A ``POST`` request to a versioned object updates only the metadata
      for the object and does not create a new version of the object. New
      versions are created only when the content of the object changes.

#. Issue a ``DELETE`` request to a versioned object to remove the
   current version of the object and replace it with the next-most
   current version in the non-current container.

   .. code-block:: console

      $ curl -i $publicURL/current/my_object -X DELETE -H \
        "X-Auth-Token: $token"

   .. code-block:: console

      HTTP/1.1 204 No Content
      Content-Length: 0
      Content-Type: text/html; charset=UTF-8
      X-Trans-Id: tx006d944e02494e229b8ee-0052e18edd
      Date: Thu, 23 Jan 2014 21:51:25 GMT

   List objects in the ``archive`` container to show that the archived
   object was moved back to the ``current`` container:

   .. code-block:: console

      $ curl -i $publicURL/archive?prefix=009my_object -X GET -H \
        "X-Auth-Token: $token"

   .. code-block:: console

      HTTP/1.1 204 No Content
      Content-Length: 0
      X-Container-Object-Count: 0
      Accept-Ranges: bytes
      X-Timestamp: 1390513280.79684
      X-Container-Bytes-Used: 0
      Content-Type: text/html; charset=UTF-8
      X-Trans-Id: tx044f2a05f56f4997af737-0052e18eed
      Date: Thu, 23 Jan 2014 21:51:41 GMT

   This next-most current version carries with it any metadata last set
   on it. If you want to completely remove an object and you have five
   versions of it, you must ``DELETE`` it five times.

#. To disable object versioning for the ``current`` container, remove
   its ``X-Versions-Location`` metadata header by sending an empty key
   value.

   .. code-block:: console

      $ curl -i $publicURL/current -X PUT -H "Content-Length: 0" -H \
        "X-Auth-Token: $token" -H "X-Versions-Location: "

   .. code-block:: console

      HTTP/1.1 202 Accepted
      Content-Length: 76
      Content-Type: text/html; charset=UTF-8
      X-Trans-Id: txe2476de217134549996d0-0052e19038
      Date: Thu, 23 Jan 2014 21:57:12 GMT

    <html><h1>Accepted</h1><p>The request is accepted for processing.</p></html>

Versioning with python-swiftclient
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can utilize ``python-swiftclient`` to enable object versioning.

*  Create an additional container to hold previous versions:

   .. code-block:: console

      $ swift post CONTAINER_versions

*  Enable object versioning on your desired container:

   .. code-block:: console

      $ swift post CONTAINER -H "X-Versions-Location:CONTAINER-versions"
