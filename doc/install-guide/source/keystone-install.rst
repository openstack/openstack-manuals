.. _keystone-install:

Install and configure
~~~~~~~~~~~~~~~~~~~~~

This section describes how to install and configure the OpenStack
Identity service, code-named keystone, on the controller node. For
performance, this configuration deploys the Apache HTTP server to handle
requests and Memcached to store tokens instead of an SQL database.

.. only:: obs or rdo or ubuntu

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

.. only:: obs or rdo or ubuntu

   Install and configure components
   --------------------------------

   .. include:: shared/note_configuration_vary_by_distribution.rst

   .. note::
      In Kilo and Liberty releases, the keystone project deprecates eventlet
      in favor of a separate web server with WSGI extensions. This guide uses
      the Apache HTTP server with ``mod_wsgi`` to serve Identity service
      requests on port 5000 and 35357. By default, the keystone service
      still listens on ports 5000 and 35357. Therefore, this guide disables
      the keystone service. The keystone project plans to remove eventlet
      support in Mitaka.

   .. only:: ubuntu

      #. Disable the keystone service from starting automatically after
         installation:

         .. code-block:: console

            # echo "manual" > /etc/init/keystone.override

      #. Run the following command to install the packages:

         .. only:: ubuntu

            .. code-block:: console

               # apt-get install keystone apache2 libapache2-mod-wsgi \
                 memcached python-memcache

   .. only:: obs or rdo

      #. Run the following command to install the packages:

         .. only:: rdo

            .. code-block:: console

               # yum install openstack-keystone httpd mod_wsgi \
                 memcached python-memcached

         .. only:: obs

            .. code-block:: console

               # zypper install openstack-keystone apache2-mod_wsgi \
                 memcached python-python-memcached

   .. only:: obs or rdo

      2. Start the Memcached service and configure it to start when the system
         boots:

         .. code-block:: console

            # systemctl enable memcached.service
            # systemctl start memcached.service

   .. only:: obs or rdo or ubuntu

      3. Edit the ``/etc/keystone/keystone.conf`` file and complete the following
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

           .. only:: ubuntu or obs

              .. code-block:: ini

                 [database]
                 ...
                 connection = mysql+pymysql://keystone:KEYSTONE_DBPASS@controller/keystone

           .. only:: rdo

              .. code-block:: ini

                 [database]
                 ...
                 connection = mysql://keystone:KEYSTONE_DBPASS@controller/keystone

           Replace ``KEYSTONE_DBPASS`` with the password you chose for the database.

         * In the ``[memcache]`` section, configure the Memcached service:

           .. code-block:: ini

              [memcache]
              ...
              servers = localhost:11211

         * In the ``[token]`` section, configure the UUID token provider and
           Memcached driver:

           .. code-block:: ini

              [token]
              ...
              provider = uuid
              driver = memcache

         * In the ``[revoke]`` section, configure the SQL revocation driver:

           .. code-block:: ini

              [revoke]
              ...
              driver = sql

         * (Optional) To assist with troubleshooting, enable verbose logging in the
           ``[DEFAULT]`` section:

           .. code-block:: ini

              [DEFAULT]
              ...
              verbose = True

   .. only:: obs or rdo or ubuntu

      4. Populate the Identity service database:

         .. code-block:: console

            # su -s /bin/sh -c "keystone-manage db_sync" keystone

.. only:: debian

   Install and configure the components
   ------------------------------------

   #. Run the following command to install the packages:

      .. code-block:: console

         # apt-get install keystone

   #. Respond to prompts for :doc:`debconf/debconf-dbconfig-common`,
      which will fill the below database access directive.

      .. code-block:: ini

         [database]
         ...
         connection = mysql+pymysql://keystone:KEYSTONE_DBPASS@controller/keystone

      If you decide to not use ``dbconfig-common``, then you have to
      create the database and manage its access rights yourself, and run the
      following by hand.

      .. code-block:: console

         # keystone-manage db_sync

   #. Generate a random value to use as the administration token during
      initial configuration:

      .. code-block:: console

         $ openssl rand -hex 10

   #. Configure the initial administration token:

      .. image:: figures/debconf-screenshots/keystone_1_admin_token.png
         :scale: 50

      Use the random value that you generated in a previous step. If you
      install using non-interactive mode or you do not specify this token, the
      configuration tool generates a random value.

      Later on, the package will configure the below directive with the value
      you entered:

      .. code-block:: ini

         [DEFAULT]
         ...
         admin_token = ADMIN_TOKEN

   #. Create the ``admin`` project and user:

      During the final stage of the package installation, it is possible to
      automatically create an ``admin`` and ``service`` project, and an ``admin`` user.
      This can later be used for other OpenStack services to contact the
      Identity service. This is the equivalent of running the below commands:

      .. code-block:: console

         # openstack --os-token ${AUTH_TOKEN} \
           --os-url=http://127.0.0.1:35357/v3/ \
           --os-domain-name default \
           --os-identity-api-version=3 \
           project create --or-show \
           admin --domain default \
           --description "Default Debian admin project"

         # openstack --os-token ${AUTH_TOKEN} \
           --os-url=http://127.0.0.1:35357/v3/ \
           --os-domain-name default \
           --os-identity-api-version=3 \
           project create --or-show \
           service --domain default \
           --description "Default Debian admin project"

         # openstack --os-token ${AUTH_TOKEN} \
           --os-url=http://127.0.0.1:35357/v3/ \
           --os-domain-name default \
           --os-identity-api-version=3 \
           user create --or-show \
           --password ADMIN_PASS \
           --project admin \
           --email root@localhost \
           --enable \
           admin \
           --domain default \
           --description "Default Debian admin user"

         # openstack --os-token ${AUTH_TOKEN} \
           --os-url=http://127.0.0.1:35357/v3/ \
           --os-domain-name default \
           --os-identity-api-version=3 \
           role create --or-show admin

         # openstack  --os-token ${AUTH_TOKEN} \
           --os-url=http://127.0.0.1:35357/v3/ \
           --os-domain-name default \
           --os-identity-api-version=3 \
           role add --project admin --user admin admin

      .. image:: figures/debconf-screenshots/keystone_2_register_admin_tenant_yes_no.png
         :scale: 50

      .. image:: figures/debconf-screenshots/keystone_3_admin_user_name.png
         :scale: 50

      .. image:: figures/debconf-screenshots/keystone_4_admin_user_email.png
         :scale: 50

      .. image:: figures/debconf-screenshots/keystone_5_admin_user_pass.png
         :scale: 50

      .. image:: figures/debconf-screenshots/keystone_6_admin_user_pass_confirm.png
         :scale: 50

      In Debian, the Keystone package offers automatic registration of
      Keystone in the service catalogue. This is equivalent of running the
      below commands:

      .. code-block:: console

         # openstack --os-token ${AUTH_TOKEN} \
           --os-url=http://127.0.0.1:35357/v3/ \
           --os-domain-name default \
           --os-identity-api-version=3 \
           service create \
           --name keystone \
           --description "OpenStack Identity" \
           identity

         # openstack --os-token ${AUTH_TOKEN} \
           --os-url=http://127.0.0.1:35357/v3/ \
           --os-domain-name default \
           --os-identity-api-version=3 \
           keystone public http://controller:5000/v2.0

         # openstack --os-token ${AUTH_TOKEN} \
           --os-url=http://127.0.0.1:35357/v3/ \
           --os-domain-name default \
           --os-identity-api-version=3 \
           keystone internal http://controller:5000/v2.0

         # openstack --os-token ${AUTH_TOKEN} \
           --os-url=http://127.0.0.1:35357/v3/ \
           --os-domain-name default \
           --os-identity-api-version=3 \
           keystone admin http://controller:35357/v2.0

      .. image:: figures/debconf-screenshots/keystone_7_register_endpoint.png


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
                <IfVersion >= 2.4>
                  ErrorLogFormat "%{cu}t %M"
                </IfVersion>
                ErrorLog /var/log/httpd/keystone-error.log
                CustomLog /var/log/httpd/keystone-access.log combined

                <Directory /usr/bin>
                    <IfVersion >= 2.4>
                        Require all granted
                    </IfVersion>
                    <IfVersion < 2.4>
                        Order allow,deny
                        Allow from all
                    </IfVersion>
                </Directory>
            </VirtualHost>

            <VirtualHost *:35357>
                WSGIDaemonProcess keystone-admin processes=5 threads=1 user=keystone group=keystone display-name=%{GROUP}
                WSGIProcessGroup keystone-admin
                WSGIScriptAlias / /usr/bin/keystone-wsgi-admin
                WSGIApplicationGroup %{GLOBAL}
                WSGIPassAuthorization On
                <IfVersion >= 2.4>
                  ErrorLogFormat "%{cu}t %M"
                </IfVersion>
                ErrorLog /var/log/httpd/keystone-error.log
                CustomLog /var/log/httpd/keystone-access.log combined

                <Directory /usr/bin>
                    <IfVersion >= 2.4>
                        Require all granted
                    </IfVersion>
                    <IfVersion < 2.4>
                        Order allow,deny
                        Allow from all
                    </IfVersion>
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
                <IfVersion >= 2.4>
                  ErrorLogFormat "%{cu}t %M"
                </IfVersion>
                ErrorLog /var/log/apache2/keystone.log
                CustomLog /var/log/apache2/keystone_access.log combined

                <Directory /usr/bin>
                    <IfVersion >= 2.4>
                        Require all granted
                    </IfVersion>
                    <IfVersion < 2.4>
                        Order allow,deny
                        Allow from all
                    </IfVersion>
                </Directory>
            </VirtualHost>

            <VirtualHost *:35357>
                WSGIDaemonProcess keystone-admin processes=5 threads=1 user=keystone group=keystone display-name=%{GROUP}
                WSGIProcessGroup keystone-admin
                WSGIScriptAlias / /usr/bin/keystone-wsgi-admin
                WSGIApplicationGroup %{GLOBAL}
                WSGIPassAuthorization On
                <IfVersion >= 2.4>
                  ErrorLogFormat "%{cu}t %M"
                </IfVersion>
                ErrorLog /var/log/apache2/keystone.log
                CustomLog /var/log/apache2/keystone_access.log combined

                <Directory /usr/bin>
                    <IfVersion >= 2.4>
                        Require all granted
                    </IfVersion>
                    <IfVersion < 2.4>
                        Order allow,deny
                        Allow from all
                    </IfVersion>
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
                <IfVersion >= 2.4>
                  ErrorLogFormat "%{cu}t %M"
                </IfVersion>
                ErrorLog /var/log/apache2/keystone.log
                CustomLog /var/log/apache2/keystone_access.log combined

                <Directory /usr/bin>
                    <IfVersion >= 2.4>
                        Require all granted
                    </IfVersion>
                    <IfVersion < 2.4>
                        Order allow,deny
                        Allow from all
                    </IfVersion>
                </Directory>
            </VirtualHost>

            <VirtualHost *:35357>
                WSGIDaemonProcess keystone-admin processes=5 threads=1 user=keystone group=keystone display-name=%{GROUP}
                WSGIProcessGroup keystone-admin
                WSGIScriptAlias / /usr/bin/keystone-wsgi-admin
                WSGIApplicationGroup %{GLOBAL}
                WSGIPassAuthorization On
                <IfVersion >= 2.4>
                  ErrorLogFormat "%{cu}t %M"
                </IfVersion>
                ErrorLog /var/log/apache2/keystone.log
                CustomLog /var/log/apache2/keystone_access.log combined

                <Directory /usr/bin>
                    <IfVersion >= 2.4>
                        Require all granted
                    </IfVersion>
                    <IfVersion < 2.4>
                        Order allow,deny
                        Allow from all
                    </IfVersion>
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

      #. Activate the Apache module ``mod_version``:

         .. code-block:: console

            # a2enmod version

      #. Start the Apache HTTP service and configure it to start when the system boots:

         .. code-block:: console

            # systemctl enable apache2.service
            # systemctl start apache2.service
