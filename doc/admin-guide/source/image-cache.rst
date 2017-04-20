======================
The glance image cache
======================

The glance API server can be configured to have an optional local image cache.
A local image cache stores a copy of image files, essentially enabling multiple
API servers to serve the same image file, resulting in an increase in
scalability due to an increased number of endpoints serving an image file.

This local image cache is transparent to the end user. The
end user does not know that the glance API is streaming an image file from
its local cache or from the actual backend storage system.

Managing the glance image cache
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

While image files are automatically placed in the image cache on successful
requests to ``GET /images/<IMAGE_ID>``, the image cache is not automatically
managed.

Configuration options for the image cache
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The glance cache uses two files:
* One for configuring the server: ``glance-api.conf``
* Another for the utilities: ``glance-cache.conf``

The following options are in both configuration files. These need the
same values otherwise the cache will potentially run into problems.

- ``image_cache_dir``: This is the base directory where glance stores
  the cache data (Required to be set, as does not have a default).
- ``image_cache_sqlite_db``: Path to the sqlite file database that will
  be used for cache management. This is a relative path from the
  ``image_cache_dir`` directory (Default:``cache.db``).
- ``image_cache_driver``: The driver used for cache management.
  (Default:``sqlite``)
- ``image_cache_max_size``: The size when the ``glance-cache-pruner``
  removes the oldest images. This reduces the bytes until under this value.
  (Default:``10 GB``)
- ``image_cache_stall_time``: The amount of time an incomplete image
  stays in the cache. After this the incomplete image will be deleted.
  (Default:``1 day``)

The following values are the ones that are specific to the
``glance-cache.conf`` and are only required for the prefetcher to run
correctly.

- ``admin_user``: The username for an admin account, this is so it can
  get the image data into the cache.
- ``admin_password``: The password to the admin account.
- ``admin_tenant_name``: The tenant of the admin account.
- ``auth_url``: The URL used to authenticate to keystone. This will
  be taken from the environment variables if it exists.
- ``filesystem_store_datadir``: This is used if using the filesystem
  store, points to where the data is kept.
- ``filesystem_store_datadirs``: This is used to point to multiple
  filesystem stores.
- ``registry_host``: The URL to the glance registry.

Controlling the growth of the image cache
-----------------------------------------

The image cache has a configurable maximum size (the ``image_cache_max_size``
configuration file option). The ``image_cache_max_size`` is an upper limit
beyond which pruner, if running, starts cleaning the images cache.
However, when images are successfully returned from a call to
``GET /images/<IMAGE_ID>``, the image cache automatically writes the image
file to its cache, regardless of whether the resulting write would make the
image cache's size exceed the value of ``image_cache_max_size``.
In order to keep the image cache at or below this maximum cache size,
you need to run the ``glance-cache-pruner`` executable.

We recommend using ``cron`` to fire ``glance-cache-pruner``
at a regular intervals.

Cleaning the image cache
------------------------

Over time, the image cache can accumulate image files that are either in
a stalled or invalid state. Stalled image files are the result of an image
cache write failing to complete. Invalid image files are the result of an
image file not being written properly to disk.

To remove these types of files, run the ``glance-cache-cleaner``
executable.

We recommend using ``cron`` to fire ``glance-cache-cleaner``
at a semi-regular interval.

Prefetching images into the image cache
---------------------------------------

Some installations have base (sometimes called "golden") images that are
very commonly used to boot virtual machines. When spinning up a new API
server, administrators may wish to prefetch these image files into the
local image cache to ensure that reads of those popular image files come
from a local cache.

To queue an image for prefetching, you can use one of the following methods:

 * If the ``cache_manage`` middleware is enabled in the application pipeline,
   call ``PUT /queued-images/<IMAGE_ID>`` to queue the image with
   identifier ``<IMAGE_ID>``.

   Alternately, use the ``glance-cache-manage`` program to queue the
   image. This program may be run from a different host than the host
   containing the image cache. For example:

   .. code-block:: console

      $> glance-cache-manage --host=<HOST> queue-image <IMAGE_ID>

   This queues the image with identifier ``<IMAGE_ID>`` for prefetching.

Once you have queued the images you wish to prefetch, call the
``glance-cache-prefetcher`` executable. This prefetches all queued images
concurrently, logging the results of the fetch for each image.

Finding images in the image cache
---------------------------------

You can sources images in the image cache using one of the
following methods:

* If the ``cachemanage`` middleware is enabled in the application pipeline,
  call ``GET /cached-images`` to see a JSON-serialized list of
  mappings that show cached images, the number of cache hits on each image,
  the size of the image, and the times they were last accessed.

  Alternately, you can use the ``glance-cache-manage`` program. This program
  may be run from a different host than the host containing the image cache.
  For example:

  .. code-block:: console

     $> glance-cache-manage --host=<HOST> list-cached

* You can issue the following call on ``\*nix`` systems (on the host that
  contains the image cache):

  .. code-block:: console

     $> ls -lhR $IMAGE_CACHE_DIR

  ``$IMAGE_CACHE_DIR`` is the value of the ``image_cache_dir`` configuration
  variable.

  .. note::

     The image's cache hit is not shown using this method.

Manually removing images from the image cache
---------------------------------------------

If the ``cachemanage`` middleware is enabled, you may call
``DELETE /cached-images/<IMAGE_ID>`` to remove the image file for image
with identifier ``<IMAGE_ID>`` from the cache.

Alternately, you can use the ``glance-cache-manage`` program. For example:

.. code-block:: console

   $> glance-cache-manage --host=<HOST> delete-cached-image <IMAGE_ID>
