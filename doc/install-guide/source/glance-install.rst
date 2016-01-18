Install and configure
~~~~~~~~~~~~~~~~~~~~~

This section describes how to install and configure the Image service,
code-named glance, on the controller node. For simplicity, this
configuration stores images on the local file system.

.. only:: obs or rdo or ubuntu

   Prerequisites
   -------------

   Before you install and configure the Image service, you must
   create a database, service credentials, and API endpoints.

   #. To create the database, complete these steps:

      * Use the database access client to connect to the database
        server as the ``root`` user:

        .. code-block:: console

           $ mysql -u root -p

      * Create the ``glance`` database:

        .. code-block:: console

           CREATE DATABASE glance;

      * Grant proper access to the ``glance`` database:

        .. code-block:: console

           GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'localhost' \
             IDENTIFIED BY 'GLANCE_DBPASS';
           GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'%' \
             IDENTIFIED BY 'GLANCE_DBPASS';

        Replace ``GLANCE_DBPASS`` with a suitable password.

      * Exit the database access client.

   #. Source the ``admin`` credentials to gain access to
      admin-only CLI commands:

      .. code-block:: console

         $ source admin-openrc.sh

   #. To create the service credentials, complete these steps:

      * Create the ``glance`` user:

        .. code-block:: console

           $ openstack user create --domain default --password-prompt glance
           User Password:
           Repeat User Password:
           +-----------+----------------------------------+
           | Field     | Value                            |
           +-----------+----------------------------------+
           | domain_id | default                          |
           | enabled   | True                             |
           | id        | e38230eeff474607805b596c91fa15d9 |
           | name      | glance                           |
           +-----------+----------------------------------+

      * Add the ``admin`` role to the ``glance`` user and
        ``service`` project:

        .. code-block:: console

           $ openstack role add --project service --user glance admin

        .. note::

           This command provides no output.

      * Create the ``glance`` service entity:

        .. code-block:: console

           $ openstack service create --name glance \
             --description "OpenStack Image service" image
           +-------------+----------------------------------+
           | Field       | Value                            |
           +-------------+----------------------------------+
           | description | OpenStack Image service          |
           | enabled     | True                             |
           | id          | 8c2c7f1b9b5049ea9e63757b5533e6d2 |
           | name        | glance                           |
           | type        | image                            |
           +-------------+----------------------------------+

   #. Create the Image service API endpoints:

      .. code-block:: console

         $ openstack endpoint create --region RegionOne \
           image public http://controller:9292
         +--------------+----------------------------------+
         | Field        | Value                            |
         +--------------+----------------------------------+
         | enabled      | True                             |
         | id           | 340be3625e9b4239a6415d034e98aace |
         | interface    | public                           |
         | region       | RegionOne                        |
         | region_id    | RegionOne                        |
         | service_id   | 8c2c7f1b9b5049ea9e63757b5533e6d2 |
         | service_name | glance                           |
         | service_type | image                            |
         | url          | http://controller:9292           |
         +--------------+----------------------------------+

         $ openstack endpoint create --region RegionOne \
           image internal http://controller:9292
         +--------------+----------------------------------+
         | Field        | Value                            |
         +--------------+----------------------------------+
         | enabled      | True                             |
         | id           | a6e4b153c2ae4c919eccfdbb7dceb5d2 |
         | interface    | internal                         |
         | region       | RegionOne                        |
         | region_id    | RegionOne                        |
         | service_id   | 8c2c7f1b9b5049ea9e63757b5533e6d2 |
         | service_name | glance                           |
         | service_type | image                            |
         | url          | http://controller:9292           |
         +--------------+----------------------------------+

         $ openstack endpoint create --region RegionOne \
           image admin http://controller:9292
         +--------------+----------------------------------+
         | Field        | Value                            |
         +--------------+----------------------------------+
         | enabled      | True                             |
         | id           | 0c37ed58103f4300a84ff125a539032d |
         | interface    | admin                            |
         | region       | RegionOne                        |
         | region_id    | RegionOne                        |
         | service_id   | 8c2c7f1b9b5049ea9e63757b5533e6d2 |
         | service_name | glance                           |
         | service_type | image                            |
         | url          | http://controller:9292           |
         +--------------+----------------------------------+

Install and configure components
--------------------------------

.. only:: obs or rdo or ubuntu

   .. include:: shared/note_configuration_vary_by_distribution.rst

.. only:: obs

   #. Install the packages:

      .. code-block:: console

         # zypper install openstack-glance python-glanceclient

.. only:: rdo

   #. Install the packages:

      .. code-block:: console

         # yum install openstack-glance python-glance python-glanceclient

.. The installation of python-glance is a workaround
   for bug: https://bugzilla.redhat.com/show_bug.cgi?id=1213545

.. only:: ubuntu

   #. Install the packages:

      .. code-block:: console

         # apt-get install glance python-glanceclient

.. only:: obs or rdo or ubuntu

   2. Edit the ``/etc/glance/glance-api.conf`` file and complete
      the following actions:

      * In the ``[database]`` section, configure database access:

        .. only:: ubuntu or obs

           .. code-block:: ini

              [database]
              ...
              connection = mysql+pymysql://glance:GLANCE_DBPASS@controller/glance

        .. only:: rdo

           .. code-block:: ini

              [database]
              ...
              connection = mysql://glance:GLANCE_DBPASS@controller/glance

        Replace ``GLANCE_DBPASS`` with the password you chose for the
        Image service database.

      * In the ``[keystone_authtoken]`` and ``[paste_deploy]`` sections,
        configure Identity service access:

        .. code-block:: ini

           [keystone_authtoken]
           ...
           auth_uri = http://controller:5000
           auth_url = http://controller:35357
           auth_plugin = password
           project_domain_id = default
           user_domain_id = default
           project_name = service
           username = glance
           password = GLANCE_PASS

           [paste_deploy]
           ...
           flavor = keystone

        Replace ``GLANCE_PASS`` with the password you chose for the
        ``glance`` user in the Identity service.

        .. note::

           Comment out or remove any other options in the
           ``[keystone_authtoken]`` section.

      * In the ``[glance_store]`` section, configure the local file
        system store and location of image files:

        .. code-block:: ini

           [glance_store]
           ...
           default_store = file
           filesystem_store_datadir = /var/lib/glance/images/

      * In the ``[DEFAULT]`` section, configure the ``noop``
        notification driver to disable notifications because
        they only pertain to the optional Telemetry service:

        .. code-block:: ini

           [DEFAULT]
           ...
           notification_driver = noop

        The Telemetry chapter provides an Image service configuration
        that enables notifications.

      * (Optional) To assist with troubleshooting,
        enable verbose logging in the ``[DEFAULT]`` section:

        .. code-block:: ini

           [DEFAULT]
           ...
           verbose = True

   3. Edit the ``/etc/glance/glance-registry.conf`` file and
      complete the following actions:

      * In the ``[database]`` section, configure database access:

        .. only:: ubuntu or obs

           .. code-block:: ini

              [database]
              ...
              connection = mysql+pymysql://glance:GLANCE_DBPASS@controller/glance

        .. only:: rdo

           .. code-block:: ini

              [database]
              ...
              connection = mysql://glance:GLANCE_DBPASS@controller/glance

        Replace ``GLANCE_DBPASS`` with the password you chose for the
        Image service database.

      * In the ``[keystone_authtoken]`` and ``[paste_deploy]`` sections,
        configure Identity service access:

        .. code-block:: ini

           [keystone_authtoken]
           ...
           auth_uri = http://controller:5000
           auth_url = http://controller:35357
           auth_plugin = password
           project_domain_id = default
           user_domain_id = default
           project_name = service
           username = glance
           password = GLANCE_PASS

           [paste_deploy]
           ...
           flavor = keystone

        Replace ``GLANCE_PASS`` with the password you chose for the
        ``glance`` user in the Identity service.

        .. note::

           Comment out or remove any other options in the
           ``[keystone_authtoken]`` section.

      * In the ``[DEFAULT]`` section, configure the ``noop`` notification
        driver to disable notifications because they only pertain to the
        optional Telemetry service:

        .. code-block:: ini

           [DEFAULT]
           ...
           notification_driver = noop

        The Telemetry chapter provides an Image service configuration
        that enables notifications.

      * (Optional) To assist with troubleshooting,
        enable verbose logging in the ``[DEFAULT]`` section:

        .. code-block:: ini

           [DEFAULT]
           ...
           verbose = True

.. only:: rdo or ubuntu

   4. Populate the Image service database:

      .. code-block:: console

         # su -s /bin/sh -c "glance-manage db_sync" glance

.. only:: debian

   #. Install the packages:

      .. code-block:: console

         # apt-get install glance python-glanceclient

   #. Respond to prompts for
      :doc:`database management <debconf/debconf-dbconfig-common>`,
      :doc:`Identity service credentials <debconf/debconf-keystone-authtoken>`,
      :doc:`service endpoint registration <debconf/debconf-api-endpoints>`,
      and :doc:`message broker credentials <debconf/debconf-rabbitmq>`.

   #. Select the ``keystone`` pipeline to configure the Image service
      to use the Identity service:

      .. image:: figures/debconf-screenshots/glance-common_pipeline_flavor.png
         :width: 100%

.. only:: obs or rdo or ubuntu

   Finalize installation
   ---------------------

   .. only:: obs or rdo

      * Start the Image services and configure them to start when
        the system boots:

        .. code-block:: console

           # systemctl enable openstack-glance-api.service \
             openstack-glance-registry.service
           # systemctl start openstack-glance-api.service \
             openstack-glance-registry.service

   .. only:: ubuntu

      #. Restart the Image services:

         .. code-block:: console

            # service glance-registry restart
            # service glance-api restart

      #. By default, the Ubuntu packages create an SQLite database.

         Because this configuration uses an SQL database server, you can
         remove the SQLite database file:

         .. code-block:: console

            # rm -f /var/lib/glance/glance.sqlite
