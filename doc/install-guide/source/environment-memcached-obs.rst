Memcached for SUSE
~~~~~~~~~~~~~~~~~~

The Identity service authentication mechanism for services uses Memcached
to cache tokens. The memcached service typically runs on the controller
node. For production deployments, we recommend enabling a combination of
firewalling, authentication, and encryption to secure it.

Install and configure components
--------------------------------

#. Install the packages:

   .. code-block:: console

      # zypper install memcached python-python-memcached

   .. end

2. Edit the ``/etc/sysconfig/memcached`` file and complete the
   following actions:

   * Configure the service to use the management IP address of the
     controller node. This is to enable access by other nodes via
     the management network:

     .. code-block:: none

        MEMCACHED_PARAMS="-l 127.0.0.1"

     .. end

     .. note::

        Change the existing line ``MEMCACHED_PARAMS="-l 127.0.0.1,::1"``.

Finalize installation
---------------------

* Start the Memcached service and configure it to start when the system
  boots:

  .. code-block:: console

     # systemctl enable memcached.service
     # systemctl start memcached.service

  .. end
