=====================================
Example nova.conf configuration files
=====================================

The following sections describe the configuration options in the
``nova.conf`` file. You must copy the ``nova.conf`` file to each
compute node. The sample ``nova.conf`` files show examples of
specific configurations.

Small, private cloud
~~~~~~~~~~~~~~~~~~~~

This example ``nova.conf`` file configures a small private cloud
with cloud controller services, database server, and messaging
server on the same server. In this case, ``CONTROLLER_IP`` represents
the IP address of a central server, ``BRIDGE_INTERFACE`` represents
the bridge such as br100, the ``NETWORK_INTERFACE`` represents an
interface to your VLAN setup, and passwords are represented as
``DB_PASSWORD_COMPUTE`` for your Compute (nova) database password,
and ``RABBIT PASSWORD`` represents the password to your message
queue installation.

.. literalinclude:: nova.conf
   :language: ini

