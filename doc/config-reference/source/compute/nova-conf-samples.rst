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
server on the same server.
In this case,
``CONTROLLER_IP`` represents the IP address of a central server.
And passwords are represented as:
``NOVA_DATABASE_PASSWD`` for your Compute (nova) database password,
``NOVA_API_DATABASE_PASSWD`` for your Compute (nova) API database
password,
``RABBIT_PASSWD`` represents the password to your message queue
installation,
``NOVA_PASSWORD`` for your Compute (nova) service password,
``NEUTRON_PASSWORD`` for your Networking (neutron) service password,
and ``METADATA_SECRET_KEY`` for your neutron metadata service secret key.

.. literalinclude:: nova.conf
   :language: ini

