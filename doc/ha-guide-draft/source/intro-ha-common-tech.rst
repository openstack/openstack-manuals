========================
Commonly used technology
========================
High availability can be achieved only on system level, while both hardware and
software components can contribute to the system level availability.
This document lists the most common hardware and software technologies
that can be used to build a highly available system.

Hardware
~~~~~~~~
Using different technologies to enable high availability on the hardware
level provides a good basis to build a high available system. The next chapters
discuss the most common technologies used in this field.

Redundant switches
------------------
Network switches are single point of failures as networking is critical to
operate all other basic domains of the infrastructure, like compute and
storage. Network switches need to be able to forward the network traffic
and be able to forward the traffic to a working next hop.
For these reasons consider the following two factors when making a network
switch redundant:

#. The network switch itself should synchronize its internal state to a
   redundant switch either in active/active or active/passive way.

#. The network topology should be designed in a way that the network router can
   use at least two paths in every critical direction.

Bonded interfaces
-----------------
Bonded interfaces are two independent physical network interfaces handled as
one interface in active/passive or in active/active redundancy mode. In
active/passive mode, if an error happens in the active network interface or in
the remote end of the interface, the interfaces are switched over. In
active/active mode, when an error happens in an interface or in the remote end
of an interface, then the interface is marked as unavailable and ceases to be
used.

Load balancers
--------------
Physical load balancers are special routers which direct the traffic in
different directions based on a set of rules. Load balancers can be in
redundant mode similarly to the physical switches.
Load balancers are also important for distributing the traffic to the different
active/active components of the system.

Storage
-------
Physical storage high availability can be achieved with different scopes:

#. High availability within a hardware unit with redundant disks (mostly
   organized into different RAID configurations), redundant control components,
   redundant I/O interfaces and redundant power supply.

#. System level high availability with redundant hardware units with data
   replication.

Software
~~~~~~~~

HAproxy
-------

HAProxy provides a fast and reliable HTTP reverse proxy and load balancer
for TCP or HTTP applications. It is particularly suited for web crawling
under very high loads while needing persistence or Layer 7 processing.
It realistically supports tens of thousands of connections with recent
hardware.

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

keepalived
----------

`keepalived <http://www.keepalived.org/>`_ is a routing software that
provides facilities for load balancing and high-availability to Linux
system and Linux based infrastructures.

Keepalived implements a set of checkers to dynamically and
adaptively maintain and manage loadbalanced server pool according
their health.

The keepalived daemon can be used to monitor services or systems and
to automatically failover to a standby if problems occur.

Pacemaker
---------

`Pacemaker <http://clusterlabs.org/>`_ cluster stack is a state-of-the-art
high availability and load balancing stack for the Linux platform.
Pacemaker is used to make OpenStack infrastructure highly available.

Pacemaker relies on the
`Corosync <http://corosync.github.io/corosync/>`_ messaging layer
for reliable cluster communications. Corosync implements the Totem single-ring
ordering and membership protocol. It also provides UDP and InfiniBand based
messaging, quorum, and cluster membership to Pacemaker.

Pacemaker does not inherently understand the applications it manages.
Instead, it relies on resource agents (RAs) that are scripts that encapsulate
the knowledge of how to start, stop, and check the health of each application
managed by the cluster.

These agents must conform to one of the `OCF <https://github.com/ClusterLabs/
OCF-spec/blob/master/ra/resource-agent-api.md>`_,
`SysV Init <http://refspecs.linux-foundation.org/LSB_3.0.0/LSB-Core-generic/
LSB-Core-generic/iniscrptact.html>`_, Upstart, or Systemd standards.

Pacemaker ships with a large set of OCF agents (such as those managing
MySQL databases, virtual IP addresses, and RabbitMQ), but can also use
any agents already installed on your system and can be extended with
your own (see the
`developer guide <http://www.linux-ha.org/doc/dev-guides/ra-dev-guide.html>`_).
