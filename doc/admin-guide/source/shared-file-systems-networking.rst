.. _shared_file_systems_networking:

==========
Networking
==========

Unlike the OpenStack Block Storage service, the Shared File Systems service
must connect to the Networking service. The share service requires the
option to self-manage share servers. For client authentication and
authorization, you can configure the Shared File Systems service to
work with different network authentication services, like LDAP, Kerberos
protocols, or Microsoft Active Directory.

.. toctree::

   shared-file-systems-share-networks.rst
   shared-file-systems-network-plugins.rst
