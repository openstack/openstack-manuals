============================
Create and manage containers
============================

-  To create a container, run the following command and replace
   ``CONTAINER`` with the name of your container.

   .. code-block:: console

      $ swift post CONTAINER

-  To list all containers, run the following command:

   .. code-block:: console

      $ swift list

-  To check the status of containers, run the following command:

   .. code-block:: console

      $ swift stat

   .. code-block:: console

      Account: AUTH_7b5970fbe7724bf9b74c245e77c03bcg
      Containers: 2
      Objects: 3
      Bytes: 268826
      Accept-Ranges: bytes
      X-Timestamp: 1392683866.17952
      Content-Type: text/plain; charset=utf-8

   You can also use the :command:`swift stat` command with the ``ACCOUNT`` or
   ``CONTAINER`` names as parameters.

   .. code-block:: console

      $ swift stat CONTAINER

   .. code-block:: console

      Account: AUTH_7b5970fbe7724bf9b74c245e77c03bcg
      Container: storage1
      Objects: 2
      Bytes: 240221
      Read ACL:
      Write ACL:
      Sync To:
      Sync Key:
      Accept-Ranges: bytes
      X-Timestamp: 1392683866.20180
      Content-Type: text/plain; charset=utf-8
