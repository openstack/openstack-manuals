============================
The keepalived architecture
============================

High availability strategies
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following diagram shows a very simplified view of the different
strategies used to achieve high availability for the OpenStack
services:

.. image:: /figures/keepalived-arch.jpg
   :width: 100%

Depending on the method used to communicate with the service, the
following availability strategies will be followed:

-  Keepalived, for the HAProxy instances.
-  Access via an HAProxy virtual IP, for services such as HTTPd that
   are accessed via a TCP socket that can be load balanced
-  Built-in application clustering, when available from the application.
   Galera is one example of this.
-  Starting up one instance of the service on several controller nodes,
   when they can coexist and coordinate by other means. RPC in
   ``nova-conductor`` is one example of this.
-  No high availability, when the service can only work in
   active/passive mode.

There are known issues with cinder-volume that recommend setting it as
active-passive for now, see:
https://blueprints.launchpad.net/cinder/+spec/cinder-volume-active-active-support

While there will be multiple neutron LBaaS agents running, each agent
will manage a set of load balancers, that cannot be failed over to
another node.

Architecture limitations
~~~~~~~~~~~~~~~~~~~~~~~~

This architecture has some inherent limitations that should be kept in
mind during deployment and daily operations.
The following sections describe these limitations.

#. Keepalived and network partitions

   In case of a network partitioning, there is a chance that two or
   more nodes running keepalived claim to hold the same VIP, which may
   lead to an undesired behaviour. Since keepalived uses VRRP over
   multicast to elect a master (VIP owner), a network partition in
   which keepalived nodes cannot communicate will result in the VIPs
   existing on two nodes. When the network partition is resolved, the
   duplicate VIPs should also be resolved. Note that this network
   partition problem with VRRP is a known limitation for this
   architecture.

#. Cinder-volume as a single point of failure

   There are currently concerns over the cinder-volume service ability
   to run as a fully active-active service. During the Mitaka
   timeframe, this is being worked on, see:
   https://blueprints.launchpad.net/cinder/+spec/cinder-volume-active-active-support
   Thus, cinder-volume will only be running on one of the controller
   nodes, even if it will be configured on all nodes. In case of a
   failure in the node running cinder-volume, it should be started in
   a surviving controller node.

#. Neutron-lbaas-agent as a single point of failure

   The current design of the neutron LBaaS agent using the HAProxy
   driver does not allow high availability for the tenant load
   balancers. The neutron-lbaas-agent service will be enabled and
   running on all controllers, allowing for load balancers to be
   distributed across all nodes. However, a controller node failure
   will stop all load balancers running on that node until the service
   is recovered or the load balancer is manually removed and created
   again.

#. Service monitoring and recovery required

   An external service monitoring infrastructure is required to check
   the OpenStack service health, and notify operators in case of any
   failure. This architecture does not provide any facility for that,
   so it would be necessary to integrate the OpenStack deployment with
   any existing monitoring environment.

#. Manual recovery after a full cluster restart

   Some support services used by RDO or RHEL OSP use their own form of
   application clustering. Usually, these services maintain a cluster
   quorum, that may be lost in case of a simultaneous restart of all
   cluster nodes, for example during a power outage. Each service will
   require its own procedure to regain quorum.

If you find any or all of these limitations concerning, you are
encouraged to refer to the
:doc:`Pacemaker HA architecture<intro-ha-arch-pacemaker>` instead.
