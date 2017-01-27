.. _database:

========
Database
========

The Database service provides database management features.

Introduction
~~~~~~~~~~~~

The Database service provides scalable and reliable cloud
provisioning functionality for both relational and non-relational
database engines. Users can quickly and easily use database features
without the burden of handling complex administrative tasks. Cloud
users and database administrators can provision and manage multiple
database instances as needed.

The Database service provides resource isolation at high performance
levels, and automates complex administrative tasks such as deployment,
configuration, patching, backups, restores, and monitoring.

You can modify various cluster characteristics by editing the
``/etc/trove/trove.conf`` file. A comprehensive list of the Database
service configuration options is described in the `Database service
<https://docs.openstack.org/newton/config-reference/database.html>`_
chapter in the *Configuration Reference*.

Create a data store
~~~~~~~~~~~~~~~~~~~

An administrative user can create data stores for a variety of
databases.

This section assumes you do not yet have a MySQL data store, and shows
you how to create a MySQL data store and populate it with a MySQL 5.5
data store version.


**To create a data store**

#. **Create a trove image**

   Create an image for the type of database you want to use, for
   example, MySQL, MongoDB, Cassandra.

   This image must have the trove guest agent installed, and it must
   have the ``trove-guestagent.conf`` file configured to connect to
   your OpenStack environment. To configure ``trove-guestagent.conf``,
   add the following lines to ``trove-guestagent.conf`` on the guest
   instance you are using to build your image:

   .. code-block:: ini

      rabbit_host = controller
      rabbit_password = RABBIT_PASS
      nova_proxy_admin_user = admin
      nova_proxy_admin_pass = ADMIN_PASS
      nova_proxy_admin_tenant_name = service
      trove_auth_url = http://controller:35357/v2.0

   This example assumes you have created a MySQL 5.5 image called
   ``mysql-5.5.qcow2``.

   .. important::

      If you have a guest image that was created with an OpenStack version
      before Kilo, modify the guest agent init script for the guest image to
      read the configuration files from the directory ``/etc/trove/conf.d``.

      For a backwards compatibility with pre-Kilo guest instances, set the
      database service configuration options ``injected_config_location`` to
      ``/etc/trove`` and ``guest_info`` to ``/etc/guest_info``.

#. **Register image with Image service**

   You need to register your guest image with the Image service.

   In this example, you use the :command:`openstack image create`
   command to register a ``mysql-5.5.qcow2`` image.

   .. code-block:: console

      $ openstack image create mysql-5.5 --disk-format qcow2 --container-format bare --public < mysql-5.5.qcow2
      +------------------+------------------------------------------------------+
      | Field            | Value                                                |
      +------------------+------------------------------------------------------+
      | checksum         | 133eae9fb1c98f45894a4e60d8736619                     |
      | container_format | bare                                                 |
      | created_at       | 2016-12-21T12:10:02Z                                 |
      | disk_format      | qcow2                                                |
      | file             | /v2/images/d1afb4f0-2360-4400-8d97-846b1ab6af52/file |
      | id               | d1afb4f0-2360-4400-8d97-846b1ab6af52                 |
      | min_disk         | 0                                                    |
      | min_ram          | 0                                                    |
      | name             | mysql-5.5                                            |
      | owner            | 5669caad86a04256994cdf755df4d3c1                     |
      | protected        | False                                                |
      | schema           | /v2/schemas/image                                    |
      | size             | 13200896                                             |
      | status           | active                                               |
      | tags             |                                                      |
      | updated_at       | 2016-12-21T12:10:03Z                                 |
      | virtual_size     | None                                                 |
      | visibility       | public                                               |
      +------------------+------------------------------------------------------+

#. **Create the data store**

   Create the data store that will house the new image. To do this, use
   the :command:`trove-manage` :command:`datastore_update` command.

   This example uses the following arguments:

   .. list-table::
      :header-rows: 1
      :widths: 20 20 20

      * - Argument
        - Description
        - In this example:
      * - config file
        - The configuration file to use.
        - ``--config-file=/etc/trove/trove.conf``
      * - name
        - Name you want to use for this data store.
        - ``mysql``
      * - default version
        - You can attach multiple versions/images to a data store. For
          example, you might have a MySQL 5.5 version and a MySQL 5.6
          version. You can designate one version as the default, which
          the system uses if a user does not explicitly request a
          specific version.
        - ``""``

          At this point, you do not yet have a default version, so pass
          in an empty string.

   |

   Example:

   .. code-block:: console

      $ trove-manage --config-file=/etc/trove/trove.conf datastore_update mysql ""

#. **Add a version to the new data store**

   Now that you have a MySQL data store, you can add a version to it,
   using the :command:`trove-manage` :command:`datastore_version_update`
   command. The version indicates which guest image to use.

   This example uses the following arguments:

   .. list-table::
      :header-rows: 1
      :widths: 20 20 20

      * - Argument
        - Description
        - In this example:

      * - config file
        - The configuration file to use.
        - ``--config-file=/etc/trove/trove.conf``

      * - data store
        - The name of the data store you just created via
          ``trove-manage`` :command:`datastore_update`.
        - ``mysql``

      * - version name
        - The name of the version you are adding to the data store.
        - ``mysql-5.5``

      * - data store manager
        - Which data store manager to use for this version. Typically,
          the data store manager is identified by one of the following
          strings, depending on the database:

          * cassandra
          * couchbase
          * couchdb
          * db2
          * mariadb
          * mongodb
          * mysql
          * percona
          * postgresql
          * pxc
          * redis
          * vertica
        - ``mysql``

      * - glance ID
        - The ID of the guest image you just added to the Image
          service. You can get this ID by using the glance
          :command:`image-show` IMAGE_NAME command.
        - bb75f870-0c33-4907-8467-1367f8cb15b6

      * - packages
        - If you want to put additional packages on each guest that
          you create with this data store version, you can list the
          package names here.
        - ``""``

          In this example, the guest image already contains all the
          required packages, so leave this argument empty.

      * - active
        - Set this to either 1 or 0:
           * ``1`` = active
           * ``0`` = disabled
        - 1

   |

   Example:

   .. code-block:: console

      $ trove-manage --config-file=/etc/trove/trove.conf datastore_version_update mysql mysql-5.5 mysql GLANCE_ID "" 1

   **Optional.** Set your new version as the default version. To do
   this, use the :command:`trove-manage` :command:`datastore_update`
   command again, this time specifying the version you just created.

   .. code-block:: console

      $ trove-manage --config-file=/etc/trove/trove.conf datastore_update mysql mysql-5.5

#. **Load validation rules for configuration groups**

   .. note::

     **Applies only to MySQL and Percona data stores**

     * If you just created a MySQL or Percona data store, then you need
       to load the appropriate validation rules, as described in this
       step.
     * If you just created a different data store, skip this step.

   **Background.** You can manage database configuration tasks by using
   configuration groups. Configuration groups let you set configuration
   parameters, in bulk, on one or more databases.

   When you set up a configuration group using the trove
   :command:`configuration-create` command, this command compares the configuration
   values you are setting against a list of valid configuration values
   that are stored in the ``validation-rules.json`` file.

   .. list-table::
      :header-rows: 1
      :widths: 20 20 20

      * - Operating System
        - Location of :file:`validation-rules.json`
        - Notes

      * - Ubuntu 14.04
        - :file:`/usr/lib/python2.7/dist-packages/trove/templates/DATASTORE_NAME`
        - DATASTORE_NAME is the name of either the MySQL data store or
          the Percona data store. This is typically either ``mysql``
          or ``percona``.

      * - RHEL 7, CentOS 7, Fedora 20, and Fedora 21
        - :file:`/usr/lib/python2.7/site-packages/trove/templates/DATASTORE_NAME`
        - DATASTORE_NAME is the name of either the MySQL data store or
          the Percona data store. This is typically either ``mysql`` or ``percona``.

   |

   Therefore, as part of creating a data store, you need to load the
   ``validation-rules.json`` file, using the :command:`trove-manage`
   :command:`db_load_datastore_config_parameters` command. This command
   takes the following arguments:

   * Data store name
   * Data store version
   * Full path to the ``validation-rules.json`` file

   |

   This example loads the ``validation-rules.json`` file for a MySQL
   database on Ubuntu 14.04:

   .. code-block:: console

      $ trove-manage db_load_datastore_config_parameters mysql mysql-5.5 /usr/lib/python2.7/dist-packages/trove/templates/mysql/validation-rules.json

#. **Validate data store**

   To validate your new data store and version, start by listing the
   data stores on your system:

   .. code-block:: console

      $ trove datastore-list
      +--------------------------------------+--------------+
      |                  id                  |     name     |
      +--------------------------------------+--------------+
      | 10000000-0000-0000-0000-000000000001 | Legacy MySQL |
      | e5dc1da3-f080-4589-a4c2-eff7928f969a |    mysql     |
      +--------------------------------------+--------------+

   Take the ID of the MySQL data store and pass it in with the
   :command:`datastore-version-list` command:

   .. code-block:: console

      $ trove datastore-version-list DATASTORE_ID
      +--------------------------------------+-----------+
      |                  id                  |    name   |
      +--------------------------------------+-----------+
      | 36a6306b-efd8-4d83-9b75-8b30dd756381 | mysql-5.5 |
      +--------------------------------------+-----------+

Data store classifications
--------------------------

The Database service supports a variety of both relational and
non-relational database engines, but to a varying degree of support for
each :term:`data store`. The Database service project has defined
several classifications that indicate the quality of support for each
data store. Data stores also implement different extensions.
An extension is called a :term:`strategy` and is classified similar to
data stores.

Valid classifications for a data store and a strategy are:

* Experimental

* Technical preview

* Stable

Each classification builds on the previous one. This means that a data store
that meets the ``technical preview`` requirements must also meet all the
requirements for ``experimental``, and a data store that meets the ``stable``
requirements must also meet all the requirements for ``technical preview``.

**Requirements**

* Experimental

  A data store is considered to be ``experimental`` if it meets these criteria:

  * It implements a basic subset of the Database service API including
    ``create`` and ``delete``.

  * It has guest agent elements that allow guest agent creation.

  * It has a definition of supported operating systems.

  * It meets the other
    `Documented Technical Requirements <https://specs.openstack.org/openstack/trove-specs/specs/kilo/experimental-datastores.html#requirements>`_.

  A strategy is considered ``experimental`` if:

  * It meets the
    `Documented Technical Requirements <https://specs.openstack.org/openstack/trove-specs/specs/kilo/experimental-datastores.html#requirements>`_.

* Technical preview

  A data store is considered to be a ``technical preview`` if it meets the
  requirements of ``experimental`` and further:

  * It implements APIs required to plant and start the capabilities of the
    data store as defined in the
    `Datastore Compatibility Matrix <https://wiki.openstack.org/wiki/Trove/DatastoreCompatibilityMatrix>`_.

    .. note::

       It is not required that the data store implements all features like
       resize, backup, replication, or clustering to meet this classification.

  * It provides a mechanism for building a guest image that allows you to
    exercise its capabilities.

  * It meets the other
    `Documented Technical Requirements <https://specs.openstack.org/openstack/trove-specs/specs/kilo/experimental-datastores.html#requirements>`_.

  .. important::

     A strategy is not normally considered to be ``technical
     preview``.

* Stable

  A data store or a strategy is considered ``stable`` if:

  * It meets the requirements of ``technical preview``.

  * It meets the other
    `Documented Technical Requirements <https://specs.openstack.org/openstack/trove-specs/specs/kilo/experimental-datastores.html#requirements>`_.

**Initial Classifications**

The following table shows the current classification assignments for the
different data stores.

.. list-table::
   :header-rows: 1
   :widths: 30 30

   * - Classification
     - Data store
   * - Stable
     - MySQL
   * - Technical Preview
     - Cassandra, MongoDB
   * - Experimental
     - All others

Redis data store replication
----------------------------

Replication strategies are available for Redis with
several commands located in the Redis data store
manager:

- :command:`create`
- :command:`detach-replica`
- :command:`eject-replica-source`
- :command:`promote-to-replica-source`

Additional arguments for the :command:`create` command
include :command:`--replica_of` and
:command:`--replica_count`.

Redis integration and unit tests
--------------------------------

Unit tests and integration tests are also available for
Redis.

#. Install redstack:

   .. code-block:: console

      $ ./redstack install

      .. note::

         Redstack is a development script used for integration
         testing and Database service development installations.
         Do not use Redstack in a production environment. For
         more information, see `the Database service
         developer docs <https://docs.openstack.org/developer/trove/dev/install.html#running-redstack-to-install-trove>`_

#. Start Redis:

   .. code-block:: console

      $ ./redstack kick-start redis

#. Run integration tests:

   .. code-block:: console

      $ ./redstack int-tests --group=replication

   You can run :command:`--group=redis_supported`
   instead of :command:`--group=replication` if needed.

Configure a cluster
~~~~~~~~~~~~~~~~~~~

An administrative user can configure various characteristics of a
MongoDB cluster.

**Query routers and config servers**

**Background.** Each cluster includes at least one query router and
one config server. Query routers and config servers count against your
quota. When you delete a cluster, the system deletes the associated
query router(s) and config server(s).

**Configuration.** By default, the system creates one query router and
one config server per cluster. You can change this by editing
the ``/etc/trove/trove.conf`` file. These settings are in the
``mongodb`` section of the file:

.. list-table::
   :header-rows: 1
   :widths: 30 30

   * - Setting
     - Valid values are:

   * - num_config_servers_per_cluster
     - 1 or 3

   * - num_query_routers_per_cluster
     - 1 or 3
