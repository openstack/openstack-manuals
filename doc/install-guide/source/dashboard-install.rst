=====================
Install and configure
=====================

This section describes how to install and configure the dashboard
on the controller node.

The dashboard relies on functional core services including
Identity, Image service, Compute, and either Networking (neutron)
or legacy networking (nova-network). Environments with
stand-alone services such as Object Storage cannot use the
dashboard. For more information, see the
`developer documentation <http://docs.openstack.org/developer/
horizon/topics/deployment.html>`__.

This section assumes proper installation, configuration, and
operation of the Identity service using the Apache HTTP server and
Memcached as described in the ":doc:`keystone-install`" section.

To install the dashboard components
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. only:: obs

   * Install the packages:

     .. code-block:: console

        # zypper install openstack-dashboard apache2-mod_wsgi \
          memcached python-python-memcached

.. only:: rdo

   * Install the packages:

     .. code-block:: console

        # yum install openstack-dashboard httpd mod_wsgi \
          memcached python-memcached

.. only:: ubuntu

   * Install the packages:

     .. code-block:: console

        # apt-get install openstack-dashboard

.. only:: debian

   * Install the packages:

     .. code-block:: console

        # apt-get install openstack-dashboard-apache

   * Respond to prompts for web server configuration.

     .. note::

        The automatic configuration process generates a self-signed
        SSL certificate. Consider obtaining an official certificate
        for production environments.

.. only:: ubuntu

   .. note::

      Ubuntu installs the ``openstack-dashboard-ubuntu-theme``
      package as a dependency. Some users reported issues with
      this theme in previous releases. If you encounter issues,
      remove this package to restore the original OpenStack theme.

To configure the dashboard
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. only:: obs

   * Configure the web server:

     .. code-block:: console

        # cp /etc/apache2/conf.d/openstack-dashboard.conf.sample \
          /etc/apache2/conf.d/openstack-dashboard.conf
        # a2enmod rewrite;a2enmod ssl;a2enmod wsgi

.. only:: obs

   * Edit the
     ``/srv/www/openstack-dashboard/openstack_dashboard/local/local_settings.py``
     file and complete the following actions:

.. only:: rdo or ubuntu or debian

   * Edit the
     ``/etc/openstack-dashboard/local_settings.py``
     file and complete the following actions:

* Configure the dashboard to use OpenStack services on the
  ``controller`` node:

  .. code-block:: ini

     OPENSTACK_HOST = "controller"

* Allow all hosts to access the dashboard:

  .. code-block:: ini

     ALLOWED_HOSTS = ['*', ]

* Configure the ``memcached`` session storage service:

  .. code-block:: ini

     CACHES = {
         'default': {
              'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
              'LOCATION': '127.0.0.1:11211',
         }
     }

.. note::

   Comment out any other session storage configuration.

.. only:: obs

   .. note::

      By default, SLES and openSUSE use an SQL database for session
      storage. For simplicity, we recommend changing the configuration
      to use ``memcached`` for session storage.

* Configure ``user`` as the default role for
  users that you create via the dashboard:

  .. code-block:: ini

     OPENSTACK_KEYSTONE_DEFAULT_ROLE = "user"

* Optionally, configure the time zone:

  .. code-block:: ini

     TIME_ZONE = "TIME_ZONE"

  Replace ``TIME_ZONE`` with an appropriate time zone identifier.
  For more information, see the `list of time zones
  <http://en.wikipedia.org/wiki/List_of_tz_database_time_zones>`__.

To finalize installation
~~~~~~~~~~~~~~~~~~~~~~~~

.. only:: rdo

   On RHEL and CentOS, configure SELinux to permit the web server
   to connect to OpenStack services:

   .. code-block:: console

      # setsebool -P httpd_can_network_connect on

.. only:: rdo

   Due to a packaging bug, the dashboard CSS fails to load properly.
   Run the following command to resolve this issue:

   .. code-block:: console

      # chown -R apache:apache /usr/share/openstack-dashboard/static

   For more information, see the `bug report
   <https://bugzilla.redhat.com/show_bug.cgi?id=1150678>`__.

.. only:: ubuntu

   Reload the web server configuration:

   .. code-block:: console

      # service apache2 reload

.. only:: obs

   Start the web server and session storage service and configure
   them to start when the system boots:

   .. code-block:: console

      # systemctl enable apache2.service memcached.service
      # systemctl start apache2.service memcached.service

   .. note::

      Restart the Apache HTTP service if it is already running.

.. only:: rdo

   Start the web server and session storage service and configure
   them to start when the system boots:

   .. code-block:: console

      # systemctl enable httpd.service memcached.service
      # systemctl start httpd.service memcached.service

   .. note::

      Restart the Apache HTTP service if it is already running.
