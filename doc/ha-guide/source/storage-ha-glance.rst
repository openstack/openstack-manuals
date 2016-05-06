====================================
Highly available OpenStack Image API
====================================

The OpenStack Image service offers a service for discovering,
registering, and retrieving virtual machine images.
To make the OpenStack Image API service highly available
in active / passive mode, you must:

- :ref:`glance-api-pacemaker`
- :ref:`glance-api-configure`
- :ref:`glance-services`

This section assumes that you are familiar with the
`documentation
<http://docs.openstack.org/liberty/install-guide-ubuntu/glance.html>`_
for installing the OpenStack Image API service.

.. _glance-api-pacemaker:

Add OpenStack Image API resource to Pacemaker
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You must first download the resource agent to your system:

.. code-block:: console

   # cd /usr/lib/ocf/resource.d/openstack
   # wget https://git.openstack.org/cgit/openstack/openstack-resource-agents/plain/ocf/glance-api
   # chmod a+rx *

You can now add the Pacemaker configuration
for the OpenStack Image API resource.
Use the :command:`crm configure` command
to connect to the Pacemaker cluster
and add the following cluster resources:

::

   primitive p_glance-api ocf:openstack:glance-api \
      params config="/etc/glance/glance-api.conf" \
      os_password="secretsecret" \
      os_username="admin" os_tenant_name="admin" \
      os_auth_url="http://10.0.0.11:5000/v2.0/" \
      op monitor interval="30s" timeout="30s"

This configuration creates ``p_glance-api``,
a resource for managing the OpenStack Image API service.

The :command:`crm configure` command  supports batch input,
so you may copy and paste the above into your live Pacemaker configuration
and then make changes as required.
For example, you may enter edit ``p_ip_glance-api``
from the :command:`crm configure` menu
and edit the resource to match your preferred virtual IP address.

After completing these steps,
commit your configuration changes by entering :command:`commit`
from the :command:`crm configure` menu.
Pacemaker then starts the OpenStack Image API service
and its dependent resources on one of your nodes.

.. _glance-api-configure:

Configure OpenStack Image service API
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Edit the :file:`/etc/glance/glance-api.conf` file
to configure the OpenStack image service:

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

Configure OpenStack services to use highly available OpenStack Image API
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Your OpenStack services must now point
their OpenStack Image API configuration to the highly available,
virtual cluster IP address
instead of pointint to the physical IP address
of an OpenStack Image API server
as you would in a non-HA cluster.

For OpenStack Compute, for example,
if your OpenStack Image API service IP address is 10.0.0.11
(as in the configuration explained here),
you would use the following configuration in your :file:`nova.conf` file:

.. code-block:: ini

   [glance]
   ...
   api_servers = 10.0.0.11
   ...


You must also create the OpenStack Image API endpoint with this IP address.
If you are using both private and public IP addresses,
you should create two virtual IP addresses
and define your endpoint like this:

.. code-block:: console

   $ keystone endpoint-create --region $KEYSTONE_REGION \
      --service-id $service-id --publicurl 'http://PUBLIC_VIP:9292' \
      --adminurl 'http://10.0.0.11:9292' \
      --internalurl 'http://10.0.0.11:9292'


