Verify operation
~~~~~~~~~~~~~~~~

Verify operation of the Object Storage service.

.. note::

   Perform these steps on the controller node.

#. In each client environment script, configure the Object Storage
   service client to use the Identity API version 3:

   .. code-block:: console

      $ echo "export OS_AUTH_VERSION=3" \
        | tee -a admin-openrc.sh demo-openrc.sh

#. Source the ``demo`` credentials:

   .. code-block:: console

      $ source demo-openrc.sh

#. Show the service status:

   .. code-block:: console

      $ swift stat
                              Account: AUTH_ed0b60bf607743088218b0a533d5943f
                           Containers: 0
                              Objects: 0
                                Bytes: 0
      Containers in policy "policy-0": 0
         Objects in policy "policy-0": 0
           Bytes in policy "policy-0": 0
          X-Account-Project-Domain-Id: default
                          X-Timestamp: 1444143887.71539
                           X-Trans-Id: tx1396aeaf17254e94beb34-0056143bde
                         Content-Type: text/plain; charset=utf-8
                        Accept-Ranges: bytes

#. Upload a test file:

   .. code-block:: console

      $ swift upload container1 FILE
      FILE

   Replace ``FILE`` with the name of a local file to upload to the
   ``container1`` container.

#. List containers:

   .. code-block:: console

      $ swift list
      container1

#. Download a test file:

   .. code-block:: console

      $ swift download container1 FILE
      FILE [auth 0.295s, headers 0.339s, total 0.339s, 0.005 MB/s]

   Replace ``FILE`` with the name of the file uploaded to the
   ``container1`` container.
