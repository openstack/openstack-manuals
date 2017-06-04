=======
HAProxy
=======

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
~~~~~~~~~~~~~~~~~~~

#. Restart the HAProxy service.

#. Locate your HAProxy instance on each OpenStack controller node in your
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
