.. _shared_file_systems_networking:

==========
Networking
==========

Unlike the OpenStack Block Storage service, the Shared File Systems service
must connect to the Networking service. First of all, it is because
the share services require the option to self-manage share servers. Also, for
authentication and authorization of the clients, the Shared File Systems
service can be optionally configured to work with different network
authentication services, like LDAP, Kerberos protocols, or Microsoft Active
Directory.

.. toctree::

   shared_file_systems_share_networks.rst
   shared_file_systems_network_plugins.rst
