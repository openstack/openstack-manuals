.. _manila-controller:

Install and configure controller node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section describes how to install and configure the Shared File Systems
service, code-named manila, on the controller node. This service requires at
least one additional share node that manages file storage drivers.

Prerequisites
-------------

Before you install and configure the Share File System service, you
must create a database, service credentials, and API endpoints.

#. To create the database, complete these steps:

   * Use the database access client to connect to the database server as the
     ``root`` user:

     .. code-block:: console

        $ mysql -u root -p

   * Create the ``manila`` database:

     .. code-block:: console

        CREATE DATABASE manila;

   * Grant proper access to the ``manila`` database:

     .. code-block:: console

        GRANT ALL PRIVILEGES ON manila.* TO 'manila'@'localhost' \
          IDENTIFIED BY 'MANILA_DBPASS';
        GRANT ALL PRIVILEGES ON manila.* TO 'manila'@'%' \
          IDENTIFIED BY 'MANILA_DBPASS';

     Replace ``MANILA_DBPASS`` with a suitable password.

   * Exit the database access client.

#. Source the ``admin`` credentials to gain access to admin-only CLI commands:

   .. code-block:: console

      $ . admin-openrc

#. To create the service credentials, complete these steps:

   * Create a ``manila`` user:

     .. code-block:: console

        $ openstack user create --domain default --password-prompt manila
        User Password:
        Repeat User Password:
        +-----------+----------------------------------+
        | Field     | Value                            |
        +-----------+----------------------------------+
        | domain_id | e0353a670a9e496da891347c589539e9 |
        | enabled   | True                             |
        | id        | 83a3990fc2144100ba0e2e23886d8acc |
        | name      | manila                           |
        +-----------+----------------------------------+

   * Add the ``admin`` role to the ``manila`` user:

     .. code-block:: console

        $ openstack role add --project service --user manila admin

     .. note::

        This command provides no output.

   * Create the ``manila`` and ``manilav2`` service entities:

     .. code-block:: console

        $ openstack service create --name manila \
          --description "OpenStack Shared File Systems" share
          +-------------+----------------------------------+
          | Field       | Value                            |
          +-------------+----------------------------------+
          | description | OpenStack Shared File Systems    |
          | enabled     | True                             |
          | id          | 82378b5a16b340aa9cc790cdd46a03ba |
          | name        | manila                           |
          | type        | share                            |
          +-------------+----------------------------------+

     .. code-block:: console

        $ openstack service create --name manilav2 \
          --description "OpenStack Shared File Systems" sharev2
          +-------------+----------------------------------+
          | Field       | Value                            |
          +-------------+----------------------------------+
          | description | OpenStack Shared File Systems    |
          | enabled     | True                             |
          | id          | 30d92a97a81a4e5d8fd97a32bafd7b88 |
          | name        | manilav2                         |
          | type        | sharev2                          |
          +-------------+----------------------------------+

     .. note::

        The Share File System services require two service entities.

#. Create the Shared File Systems service API endpoints:

   .. code-block:: console

      $ openstack endpoint create --region RegionOne \
        share public http://controller:8786/v1/%\(tenant_id\)s
        +--------------+-----------------------------------------+
        | Field        | Value                                   |
        +--------------+-----------------------------------------+
        | enabled      | True                                    |
        | id           | 0bd2bbf8d28b433aaea56a254c69f69d        |
        | interface    | public                                  |
        | region       | RegionOne                               |
        | region_id    | RegionOne                               |
        | service_id   | 82378b5a16b340aa9cc790cdd46a03ba        |
        | service_name | manila                                  |
        | service_type | share                                   |
        | url          | http://controller:8786/v1/%(tenant_id)s |
        +--------------+-----------------------------------------+

      $ openstack endpoint create --region RegionOne \
        share internal http://controller:8786/v1/%\(tenant_id\)s
        +--------------+-----------------------------------------+
        | Field        | Value                                   |
        +--------------+-----------------------------------------+
        | enabled      | True                                    |
        | id           | a2859b5732cc48b5b083dd36dafb6fd9        |
        | interface    | internal                                |
        | region       | RegionOne                               |
        | region_id    | RegionOne                               |
        | service_id   | 82378b5a16b340aa9cc790cdd46a03ba        |
        | service_name | manila                                  |
        | service_type | share                                   |
        | url          | http://controller:8786/v1/%(tenant_id)s |
        +--------------+-----------------------------------------+

      $ openstack endpoint create --region RegionOne \
        share admin http://controller:8786/v1/%\(tenant_id\)s
        +--------------+-----------------------------------------+
        | Field        | Value                                   |
        +--------------+-----------------------------------------+
        | enabled      | True                                    |
        | id           | f7f46df93a374cc49c0121bef41da03c        |
        | interface    | admin                                   |
        | region       | RegionOne                               |
        | region_id    | RegionOne                               |
        | service_id   | 82378b5a16b340aa9cc790cdd46a03ba        |
        | service_name | manila                                  |
        | service_type | share                                   |
        | url          | http://controller:8786/v1/%(tenant_id)s |
        +--------------+-----------------------------------------+

   .. code-block:: console

      $ openstack endpoint create --region RegionOne \
        sharev2 public http://controller:8786/v2/%\(tenant_id\)s
        +--------------+-----------------------------------------+
        | Field        | Value                                   |
        +--------------+-----------------------------------------+
        | enabled      | True                                    |
        | id           | d63cc0d358da4ea680178657291eddc1        |
        | interface    | public                                  |
        | region       | RegionOne                               |
        | region_id    | RegionOne                               |
        | service_id   | 30d92a97a81a4e5d8fd97a32bafd7b88        |
        | service_name | manilav2                                |
        | service_type | sharev2                                 |
        | url          | http://controller:8786/v2/%(tenant_id)s |
        +--------------+-----------------------------------------+

      $ openstack endpoint create --region RegionOne \
        sharev2 internal http://controller:8786/v2/%\(tenant_id\)s
        +--------------+-----------------------------------------+
        | Field        | Value                                   |
        +--------------+-----------------------------------------+
        | enabled      | True                                    |
        | id           | afc86e5f50804008add349dba605da54        |
        | interface    | internal                                |
        | region       | RegionOne                               |
        | region_id    | RegionOne                               |
        | service_id   | 30d92a97a81a4e5d8fd97a32bafd7b88        |
        | service_name | manilav2                                |
        | service_type | sharev2                                 |
        | url          | http://controller:8786/v2/%(tenant_id)s |
        +--------------+-----------------------------------------+

      $ openstack endpoint create --region RegionOne \
        sharev2 admin http://controller:8786/v2/%\(tenant_id\)s
        +--------------+-----------------------------------------+
        | Field        | Value                                   |
        +--------------+-----------------------------------------+
        | enabled      | True                                    |
        | id           | e814a0cec40546e98cf0c25a82498483        |
        | interface    | admin                                   |
        | region       | RegionOne                               |
        | region_id    | RegionOne                               |
        | service_id   | 30d92a97a81a4e5d8fd97a32bafd7b88        |
        | service_name | manilav2                                |
        | service_type | sharev2                                 |
        | url          | http://controller:8786/v2/%(tenant_id)s |
        +--------------+-----------------------------------------+

   .. note::

      The Share File System services require endpoints for each service
      entity.

Install and configure components
--------------------------------

#. Install the packages:

   .. code-block:: console

      # apt-get install manila-api manila-scheduler \
        python-manilaclient

   Respond to prompts for
   :doc:`database management <debconf/debconf-dbconfig-common>`,
   :doc:`Identity service credentials <debconf/debconf-keystone-authtoken>`,
   :doc:`service endpoint registration <debconf/debconf-api-endpoints>`,
   and :doc:`message broker credentials <debconf/debconf-rabbitmq>`.

Finalize installation
---------------------

* Restart the Share File Systems services:

  .. code-block:: console

     # service manila-scheduler restart
     # service manila-api restart
