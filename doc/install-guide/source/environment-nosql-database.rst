.. _environment-nosql-database:

NoSQL database
~~~~~~~~~~~~~~

The Telemetry service uses a NoSQL database to store information. The database
typically runs on the controller node. The procedures in this guide use
MongoDB.

.. note::

   The installation of the NoSQL database server is only necessary when
   installing the Telemetry service as documented in :ref:`install_ceilometer`.

Install and configure components
--------------------------------

.. only:: obs

   1. Enable the Open Build Service repositories for MongoDB based on
      your openSUSE or SLES version:

      On openSUSE:

      .. code-block:: console

         # zypper addrepo -f obs://server:database/openSUSE_13.2 Database

      On SLES:

      .. code-block:: console

         # zypper addrepo -f obs://server:database/SLE_12 Database

      .. note::

         The packages are signed by GPG key ``05905EA8``. You should
         verify the fingerprint of the imported GPG key before using it.

         .. code-block:: console

            Key Name:         server:database OBS Project <server:database@build.opensuse.org>
            Key Fingerprint:  116EB863 31583E47 E63CDF4D 562111AC 05905EA8
            Key Created:      Mon 08 Dec 2014 09:54:12 AM UTC
            Key Expires:      Wed 15 Feb 2017 09:54:12 AM UTC

      Install the MongoDB package:

      .. code-block:: console

         # zypper install mongodb

.. only:: rdo

   1. Install the MongoDB packages:

      .. code-block:: console

         # yum install mongodb-server mongodb

.. only:: ubuntu

   1. Install the MongoDB packages:

      .. code-block:: console

         # apt-get install mongodb-server mongodb-clients python-pymongo

.. only:: obs

   2. Edit the ``/etc/mongodb.conf`` file and complete the following
      actions:

      * Configure the ``bind_ip`` key to use the management interface
        IP address of the controller node.

        .. code-block:: ini

           bind_ip = 10.0.0.11

      * By default, MongoDB creates several 1 GB journal files
        in the ``/var/lib/mongodb/journal`` directory.
        If you want to reduce the size of each journal file to
        128 MB and limit total journal space consumption to 512 MB,
        assert the ``smallfiles`` key:

        .. code-block:: ini

           smallfiles = true

        You can also disable journaling. For more information, see the
        `MongoDB manual <http://docs.mongodb.org/manual/>`__.

.. only:: rdo

   2. Edit the ``/etc/mongod.conf`` file and complete the following
      actions:

      * Configure the ``bind_ip`` key to use the management interface
        IP address of the controller node.

        .. code-block:: ini

           bind_ip = 10.0.0.11

      * By default, MongoDB creates several 1 GB journal files
        in the ``/var/lib/mongodb/journal`` directory.
        If you want to reduce the size of each journal file to
        128 MB and limit total journal space consumption to 512 MB,
        assert the ``smallfiles`` key:

        .. code-block:: ini

           smallfiles = true

        You can also disable journaling. For more information, see the
        `MongoDB manual <http://docs.mongodb.org/manual/>`__.

.. only:: ubuntu

   2. Edit the ``/etc/mongodb.conf`` file and complete the following
      actions:

      * Configure the ``bind_ip`` key to use the management interface
        IP address of the controller node.

        .. code-block:: ini

           bind_ip = 10.0.0.11

      * By default, MongoDB creates several 1 GB journal files
        in the ``/var/lib/mongodb/journal`` directory.
        If you want to reduce the size of each journal file to
        128 MB and limit total journal space consumption to 512 MB,
        assert the ``smallfiles`` key:

        .. code-block:: ini

           smallfiles = true

        You can also disable journaling. For more information, see the
        `MongoDB manual <http://docs.mongodb.org/manual/>`__.

Finalize installation
---------------------

.. only:: ubuntu

   * If you change the journaling configuration, stop the MongoDB
     service, remove the initial journal files, and start the service:

     .. code-block:: console

        # service mongodb stop
        # rm /var/lib/mongodb/journal/prealloc.*
        # service mongodb start

.. only:: rdo

   * Start the MongoDB service and configure it to start when
     the system boots:

     .. code-block:: console

        # systemctl enable mongod.service
        # systemctl start mongod.service

.. only:: obs

   * Start the MongoDB service and configure it to start when
     the system boots:

     .. code-block:: console

        # systemctl enable mongodb.service
        # systemctl start mongodb.service
