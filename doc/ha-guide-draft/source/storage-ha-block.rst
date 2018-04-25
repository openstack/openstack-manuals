==================================
Highly available Block Storage API
==================================

Cinder provides Block-Storage-as-a-Service suitable for performance
sensitive scenarios such as databases, expandable file systems, or
providing a server with access to raw block level storage.

Persistent block storage can survive instance termination and can also
be moved across instances like any external storage device. Cinder
also has volume snapshots capability for backing up the volumes.

Making the Block Storage API service highly available in
active/passive mode involves:

- :ref:`ha-blockstorage-pacemaker`
- :ref:`ha-blockstorage-configure`
- :ref:`ha-blockstorage-services`

In theory, you can run the Block Storage service as active/active.
However, because of sufficient concerns, we recommend running
the volume component as active/passive only.

You can read more about these concerns on the
`Red Hat Bugzilla <https://bugzilla.redhat.com/show_bug.cgi?id=1193229>`_
and there is a
`psuedo roadmap <https://etherpad.openstack.org/p/cinder-kilo-stabilisation-work>`_
for addressing them upstream.

.. _ha-blockstorage-pacemaker:

Add Block Storage API resource to Pacemaker
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

On RHEL-based systems, create resources for cinder's systemd agents and create
constraints to enforce startup/shutdown ordering:

.. code-block:: console

  pcs resource create openstack-cinder-api systemd:openstack-cinder-api --clone interleave=true
  pcs resource create openstack-cinder-scheduler systemd:openstack-cinder-scheduler --clone interleave=true
  pcs resource create openstack-cinder-volume systemd:openstack-cinder-volume

  pcs constraint order start openstack-cinder-api-clone then openstack-cinder-scheduler-clone
  pcs constraint colocation add openstack-cinder-scheduler-clone with openstack-cinder-api-clone
  pcs constraint order start openstack-cinder-scheduler-clone then openstack-cinder-volume
  pcs constraint colocation add openstack-cinder-volume with openstack-cinder-scheduler-clone


If the Block Storage service runs on the same nodes as the other services,
then it is advisable to also include:

.. code-block:: console

   pcs constraint order start openstack-keystone-clone then openstack-cinder-api-clone

Alternatively, instead of using systemd agents, download and
install the OCF resource agent:

.. code-block:: console

   # cd /usr/lib/ocf/resource.d/openstack
   # wget https://git.openstack.org/cgit/openstack/openstack-resource-agents/plain/ocf/cinder-api
   # chmod a+rx *

You can now add the Pacemaker configuration for Block Storage API resource.
Connect to the Pacemaker cluster with the :command:`crm configure` command
and add the following cluster resources:

.. code-block:: none

   primitive p_cinder-api ocf:openstack:cinder-api \
      params config="/etc/cinder/cinder.conf" \
      os_password="secretsecret" \
      os_username="admin" \
      os_tenant_name="admin" \
      keystone_get_token_url="http://10.0.0.11:5000/v2.0/tokens" \
      op monitor interval="30s" timeout="30s"

This configuration creates ``p_cinder-api``, a resource for managing the
Block Storage API service.

The command :command:`crm configure` supports batch input, copy and paste the
lines above into your live Pacemaker configuration and then make changes as
required. For example, you may enter ``edit p_ip_cinder-api`` from the
:command:`crm configure` menu and edit the resource to match your preferred
virtual IP address.

Once completed, commit your configuration changes by entering :command:`commit`
from the :command:`crm configure` menu. Pacemaker then starts the Block Storage
API service and its dependent resources on one of your nodes.

.. _ha-blockstorage-configure:

Configure Block Storage API service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Edit the ``/etc/cinder/cinder.conf`` file. For example, on a RHEL-based system:

.. code-block:: ini
   :linenos:

   [DEFAULT]
   # This is the name which we should advertise ourselves as and for
   # A/P installations it should be the same everywhere
   host = cinder-cluster-1

   # Listen on the Block Storage VIP
   osapi_volume_listen = 10.0.0.11

   auth_strategy = keystone
   control_exchange = cinder

   volume_driver = cinder.volume.drivers.nfs.NfsDriver
   nfs_shares_config = /etc/cinder/nfs_exports
   nfs_sparsed_volumes = true
   nfs_mount_options = v3

   [database]
   sql_connection = mysql://cinder:CINDER_DBPASS@10.0.0.11/cinder
   max_retries = -1

   [keystone_authtoken]
   # 10.0.0.11 is the Keystone VIP
   identity_uri = http://10.0.0.11:35357/
   auth_uri = http://10.0.0.11:5000/
   admin_tenant_name = service
   admin_user = cinder
   admin_password = CINDER_PASS

   [oslo_messaging_rabbit]
   # Explicitly list the rabbit hosts as it doesn't play well with HAProxy
   rabbit_hosts = 10.0.0.12,10.0.0.13,10.0.0.14
   # As a consequence, we also need HA queues
   rabbit_ha_queues = True
   heartbeat_timeout_threshold = 60
   heartbeat_rate = 2

Replace ``CINDER_DBPASS`` with the password you chose for the Block Storage
database. Replace ``CINDER_PASS`` with the password you chose for the
``cinder`` user in the Identity service.

This example assumes that you are using NFS for the physical storage, which
will almost never be true in a production installation.

If you are using the Block Storage service OCF agent, some settings will
be filled in for you, resulting in a shorter configuration file:

.. code-block:: ini
   :linenos:

   # We have to use MySQL connection to store data:
   sql_connection = mysql://cinder:CINDER_DBPASS@10.0.0.11/cinder
   # Alternatively, you can switch to pymysql,
   # a new Python 3 compatible library and use
   # sql_connection = mysql+pymysql://cinder:CINDER_DBPASS@10.0.0.11/cinder
   # and be ready when everything moves to Python 3.
   # Ref: https://wiki.openstack.org/wiki/PyMySQL_evaluation

   # We bind Block Storage API to the VIP:
   osapi_volume_listen = 10.0.0.11

   # We send notifications to High Available RabbitMQ:
   notifier_strategy = rabbit
   rabbit_host = 10.0.0.11

Replace ``CINDER_DBPASS`` with the password you chose for the Block Storage
database.

.. _ha-blockstorage-services:

Configure OpenStack services to use the highly available Block Storage API
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Your OpenStack services must now point their Block Storage API configuration
to the highly available, virtual cluster IP address rather than a Block Storage
API server’s physical IP address as you would for a non-HA environment.

Create the Block Storage API endpoint with this IP.

If you are using both private and public IP addresses, create two virtual IPs
and define your endpoint. For example:

.. code-block:: console

   $ openstack endpoint create --region $KEYSTONE_REGION \
     volumev2 public http://PUBLIC_VIP:8776/v2/%\(project_id\)s
   $ openstack endpoint create --region $KEYSTONE_REGION \
     volumev2 admin http://10.0.0.11:8776/v2/%\(project_id\)s
   $ openstack endpoint create --region $KEYSTONE_REGION \
     volumev2 internal http://10.0.0.11:8776/v2/%\(project_id\)s

