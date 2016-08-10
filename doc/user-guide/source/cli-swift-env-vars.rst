.. _env-vars:

==============================================
Environment variables required to run examples
==============================================

To run the cURL command examples for the Object Storage API requests,
set these environment variables:

publicURL
  The public URL that is the HTTP endpoint from where you can access
  Object Storage. It includes the Object Storage API version number
  and your account name. For example,
  ``https://23.253.72.207/v1/my_account``.

token
  The authentication token for Object Storage.

To obtain these values, run the :command:`swift stat -v` command.

As shown in this example, the public URL appears in the ``StorageURL``
field, and the token appears in the ``Auth Token`` field:

.. code-block:: console

   StorageURL: https://23.253.72.207/v1/my_account
   Auth Token: {token}
   Account: my_account
   Containers: 2
   Objects: 3
   Bytes: 47
   Meta Book: MobyDick
   X-Timestamp: 1389453423.35964
   X-Trans-Id: txee55498935404a2caad89-0052dd3b77
   Content-Type: text/plain; charset=utf-8
   Accept-Ranges: bytes
