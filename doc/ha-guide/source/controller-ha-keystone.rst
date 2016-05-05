
============================
Identity services (keystone)
============================

OpenStack Identity (keystone)
is the Identity service in OpenStack that is used by many services.
You should be familiar with
`OpenStack identity concepts
<http://docs.openstack.org/liberty/install-guide-ubuntu/common/get_started_identity.html>`_
before proceeding.

Making the OpenStack Identity service highly available
in active / passive mode involves:

- :ref:`keystone-pacemaker`
- :ref:`keystone-config-identity`
- :ref:`keystone-services-config`

.. _keystone-pacemaker:

Add OpenStack Identity resource to Pacemaker
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. You must first download the OpenStack Identity resource to Pacemaker
   by running the following commands:

   .. code-block:: console

      # cd /usr/lib/ocf/resource.d
      # mkdir openstack
      # cd openstack
      # wget https://git.openstack.org/cgit/openstack/openstack-resource-agents/plain/ocf/keystone
      # chmod a+rx *

#. You can now add the Pacemaker configuration
   for the OpenStack Identity resource
   by running the :command:`crm configure` command
   to connect to the Pacemaker cluster.
   Add the following cluster resources:

   ::

      primitive p_keystone ocf:openstack:keystone \
      params config="/etc/keystone/keystone.conf"
          os_password="secretsecret" \
          os_username="admin"
          os_tenant_name="admin"
          os_auth_url="http://10.0.0.11:5000/v2.0/" \
          op monitor interval="30s" timeout="30s"

   This configuration creates ``p_keystone``,
   a resource for managing the OpenStack Identity service.

   :command:`crm configure` supports batch input
   so you may copy and paste the above lines
   into your live Pacemaker configuration,
   and then make changes as required.
   For example, you may enter edit ``p_ip_keystone``
   from the :command:`crm configure` menu
   and edit the resource to match your preferred virtual IP address.

#. After you add these resources,
   commit your configuration changes by entering :command:`commit`
   from the :command:`crm configure` menu.
   Pacemaker then starts the OpenStack Identity service
   and its dependent resources on one of your nodes.

.. _keystone-config-identity:

Configure OpenStack Identity service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Edit the :file:`keystone.conf` file
   to change the values of the :manpage:`bind(2)` parameters:

   .. code-block:: ini

      bind_host = 10.0.0.11
      public_bind_host = 10.0.0.11
      admin_bind_host = 10.0.0.11

   The ``admin_bind_host`` parameter
   lets you use a private network for admin access.

#. To be sure that all data is highly available,
   ensure that everything is stored in the MySQL database
   (which is also highly available):

   .. code-block:: ini

      [catalog]
      driver = keystone.catalog.backends.sql.Catalog
      ...
      [identity]
      driver = keystone.identity.backends.sql.Identity
      ...


.. _keystone-services-config:

Configure OpenStack services to use the highly available OpenStack Identity
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Your OpenStack services must now point
their OpenStack Identity configuration
to the highly available virtual cluster IP address
rather than point to the physical IP address
of an OpenStack Identity server as you would do
in a non-HA environment.

#. For OpenStack Compute, for example,
   if your OpenStack Identiy service IP address is 10.0.0.11,
   use the following configuration in your :file:`api-paste.ini` file:

   .. code-block:: ini

      auth_host = 10.0.0.11

#. You also need to create the OpenStack Identity Endpoint
   with this IP address.

   .. note::

      If you are using both private and public IP addresses,
      you should create two virtual IP addresses
      and define your endpoint like this:

      .. code-block:: console

         $ openstack endpoint create --region $KEYSTONE_REGION \
           $service-type public http://PUBLIC_VIP:5000/v2.0
         $ openstack endpoint create --region $KEYSTONE_REGION \
           $service-type admin http://10.0.0.11:35357/v2.0
         $ openstack endpoint create --region $KEYSTONE_REGION \
           $service-type internal http://10.0.0.11:5000/v2.0


#. If you are using the horizon dashboard,
   edit the :file:`local_settings.py` file
   to include the following:

   .. code-block:: ini

      OPENSTACK_HOST = 10.0.0.11


