==============================
Additional networking services
==============================

OpenStack, like any network application, has a number of standard
services to consider, such as NTP and DNS.

NTP
~~~

Time synchronization is a critical element to ensure continued operation
of OpenStack components. Ensuring that all components have the correct
time is necessary to avoid errors in instance scheduling, replication of
objects in the object store, and matching log timestamps for debugging.

All servers running OpenStack components should be able to access an
appropriate NTP server. You may decide to set up one locally or use the
public pools available from the `Network Time Protocol
project <http://www.pool.ntp.org/>`_.

DNS
~~~

Designate is a multi-tenant DNSaaS service for OpenStack. It provides a REST
API with integrated keystone authentication. It can be configured to
auto-generate records based on nova and neutron actions. Designate supports a
variety of DNS servers including Bind9 and PowerDNS.

The DNS service provides DNS Zone and RecordSet management for OpenStack
clouds. The DNS Service includes a REST API, a command-line client, and a
horizon Dashboard plugin.

For more information, see the `Designate project <https://www.openstack.org/software/releases/ocata/components/designate>`_
web page.

.. note::

  The Designate service does not provide DNS service for the OpenStack
  infrastructure upon install. We recommend working with your service
  provider when installing OpenStack in order to properly name your
  servers and other infrastructure hardware.

DHCP
~~~~

OpenStack neutron deploys various agents when a network is created within
OpenStack. One of these agents is a DHCP agent. This DHCP agent uses the linux
binary, dnsmasq as the delivery agent for DHCP. This agent manages the network
namespaces that are spawned for each project subnet to act as a DHCP server.
The dnsmasq process is capable of allocating IP addresses to all virtual
machines running on a network. When a network is created through OpenStack and
the DHCP agent is enabled for that network, DHCP services are enabled by
default.

LBaaS
~~~~~

OpenStack neutron has the ability to distribute incoming requests between
designated instances. Using neutron networking and OVS, Load
Balancing-as-a-Service (LBaaS) can be created. The load balancing of workloads
is used to distribute incoming application requests evenly between designated
instances. This operation ensures that a workload is shared predictably among
defined instances and allows a more effective use of underlying resources.
OpenStack LBaaS can distribute load in the following methods:

* Round robin - Even rotation between multiple defined instances.
* Source IP - Requests from specific IPs are consistently directed to the same
  instance.
* Least connections - Sends requests to the instance with the least number of
  active connections.
