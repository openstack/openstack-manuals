==================
Network namespaces
==================

A namespace is a container for a set of identifiers. Namespaces provide a level
of direction to specific identifiers and make it possible to differentiate
between identifiers with the same exact name. With network namespaces, you can
have different and separate instances of network interfaces and routing tables
that operate independently of each other.

Virtual routing and forwarding (VRF)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Virtual routing and forwarding is an IP technology that allows multiple
instances of a routing table to coexist on the same router at the same time.

Linux network namespaces
~~~~~~~~~~~~~~~~~~~~~~~~

Linux network namespaces provide isolation of the system resources associated
with networking. Each network namespace has its own network devices, IP
addresses, IP routing tables, iptables, and /proc/net directory.
