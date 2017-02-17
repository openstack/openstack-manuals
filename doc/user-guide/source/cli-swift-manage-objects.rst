==============
Manage objects
==============

-  To upload an object to a container, run the following command:

   .. code-block:: console

      $ swift upload CONTAINER OBJECT_FILENAME

   To upload in chunks, for larger than 5GB files, run the following command:

   .. code-block:: console

      $ swift upload -S CHUNK_SIZE CONTAINER OBJECT_FILENAME

-  To check the status of the object, run the following command:

   .. code-block:: console

      $ swift stat CONTAINER OBJECT_FILENAME

   .. code-block:: console

      Account: AUTH_7b5970fbe7724bf9b74c245e77c03bcg
      Container: storage1
      Object: images
      Content Type: application/octet-stream
      Content Length: 211616
      Last Modified: Tue, 18 Feb 2014 00:40:36 GMT
      ETag: 82169623d55158f70a0d720f238ec3ef
      Meta Orig-Filename: images.jpg
      Accept-Ranges: bytes
      X-Timestamp: 1392684036.33306

-  To list the objects in a container, run the following command:

   .. code-block:: console

      $ swift list CONTAINER

-  To download an object from a container, run the following command:

   .. code-block:: console

      $ swift download CONTAINER OBJECT_FILENAME
