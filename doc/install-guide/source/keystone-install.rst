.. _keystone-install:

Install and configure
~~~~~~~~~~~~~~~~~~~~~

This section describes how to install and configure the OpenStack
Identity service, code-named keystone, on the controller node. For
performance, this configuration deploys Fernet tokens and the Apache
HTTP server to handle requests.

Prerequisites
-------------

Before you configure the OpenStack Identity service, you must create a
database and an administration token.

#. To create the database, complete the following actions:

   * Use the database access client to connect to the database server as the
     ``root`` user:

     .. code-block:: console

        $ mysql -u root -p

   * Create the ``keystone`` database:

     .. code-block:: console

        CREATE DATABASE keystone;

   * Grant proper access to the ``keystone`` database:

     .. code-block:: console

        GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' \
          IDENTIFIED BY 'KEYSTONE_DBPASS';
        GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' \
          IDENTIFIED BY 'KEYSTONE_DBPASS';

     Replace ``KEYSTONE_DBPASS`` with a suitable password.

   * Exit the database access client.

#. Generate a random value to use as the administration token during
   initial configuration:

   .. code-block:: console

      $ openssl rand -hex 10

Install and configure components
--------------------------------

.. include:: shared/note_configuration_vary_by_distribution.rst

.. only:: obs or rdo

   .. note::

      This guide uses the Apache HTTP server with ``mod_wsgi`` to serve
      Identity service requests on ports 5000 and 35357. By default, the
      keystone service still listens on these ports. Therefore, this guide
      manually disables the keystone service.

.. only:: ubuntu or debian

   .. note::

      This guide uses the Apache HTTP server with ``mod_wsgi`` to serve
      Identity service requests on ports 5000 and 35357. By default, the
      keystone service still listens on these ports. The package handles
      all of the Apache configuration for you (including the activation of
      the ``mod_wsgi`` apache2 module and keystone configuration in Apache).

   #. Run the following command to install the packages:

      .. code-block:: console

         # apt-get install keystone

.. only:: obs or rdo

   #. Run the following command to install the packages:

      .. only:: rdo

         .. code-block:: console

            # yum install openstack-keystone httpd mod_wsgi

      .. only:: obs

         .. code-block:: console

            # zypper install openstack-keystone apache2-mod_wsgi

2. Edit the ``/etc/keystone/keystone.conf`` file and complete the following
   actions:

   * In the ``[DEFAULT]`` section, define the value of the initial
     administration token:

     .. code-block:: ini

        [DEFAULT]
           ...
        admin_token = ADMIN_TOKEN

     Replace ``ADMIN_TOKEN`` with the random value that you generated in a
     previous step.

   * In the ``[database]`` section, configure database access:

     .. code-block:: ini

        [database]
        ...
        connection = mysql+pymysql://keystone:KEYSTONE_DBPASS@controller/keystone

     Replace ``KEYSTONE_DBPASS`` with the password you chose for the database.

   * In the ``[token]`` section, configure the Fernet token provider:

     .. code-block:: ini

        [token]
        ...
        provider = fernet

3. Populate the Identity service database:

   .. code-block:: console

      # su -s /bin/sh -c "keystone-manage db_sync" keystone

   .. note::

     Ignore any deprecation messages in this output.

4. Initialize Fernet keys:

   .. code-block:: console

      # keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone

.. only:: obs or rdo or ubuntu

   Configure the Apache HTTP server
   --------------------------------

   .. only:: rdo

      #. Edit the ``/etc/httpd/conf/httpd.conf`` file and configure the
         ``ServerName`` option to reference the controller node:

         .. code-block:: apache

            ServerName controller

      #. Create the ``/etc/httpd/conf.d/wsgi-keystone.conf`` file with
         the following content:

         .. code-block:: apache

            Listen 5000
            Listen 35357

            <VirtualHost *:5000>
                WSGIDaemonProcess keystone-public processes=5 threads=1 user=keystone group=keystone display-name=%{GROUP}
                WSGIProcessGroup keystone-public
                WSGIScriptAlias / /usr/bin/keystone-wsgi-public
                WSGIApplicationGroup %{GLOBAL}
                WSGIPassAuthorization On
                ErrorLogFormat "%{cu}t %M"
                ErrorLog /var/log/httpd/keystone-error.log
                CustomLog /var/log/httpd/keystone-access.log combined

                <Directory /usr/bin>
                    Require all granted
                </Directory>
            </VirtualHost>

            <VirtualHost *:35357>
                WSGIDaemonProcess keystone-admin processes=5 threads=1 user=keystone group=keystone display-name=%{GROUP}
                WSGIProcessGroup keystone-admin
                WSGIScriptAlias / /usr/bin/keystone-wsgi-admin
                WSGIApplicationGroup %{GLOBAL}
                WSGIPassAuthorization On
                ErrorLogFormat "%{cu}t %M"
                ErrorLog /var/log/httpd/keystone-error.log
                CustomLog /var/log/httpd/keystone-access.log combined

                <Directory /usr/bin>
                    Require all granted
                </Directory>
            </VirtualHost>

   .. only:: ubuntu

      #. Edit the ``/etc/apache2/apache2.conf`` file and configure the
         ``ServerName`` option to reference the controller node:

         .. code-block:: apache

            ServerName controller

      #. Create the ``/etc/apache2/sites-available/wsgi-keystone.conf`` file
         with the following content:

         .. code-block:: apache

            Listen 5000
            Listen 35357

            <VirtualHost *:5000>
                WSGIDaemonProcess keystone-public processes=5 threads=1 user=keystone group=keystone display-name=%{GROUP}
                WSGIProcessGroup keystone-public
                WSGIScriptAlias / /usr/bin/keystone-wsgi-public
                WSGIApplicationGroup %{GLOBAL}
                WSGIPassAuthorization On
                ErrorLogFormat "%{cu}t %M"
                ErrorLog /var/log/apache2/keystone.log
                CustomLog /var/log/apache2/keystone_access.log combined

                <Directory /usr/bin>
                    Require all granted
                </Directory>
            </VirtualHost>

            <VirtualHost *:35357>
                WSGIDaemonProcess keystone-admin processes=5 threads=1 user=keystone group=keystone display-name=%{GROUP}
                WSGIProcessGroup keystone-admin
                WSGIScriptAlias / /usr/bin/keystone-wsgi-admin
                WSGIApplicationGroup %{GLOBAL}
                WSGIPassAuthorization On
                ErrorLogFormat "%{cu}t %M"
                ErrorLog /var/log/apache2/keystone.log
                CustomLog /var/log/apache2/keystone_access.log combined

                <Directory /usr/bin>
                    Require all granted
                </Directory>
            </VirtualHost>

      #. Enable the Identity service virtual hosts:

         .. code-block:: console

            # ln -s /etc/apache2/sites-available/wsgi-keystone.conf /etc/apache2/sites-enabled

   .. only:: obs

      #. Edit the ``/etc/sysconfig/apache2`` file and configure the
         ``APACHE_SERVERNAME`` option to reference the controller node:

         .. code-block:: apache

            APACHE_SERVERNAME="controller"

      #. Create the ``/etc/apache2/conf.d/wsgi-keystone.conf`` file
         with the following content:

         .. code-block:: apache

            Listen 5000
            Listen 35357

            <VirtualHost *:5000>
                WSGIDaemonProcess keystone-public processes=5 threads=1 user=keystone group=keystone display-name=%{GROUP}
                WSGIProcessGroup keystone-public
                WSGIScriptAlias / /usr/bin/keystone-wsgi-public
                WSGIApplicationGroup %{GLOBAL}
                WSGIPassAuthorization On
                ErrorLogFormat "%{cu}t %M"
                ErrorLog /var/log/apache2/keystone.log
                CustomLog /var/log/apache2/keystone_access.log combined

                <Directory /usr/bin>
                    Require all granted
                </Directory>
            </VirtualHost>

            <VirtualHost *:35357>
                WSGIDaemonProcess keystone-admin processes=5 threads=1 user=keystone group=keystone display-name=%{GROUP}
                WSGIProcessGroup keystone-admin
                WSGIScriptAlias / /usr/bin/keystone-wsgi-admin
                WSGIApplicationGroup %{GLOBAL}
                WSGIPassAuthorization On
                ErrorLogFormat "%{cu}t %M"
                ErrorLog /var/log/apache2/keystone.log
                CustomLog /var/log/apache2/keystone_access.log combined

                <Directory /usr/bin>
                    Require all granted
                </Directory>
            </VirtualHost>

      6. Recursively change the ownership of the ``/etc/keystone`` directory:

         .. code-block:: console

            # chown -R keystone:keystone /etc/keystone

.. only:: ubuntu or rdo or obs

   Finalize the installation
   -------------------------

   .. only:: ubuntu

      #. Restart the Apache HTTP server:

         .. code-block:: console

            # service apache2 restart

      #. By default, the Ubuntu packages create an SQLite database.

         Because this configuration uses an SQL database server, you can remove
         the SQLite database file:

         .. code-block:: console

            # rm -f /var/lib/keystone/keystone.db

   .. only:: rdo

      * Start the Apache HTTP service and configure it to start when the system boots:

        .. code-block:: console

           # systemctl enable httpd.service
           # systemctl start httpd.service

   .. only:: obs

      #. Start the Apache HTTP service and configure it to start when the system boots:

         .. code-block:: console

            # systemctl enable apache2.service
            # systemctl start apache2.service
