========================================
Highly available Shared File Systems API
========================================

Making the Shared File Systems (manila) API service highly available
in active/passive mode involves:

- :ref:`ha-sharedfilesystems-configure`
- :ref:`ha-sharedfilesystems-services`
- :ref:`ha-sharedfilesystems-pacemaker`

.. _ha-sharedfilesystems-configure:

Configure Shared File Systems API service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Edit the :file:`/etc/manila/manila.conf` file:

.. code-block:: ini
   :linenos:

   # We have to use MySQL connection to store data:
   sql_connection = mysql+pymysql://manila:password@10.0.0.11/manila?charset=utf8

   # We bind Shared File Systems API to the VIP:
   osapi_volume_listen = 10.0.0.11

   # We send notifications to High Available RabbitMQ:
   notifier_strategy = rabbit
   rabbit_host = 10.0.0.11


.. _ha-sharedfilesystems-services:

Configure OpenStack services to use Shared File Systems API
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Your OpenStack services must now point their Shared File Systems API
configuration to the highly available, virtual cluster IP address rather than
a Shared File Systems API server’s physical IP address as you would
for a non-HA environment.

You must create the Shared File Systems API endpoint with this IP.

If you are using both private and public IP addresses, you should create two
virtual IPs and define your endpoints like this:

.. code-block:: console

   $ openstack endpoint create --region RegionOne \
     sharev2 public 'http://PUBLIC_VIP:8786/v2/%(tenant_id)s'

   $ openstack endpoint create --region RegionOne \
     sharev2 internal 'http://10.0.0.11:8786/v2/%(tenant_id)s'

   $ openstack endpoint create --region RegionOne \
     sharev2 admin 'http://10.0.0.11:8786/v2/%(tenant_id)s'

.. _ha-sharedfilesystems-pacemaker:

Add Shared File Systems API resource to Pacemaker
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Download the resource agent to your system:

   .. code-block:: console

      # cd /usr/lib/ocf/resource.d/openstack
      # wget https://git.openstack.org/cgit/openstack/openstack-resource-agents/plain/ocf/manila-api
      # chmod a+rx *

#. Add the Pacemaker configuration for the Shared File Systems
   API resource. Connect to the Pacemaker cluster with the following
   command:

   .. code-block:: console

      # crm configure

   .. note::

      The :command:`crm configure` supports batch input. Copy and paste
      the lines in the next step into your live Pacemaker configuration and then
      make changes as required.

      For example, you may enter ``edit p_ip_manila-api`` from the
      :command:`crm configure` menu and edit the resource to match your preferred
      virtual IP address.

#. Add the following cluster resources:

   .. code-block:: none

      primitive p_manila-api ocf:openstack:manila-api \
        params config="/etc/manila/manila.conf" \
        os_password="secretsecret" \
        os_username="admin" \
        os_tenant_name="admin" \
        keystone_get_token_url="http://10.0.0.11:5000/v2.0/tokens" \
        op monitor interval="30s" timeout="30s"

   This configuration creates ``p_manila-api``, a resource for managing the
   Shared File Systems API service.

#. Commit your configuration changes by entering the following command
   from the :command:`crm configure` menu:

   .. code-block:: console

      # commit

Pacemaker now starts the Shared File Systems API service and its
dependent resources on one of your nodes.

