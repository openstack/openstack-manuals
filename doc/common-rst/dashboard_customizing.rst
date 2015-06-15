:orphan:

.. highlight:: guess
   :linenothreshold: 5

=======================
Customize the dashboard
=======================

Once you have the dashboard installed you can customize the way it looks
and feels to suit your own needs.

.. note::
   The OpenStack dashboard by default on Ubuntu installs the
   ``openstack-dashboard-ubuntu-theme`` package.

   If you do not want to use this theme you can remove it and its
   dependencies using the following command::

     # apt-get remove --auto-remove openstack-dashboard-ubuntu-theme

.. note::
   This guide focuses on the :file:`local_settings.py` file, stored in
   :file:`/openstack-dashboard/openstack_dashboard/local/`.

This guide is adapted from `How To Custom Brand The OpenStack "Horizon"
Dashboard <http://www.prestonlee.com/2012/05/09/how-to-custom-brand-the-openstack-horizon-dashboard/>`__.

Logo and site colors
~~~~~~~~~~~~~~~~~~~~
#. Create two PNG logo files with transparent backgrounds using
   the following sizes:

   - Login screen: 365 x 50
   - Logged in banner: 216 x 35

#. Upload your new images to
   :file:`/usr/share/openstack-dashboard/openstack_dashboard/static/dashboard/img/`.

#. Create a CSS style sheet in
   :file:`/usr/share/openstack-dashboard/openstack_dashboard/static/dashboard/css/`.

#. Change the colors and image file names as appropriate, though the
   relative directory paths should be the same. The following example file
   shows you how to customize your CSS file::

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

#. Open the following HTML template in an editor of your choice::

     /usr/share/openstack-dashboard/openstack_dashboard/templates/_stylesheets.html

#. Add a line to include your newly created style sheet. For example
   :file:`custom.css`::

     <link href='{{ STATIC_URL }}bootstrap/css/bootstrap.min.css' media='screen' rel='stylesheet' />
     <link href='{{ STATIC_URL }}dashboard/css/{% choose_css %}' media='screen' rel='stylesheet' />
     <link href='{{ STATIC_URL }}dashboard/css/custom.css' media='screen' rel='stylesheet' />

#. Restart Apache:

   On Ubuntu::

     # service apache2 restart

   On Fedora, RHEL, CentOS::

     # service httpd restart

   On openSUSE::

     # service apache2 restart

#. To view your changes reload your dashboard. If necessary go back
   and modify your CSS file as appropriate.

HTML title
~~~~~~~~~~
#. Set the HTML title, which appears at the top of the browser window, by
   adding the following line to :file:`local_settings.py`::

     SITE_BRANDING = "Example, Inc. Cloud"

#. Restart Apache for this change to take effect.

Logo link
~~~~~~~~~
#. The logo also acts as a hyperlink. The default behavior is to redirect
   to ``horizon:user_home``. To change this, add the following attribute to
   :file:`local_settings.py`::

     SITE_BRANDING_LINK = "http://example.com"

#. Restart Apache for this change to take effect.

Help URL
~~~~~~~~
#. By default the help URL points to http://docs.openstack.org. Change this
   by editing the following attribute to the URL of your choice in
   :file:`local_settings.py`::

     'help_url': "http://openstack.mycompany.org"

#. Restart Apache for this change to take effect.
