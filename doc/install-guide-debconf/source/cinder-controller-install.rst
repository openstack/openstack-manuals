.. _cinder-controller:

Install and configure controller node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section describes how to install and configure the Block
Storage service, code-named cinder, on the controller node. This
service requires at least one additional storage node that provides
volumes to instances.

Install and configure components
--------------------------------

#. Install the packages:

   .. code-block:: console

      # apt-get install cinder-api cinder-scheduler

   Respond to prompts for
   :doc:`database management <debconf/debconf-dbconfig-common>`,
   :doc:`Identity service credentials <debconf/debconf-keystone-authtoken>`,
   :doc:`service endpoint registration <debconf/debconf-api-endpoints>`,
   and :doc:`message broker credentials <debconf/debconf-rabbitmq>`.

#. Edit the ``/etc/cinder/cinder.conf`` file and complete the
   following actions:

   * In the ``[DEFAULT]`` section, configure the ``my_ip`` option to
     use the management interface IP address of the controller node:

     .. code-block:: ini

        [DEFAULT]
        ...
        my_ip = 10.0.0.11

Configure Compute to use Block Storage
--------------------------------------

* Edit the ``/etc/nova/nova.conf`` file and add the following
  to it:

  .. code-block:: ini

     [cinder]
     os_region_name = RegionOne

Finalize installation
---------------------

#. Restart the Compute API service:

   .. code-block:: console

      # service nova-api restart

#. Restart the Block Storage services:

   .. code-block:: console

      # service cinder-scheduler restart
      # service cinder-api restart
