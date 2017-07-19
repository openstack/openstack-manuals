==========================
Highly available Image API
==========================

The OpenStack Image service offers a service for discovering, registering, and
retrieving virtual machine images. To make the OpenStack Image API service
highly available in active/passive mode, you must:

- :ref:`glance-api-pacemaker`
- :ref:`glance-api-configure`
- :ref:`glance-services`

Prerequisites
~~~~~~~~~~~~~

Before beginning, ensure that you are familiar with the
documentation for installing the OpenStack Image API service.
See the *Image service* section in the
`Installation Tutorials and Guides <https://docs.openstack.org/ocata/install/>`_,
depending on your distribution.

.. _glance-api-pacemaker:

Add OpenStack Image API resource to Pacemaker
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Download the resource agent to your system:

   .. code-block:: console

      # cd /usr/lib/ocf/resource.d/openstack
      # wget https://git.openstack.org/cgit/openstack/openstack-resource-agents/plain/ocf/glance-api
      # chmod a+rx *

#. Add the Pacemaker configuration for the OpenStack Image API resource.
   Use the following command to connect to the Pacemaker cluster:

   .. code-block:: console

      crm configure

   .. note::

      The :command:`crm configure` command supports batch input. Copy and paste
      the lines in the next step into your live Pacemaker configuration and
      then make changes as required.

      For example, you may enter ``edit p_ip_glance-api`` from the
      :command:`crm configure` menu and edit the resource to match your
      preferred virtual IP address.

#. Add the following cluster resources:

   .. code-block:: console

      primitive p_glance-api ocf:openstack:glance-api \
        params config="/etc/glance/glance-api.conf" \
        os_password="secretsecret" \
        os_username="admin" os_tenant_name="admin" \
        os_auth_url="http://10.0.0.11:5000/v2.0/" \
        op monitor interval="30s" timeout="30s"

   This configuration creates ``p_glance-api``, a resource for managing the
   OpenStack Image API service.

#. Commit your configuration changes by entering the following command from
   the :command:`crm configure` menu:

   .. code-block:: console

      commit

Pacemaker then starts the OpenStack Image API service and its dependent
resources on one of your nodes.

.. _glance-api-configure:

Configure OpenStack Image service API
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Edit the :file:`/etc/glance/glance-api.conf` file
to configure the OpenStack Image service:

.. code-block:: ini

   # We have to use MySQL connection to store data:
   sql_connection=mysql://glance:password@10.0.0.11/glance
   # Alternatively, you can switch to pymysql,
   # a new Python 3 compatible library and use
   # sql_connection=mysql+pymysql://glance:password@10.0.0.11/glance
   # and be ready when everything moves to Python 3.
   # Ref: https://wiki.openstack.org/wiki/PyMySQL_evaluation

   # We bind OpenStack Image API to the VIP:
   bind_host = 10.0.0.11

   # Connect to OpenStack Image registry service:
   registry_host = 10.0.0.11

   # We send notifications to High Available RabbitMQ:
   notifier_strategy = rabbit
   rabbit_host = 10.0.0.11

[TODO: need more discussion of these parameters]

.. _glance-services:

Configure OpenStack services to use the highly available OpenStack Image API
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Your OpenStack services must now point their OpenStack Image API configuration
to the highly available, virtual cluster IP address instead of pointing to the
physical IP address of an OpenStack Image API server as you would in a non-HA
cluster.

For example, if your OpenStack Image API service IP address is 10.0.0.11
(as in the configuration explained here), you would use the following
configuration in your :file:`nova.conf` file:

.. code-block:: ini

   [glance]
   # ...
   api_servers = 10.0.0.11
   # ...


You must also create the OpenStack Image API endpoint with this IP address.
If you are using both private and public IP addresses, create two virtual IP
addresses and define your endpoint. For example:

.. code-block:: console

   $ openstack endpoint create --region $KEYSTONE_REGION \
     image public http://PUBLIC_VIP:9292

   $ openstack endpoint create --region $KEYSTONE_REGION \
     image admin http://10.0.0.11:9292

   $ openstack endpoint create --region $KEYSTONE_REGION \
     image internal http://10.0.0.11:9292
