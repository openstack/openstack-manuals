.. _cinder-controller:

Install and configure controller node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section describes how to install and configure the Block
Storage service, code-named cinder, on the controller node. This
service requires at least one additional storage node that provides
volumes to instances.

Prerequisites
-------------

Before you install and configure the Block Storage service, you
must create a database, service credentials, and API endpoints.

#. To create the database, complete these steps:

   * Use the database access client to connect to the database
     server as the ``root`` user:

     .. code-block:: console

        $ mysql -u root -p

   * Create the ``cinder`` database:

     .. code-block:: console

        CREATE DATABASE cinder;

   * Grant proper access to the ``cinder`` database:

     .. code-block:: console

        GRANT ALL PRIVILEGES ON cinder.* TO 'cinder'@'localhost' \
          IDENTIFIED BY 'CINDER_DBPASS';
        GRANT ALL PRIVILEGES ON cinder.* TO 'cinder'@'%' \
          IDENTIFIED BY 'CINDER_DBPASS';

     Replace ``CINDER_DBPASS`` with a suitable password.

   * Exit the database access client.

#. Source the ``admin`` credentials to gain access to admin-only
   CLI commands:

   .. code-block:: console

      $ . admin-openrc

#. To create the service credentials, complete these steps:

   * Create a ``cinder`` user:

     .. code-block:: console

        $ openstack user create --domain default --password-prompt cinder
        User Password:
        Repeat User Password:
        +-----------+----------------------------------+
        | Field     | Value                            |
        +-----------+----------------------------------+
        | domain_id | e0353a670a9e496da891347c589539e9 |
        | enabled   | True                             |
        | id        | bb279f8ffc444637af38811a5e1f0562 |
        | name      | cinder                           |
        +-----------+----------------------------------+

   * Add the ``admin`` role to the ``cinder`` user:

     .. code-block:: console

        $ openstack role add --project service --user cinder admin

     .. note::

        This command provides no output.

   * Create the ``cinder`` and ``cinderv2`` service entities:

     .. code-block:: console

        $ openstack service create --name cinder \
          --description "OpenStack Block Storage" volume
        +-------------+----------------------------------+
        | Field       | Value                            |
        +-------------+----------------------------------+
        | description | OpenStack Block Storage          |
        | enabled     | True                             |
        | id          | ab3bbbef780845a1a283490d281e7fda |
        | name        | cinder                           |
        | type        | volume                           |
        +-------------+----------------------------------+

     .. code-block:: console

        $ openstack service create --name cinderv2 \
          --description "OpenStack Block Storage" volumev2
        +-------------+----------------------------------+
        | Field       | Value                            |
        +-------------+----------------------------------+
        | description | OpenStack Block Storage          |
        | enabled     | True                             |
        | id          | eb9fd245bdbc414695952e93f29fe3ac |
        | name        | cinderv2                         |
        | type        | volumev2                         |
        +-------------+----------------------------------+

   .. note::

      The Block Storage services require two service entities.

#. Create the Block Storage service API endpoints:

   .. code-block:: console

      $ openstack endpoint create --region RegionOne \
        volume public http://controller:8776/v1/%\(tenant_id\)s
        +--------------+-----------------------------------------+
        | Field        | Value                                   |
        +--------------+-----------------------------------------+
        | enabled      | True                                    |
        | id           | 03fa2c90153546c295bf30ca86b1344b        |
        | interface    | public                                  |
        | region       | RegionOne                               |
        | region_id    | RegionOne                               |
        | service_id   | ab3bbbef780845a1a283490d281e7fda        |
        | service_name | cinder                                  |
        | service_type | volume                                  |
        | url          | http://controller:8776/v1/%(tenant_id)s |
        +--------------+-----------------------------------------+

      $ openstack endpoint create --region RegionOne \
        volume internal http://controller:8776/v1/%\(tenant_id\)s
        +--------------+-----------------------------------------+
        | Field        | Value                                   |
        +--------------+-----------------------------------------+
        | enabled      | True                                    |
        | id           | 94f684395d1b41068c70e4ecb11364b2        |
        | interface    | internal                                |
        | region       | RegionOne                               |
        | region_id    | RegionOne                               |
        | service_id   | ab3bbbef780845a1a283490d281e7fda        |
        | service_name | cinder                                  |
        | service_type | volume                                  |
        | url          | http://controller:8776/v1/%(tenant_id)s |
        +--------------+-----------------------------------------+

      $ openstack endpoint create --region RegionOne \
        volume admin http://controller:8776/v1/%\(tenant_id\)s
        +--------------+-----------------------------------------+
        | Field        | Value                                   |
        +--------------+-----------------------------------------+
        | enabled      | True                                    |
        | id           | 4511c28a0f9840c78bacb25f10f62c98        |
        | interface    | admin                                   |
        | region       | RegionOne                               |
        | region_id    | RegionOne                               |
        | service_id   | ab3bbbef780845a1a283490d281e7fda        |
        | service_name | cinder                                  |
        | service_type | volume                                  |
        | url          | http://controller:8776/v1/%(tenant_id)s |
        +--------------+-----------------------------------------+

   .. code-block:: console

      $ openstack endpoint create --region RegionOne \
        volumev2 public http://controller:8776/v2/%\(tenant_id\)s
      +--------------+-----------------------------------------+
      | Field        | Value                                   |
      +--------------+-----------------------------------------+
      | enabled      | True                                    |
      | id           | 513e73819e14460fb904163f41ef3759        |
      | interface    | public                                  |
      | region       | RegionOne                               |
      | region_id    | RegionOne                               |
      | service_id   | eb9fd245bdbc414695952e93f29fe3ac        |
      | service_name | cinderv2                                |
      | service_type | volumev2                                |
      | url          | http://controller:8776/v2/%(tenant_id)s |
      +--------------+-----------------------------------------+

      $ openstack endpoint create --region RegionOne \
        volumev2 internal http://controller:8776/v2/%\(tenant_id\)s
      +--------------+-----------------------------------------+
      | Field        | Value                                   |
      +--------------+-----------------------------------------+
      | enabled      | True                                    |
      | id           | 6436a8a23d014cfdb69c586eff146a32        |
      | interface    | internal                                |
      | region       | RegionOne                               |
      | region_id    | RegionOne                               |
      | service_id   | eb9fd245bdbc414695952e93f29fe3ac        |
      | service_name | cinderv2                                |
      | service_type | volumev2                                |
      | url          | http://controller:8776/v2/%(tenant_id)s |
      +--------------+-----------------------------------------+

      $ openstack endpoint create --region RegionOne \
        volumev2 admin http://controller:8776/v2/%\(tenant_id\)s
      +--------------+-----------------------------------------+
      | Field        | Value                                   |
      +--------------+-----------------------------------------+
      | enabled      | True                                    |
      | id           | e652cf84dd334f359ae9b045a2c91d96        |
      | interface    | admin                                   |
      | region       | RegionOne                               |
      | region_id    | RegionOne                               |
      | service_id   | eb9fd245bdbc414695952e93f29fe3ac        |
      | service_name | cinderv2                                |
      | service_type | volumev2                                |
      | url          | http://controller:8776/v2/%(tenant_id)s |
      +--------------+-----------------------------------------+

   .. note::

      The Block Storage services require endpoints for each service
      entity.

Install and configure components
--------------------------------

.. only:: obs

   #. Install the packages:

      .. code-block:: console

         # zypper install openstack-cinder-api openstack-cinder-scheduler

.. only:: rdo

   #. Install the packages:

      .. code-block:: console

         # yum install openstack-cinder

.. only:: ubuntu or debian

   #. Install the packages:

      .. code-block:: console

         # apt-get install cinder-api cinder-scheduler

2. Edit the ``/etc/cinder/cinder.conf`` file and complete the
   following actions:

   * In the ``[database]`` section, configure database access:

     .. code-block:: ini

        [database]
        ...
        connection = mysql+pymysql://cinder:CINDER_DBPASS@controller/cinder

     Replace ``CINDER_DBPASS`` with the password you chose for the
     Block Storage database.

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

   * In the ``[DEFAULT]`` and ``[keystone_authtoken]`` sections,
     configure Identity service access:

     .. code-block:: ini

        [DEFAULT]
        ...
        auth_strategy = keystone

        [keystone_authtoken]
        ...
        auth_uri = http://controller:5000
        auth_url = http://controller:35357
        memcached_servers = controller:11211
        auth_type = password
        project_domain_name = default
        user_domain_name = default
        project_name = service
        username = cinder
        password = CINDER_PASS

     Replace ``CINDER_PASS`` with the password you chose for
     the ``cinder`` user in the Identity service.

     .. note::

        Comment out or remove any other options in the
        ``[keystone_authtoken]`` section.

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
        lock_path = /var/lib/cinder/tmp

.. only:: rdo or ubuntu or debian

   3. Populate the Block Storage database:

      .. code-block:: console

         # su -s /bin/sh -c "cinder-manage db sync" cinder

      .. note::

         Ignore any deprecation messages in this output.

Configure Compute to use Block Storage
--------------------------------------

* Edit the ``/etc/nova/nova.conf`` file and add the following
  to it:

  .. code-block:: ini

     [cinder]
     os_region_name = RegionOne

Finalize installation
---------------------

.. only:: obs or rdo

   #. Restart the Compute API service:

      .. code-block:: console

         # systemctl restart openstack-nova-api.service

   #. Start the Block Storage services and configure them to start when
      the system boots:

      .. code-block:: console

         # systemctl enable openstack-cinder-api.service openstack-cinder-scheduler.service
         # systemctl start openstack-cinder-api.service openstack-cinder-scheduler.service

.. only:: ubuntu or debian

   #. Restart the Compute API service:

      .. code-block:: console

         # service nova-api restart

   #. Restart the Block Storage services:

      .. code-block:: console

         # service cinder-scheduler restart
         # service cinder-api restart
