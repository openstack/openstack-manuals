=============================
Manage objects and containers
=============================

The OpenStack Object Storage service provides the ``swift`` client,
which is a command-line interface (CLI). Use this client to list
objects and containers, upload objects to containers, and download
or delete objects from containers. You can also gather statistics and
update metadata for accounts, containers, and objects.

This client is based on the native swift client library, ``client.py``,
which seamlessly re-authenticates if the current token expires during
processing, retries operations multiple times, and provides a processing
concurrency of 10.

.. toctree::
   :maxdepth: 2

   cli-swift-create-containers.rst
   cli-swift-manage-access-swift.rst
   cli-swift-manage-objects.rst
   cli-swift-env-vars.rst
   cli-swift-set-object-versions.rst
   cli-swift-set-object-expiration.rst
   cli-swift-serialized-response-formats.rst
   cli-swift-large-lists.rst
   cli-swift-pseudo-hierarchical-folders-directories.rst
   cli-swift-discoverability.rst
   cli-swift-large-object-creation.rst
   cli-swift-archive-auto-extract.rst
   cli-swift-bulk-delete.rst
   cli-swift-static-website.rst
