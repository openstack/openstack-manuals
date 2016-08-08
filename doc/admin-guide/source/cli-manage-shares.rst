.. _share:

=============
Manage shares
=============

A share is provided by file storage. You can give access to a share to
instances. To create and manage shares, use ``manila`` client commands.

Migrate a share
~~~~~~~~~~~~~~~

As an administrator, you can migrate a share with its data from one
location to another in a manner that is transparent to users and
workloads.

Possible use cases for data migration include:

-  Bring down a physical storage device for maintenance without
   disrupting workloads.

-  Modify the properties of a share.

-  Free up space in a thinly-provisioned back end.

Migrate a share with the :command:`manila migrate` command, as shown in the
following example:

.. code-block:: console

   $ manila migrate shareID destinationHost --force-host-copy True|False

In this example, :option:`--force-host-copy True` forces the generic
host-based migration mechanism and bypasses any driver optimizations.
``destinationHost`` is in this format ``host#pool`` which includes
destination host and pool.

.. note::

   If the user is not an administrator, the migration fails.
