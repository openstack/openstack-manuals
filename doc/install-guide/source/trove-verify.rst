.. _trove-verify:

Verify operation
~~~~~~~~~~~~~~~~

Verify operation of the Database service.

.. note::

   Perform these commands on the node where you installed trove.

#. Source the ``admin`` tenant credentials:

   .. code-block:: console

      $ . admin-openrc

#. Run the ``trove list`` command. You should see output similar to this:

   .. code-block:: console

      $ trove list
      +----+------+-----------+-------------------+--------+-----------+------+
      | id | name | datastore | datastore_version | status | flavor_id | size |
      +----+------+-----------+-------------------+--------+-----------+------+
      +----+------+-----------+-------------------+--------+-----------+------+

#. Add a datastore to trove:

   * `Create a trove image <http://docs.openstack.org/developer/trove/dev/building_guest_images.html>`_.
      Create an image for the type of database you want to use, for example,
      MySQL, MongoDB, Cassandra.

      This image must have the trove guest agent installed.

   * Upload the image to glance. Example:

     .. code-block:: console

        $ glance image-create --name "mysqlTest" --disk-format qcow2 \
          --container-format bare \
          --file mysql-5.6.qcow2
        +------------------+--------------------------------------+
        | Property         | Value                                |
        +------------------+--------------------------------------+
        | checksum         | 51a8e6e5ff10b08f2c2ec2953f0a8086     |
        | container_format | bare                                 |
        | created_at       | 2016-04-08T15:15:41Z                 |
        | disk_format      | qcow2                                |
        | id               | 5caa76dd-f44b-4d01-a3b4-a111e27896be |
        | min_disk         | 0                                    |
        | min_ram          | 0                                    |
        | name             | mysqlTest                            |
        | owner            | 0c0bd5e850c24893b48c4cc01e2a7986     |
        | protected        | False                                |
        | size             | 533790720                            |
        | status           | active                               |
        | tags             | []                                   |
        | updated_at       | 2016-04-08T15:15:51Z                 |
        | virtual_size     | None                                 |
        | visibility       | private                              |
        +------------------+--------------------------------------+

   * Create a datastore. You need to create a separate datastore for
     each type of database you want to use, for example, MySQL, MongoDB,
     Cassandra. This example shows you how to create a datastore for a
     MySQL database:

     .. code-block:: console

        # su -s /bin/sh -c "trove-manage \
          --config-file /etc/trove/trove.conf \
          datastore_update mysql ''" trove
        ...
        Datastore 'mysql' updated.


#. Update the datastore to use the new image.

   This example shows you how to update a MySQL 5.6 datastore:

   .. code-block:: console

      # su -s /bin/sh -c "trove-manage --config-file /etc/trove/trove.conf \
        datastore_version_update \
        mysql mysql-5.6 mysql glance_image_ID '' 1" trove
      ...
      Datastore version 'mysql-5.6' updated.

#. Create a database `instance
   <http://docs.openstack.org/user-guide/create_db.html>`_.
