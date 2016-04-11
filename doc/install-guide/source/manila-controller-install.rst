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

.. only:: obs

   #. Install the packages:

      .. code-block:: console

         # zypper install openstack-manila-api openstack-manila-scheduler

.. only:: rdo

   #. Install the packages:

      .. code-block:: console

         # yum install openstack-manila

.. only:: ubuntu or debian

   #. Install the packages:

      .. code-block:: console

         # apt-get install manila-api manila-scheduler

      .. only:: debian

         Respond to prompts for
         :doc:`database management <debconf/debconf-dbconfig-common>`,
         :doc:`Identity service credentials <debconf/debconf-keystone-authtoken>`,
         :doc:`service endpoint registration <debconf/debconf-api-endpoints>`,
         and :doc:`message broker credentials <debconf/debconf-rabbitmq>`.

2. Edit the ``/etc/manila/manila.conf`` file and complete the
   following actions:

   .. only:: obs or rdo or ubuntu

      * In the ``[database]`` section, configure database access:

        .. only:: ubuntu or obs

           .. code-block:: ini

              [database]
              ...
              connection = mysql+pymysql://manila:MANILA_DBPASS@controller/manila

        .. only:: rdo

           .. code-block:: ini

              [database]
              ...
              connection = mysql+pymysql://manila:MANILA_DBPASS@controller/manila

        Replace ``MANILA_DBPASS`` with the password you chose for the
        Share File System database.

      * In the ``[DEFAULT]`` and ``[oslo_messaging_rabbit]`` sections,
        configure ``RabbitMQ`` message queue access:

        .. code-block:: ini

           [DEFAULT]
           ...
           rpc_backend = rabbit

           [oslo_messaging_rabbit]
           ...
           rabbit_host = controller
           rabbit_userid = openstack
           rabbit_password = RABBIT_PASS

        Replace ``RABBIT_PASS`` with the password you chose for the
        ``openstack`` account in ``RabbitMQ``.

      * In the ``[DEFAULT]`` section, set the following config values:

        .. code-block:: ini

           [DEFAULT]
           ...
           default_share_type = default_share_type
           rootwrap_config = /etc/manila/rootwrap.conf

      * In the ``[DEFAULT]`` and ``[keystone_authtoken]`` sections,
        configure Identity service access:

        .. code-block:: ini

           [DEFAULT]
           ...
           auth_strategy = keystone

           [keystone_authtoken]
           ...
           memcached_servers = controller:11211
           auth_uri = http://controller:5000
           auth_url = http://controller:35357
           auth_type = password
           project_domain_name = default
           user_domain_name = default
           project_name = service
           username = manila
           password = MANILA_PASS

        Replace ``MANILA_PASS`` with the password you chose for
        the ``manila`` user in the Identity service.

   * In the ``[DEFAULT]`` section, configure the ``my_ip`` option to
     use the management interface IP address of the controller node:

     .. code-block:: ini

        [DEFAULT]
        ...
        my_ip = 10.0.0.11

   .. only:: obs or rdo or ubuntu

      * In the ``[oslo_concurrency]`` section, configure the lock path:

        .. code-block:: ini

           [oslo_concurrency]
           ...
           lock_path = /var/lib/manila/tmp

.. only:: rdo or ubuntu

   3. Populate the Share File System database:

      .. code-block:: console

         # su -s /bin/sh -c "manila-manage db sync" manila

Finalize installation
---------------------

.. only:: obs or rdo

   * Start the Share File System services and configure them to start when
     the system boots:

     .. code-block:: console

        # systemctl enable openstack-manila-api.service openstack-manila-scheduler.service
        # systemctl start openstack-manila-api.service openstack-manila-scheduler.service

.. only:: ubuntu or debian

   * Restart the Share File Systems services:

     .. code-block:: console

        # service manila-scheduler restart
        # service manila-api restart

.. only:: ubuntu

   * By default, the Ubuntu packages create an SQLite database.

     Because this configuration uses an SQL database server,
     you can remove the SQLite database file:

     .. code-block:: console

        # rm -f /var/lib/manila/manila.sqlite
