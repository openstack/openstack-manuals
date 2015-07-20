==========
Next steps
==========

Your OpenStack environment now includes the dashboard. You can
:doc:`launch an instance <launch-instance>` or add
more services to your environment in the following chapters.

After you install and configure the dashboard, you can
complete the following tasks:

* Provide users with a public IP address, a username, and a password
  so they can access the dashboard through a web browser. In case of
  any SSL certificate connection problems, point the server
  IP address to a domain name, and give users access.

* Customize your dashboard. See section
  `Customize the dashboad <http://docs.openstack.org/admin-guide-cloud/
  content/ch_install-dashboard.html#dashboard-custom-brand>`__
  in the `OpenStack Cloud Administrator Guide
  <http://docs.openstack.org/admin-guide-cloud/content/>`__
  for information on setting up colors, logos, and site titles.

* Set up session storage. See section
  `Set up session storage for the dashboard
  <http://docs.openstack.org/admin-guide-cloud/content/
  dashboard-sessions.html#dashboard-sessions>`__
  in the `OpenStack Cloud Administrator Guide
  <http://docs.openstack.org/admin-guide-cloud/content>`__
  for information on user session data.

* To use the VNC client with the dashboard, the browser
  must support HTML5 Canvas and HTML5 WebSockets.

  For details about browsers that support noVNC, see
  `README
  <https://github.com/kanaka/noVNC/blob/master/README.md>`__
  and `browser support
  <https://github.com/kanaka/noVNC/wiki/Browser-support>`__.
