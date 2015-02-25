=============================
Schedule objects for deletion
=============================

To determine whether your Object Storage system supports this feature,
see ?. Alternatively, check with your service provider.

.. TODO(DC) Add the link above when section_cli_swift_howto.xml is converted.

Scheduling an object for deletion is helpful for managing objects that
you do not want to permanently store, such as log files, recurring full
backups of a dataset, or documents or images that become outdated at a
specified time.

To schedule an object for deletion, include one of these headers with
the ``PUT`` or ``POST`` request on the object:

X-Delete-At
  A UNIX epoch timestamp, in integer form. For example, ``1348691905``
  represents ``Wed, 26 Sept 2012 20:38:25 GMT``. It specifies the time you
  want the object to expire, no longer be served, and be deleted completely
  from the object store.


X-Delete-After
  An integer value which specifies the number of seconds from the time of
  the request to when you want to delete the object.
  This header is converted to a ``X-Delete-At`` header that is set to
  the sum of the ``X-Delete-After`` value plus the current time, in
  seconds.

.. note::
   Use http://www.epochconverter.com/ to convert dates to and from
   epoch timestamps and for batch conversions.

Use the POST method to assign expiration headers to existing objects
that you want to expire.

In this example, the ``X-Delete-At`` header is assigned a UNIX epoch
timestamp in integer form for ``Mon, 11 Jun 2012 15:38:25 GMT``.

.. code::

   $ curl -i publicURL/marktwain/goodbye -X PUT -H "X-Auth-Token: token" \
   -H "X-Delete-At: 1390581073" -H "Content-Length: 14" -H \
   "Content-Type: application/octet-stream"

In this example, the ``X-Delete-After`` header is set to 864000 seconds.
The object expires after this time.

.. code::

   PUT /<api version>/<account>/<container>/<object> HTTP/1.1
   Host: storage.example.com
   X-Auth-Token: eaaafd18-0fed-4b3a-81b4-663c99ec1cbb
   Content-Type: image/jpeg
   X-Delete-After: 864000
