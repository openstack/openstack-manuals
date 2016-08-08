==========================
Start the Identity service
==========================

In Kilo and newer releases, the Identity service should use the Apache
HTTP Server with the ``mod_wsgi`` module instead of the eventlet library.
Using the proper WSGI configuration, the Apache HTTP Server binds to ports
5000 and 35357 rather than the keystone process.

.. important::

   Eventlet support will be removed in OpenStack Newton.

For more information, see
http://docs.openstack.org/developer/keystone/apache-httpd.html and
https://git.openstack.org/cgit/openstack/keystone/tree/httpd.
