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

   cli_swift_create_containers.rst
   cli_swift_manage_access_swift.rst
   cli_swift_manage_objects.rst
   cli_swift_env_vars.rst
   cli_swift_set_object_versions.rst
   cli_swift_serialized_response_formats.rst
   cli_swift_large_lists.rst
   cli_swift_pseudo_hierarchical_folders_directories.rst
   cli_swift_discoverability.rst
   cli_swift_large_object_creation.rst
   cli_swift_archive_auto_extract.rst
   cli_swift_bulk_delete.rst
   cli_swift_static_website.rst
