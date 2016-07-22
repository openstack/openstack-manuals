Install and configure compute node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The compute node handles connectivity and :term:`security groups <security
group>` for instances.

.. only:: ubuntu or rdo or obs

Install the components
----------------------

.. only:: ubuntu or debian

   .. code-block:: console

      # apt-get install neutron-linuxbridge-agent

.. only:: rdo

   .. todo:

      https://bugzilla.redhat.com/show_bug.cgi?id=1334626

   .. code-block:: console

      # yum install openstack-neutron-linuxbridge ebtables ipset

.. only:: obs

   .. code-block:: console

      # zypper install --no-recommends openstack-neutron-linuxbridge-agent

Configure the common component
------------------------------

The Networking common component configuration includes the
authentication mechanism, message queue, and plug-in.

.. include:: shared/note_configuration_vary_by_distribution.rst

* Edit the ``/etc/neutron/neutron.conf`` file and complete the following
  actions:

  * In the ``[database]`` section, comment out any ``connection`` options
    because compute nodes do not directly access the database.

  * In the ``[DEFAULT]`` and ``[oslo_messaging_rabbit]`` sections, configure
    RabbitMQ message queue access:

    .. code-block:: ini

       [DEFAULT]
       ...
       rpc_backend = rabbit

       [oslo_messaging_rabbit]
       ...
       rabbit_host = controller
       rabbit_userid = openstack
       rabbit_password = RABBIT_PASS

    Replace ``RABBIT_PASS`` with the password you chose for the ``openstack``
    account in RabbitMQ.

  * In the ``[DEFAULT]`` and ``[keystone_authtoken]`` sections, configure
    Identity service access:

    .. code-block:: ini

       [DEFAULT]
       ...
       auth_strategy = keystone

       [keystone_authtoken]
       ...
       auth_uri = http://controller:5000
       auth_url = http://controller:35357
       memcached_servers = controller:11211
       auth_type = password
       project_domain_name = default
       user_domain_name = default
       project_name = service
       username = neutron
       password = NEUTRON_PASS

    Replace ``NEUTRON_PASS`` with the password you chose for the ``neutron``
    user in the Identity service.

    .. note::

       Comment out or remove any other options in the
       ``[keystone_authtoken]`` section.

  .. only:: rdo

     * In the ``[oslo_concurrency]`` section, configure the lock path:

       .. code-block:: ini

          [oslo_concurrency]
          ...
          lock_path = /var/lib/neutron/tmp

Configure networking options
----------------------------

Choose the same networking option that you chose for the controller node to
configure services specific to it. Afterwards, return here and proceed to
:ref:`neutron-compute-compute`.

.. toctree::
   :maxdepth: 1

   neutron-compute-install-option1.rst
   neutron-compute-install-option2.rst

.. _neutron-compute-compute:

Configure Compute to use Networking
-----------------------------------

* Edit the ``/etc/nova/nova.conf`` file and complete the following actions:

  * In the ``[neutron]`` section, configure access parameters:

    .. code-block:: ini

       [neutron]
       ...
       url = http://controller:9696
       auth_url = http://controller:35357
       auth_type = password
       project_domain_name = default
       user_domain_name = default
       region_name = RegionOne
       project_name = service
       username = neutron
       password = NEUTRON_PASS

    Replace ``NEUTRON_PASS`` with the password you chose for the ``neutron``
    user in the Identity service.

Finalize installation
---------------------

.. only:: rdo

   #. Restart the Compute service:

      .. code-block:: console

         # systemctl restart openstack-nova-compute.service

   #. Start the Linux bridge agent and configure it to start when the
      system boots:

      .. code-block:: console

         # systemctl enable neutron-linuxbridge-agent.service
         # systemctl start neutron-linuxbridge-agent.service

.. only:: obs

   #. The Networking service initialization scripts expect the variable
      ``NEUTRON_PLUGIN_CONF`` in the ``/etc/sysconfig/neutron`` file to
      reference the ML2 plug-in configuration file. Ensure that the
      ``/etc/sysconfig/neutron`` file contains the following:

      .. code-block:: ini

         NEUTRON_PLUGIN_CONF="/etc/neutron/plugins/ml2/ml2_conf.ini"

   #. Restart the Compute service:

      .. code-block:: console

         # systemctl restart openstack-nova-compute.service

   #. Start the Linux Bridge agent and configure it to start when the
      system boots:

      .. code-block:: console

         # systemctl enable openstack-neutron-linuxbridge-agent.service
         # systemctl start openstack-neutron-linuxbridge-agent.service

.. only:: ubuntu or debian

   #. Restart the Compute service:

      .. code-block:: console

         # service nova-compute restart

   #. Restart the Linux bridge agent:

      .. code-block:: console

         # service neutron-linuxbridge-agent restart
