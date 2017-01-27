=============================
Highly available Identity API
=============================

Making the OpenStack Identity service highly available
in active and passive mode involves:

- :ref:`identity-pacemaker`
- :ref:`identity-config-identity`
- :ref:`identity-services-config`

.. _identity-pacemaker:

Prerequisites
~~~~~~~~~~~~~

Before beginning, ensure you have read the
`OpenStack Identity service getting started documentation
<https://docs.openstack.org/admin-guide/common/get-started-identity.html>`_.

Add OpenStack Identity resource to Pacemaker
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following section(s) detail how to add the OpenStack Identity
resource to Pacemaker on SUSE and Red Hat.

SUSE
-----

SUSE Enterprise Linux and SUSE-based distributions, such as openSUSE,
use a set of OCF agents for controlling OpenStack services.

#. Run the following commands to download the OpenStack Identity resource
   to Pacemaker:

   .. code-block:: console

      # cd /usr/lib/ocf/resource.d
      # mkdir openstack
      # cd openstack
      # wget https://git.openstack.org/cgit/openstack/openstack-resource-agents/plain/ocf/keystone
      # chmod a+rx *

#. Add the Pacemaker configuration for the OpenStack Identity resource
   by running the following command to connect to the Pacemaker cluster:

   .. code-block:: console

      # crm configure

#. Add the following cluster resources:

   .. code-block:: console

      clone p_keystone ocf:openstack:keystone \
      params config="/etc/keystone/keystone.conf" os_password="secretsecret" os_username="admin" os_tenant_name="admin" os_auth_url="http://10.0.0.11:5000/v2.0/" \
          op monitor interval="30s" timeout="30s"

   .. note::

      This configuration creates ``p_keystone``,
      a resource for managing the OpenStack Identity service.

#. Commit your configuration changes from the :command:`crm configure` menu
   with the following command:

   .. code-block:: console

      # commit

The :command:`crm configure` supports batch input. You may have to copy and
paste the above lines into your live Pacemaker configuration, and then make
changes as required.

For example, you may enter ``edit p_ip_keystone`` from the
:command:`crm configure` menu and edit the resource to match your preferred
virtual IP address.

Pacemaker now starts the OpenStack Identity service and its dependent
resources on all of your nodes.

Red Hat
--------

For Red Hat Enterprise Linux and Red Hat-based Linux distributions,
the following process uses Systemd unit files.

.. code-block:: console

   # pcs resource create openstack-keystone systemd:openstack-keystone --clone interleave=true

.. _identity-config-identity:

Configure OpenStack Identity service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Edit the :file:`keystone.conf` file
   to change the values of the :manpage:`bind(2)` parameters:

   .. code-block:: ini

      bind_host = 10.0.0.12
      public_bind_host = 10.0.0.12
      admin_bind_host = 10.0.0.12

   The ``admin_bind_host`` parameter
   lets you use a private network for admin access.

#. To be sure that all data is highly available,
   ensure that everything is stored in the MySQL database
   (which is also highly available):

   .. code-block:: ini

      [catalog]
      driver = keystone.catalog.backends.sql.Catalog
      # ...
      [identity]
      driver = keystone.identity.backends.sql.Identity
      # ...

#. If the Identity service will be sending ceilometer notifications
   and your message bus is configured for high availability, you will
   need to ensure that the Identity service is correctly configured to
   use it. For details on how to configure the Identity service for
   this kind of deployment, see :doc:`shared-messaging`.

.. _identity-services-config:

Configure OpenStack services to use the highly available OpenStack Identity
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Your OpenStack services now point their OpenStack Identity configuration
to the highly available virtual cluster IP address.

#. For OpenStack Compute, (if your OpenStack Identity service IP address
   is 10.0.0.11) use the following configuration in the :file:`api-paste.ini`
   file:

   .. code-block:: ini

      auth_host = 10.0.0.11

#. Create the OpenStack Identity Endpoint with this IP address.

   .. note::

      If you are using both private and public IP addresses,
      create two virtual IP addresses and define the endpoint. For
      example:

      .. code-block:: console

         $ openstack endpoint create --region $KEYSTONE_REGION \
           $service-type public http://PUBLIC_VIP:5000/v2.0
         $ openstack endpoint create --region $KEYSTONE_REGION \
           $service-type admin http://10.0.0.11:35357/v2.0
         $ openstack endpoint create --region $KEYSTONE_REGION \
           $service-type internal http://10.0.0.11:5000/v2.0


#. If you are using the horizon Dashboard, edit the :file:`local_settings.py`
   file to include the following:

   .. code-block:: ini

      OPENSTACK_HOST = 10.0.0.11
