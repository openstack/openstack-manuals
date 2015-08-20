=====================
Install and configure
=====================

This section describes how to install and configure the Image service,
code-named glance, on the controller node. For simplicity, this
configuration stores images on the local file system.

.. note::

   This section assumes proper installation, configuration, and
   operation of the Identity service as described in the
   ":doc:`keystone-install`" section and the ":doc:`keystone-verify`"
   section as well as setup of the :file:`admin-openrc.sh` script
   as described in the ":doc:`keystone-openrc`" section.

To configure prerequisites
~~~~~~~~~~~~~~~~~~~~~~~~~~

Before you install and configure the Image service, you must
create a database, service credentials, and API endpoint.

#. To create the database, complete these steps:

   a. Use the database access client to connect to the database
      server as the ``root`` user:

      .. code-block:: console

         $ mysql -u root -p

   b. Create the ``glance`` database:

      .. code-block:: console

         CREATE DATABASE glance;

   c. Grant proper access to the ``glance`` database:

      .. code-block:: console

         GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'localhost' \
           IDENTIFIED BY 'GLANCE_DBPASS';
         GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'%' \
           IDENTIFIED BY 'GLANCE_DBPASS';

      Replace ``GLANCE_DBPASS`` with a suitable password.

   d. Exit the database access client.

#. Source the ``admin`` credentials to gain access to
   admin-only CLI commands:

   .. code-block:: console

        $ source admin-openrc.sh

#. To create the service credentials, complete these steps:

   a. Create the ``glance`` user:

      .. code-block:: console

         $ openstack user create --password-prompt glance
         User Password:
         Repeat User Password:
         +----------+----------------------------------+
         | Field    | Value                            |
         +----------+----------------------------------+
         | email    | None                             |
         | enabled  | True                             |
         | id       | 1dc206e084334db2bee88363745da014 |
         | name     | glance                           |
         | username | glance                           |
         +----------+----------------------------------+

   b. Add the ``admin`` role to the ``glance`` user and
      ``service`` project:

      .. code-block:: console

         $ openstack role add --project service --user glance admin
         +-------+----------------------------------+
         | Field | Value                            |
         +-------+----------------------------------+
         | id    | cd2cb9a39e874ea69e5d4b896eb16128 |
         | name  | admin                            |
         +-------+----------------------------------+

   c. Create the ``glance`` service entity:

      .. code-block:: console

         $ openstack service create --name glance \
           --description "OpenStack Image service" image
         +-------------+----------------------------------+
         | Field       | Value                            |
         +-------------+----------------------------------+
         | description | OpenStack Image service          |
         | enabled     | True                             |
         | id          | 178124d6081c441b80d79972614149c6 |
         | name        | glance                           |
         | type        | image                            |
         +-------------+----------------------------------+

#. Create the Image service API endpoint:

   .. code-block:: console

      $ openstack endpoint create \
        --publicurl http://controller:9292 \
        --internalurl http://controller:9292 \
        --adminurl http://controller:9292 \
        --region RegionOne \
        image
      +--------------+----------------------------------+
      | Field        | Value                            |
      +--------------+----------------------------------+
      | adminurl     | http://controller:9292           |
      | id           | 805b1dbc90ab47479111102bc6423313 |
      | internalurl  | http://controller:9292           |
      | publicurl    | http://controller:9292           |
      | region       | RegionOne                        |
      | service_id   | 178124d6081c441b80d79972614149c6 |
      | service_name | glance                           |
      | service_type | image                            |
      +--------------+----------------------------------+

To install and configure the Image service components
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. note::

   Default configuration files vary by distribution. You might need
   to add these sections and options rather than modifying existing
   sections and options. Also, an ellipsis (...) in the configuration
   snippets indicates potential default configuration options that you
   should retain.

.. only:: obs

   1. Install the packages:

      .. code-block:: console

         # zypper install openstack-glance python-glanceclient

.. only:: rdo

   1. Install the packages:

      .. code-block:: console

         # yum install openstack-glance python-glance python-glanceclient

.. The installation of python-glance is a workaround
   for bug: https://bugzilla.redhat.com/show_bug.cgi?id=1213545

.. only:: ubuntu

   1. Install the packages:

      .. code-block:: console

         # apt-get install glance python-glanceclient

2. Edit the :file:`/etc/glance/glance-api.conf` file and complete
   the following actions:

   a. In the ``[database]`` section, configure database access:

      .. code-block:: ini
         :linenos:

         [database]
         ...
         connection = mysql://glance:GLANCE_DBPASS@controller/glance

      Replace ``GLANCE_DBPASS`` with the password you chose for the
      Image service database.

   b. In the ``[keystone_authtoken]`` and ``[paste_deploy]`` sections,
      configure Identity service access:

      .. code-block:: ini
         :linenos:

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

   c. In the ``[glance_store]`` section, configure the local file
      system store and location of image files:

      .. code-block:: ini
         :linenos:

         [glance_store]
         ...
         default_store = file
         filesystem_store_datadir = /var/lib/glance/images/

   d. In the ``[DEFAULT]`` section, configure the ``noop``
      notification driver to disable notifications because
      they only pertain to the optional Telemetry service:

      .. code-block:: ini
         :linenos:

         [DEFAULT]
         ...
         notification_driver = noop

      The Telemetry chapter provides an Image service configuration
      that enables notifications.

   e. (Optional) To assist with troubleshooting,
      enable verbose logging in the ``[DEFAULT]`` section:

      .. code-block:: ini
         :linenos:

         [DEFAULT]
         ...
         verbose = True

3. Edit the :file:`/etc/glance/glance-registry.conf` file and
   complete the following actions:

   a. In the ``[database]`` section, configure database access:

      .. code-block:: ini
         :linenos:

         [database]
         ...
         connection = mysql://glance:GLANCE_DBPASS@controller/glance

      Replace ``GLANCE_DBPASS`` with the password you chose for the
      Image service database.

   b. In the ``[keystone_authtoken]`` and ``[paste_deploy]`` sections,
      configure Identity service access:

      .. code-block:: ini
         :linenos:

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

   c. In the ``[DEFAULT]`` section, configure the ``noop`` notification
      driver to disable notifications because they only pertain to the
      optional Telemetry service:

      .. code-block:: ini
         :linenos:

         [DEFAULT]
         ...
         notification_driver = noop

      The Telemetry chapter provides an Image service configuration
      that enables notifications.

   d. (Optional) To assist with troubleshooting,
      enable verbose logging in the ``[DEFAULT]`` section:

      .. code-block:: ini
         :linenos:

         [DEFAULT]
         ...
         verbose = True

.. only:: rdo or ubuntu

   4. Populate the Image service database:

      .. code-block:: console

         # su -s /bin/sh -c "glance-manage db_sync" glance

To finalize installation
------------------------

.. only:: obs or rdo

   #. Start the Image service services and configure them to start when
      the system boots:

      .. code-block:: console

         # systemctl enable openstack-glance-api.service openstack-glance-registry.service
         # systemctl start openstack-glance-api.service openstack-glance-registry.service

.. only:: ubuntu

   #. Restart the Image service services:

      .. code-block:: console

         # service glance-registry restart
         # service glance-api restart

   #. By default, the Ubuntu packages create an SQLite database.

      Because this configuration uses an SQL database server, you can
      remove the SQLite database file:

      .. code-block:: console

         # rm -f /var/lib/glance/glance.sqlite
