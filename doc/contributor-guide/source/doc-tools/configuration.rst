=============
Configuration
=============

If you run the ``openstack-doc-test --check-build``, it will copy all
the books to the directory ``publish-docs`` in the top-level directory
of your repository.

By default, it outputs a directory with the same name as the directory
where the ``pom.xml`` file lives in, such as ``glossary``. You can
also check the output of the build job for the name.

Some books need special treatment and there are three options you can
set in the file ``doc-test.conf``:

* ``book`` - the name of a book that needs special treatment
* ``target_dir`` - the path of subdirectory starting at ``target``
  that is the root for publishing
* ``publish_dir`` - a new name to publish a book under

As an example, to publish the compute-api version 2 in the directory
``publish-docs/api/openstack-compute/2``, use::

  book = openstack-compute-api-2
  target_dir = target/docbkx/webhelp/api/openstack-compute/2
  publish_dir = api/openstack-compute/2

These options can be specified multiple times and should
always be used this way. You do not need to set ``publish_dir`` but if
you set it, you need to use it every time.

.. note::

   These are optional settings. The logic in the tool is
   sufficient for many of the books.

* Source: http://git.openstack.org/cgit/openstack/openstack-doc-tools
* Bugs: http://bugs.launchpad.net/openstack-manuals


Sample doc-test.conf file
~~~~~~~~~~~~~~~~~~~~~~~~~

.. code::

   [DEFAULT]

   repo_name = openstack-doc-tools
   api_site=True

   # From api-ref/src/wadls/object-api/src/
   file_exception=os-object-api-1.0.wadl

   ignore_dir=incubation
   ignore_dir=openstack-compute-api-1.0

   # These two (or three) options need to come as pairs/triplets.
   # Either add publish_pair for each book/target_dir pair or not at all.
   # If publish_dir is not specified, book is used as publish_dir.
   book = api-quick-start
   target_dir = target/docbkx/webhelp/api-quick-start-onepager-external
   #publish_dir = api-quick-start

   book = api-ref
   target_dir = target/docbkx/html
   #publish_dir = api-ref
