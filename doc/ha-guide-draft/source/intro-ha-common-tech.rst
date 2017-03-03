========================
Commonly used technology
========================

Hardware
~~~~~~~~
The following are the standard hardware requirements:

- Provider networks: See the *Overview -> Networking Option 1: Provider
  networks* section of the
  `Install Tutorials and Guides <https://docs.openstack.org/project-install-guide/ocata>`_
  depending on your distribution.
- Self-service networks: See the *Overview -> Networking Option 2:
  Self-service networks* section of the
  `Install Tutorials and Guides <https://docs.openstack.org/project-install-guide/ocata>`_
  depending on your distribution.

Load balancers
--------------

Redundant switches
------------------

Bonded interfaces
-----------------

Storage
-------

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
