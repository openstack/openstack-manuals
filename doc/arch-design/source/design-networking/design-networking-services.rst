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

OpenStack does not currently provide DNS services, aside from the
dnsmasq daemon, which resides on ``nova-network`` hosts. You could
consider providing a dynamic DNS service to allow instances to update a
DNS entry with new IP addresses. You can also consider making a generic
forward and reverse DNS mapping for instances' IP addresses, such as
``vm-203-0-113-123.example.com.``
