Memcached
~~~~~~~~~

The Identity service authentication mechanism for services uses Memcached
to cache tokens. The memcached service typically runs on the controller
node. For production deployments, we recommend enabling a combination of
firewalling, authentication, and encryption to secure it.

Install and configure components
--------------------------------

#. Install the packages:

   .. only:: ubuntu or debian

      .. code-block:: console

         # apt install memcached python-memcache

      .. end

   .. endonly

   .. only:: rdo

      .. code-block:: console

         # yum install memcached python-memcached

      .. end

   .. endonly

   .. only:: obs

      .. code-block:: console

         # zypper install memcached python-python-memcached

      .. end

   .. endonly

.. only:: ubuntu or debian

   2. Edit the ``/etc/memcached.conf`` file and configure the
      service to use the management IP address of the controller node.
      This is to enable access by other nodes via the management network:

      .. code-block:: ini

         -l 10.0.0.11

      .. end

      .. note::

         Change the existing line that had ``-l 127.0.0.1``.

.. endonly

.. only:: rdo

   2. Edit the ``/etc/sysconfig/memcached`` file and configure the
      service to use the management IP address of the controller node.
      This is to enable access by other nodes via the management network:

      .. code-block:: none

         10.0.0.11

      .. end

      .. note::

         Change the existing line from ``127.0.0.1``.

.. endonly

Finalize installation
---------------------

.. only:: ubuntu or debian

   * Restart the Memcached service:

     .. code-block:: console

        # service memcached restart

     .. end

.. endonly

.. only:: rdo or obs

   * Start the Memcached service and configure it to start when the system
     boots:

     .. code-block:: console

        # systemctl enable memcached.service
        # systemctl start memcached.service

     .. end

.. endonly
