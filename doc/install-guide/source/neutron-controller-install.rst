Install and configure controller node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. only:: obs or rdo or ubuntu

   Prerequisites
   -------------

   Before you configure the OpenStack Networking (neutron) service, you
   must create a database, service credentials, and API endpoints.

   #. To create the database, complete these steps:

      * Use the database access client to connect to the database server as the
        ``root`` user:

        .. code-block:: console

           $ mysql -u root -p

      * Create the ``neutron`` database:

        .. code-block:: console

           CREATE DATABASE neutron;

      * Grant proper access to the ``neutron`` database, replacing
        ``NEUTRON_DBPASS`` with a suitable password:

        .. code-block:: console

           GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'localhost' \
             IDENTIFIED BY 'NEUTRON_DBPASS';
           GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'%' \
             IDENTIFIED BY 'NEUTRON_DBPASS';

      * Exit the database access client.

   #. Source the ``admin`` credentials to gain access to admin-only CLI
      commands:

      .. code-block:: console

         $ source admin-openrc.sh

   #. To create the service credentials, complete these steps:

      * Create the ``neutron`` user:

        .. code-block:: console

           $ openstack user create --domain default --password-prompt neutron
           User Password:
           Repeat User Password:
           +-----------+----------------------------------+
           | Field     | Value                            |
           +-----------+----------------------------------+
           | domain_id | default                          |
           | enabled   | True                             |
           | id        | b20a6692f77b4258926881bf831eb683 |
           | name      | neutron                          |
           +-----------+----------------------------------+


      * Add the ``admin`` role to the ``neutron`` user:

        .. code-block:: console

           $ openstack role add --project service --user neutron admin

        .. note::

           This command provides no output.

      * Create the ``neutron`` service entity:

        .. code-block:: console

           $ openstack service create --name neutron \
             --description "OpenStack Networking" network
           +-------------+----------------------------------+
           | Field       | Value                            |
           +-------------+----------------------------------+
           | description | OpenStack Networking             |
           | enabled     | True                             |
           | id          | f71529314dab4a4d8eca427e701d209e |
           | name        | neutron                          |
           | type        | network                          |
           +-------------+----------------------------------+

   #. Create the Networking service API endpoints:

      .. code-block:: console

         $ openstack endpoint create --region RegionOne \
           network public http://controller:9696
         +--------------+----------------------------------+
         | Field        | Value                            |
         +--------------+----------------------------------+
         | enabled      | True                             |
         | id           | 85d80a6d02fc4b7683f611d7fc1493a3 |
         | interface    | public                           |
         | region       | RegionOne                        |
         | region_id    | RegionOne                        |
         | service_id   | f71529314dab4a4d8eca427e701d209e |
         | service_name | neutron                          |
         | service_type | network                          |
         | url          | http://controller:9696           |
         +--------------+----------------------------------+

         $ openstack endpoint create --region RegionOne \
           network internal http://controller:9696
         +--------------+----------------------------------+
         | Field        | Value                            |
         +--------------+----------------------------------+
         | enabled      | True                             |
         | id           | 09753b537ac74422a68d2d791cf3714f |
         | interface    | internal                         |
         | region       | RegionOne                        |
         | region_id    | RegionOne                        |
         | service_id   | f71529314dab4a4d8eca427e701d209e |
         | service_name | neutron                          |
         | service_type | network                          |
         | url          | http://controller:9696           |
         +--------------+----------------------------------+

         $ openstack endpoint create --region RegionOne \
           network admin http://controller:9696
         +--------------+----------------------------------+
         | Field        | Value                            |
         +--------------+----------------------------------+
         | enabled      | True                             |
         | id           | 1ee14289c9374dffb5db92a5c112fc4e |
         | interface    | admin                            |
         | region       | RegionOne                        |
         | region_id    | RegionOne                        |
         | service_id   | f71529314dab4a4d8eca427e701d209e |
         | service_name | neutron                          |
         | service_type | network                          |
         | url          | http://controller:9696           |
         +--------------+----------------------------------+

Configure networking options
----------------------------

Choose one of the following networking options to configure services
specific to it.

.. note::

   Option 2 augments option 1 with the layer-3 (routing) service and
   enables self-service (private) networks. If you want to use public
   (provider) and private (self-service) networks, choose option 2.

Complete the procedure for your selected networking option by clicking
one of the following links. After finishing that procedure, you will
be directed back to this page to proceed with configuring the metadata
agent.

.. toctree::
   :maxdepth: 1

   neutron-controller-install-option1.rst
   neutron-controller-install-option2.rst

.. _neutron-controller-metadata-agent:

Configure the metadata agent
----------------------------

The :term:`metadata agent <Metadata agent>` provides configuration information
such as credentials to instances.

* Edit the ``/etc/neutron/metadata_agent.ini`` file and complete the following
  actions:

  * In the ``[DEFAULT]`` section, configure access parameters:

    .. code-block:: ini

       [DEFAULT]
       ...
       auth_uri = http://controller:5000
       auth_url = http://controller:35357
       auth_region = RegionOne
       auth_plugin = password
       project_domain_id = default
       user_domain_id = default
       project_name = service
       username = neutron
       password = NEUTRON_PASS

    Replace ``NEUTRON_PASS`` with the password you chose for the ``neutron``
    user in the Identity service.

  * In the ``[DEFAULT]`` section, configure the metadata host:

    .. code-block:: ini

       [DEFAULT]
       ...
       nova_metadata_ip = controller

  * In the ``[DEFAULT]`` section, configure the metadata proxy shared
    secret:

    .. code-block:: ini

       [DEFAULT]
       ...
       metadata_proxy_shared_secret = METADATA_SECRET

    Replace ``METADATA_SECRET`` with a suitable secret for the metadata proxy.

  * (Optional) To assist with troubleshooting, enable verbose logging in the
    ``[DEFAULT]`` section:

    .. code-block:: ini

       [DEFAULT]
       ...
       verbose = True

Configure Compute to use Networking
-----------------------------------

* Edit the ``/etc/nova/nova.conf`` file and perform the following actions:

  * In the ``[neutron]`` section, configure access parameters, enable the
    metadata proxy, and configure the secret:

    .. code-block:: ini

       [neutron]
       ...
       url = http://controller:9696
       auth_url = http://controller:35357
       auth_plugin = password
       project_domain_id = default
       user_domain_id = default
       region_name = RegionOne
       project_name = service
       username = neutron
       password = NEUTRON_PASS

       service_metadata_proxy = True
       metadata_proxy_shared_secret = METADATA_SECRET

    Replace ``NEUTRON_PASS`` with the password you chose for the ``neutron``
    user in the Identity service.

    Replace ``METADATA_SECRET`` with the secret you chose for the metadata
    proxy.

Finalize installation
---------------------

.. only:: rdo

   #. The Networking service initialization scripts expect a symbolic link
      ``/etc/neutron/plugin.ini`` pointing to the ML2 plug-in configuration
      file, ``/etc/neutron/plugins/ml2/ml2_conf.ini``. If this symbolic
      link does not exist, create it using the following command:

      .. code-block:: console

         # ln -s /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugin.ini

   #. Populate the database:

      .. code-block:: console

         # su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf \
           --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade head" neutron

      .. note::

         Database population occurs later for Networking because the script
         requires complete server and plug-in configuration files.

   #. Restart the Compute API service:

      .. code-block:: console

         # systemctl restart openstack-nova-api.service

   #. Start the Networking services and configure them to start when the system
      boots.

      For both networking options:

      .. code-block:: console

         # systemctl enable neutron-server.service \
           neutron-linuxbridge-agent.service neutron-dhcp-agent.service \
           neutron-metadata-agent.service
         # systemctl start neutron-server.service \
           neutron-linuxbridge-agent.service neutron-dhcp-agent.service \
           neutron-metadata-agent.service

      For networking option 2, also enable and start the layer-3 service:

      .. code-block:: console

         # systemctl enable neutron-l3-agent.service
         # systemctl start neutron-l3-agent.service

.. only:: obs

   #. The Networking service initialization scripts expect the variable
      ``NEUTRON_PLUGIN_CONF`` in the ``/etc/sysconfig/neutron`` file to
      reference the ML2 plug-in configuration file. Edit the
      ``/etc/sysconfig/neutron`` file and add the following:

      .. code-block:: console

         NEUTRON_PLUGIN_CONF="/etc/neutron/plugins/ml2/ml2_conf.ini"

   #. Restart the Compute API service:

      .. code-block:: console

         # systemctl restart openstack-nova-api.service

   #. Start the Networking services and configure them to start when the system
      boots.

      For both networking options:

      .. code-block:: console

         # systemctl enable openstack-neutron.service \
           openstack-neutron-linuxbridge-agent.service \
           openstack-neutron-dhcp-agent.service \
           openstack-neutron-metadata-agent.service
         # systemctl start openstack-neutron.service \
           openstack-neutron-linuxbridge-agent.service \
           openstack-neutron-dhcp-agent.service \
           openstack-neutron-metadata-agent.service

      For networking option 2, also enable and start the layer-3 service:

      .. code-block:: console

         # systemctl enable openstack-neutron-l3-agent.service
         # systemctl start openstack-neutron-l3-agent.service

.. only:: ubuntu

   #. Populate the database:

      .. code-block:: console

         # su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf \
           --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade head" neutron

      .. note::

         Database population occurs later for Networking because the script
         requires complete server and plug-in configuration files.

   #. Restart the Compute API service:

      .. code-block:: console

         # service nova-api restart

   #. Restart the Networking services.

      For both networking options:

      .. code-block:: console

         # service neutron-server restart
         # service neutron-plugin-linuxbridge-agent restart
         # service neutron-dhcp-agent restart
         # service neutron-metadata-agent restart

      For networking option 2, also restart the layer-3 service:

      .. code-block:: console

         # service neutron-l3-agent restart

.. only:: ubuntu

   4. By default, the Ubuntu packages create an SQLite database.

      Because this configuration uses an SQL database server,
      you can remove the SQLite database file:

      .. code-block:: console

         # rm -f /var/lib/neutron/neutron.sqlite
