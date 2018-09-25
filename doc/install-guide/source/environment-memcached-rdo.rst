Memcached for RHEL and CentOS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Identity service authentication mechanism for services uses Memcached
to cache tokens. The memcached service typically runs on the controller
node. For production deployments, we recommend enabling a combination of
firewalling, authentication, and encryption to secure it.

Install and configure components
--------------------------------

#. Install the packages:

   .. code-block:: console

      # yum install memcached python-memcached

2. Edit the ``/etc/sysconfig/memcached`` file and complete the
   following actions:

   * Configure the service to use the management IP address of the
     controller node. This is to enable access by other nodes via
     the management network:

     .. code-block:: none

        OPTIONS="-l 127.0.0.1,::1,controller"

     .. note::

        Change the existing line ``OPTIONS="-l 127.0.0.1,::1"``.

Finalize installation
---------------------

* Start the Memcached service and configure it to start when the system
  boots:

  .. code-block:: console

     # systemctl enable memcached.service
     # systemctl start memcached.service
