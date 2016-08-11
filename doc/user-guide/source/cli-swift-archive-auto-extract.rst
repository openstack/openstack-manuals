.. _archive-auto-extract:

==========================
Auto-extract archive files
==========================

To discover whether your Object Storage system supports this feature,
see :ref:`discoverability`. Alternatively, check with your service
provider.

Use the auto-extract archive feature to upload a tar archive file.

The Object Storage system extracts files from the archive file and
creates an object.

Auto-extract archive request
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To upload an archive file, make a ``PUT`` request. Add the
``extract-archive=format`` query parameter to indicate that you are
uploading a tar archive file instead of normal content.

Valid values for the ``format`` variable are ``tar``, ``tar.gz``, or
``tar.bz2``.

The path you specify in the ``PUT`` request is used for the location of
the object and the prefix for the resulting object names.

In the ``PUT`` request, you can specify the path for:

-  An account

-  Optionally, a specific container

-  Optionally, a specific object prefix

For example, if the first object in the tar archive is
``/home/file1.txt`` and you specify the
``/v1/12345678912345/mybackup/castor/`` path, the operation creates the
``castor/home/file1.txt`` object in the ``mybackup`` container in the
``12345678912345`` account.

Create an archive for auto-extract
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You must use the tar utility to create the tar archive file.

You can upload regular files but you cannot upload other items (for
example, empty directories or symbolic links).

You must UTF-8-encode the member names.

The archive auto-extract feature supports these formats:

-  The POSIX.1-1988 Ustar format.

-  The GNU tar format. Includes the long name, long link, and sparse
   extensions.

-  The POSIX.1-2001 pax format.

   Use gzip or bzip2 to compress the archive.

   Use the ``extract-archive`` query parameter to specify the format.
   Valid values for this parameter are ``tar``, ``tar.gz``, or
   ``tar.bz2``.

Auto-extract archive response
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When Object Storage processes the request, it performs multiple
sub-operations. Even if all sub-operations fail, the operation returns a
201 ``Created`` status. Some sub-operations might succeed while others
fail. Examine the response body to determine the results of each
auto-extract archive sub-operation.

You can set the ``Accept`` request header to one of these values to
define the response format:

``text/plain``
    Formats response as plain text. If you omit the ``Accept`` header,
    ``text/plain`` is the default.

``application/json``
    Formats response as JSON.

``application/xml``
    Formats response as XML.

``text/xml``
    Formats response as XML.

The following auto-extract archive files example shows a ``text/plain``
response body where no failures occurred:

.. code-block:: console

   Number Files Created: 10
   Errors:

The following auto-extract archive files example shows a ``text/plain``
response where some failures occurred. In this example, the Object
Storage system is configured to reject certain character strings so that
the 400 Bad Request error occurs for any objects that use the restricted
strings.

.. code-block:: console

   Number Files Created: 8
   Errors:
   /v1/12345678912345/mycontainer/home/xx%3Cyy, 400 Bad Request
   /v1/12345678912345/mycontainer/../image.gif, 400 Bad Request

The following example shows the failure response in ``application/json``
format.

.. code-block:: json

    {
       "Number Files Created":1,
       "Errors":[
          [
             "/v1/12345678912345/mycontainer/home/xx%3Cyy",
             "400 Bad Request"
          ],
          [
             "/v1/12345678912345/mycontainer/../image.gif",
             "400 Bad Request"
          ]
       ]
    }

