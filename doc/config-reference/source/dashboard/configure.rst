=======================
Configure the dashboard
=======================

You can configure the dashboard for a simple HTTP deployment,
or you can configure the dashboard for a secured HTTPS deployment.
While the standard installation uses a non-encrypted HTTP channel,
you can enable SSL support for the dashboard.

.. note::

   This section uses concrete examples to make it easier to
   understand, but the file path varies by distribution.

Also, you can configure the size of the VNC window in the dashboard.

Configure the dashboard for HTTP
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can configure the dashboard for a simple HTTP deployment.
The standard installation uses a non-encrypted HTTP channel.

#. Specify the host for your Identity service endpoint in the
   ``local_settings.py`` file with the ``OPENSTACK_HOST`` setting.

   The following example shows this setting:

   .. code-block:: python

      import os

      from django.utils.translation import ugettext_lazy as _

      DEBUG = False
      TEMPLATE_DEBUG = DEBUG
      PROD = True
      USE_SSL = False

      SITE_BRANDING = 'OpenStack Dashboard'

      # Ubuntu-specific: Enables an extra panel in the 'Settings' section
      # that easily generates a Juju environments.yaml for download,
      # preconfigured with endpoints and credentials required for bootstrap
      # and service deployment.
      ENABLE_JUJU_PANEL = True

      # Note: You should change this value
      SECRET_KEY = 'elj1IWiLoWHgryYxFT6j7cM5fGOOxWY0'

      # Specify a regular expression to validate user passwords.
      # HORIZON_CONFIG = {
      #     "password_validator": {
      #         "regex": '.*',
      #         "help_text": _("Your password does not meet the requirements.")
      #     }
      # }

      LOCAL_PATH = os.path.dirname(os.path.abspath(__file__))

      CACHES = {
          'default': {
              'BACKEND' : 'django.core.cache.backends.memcached.MemcachedCache',
              'LOCATION' : '127.0.0.1:11211'
          }
      }

      # Send email to the console by default
      EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'
      # Or send them to /dev/null
      #EMAIL_BACKEND = 'django.core.mail.backends.dummy.EmailBackend'

      # Configure these for your outgoing email host
      # EMAIL_HOST = 'smtp.my-company.com'
      # EMAIL_PORT = 25
      # EMAIL_HOST_USER = 'djangomail'
      # EMAIL_HOST_PASSWORD = 'top-secret!'

      # For multiple regions uncomment this configuration, and add (endpoint, title).
      # AVAILABLE_REGIONS = [
      #     ('http://cluster1.example.com:5000/v2.0', 'cluster1'),
      #     ('http://cluster2.example.com:5000/v2.0', 'cluster2'),
      # ]

      OPENSTACK_HOST = "127.0.0.1"
      OPENSTACK_KEYSTONE_URL = "http://%s:5000/v2.0" % OPENSTACK_HOST
      OPENSTACK_KEYSTONE_DEFAULT_ROLE = "Member"

      # The OPENSTACK_KEYSTONE_BACKEND settings can be used to identify the
      # capabilities of the auth backend for Keystone.
      # If Keystone has been configured to use LDAP as the auth backend then set
      # can_edit_user to False and name to 'ldap'.
      #
      # TODO(tres): Remove these once Keystone has an API to identify auth backend.
      OPENSTACK_KEYSTONE_BACKEND = {
          'name': 'native',
          'can_edit_user': True
      }

      # OPENSTACK_ENDPOINT_TYPE specifies the endpoint type to use for the endpoints
      # in the Keystone service catalog. Use this setting when Horizon is running
      # external to the OpenStack environment. The default is 'internalURL'.
      #OPENSTACK_ENDPOINT_TYPE = "publicURL"

      # The number of Swift containers and objects to display on a single page before
      # providing a paging element (a "more" link) to paginate results.
      API_RESULT_LIMIT = 1000

      # If you have external monitoring links, eg:
      # EXTERNAL_MONITORING = [
      #     ['Nagios','http://foo.com'],
      #     ['Ganglia','http://bar.com'],
      # ]

      LOGGING = {
              'version': 1,
              # When set to True this will disable all logging except
              # for loggers specified in this configuration dictionary. Note that
              # if nothing is specified here and disable_existing_loggers is True,
              # django.db.backends will still log unless it is disabled explicitly.
              'disable_existing_loggers': False,
              'handlers': {
                  'null': {
                      'level': 'DEBUG',
                      'class': 'django.utils.log.NullHandler',
                      },
                  'console': {
                      # Set the level to "DEBUG" for verbose output logging.
                      'level': 'INFO',
                      'class': 'logging.StreamHandler',
                      },
                  },
              'loggers': {
                  # Logging from django.db.backends is VERY verbose, send to null
                  # by default.
                  'django.db.backends': {
                      'handlers': ['null'],
                      'propagate': False,
                      },
                  'horizon': {
                      'handlers': ['console'],
                      'propagate': False,
                  },
                  'novaclient': {
                      'handlers': ['console'],
                      'propagate': False,
                  },
                  'keystoneclient': {
                      'handlers': ['console'],
                      'propagate': False,
                  },
                  'nose.plugins.manager': {
                      'handlers': ['console'],
                      'propagate': False,
                  }
              }
      }

   The service catalog configuration in the Identity service determines
   whether a service appears in the dashboard.
   For the full listing, see `Horizon Settings and Configuration
   <http://docs.openstack.org/developer/horizon/topics/settings.html>`_.

#. Restart the Apache HTTP Server.

#. Restart ``memcached``.

Configure the dashboard for HTTPS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You can configure the dashboard for a secured HTTPS deployment.
While the standard installation uses a non-encrypted HTTP channel,
you can enable SSL support for the dashboard.

This example uses the ``http://openstack.example.com`` domain.
Use a domain that fits your current setup.

#. In the ``local_settings.py`` file, update the following options:

   .. code-block:: python

      USE_SSL = True
      CSRF_COOKIE_SECURE = True
      SESSION_COOKIE_SECURE = True
      SESSION_COOKIE_HTTPONLY = True

   To enable HTTPS, the ``USE_SSL = True`` option is required.

   The other options require that HTTPS is enabled;
   these options defend against cross-site scripting.

#. Edit the ``openstack-dashboard.conf`` file as shown in the
   **Example After**:

   **Example Before**

   .. code-block:: apacheconf

      WSGIScriptAlias / /usr/share/openstack-dashboard/openstack_dashboard/wsgi/django.wsgi
      WSGIDaemonProcess horizon user=www-data group=www-data processes=3 threads=10
      Alias /static /usr/share/openstack-dashboard/openstack_dashboard/static/
      <Directory /usr/share/openstack-dashboard/openstack_dashboard/wsgi>
      # For Apache http server 2.2 and earlier:
      Order allow,deny
      Allow from all

      # For Apache http server 2.4 and later:
      # Require all granted
      </Directory>

   **Example After**

   .. code-block:: apacheconf

      <VirtualHost *:80>
      ServerName openstack.example.com
      <IfModule mod_rewrite.c>
      RewriteEngine On
      RewriteCond %{HTTPS} off
      RewriteRule (.*) https://%{HTTP_HOST}%{REQUEST_URI}
      </IfModule>
      <IfModule !mod_rewrite.c>
      RedirectPermanent / https://openstack.example.com
      </IfModule>
      </VirtualHost>
      <VirtualHost *:443>
      ServerName openstack.example.com

      SSLEngine On
      # Remember to replace certificates and keys with valid paths in your environment
      SSLCertificateFile /etc/apache2/SSL/openstack.example.com.crt
      SSLCACertificateFile /etc/apache2/SSL/openstack.example.com.crt
      SSLCertificateKeyFile /etc/apache2/SSL/openstack.example.com.key
      SetEnvIf User-Agent ".*MSIE.*" nokeepalive ssl-unclean-shutdown

      # HTTP Strict Transport Security (HSTS) enforces that all communications
      # with a server go over SSL. This mitigates the threat from attacks such
      # as SSL-Strip which replaces links on the wire, stripping away https prefixes
      # and potentially allowing an attacker to view confidential information on the
      # wire
      Header add Strict-Transport-Security "max-age=15768000"

      WSGIScriptAlias / /usr/share/openstack-dashboard/openstack_dashboard/wsgi/django.wsgi
      WSGIDaemonProcess horizon user=www-data group=www-data processes=3 threads=10
      Alias /static /usr/share/openstack-dashboard/openstack_dashboard/static/
      <Directory /usr/share/openstack-dashboard/openstack_dashboard/wsgi>
      # For Apache http server 2.2 and earlier:
          <ifVersion <2.4>
              Order allow,deny
              Allow from all
          </ifVersion>
      # For Apache http server 2.4 and later:
          <ifVersion >=2.4>
      #The following two lines have been added by bms for error "AH01630: client denied
      #by server configuration:
      #/usr/share/openstack-dashboard/openstack_dashboard/static/dashboard/cssa"
              Options All
              AllowOverride All
              Require all granted
          </ifVersion>
      </Directory>
      <Directory /usr/share/openstack-dashboard/static>
          <ifVersion >=2.4>
              Options All
              AllowOverride All
              Require all granted
          </ifVersion>
      </Directory>
      </VirtualHost>

   In this configuration, the Apache HTTP Server listens on port 443 and
   redirects all non-secure requests to the HTTPS protocol. The secured
   section defines the private key, public key, and certificate to use.

#. Restart the Apache HTTP Server.

#. Restart ``memcached``.

   If you try to access the dashboard through HTTP, the browser redirects
   you to the HTTPS page.

   .. note::

      Configuring the dashboard for HTTPS also requires enabling SSL for
      the noVNC proxy service. On the controller node, add the following
      additional options to the ``[DEFAULT]`` section of the
      ``/etc/nova/nova.conf`` file:

      .. code-block:: ini

         [DEFAULT]
         ...
         ssl_only = true
         cert = /etc/apache2/SSL/openstack.example.com.crt
         key = /etc/apache2/SSL/openstack.example.com.key

      On the compute nodes, ensure the ``nonvncproxy_base_url`` option
      points to a URL with an HTTPS scheme:

      .. code-block:: ini

         [DEFAULT]
         ...
         novncproxy_base_url = https://controller:6080/vnc_auto.html
