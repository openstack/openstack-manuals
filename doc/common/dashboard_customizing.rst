=======================
Customize the dashboard
=======================

Once you have the dashboard installed you can customize the way it looks
and feels to suit your own needs.

.. note::

   The OpenStack dashboard by default on Ubuntu installs the
   ``openstack-dashboard-ubuntu-theme`` package.

   If you do not want to use this theme you can remove it and its
   dependencies using the following command:

   .. code-block:: console

      # apt-get remove --auto-remove openstack-dashboard-ubuntu-theme

.. note::

   This guide focuses on the ``local_settings.py`` file.

The following can easily be customized:

* Logo
* Site colors
* HTML title
* Logo link
* Help URL

Logo and site colors
~~~~~~~~~~~~~~~~~~~~
#. Create two PNG logo files with transparent backgrounds using
   the following sizes:

   - Login screen: 365 x 50
   - Logged in banner: 216 x 35

#. Upload your new images to
   ``/usr/share/openstack-dashboard/openstack_dashboard/static/dashboard/img/``.

#. Create a CSS style sheet in
   ``/usr/share/openstack-dashboard/openstack_dashboard/static/dashboard/scss/``.

#. Change the colors and image file names as appropriate, though the
   relative directory paths should be the same. The following example file
   shows you how to customize your CSS file:

   .. code-block:: css

      /*
      * New theme colors for dashboard that override the defaults:
      *  dark blue: #355796 / rgb(53, 87, 150)
      *  light blue: #BAD3E1 / rgb(186, 211, 225)
      *
      * By Preston Lee <plee@tgen.org>
      */
      h1.brand {
      background: #355796 repeat-x top left;
      border-bottom: 2px solid #BAD3E1;
      }
      h1.brand a {
      background: url(../img/my_cloud_logo_small.png) top left no-repeat;
      }
      #splash .login {
      background: #355796 url(../img/my_cloud_logo_medium.png) no-repeat center 35px;
      }
      #splash .login .modal-header {
      border-top: 1px solid #BAD3E1;
      }
      .btn-primary {
      background-image: none !important;
      background-color: #355796 !important;
      border: none !important;
      box-shadow: none;
      }
      .btn-primary:hover,
      .btn-primary:active {
      border: none;
      box-shadow: none;
      background-color: #BAD3E1 !important;
      text-decoration: none;
      }

#. Open the following HTML template in an editor of your choice:

   .. code-block:: console

      /usr/share/openstack-dashboard/openstack_dashboard/templates/_stylesheets.html

#. Add a line to include your newly created style sheet. For example,
   ``custom.css`` file:

   .. code-block:: html

      <link href='{{ STATIC_URL }}bootstrap/css/bootstrap.min.css' media='screen' rel='stylesheet' />
      <link href='{{ STATIC_URL }}dashboard/css/{% choose_css %}' media='screen' rel='stylesheet' />
      <link href='{{ STATIC_URL }}dashboard/css/custom.css' media='screen' rel='stylesheet' />

#. Restart the Apache service.

#. To view your changes reload your dashboard. If necessary go back
   and modify your CSS file as appropriate.

HTML title
~~~~~~~~~~
#. Set the HTML title, which appears at the top of the browser window, by
   adding the following line to ``local_settings.py``:

   .. code-block:: python

      SITE_BRANDING = "Example, Inc. Cloud"

#. Restart Apache for this change to take effect.

Logo link
~~~~~~~~~
#. The logo also acts as a hyperlink. The default behavior is to redirect
   to ``horizon:user_home``. To change this, add the following attribute to
   ``local_settings.py``:

   .. code-block:: python

      SITE_BRANDING_LINK = "http://example.com"

#. Restart Apache for this change to take effect.

Help URL
~~~~~~~~
#. By default the help URL points to http://docs.openstack.org. Change this
   by editing the following attribute to the URL of your choice in
   ``local_settings.py``:

   .. code-block:: python

      HORIZON_CONFIG["help_url"] = "http://openstack.mycompany.org"

#. Restart Apache for this change to take effect.
