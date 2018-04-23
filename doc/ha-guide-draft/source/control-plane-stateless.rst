==============================
Configuring stateless services
==============================

.. to do: scope what details we want on the following services

API services
~~~~~~~~~~~~

Load-balancer
~~~~~~~~~~~~~

HAProxy
-------

HAProxy provides a fast and reliable HTTP reverse proxy and load balancer
for TCP or HTTP applications. It is particularly suited for web crawling
under very high loads while needing persistence or Layer 7 processing.
It realistically supports tens of thousands of connections with recent
hardware.

Each instance of HAProxy configures its front end to accept connections only
to the virtual IP (VIP) address. The HAProxy back end (termination
point) is a list of all the IP addresses of instances for load balancing.

.. note::

   Ensure your HAProxy installation is not a single point of failure,
   it is advisable to have multiple HAProxy instances running.

   You can also ensure the availability by other means, using Keepalived
   or Pacemaker.

Alternatively, you can use a commercial load balancer, which is hardware
or software. We recommend a hardware load balancer as it generally has
good performance.

For detailed instructions about installing HAProxy on your nodes,
see the HAProxy `official documentation <http://www.haproxy.org/#docs>`_.

Configuring HAProxy
^^^^^^^^^^^^^^^^^^^

#. Restart the HAProxy service.

#. Locate your HAProxy instance on each OpenStack controller in your
   environment. The following is an example ``/etc/haproxy/haproxy.cfg``
   configuration file. Configure your instance using the following
   configuration file, you will need a copy of it on each
   controller node.


   .. code-block:: none

        global
         chroot  /var/lib/haproxy
         daemon
         group  haproxy
         maxconn  4000
         pidfile  /var/run/haproxy.pid
         user  haproxy

       defaults
         log  global
         maxconn  4000
         option  redispatch
         retries  3
         timeout  http-request 10s
         timeout  queue 1m
         timeout  connect 10s
         timeout  client 1m
         timeout  server 1m
         timeout  check 10s

        listen dashboard_cluster
         bind <Virtual IP>:443
         balance  source
         option  tcpka
         option  httpchk
         option  tcplog
         server controller1 10.0.0.12:443 check inter 2000 rise 2 fall 5
         server controller2 10.0.0.13:443 check inter 2000 rise 2 fall 5
         server controller3 10.0.0.14:443 check inter 2000 rise 2 fall 5

        listen galera_cluster
         bind <Virtual IP>:3306
         balance  source
         option  mysql-check
         server controller1 10.0.0.12:3306 check port 9200 inter 2000 rise 2 fall 5
         server controller2 10.0.0.13:3306 backup check port 9200 inter 2000 rise 2 fall 5
         server controller3 10.0.0.14:3306 backup check port 9200 inter 2000 rise 2 fall 5

        listen glance_api_cluster
         bind <Virtual IP>:9292
         balance  source
         option  tcpka
         option  httpchk
         option  tcplog
         server controller1 10.0.0.12:9292 check inter 2000 rise 2 fall 5
         server controller2 10.0.0.13:9292 check inter 2000 rise 2 fall 5
         server controller3 10.0.0.14:9292 check inter 2000 rise 2 fall 5

        listen glance_registry_cluster
         bind <Virtual IP>:9191
         balance  source
         option  tcpka
         option  tcplog
         server controller1 10.0.0.12:9191 check inter 2000 rise 2 fall 5
         server controller2 10.0.0.13:9191 check inter 2000 rise 2 fall 5
         server controller3 10.0.0.14:9191 check inter 2000 rise 2 fall 5

        listen keystone_admin_cluster
         bind <Virtual IP>:35357
         balance  source
         option  tcpka
         option  httpchk
         option  tcplog
         server controller1 10.0.0.12:35357 check inter 2000 rise 2 fall 5
         server controller2 10.0.0.13:35357 check inter 2000 rise 2 fall 5
         server controller3 10.0.0.14:35357 check inter 2000 rise 2 fall 5

        listen keystone_public_internal_cluster
         bind <Virtual IP>:5000
         balance  source
         option  tcpka
         option  httpchk
         option  tcplog
         server controller1 10.0.0.12:5000 check inter 2000 rise 2 fall 5
         server controller2 10.0.0.13:5000 check inter 2000 rise 2 fall 5
         server controller3 10.0.0.14:5000 check inter 2000 rise 2 fall 5

        listen nova_ec2_api_cluster
         bind <Virtual IP>:8773
         balance  source
         option  tcpka
         option  tcplog
         server controller1 10.0.0.12:8773 check inter 2000 rise 2 fall 5
         server controller2 10.0.0.13:8773 check inter 2000 rise 2 fall 5
         server controller3 10.0.0.14:8773 check inter 2000 rise 2 fall 5

        listen nova_compute_api_cluster
         bind <Virtual IP>:8774
         balance  source
         option  tcpka
         option  httpchk
         option  tcplog
         server controller1 10.0.0.12:8774 check inter 2000 rise 2 fall 5
         server controller2 10.0.0.13:8774 check inter 2000 rise 2 fall 5
         server controller3 10.0.0.14:8774 check inter 2000 rise 2 fall 5

        listen nova_metadata_api_cluster
         bind <Virtual IP>:8775
         balance  source
         option  tcpka
         option  tcplog
         server controller1 10.0.0.12:8775 check inter 2000 rise 2 fall 5
         server controller2 10.0.0.13:8775 check inter 2000 rise 2 fall 5
         server controller3 10.0.0.14:8775 check inter 2000 rise 2 fall 5

        listen cinder_api_cluster
         bind <Virtual IP>:8776
         balance  source
         option  tcpka
         option  httpchk
         option  tcplog
         server controller1 10.0.0.12:8776 check inter 2000 rise 2 fall 5
         server controller2 10.0.0.13:8776 check inter 2000 rise 2 fall 5
         server controller3 10.0.0.14:8776 check inter 2000 rise 2 fall 5

        listen ceilometer_api_cluster
         bind <Virtual IP>:8777
         balance  source
         option  tcpka
         option  tcplog
         server controller1 10.0.0.12:8777 check inter 2000 rise 2 fall 5
         server controller2 10.0.0.13:8777 check inter 2000 rise 2 fall 5
         server controller3 10.0.0.14:8777 check inter 2000 rise 2 fall 5

        listen nova_vncproxy_cluster
         bind <Virtual IP>:6080
         balance  source
         option  tcpka
         option  tcplog
         server controller1 10.0.0.12:6080 check inter 2000 rise 2 fall 5
         server controller2 10.0.0.13:6080 check inter 2000 rise 2 fall 5
         server controller3 10.0.0.14:6080 check inter 2000 rise 2 fall 5

        listen neutron_api_cluster
         bind <Virtual IP>:9696
         balance  source
         option  tcpka
         option  httpchk
         option  tcplog
         server controller1 10.0.0.12:9696 check inter 2000 rise 2 fall 5
         server controller2 10.0.0.13:9696 check inter 2000 rise 2 fall 5
         server controller3 10.0.0.14:9696 check inter 2000 rise 2 fall 5

        listen swift_proxy_cluster
         bind <Virtual IP>:8080
         balance  source
         option  tcplog
         option  tcpka
         server controller1 10.0.0.12:8080 check inter 2000 rise 2 fall 5
         server controller2 10.0.0.13:8080 check inter 2000 rise 2 fall 5
         server controller3 10.0.0.14:8080 check inter 2000 rise 2 fall 5

   .. note::

      The Galera cluster configuration directive ``backup`` indicates
      that two of the three controllers are standby nodes.
      This ensures that only one node services write requests
      because OpenStack support for multi-node writes is not yet production-ready.

   .. note::

      The Telemetry API service configuration does not have the ``option httpchk``
      directive as it cannot process this check properly.

.. TODO: explain why the Telemetry API is so special

#. Configure the kernel parameter to allow non-local IP binding. This allows
   running HAProxy instances to bind to a VIP for failover. Add following line
   to ``/etc/sysctl.conf``:

   .. code-block:: none

      net.ipv4.ip_nonlocal_bind = 1

#. Restart the host or, to make changes work immediately, invoke:

   .. code-block:: console

      $ sysctl -p

#. Add HAProxy to the cluster and ensure the VIPs can only run on machines
   where HAProxy is active:

   ``pcs``

   .. code-block:: console

      $ pcs resource create lb-haproxy systemd:haproxy --clone
      $ pcs constraint order start vip then lb-haproxy-clone kind=Optional
      $ pcs constraint colocation add lb-haproxy-clone with vip

   ``crmsh``

   .. code-block:: console

      $ crm cib new conf-haproxy
      $ crm configure primitive haproxy lsb:haproxy op monitor interval="1s"
      $ crm configure clone haproxy-clone haproxy
      $ crm configure colocation vip-with-haproxy inf: vip haproxy-clone
      $ crm configure order haproxy-after-vip mandatory: vip haproxy-clone


Pacemaker versus systemd
------------------------

Memcached
---------

Memcached is a general-purpose distributed memory caching system. It
is used to speed up dynamic database-driven websites by caching data
and objects in RAM to reduce the number of times an external data
source must be read.

Memcached is a memory cache demon that can be used by most OpenStack
services to store ephemeral data, such as tokens.

Access to Memcached is not handled by HAProxy because replicated
access is currently in an experimental state. Instead, OpenStack
services must be supplied with the full list of hosts running
Memcached.

The Memcached client implements hashing to balance objects among the
instances. Failure of an instance impacts only a percentage of the
objects and the client automatically removes it from the list of
instances. The SLA is several minutes.


Highly available API services
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Identity API
------------

Ensure you have read the
`OpenStack Identity service getting started documentation
<https://docs.openstack.org/admin-guide/common/get-started-identity.html>`_.

.. to do: reference controller-ha-identity and see if section involving
   adding to pacemaker is in scope


Add OpenStack Identity resource to Pacemaker
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The following section(s) detail how to add the Identity service
to Pacemaker on SUSE and Red Hat.

SUSE
----

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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
   use it.

.. _identity-services-config:

Configure OpenStack services to use the highly available OpenStack Identity
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Your OpenStack services now point their OpenStack Identity configuration
to the highly available virtual cluster IP address.

#. For OpenStack Compute service, (if your OpenStack Identity service
   IP address is 10.0.0.11) use the following configuration in the
   :file:`api-paste.ini` file:

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

#. If you are using Dashboard (horizon), edit the :file:`local_settings.py`
   file to include the following:

      .. code-block:: ini

         OPENSTACK_HOST = 10.0.0.11


Telemetry API
-------------

The Telemetry polling agent can be configured to partition its polling
workload between multiple agents. This enables high availability (HA).

Both the central and the compute agent can run in an HA deployment.
This means that multiple instances of these services can run in
parallel with workload partitioning among these running instances.

The `Tooz <https://pypi.org/project/tooz>`_ library provides
the coordination within the groups of service instances.
It provides an API above several back ends that can be used for building
distributed applications.

Tooz supports
`various drivers <https://docs.openstack.org/tooz/latest/user/drivers.html>`_
including the following back end solutions:

* `Zookeeper <http://zookeeper.apache.org/>`_:
    Recommended solution by the Tooz project.

* `Redis <http://redis.io/>`_:
    Recommended solution by the Tooz project.

* `Memcached <http://memcached.org/>`_:
    Recommended for testing.

You must configure a supported Tooz driver for the HA deployment of
the Telemetry services.

For information about the required configuration options
to set in the :file:`ceilometer.conf`, see the `coordination section
<https://docs.openstack.org/ocata/config-reference/telemetry.html>`_
in the OpenStack Configuration Reference.

.. note::

   Only one instance for the central and compute agent service(s) is able
   to run and function correctly if the ``backend_url`` option is not set.

The availability check of the instances is provided by heartbeat messages.
When the connection with an instance is lost, the workload will be
reassigned within the remaining instances in the next polling cycle.

.. note::

   Memcached uses a timeout value, which should always be set to
   a value that is higher than the heartbeat value set for Telemetry.

For backward compatibility and supporting existing deployments, the central
agent configuration supports using different configuration files. This is for
groups of service instances that are running in parallel.
For enabling this configuration, set a value for the
``partitioning_group_prefix`` option in the
`polling section <https://docs.openstack.org/ocata/config-reference/telemetry/telemetry-config-options.html>`_
in the OpenStack Configuration Reference.

.. warning::

   For each sub-group of the central agent pool with the same
   ``partitioning_group_prefix``, a disjoint subset of meters must be polled
   to avoid samples being missing or duplicated. The list of meters to poll
   can be set in the :file:`/etc/ceilometer/pipeline.yaml` configuration file.
   For more information about pipelines see the `Data processing and pipelines
   <https://docs.openstack.org/admin-guide/telemetry-data-pipelines.html>`_
   section.

To enable the compute agent to run multiple instances simultaneously with
workload partitioning, the ``workload_partitioning`` option must be set to
``True`` under the `compute section <https://docs.openstack.org/ocata/config-reference/telemetry.html>`_
in the :file:`ceilometer.conf` configuration file.


.. To Do: Cover any other projects here with API services which require specific
   HA details.
