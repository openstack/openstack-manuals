Install and configure
~~~~~~~~~~~~~~~~~~~~~

This section describes how to install and configure the dashboard
on the controller node.

The only core service required by the dashboard is the Identity service.
You can use the dashboard in combination with other services, such as
Image service, Compute, and Networking. You can also use the dashboard
in environments with stand-alone services such as Object Storage.

.. note::

   This section assumes proper installation, configuration, and operation
   of the Identity service using the Apache HTTP server and Memcached
   service as described in the :ref:`Install and configure the Identity
   service <keystone-install>` section.

.. toctree::
   :glob:

   horizon-install-*
