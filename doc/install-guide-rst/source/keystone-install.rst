=====================
Install and configure
=====================

This section describes how to install and configure the OpenStack
Identity service, code-named keystone, on the controller node. For
performance, this configuration deploys the Apache HTTP server to handle
requests and Memcached to store tokens instead of a SQL database.

|

**To configure prerequisites**

Before you configure the OpenStack Identity service, you must create a
database and an administration token.

#. To create the database, complete these steps:

   a. Use the database access client to connect to the database server as the
      ``root`` user:

      .. code-block:: console

         $ mysql -u root -p

   b. Create the ``keystone`` database:

      .. code-block:: console

         CREATE DATABASE keystone;

   c. Grant proper access to the :file:`keystone` database:

      .. code-block:: console

         GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' \
           IDENTIFIED BY 'KEYSTONE_DBPASS';
         GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' \
           IDENTIFIED BY 'KEYSTONE_DBPASS';

      Replace ``KEYSTONE_DBPASS`` with a suitable password.

   d. Exit the database access client.


#. Generate a random value to use as the administration token during
   initial configuration:

   .. code-block:: console

      $ openssl rand -hex 10

|

.. only:: obs or rdo or ubuntu

   **To install and configure the Identity service components**

   .. note::
      Default configuration files vary by distribution. You might need to
      add these sections and options rather than modifying existing
      sections and options. Also, an ellipsis (...) in the configuration
      snippets indicates potential default configuration options that you
      should retain.

   .. note::
      In Kilo, the keystone project deprecates Eventlet in favor of a WSGI
      server. This guide uses the Apache HTTP server with ``mod_wsgi`` to
      serve keystone requests on ports 5000 and 35357. By default, the
      keystone service still listens on ports 5000 and 35357. Therefore,
      this guide disables the keystone service.

.. only:: ubuntu

   #. Disable the keystone service from starting automatically after
      installation:

      .. code-block:: console

         # echo "manual" > /etc/init/keystone.override

   #. Run the following command to install the packages:

      .. only:: ubuntu

         .. code-block:: console

            # apt-get install keystone python-openstackclient apache2 libapache2-mod-wsgi memcached python-memcache

.. only:: obs or rdo

   #. Run the following command to install the packages:

      .. only:: rdo

         .. code-block:: console

            # yum install openstack-keystone httpd mod_wsgi python-openstackclient memcached python-memcached

      .. only:: obs

         .. code-block:: console

            # zypper install openstack-keystone python-openstackclient apache2-mod_wsgi memcached python-python-memcached

.. only:: obs or rdo

   2. Start the Memcached service and configure it to start when the system
      boots:

      .. code-block:: console

         # systemctl enable memcached.service
         # systemctl start memcached.service

.. only:: obs or rdo or ubuntu

   3. Edit the :file:`/etc/keystone/keystone.conf` file and complete the following
      actions:

      a. In the ``[DEFAULT]`` section, define the value of the initial
         administration token:

         .. code-block:: ini
            :linenos:

            [DEFAULT]
            ...
            admin_token = ADMIN_TOKEN

         Replace ``ADMIN_TOKEN`` with the random value that you generated in a
         previous step.

      b. In the ``[database]`` section, configure database access:

         .. code-block:: ini
            :linenos:

            [database]
            ...
            connection = mysql://keystone:KEYSTONE_DBPASS@controller/keystone

         Replace ``KEYSTONE_DBPASS`` with the password you chose for the database.

      c. In the ``[memcache]`` section, configure the Memcache service:

         .. code-block:: ini
            :linenos:

            [memcache]
            ...
            servers = localhost:11211

      d. In the ``[token]`` section, configure the UUID token provider and
         Memcached driver:

         .. code-block:: ini
            :linenos:

            [token]
            ...
            provider = keystone.token.providers.uuid.Provider
            driver = keystone.token.persistence.backends.memcache.Token

      e. In the ``[revoke]`` section, configure the SQL revocation driver:

         .. code-block:: ini
            :linenos:

            [revoke]
            ...
            driver = keystone.contrib.revoke.backends.sql.Revoke

      f. (Optional) To assist with troubleshooting, enable verbose logging in the
         ``[DEFAULT]`` section:

         .. code-block:: ini
            :linenos:

            [DEFAULT]
            ...
            verbose = True

.. only:: obs or rdo or ubuntu

   4. Populate the Identity service database:

      .. code-block:: console

         # su -s /bin/sh -c "keystone-manage db_sync" keystone

.. only:: debian

   **To install and configure the components**

   #. Run the following command to install the packages:

      .. code-block:: console

         # apt-get install keystone

      .. note::

         python-keystoneclient will automatically be installed as it is a
         dependency of the keystone package.

   #. Respond to prompts for :doc:`debconf/debconf-dbconfig-common`,
      which will fill the below database access directive.

      .. code-block:: ini
         :linenos:

         [database]
         ...
         connection = mysql://keystone:KEYSTONE_DBPASS@controller/keystone

      If you decide to not use ``dbconfig-common``, then you will have to
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
         :linenos:

         [DEFAULT]
         ...
         admin_token = ADMIN_TOKEN

   #. Create the ``admin`` tenant and user:

      During the final stage of the package installation, it is possible to
      automatically create an admin tenant and an admin user. This can later
      be used for other OpenStack services to contact the Identity service.
      This is the equivalent of running the below commands:

      .. code-block:: console

         # openstack project create --description "Admin Tenant" admin
         # openstack user create --password ADMIN_PASS --email root@localhost admin
         # openstack role create admin
         # openstack role add --project demo --user demo user

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

         # openstack service create --name keystone --description "OpenStack Identity"  identity
         # keystone endpoint-create \
           --publicurl http://controller:5000/v2.0 \
           --internalurl http://controller:5000/v2.0 \
           --adminurl http://controller:35357/v2.0 \
           --region RegionOne \
           identity

      .. image:: figures/debconf-screenshots/keystone_7_register_endpoint.png


.. only:: obs or rdo or ubuntu

   **To configure the Apache HTTP server**

.. only:: rdo

   #. Edit the :file:`/etc/httpd/conf/httpd.conf` file and configure the
      ``ServerName`` option to reference the controller node:

      .. code-block:: apache
         :linenos:

         ServerName controller

   #. Create the :file:`/etc/httpd/conf.d/wsgi-keystone.conf` file with
      the following content:

      .. code-block:: apache
         :linenos:

         Listen 5000
         Listen 35357

         <VirtualHost *:5000>
             WSGIDaemonProcess keystone-public processes=5 threads=1 user=keystone group=keystone display-name=%{GROUP}
             WSGIProcessGroup keystone-public
             WSGIScriptAlias / /var/www/cgi-bin/keystone/main
             WSGIApplicationGroup %{GLOBAL}
             WSGIPassAuthorization On
             LogLevel info
             ErrorLogFormat "%{cu}t %M"
             ErrorLog /var/log/httpd/keystone-error.log
             CustomLog /var/log/httpd/keystone-access.log combined
         </VirtualHost>

         <VirtualHost *:35357>
             WSGIDaemonProcess keystone-admin processes=5 threads=1 user=keystone group=keystone display-name=%{GROUP}
             WSGIProcessGroup keystone-admin
             WSGIScriptAlias / /var/www/cgi-bin/keystone/admin
             WSGIApplicationGroup %{GLOBAL}
             WSGIPassAuthorization On
             LogLevel info
             ErrorLogFormat "%{cu}t %M"
             ErrorLog /var/log/httpd/keystone-error.log
             CustomLog /var/log/httpd/keystone-access.log combined
         </VirtualHost>

.. only:: ubuntu

   #. Edit the :file:`/etc/apache2/apache2.conf` file and configure the
      ``ServerName`` option to reference the controller node:

      .. code-block:: apache
         :linenos:

         ServerName controller

   #. Create the :file:`/etc/apache2/sites-available/wsgi-keystone.conf` file
      with the following content:

      .. code-block:: apache
         :linenos:

         Listen 5000
         Listen 35357

         <VirtualHost *:5000>
             WSGIDaemonProcess keystone-public processes=5 threads=1 user=keystone display-name=%{GROUP}
             WSGIProcessGroup keystone-public
             WSGIScriptAlias / /var/www/cgi-bin/keystone/main
             WSGIApplicationGroup %{GLOBAL}
             WSGIPassAuthorization On
             <IfVersion >= 2.4>
               ErrorLogFormat "%{cu}t %M"
             </IfVersion>
             LogLevel info
             ErrorLog /var/log/apache2/keystone-error.log
             CustomLog /var/log/apache2/keystone-access.log combined
         </VirtualHost>

         <VirtualHost *:35357>
             WSGIDaemonProcess keystone-admin processes=5 threads=1 user=keystone display-name=%{GROUP}
             WSGIProcessGroup keystone-admin
             WSGIScriptAlias / /var/www/cgi-bin/keystone/admin
             WSGIApplicationGroup %{GLOBAL}
             WSGIPassAuthorization On
             <IfVersion >= 2.4>
               ErrorLogFormat "%{cu}t %M"
             </IfVersion>
             LogLevel info
             ErrorLog /var/log/apache2/keystone-error.log
             CustomLog /var/log/apache2/keystone-access.log combined
         </VirtualHost>

   #. Enable the Identity service virtual hosts:

      .. code-block:: console

         # ln -s /etc/apache2/sites-available/wsgi-keystone.conf /etc/apache2/sites-enabled

.. only:: obs

   #. Edit the :file:`/etc/sysconfig/apache2` file and configure the
      APACHE_SERVERNAME`` option to reference the controller node:

      .. code-block:: apache
         :linenos:

         APACHE_SERVERNAME="controller"

   #. Create the :file:`/etc/apache2/conf.d/wsgi-keystone.conf` file
      with the following content:

      .. code-block:: apache
         :linenos:

         Listen 5000
         Listen 35357

         <VirtualHost *:5000>
             WSGIDaemonProcess keystone-public processes=5 threads=1 user=keystone display-name=%{GROUP}
             WSGIProcessGroup keystone-public
             WSGIScriptAlias / /srv/www/cgi-bin/keystone/main
             WSGIApplicationGroup %{GLOBAL}
             WSGIPassAuthorization On
             ErrorLogFormat "%{cu}t %M"
             LogLevel info
             ErrorLog /var/log/apache2/keystone-error.log
             CustomLog /var/log/apache2/keystone-access.log combined
          </VirtualHost>

          <VirtualHost *:35357>
              WSGIDaemonProcess keystone-admin processes=5 threads=1 user=keystone display-name=%{GROUP}
              WSGIProcessGroup keystone-admin
              WSGIScriptAlias / /srv/www/cgi-bin/keystone/admin
              WSGIApplicationGroup %{GLOBAL}
              WSGIPassAuthorization On
              ErrorLogFormat "%{cu}t %M"
              LogLevel info
              ErrorLog /var/log/apache2/keystone-error.log
              CustomLog /var/log/apache2/keystone-access.log combined
          </VirtualHost>

.. only:: ubuntu

   4. Create the directory structure for the WSGI components:

      .. code-block:: console

         # mkdir -p /var/www/cgi-bin/keystone


   5. Copy the WSGI components from the upstream repository into this
      directory:

      .. code-block:: console

         # curl http://git.openstack.org/cgit/openstack/keystone/plain/httpd/keystone.py?h=stable/kilo \
           | tee /var/www/cgi-bin/keystone/main /var/www/cgi-bin/keystone/admin

   6. Adjust ownership and permissions on this directory and the files in it:

      .. code-block:: console

         # chown -R keystone:keystone /var/www/cgi-bin/keystone
         # chmod 755 /var/www/cgi-bin/keystone/*

.. only:: obs or rdo

   3. Create the directory structure for the WSGI components:

      .. only:: rdo

         .. code-block:: console

            # mkdir -p /var/www/cgi-bin/keystone

      .. only:: obs

         .. code-block:: console

            # mkdir -p /srv/www/cgi-bin/keystone

   4. Copy the WSGI components from the upstream repository into this
      directory:

      .. only:: rdo

         .. code-block:: console

            # curl http://git.openstack.org/cgit/openstack/keystone/plain/httpd/keystone.py?h=stable/kilo \
              | tee /var/www/cgi-bin/keystone/main /var/www/cgi-bin/keystone/admin

      .. only:: obs

         .. code-block:: console

            # curl http://git.openstack.org/cgit/openstack/keystone/plain/httpd/keystone.py?h=stable/kilo \
              | tee /srv/www/cgi-bin/keystone/main /srv/www/cgi-bin/keystone/admin

.. only:: obs or rdo

   5. Adjust ownership and permissions on this directory and the files in it:

      .. only:: rdo

         .. code-block:: console

            # chown -R keystone:keystone /var/www/cgi-bin/keystone
            # chmod 755 /var/www/cgi-bin/keystone/*

      .. only:: obs

         .. code-block:: console

            # chown -R keystone:keystone /srv/www/cgi-bin/keystone
            # chmod 755 /srv/www/cgi-bin/keystone/*

.. only:: obs

   6. Change the ownership of :file:`/etc/keystone/keystone.conf` to give the
      ``keystone`` system access to it:

      .. code-block:: console

         # chown keystone /etc/keystone/keystone.conf

|

**To finalize the installation**

.. only:: ubuntu

   #. Restart the Apache HTTP server:

      .. code-block:: console

         # service apache2 restart

   #. By default, the Ubuntu packages create a SQLite database.

      Because this configuration uses a SQL database server, you can remove
      the SQLite database file:

      .. code-block:: console

         # rm -f /var/lib/keystone/keystone.db

.. only:: rdo

   * Restart the Apache HTTP server:

     .. code-block:: console

        # systemctl enable httpd.service
        # systemctl start httpd.service

.. only:: obs

   #. Restart the Apache HTTP server:

      .. code-block:: console

         # systemctl enable apache2.service
         # systemctl start apache2.service

   #. By default, the Identity service stores expired tokens in the SQL
      database indefinitely. The accumulation of expired tokens considerably
      increases the database size and degrades performance over time,
      particularly in environments with limited resources.

      The packages already contain a cron job under
      :file:`/etc/cron.hourly/keystone`, so it is not necessary to manually
      configure a periodic task that purges expired tokens.

.. only:: debian

   * By default, the Identity service stores expired tokens in the SQL
     database indefinitely. The accumulation of expired tokens considerably
     increases the database size and degrades performance over time,
     particularly in environments with limited resources.

     The packages already contain a cron job under
     :file:`/etc/cron.hourly/keystone`, so it is not necessary to manually
     configure a periodic task that purges expired tokens.
