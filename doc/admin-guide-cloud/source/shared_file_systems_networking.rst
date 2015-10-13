.. _shared_file_systems_networking:

==========
Networking
==========

Instead of OpenStack Block Storage service, Shared File Systems service
requires interaction with Networking service. The first of all, it because
share services should have a possibility to manage share servers on its own.
Also, lots of shared file systems provides have own access control systems and
requires network connectivity with some external auth providers, like LDAP,
Kerberos, or Microsoft Active Directory. So, management share services base
on such back end needs some interacting with Networking service.

.. toctree::
    shared_file_systems_share_networks.rst
    shared_file_systems_network_plugins.rst
