.. _shared_file_systems_security_services:

=================
Security services
=================

A security service stores client configuration information used for
authentication and authorization (AuthN/AuthZ). For example, a share server
will be the client for an existing service such as LDAP, Kerberos, or
Microsoft Active Directory.

You can associate a share with one to three security service types:

- ``ldap``: LDAP.

- ``kerberos``: Kerberos.

- ``active_directory``: Microsoft Active Directory.

You can configure a security service with these options:

- A DNS IP address.

- An IP address or host name.

- A domain.

- A user or group name.

- The password for the user, if you specify a user name.

You can add the security service to the
:ref:`share network <shared_file_systems_share_networks>`.

To create a security service, specify the security service type, a
description of a security service, DNS IP address used inside project's
network, security service IP address or host name, domain, security
service user or group used by project, and a password for the user. The
share name is optional.

Create a ``ldap`` security service:

.. code-block:: console

   $ manila security-service-create ldap --dns-ip 8.8.8.8 --server 10.254.0.3 --name my_ldap_security_service
   +-------------+--------------------------------------+
   | Property    | Value                                |
   +-------------+--------------------------------------+
   | status      | new                                  |
   | domain      | None                                 |
   | password    | None                                 |
   | name        | my_ldap_security_service             |
   | dns_ip      | 8.8.8.8                              |
   | created_at  | 2015-09-25T10:19:06.019527           |
   | updated_at  | None                                 |
   | server      | 10.254.0.3                           |
   | user        | None                                 |
   | project_id  | 20787a7ba11946adad976463b57d8a2f     |
   | type        | ldap                                 |
   | id          | 413479b2-0d20-4c58-a9d3-b129fa592d8e |
   | description | None                                 |
   +-------------+--------------------------------------+

To create ``kerberos`` security service, run:

.. code-block:: console

   $ manila security-service-create kerberos --server 10.254.0.3 --user demo --password secret --name my_kerberos_security_service --description "Kerberos security service"
   +-------------+--------------------------------------+
   | Property    | Value                                |
   +-------------+--------------------------------------+
   | status      | new                                  |
   | domain      | None                                 |
   | password    | secret                               |
   | name        | my_kerberos_security_service         |
   | dns_ip      | None                                 |
   | created_at  | 2015-09-25T10:26:03.211849           |
   | updated_at  | None                                 |
   | server      | 10.254.0.3                           |
   | user        | demo                                 |
   | project_id  | 20787a7ba11946adad976463b57d8a2f     |
   | type        | kerberos                             |
   | id          | 7f46a447-2534-453d-924d-bd7c8e63bbec |
   | description | Kerberos security service            |
   +-------------+--------------------------------------+

To see the list of created security service use
:command:`manila security-service-list`:

.. code-block:: console

   $ manila security-service-list
   +--------------------------------------+------------------------------+--------+----------+
   | id                                   | name                         | status | type     |
   +--------------------------------------+------------------------------+--------+----------+
   | 413479b2-0d20-4c58-a9d3-b129fa592d8e | my_ldap_security_service     | new    | ldap     |
   | 7f46a447-2534-453d-924d-bd7c8e63bbec | my_kerberos_security_service | new    | kerberos |
   +--------------------------------------+------------------------------+--------+----------+

You can add a security service to the existing
:ref:`share network <shared_file_systems_share_networks>`, which is not
yet used (a ``share network`` not associated with a share).

Add a security service to the share network with
``share-network-security-service-add`` specifying share network and
security service. The command returns information about the
security service. You can see view new attributes and ``share_networks``
using the associated share network ID.

.. code-block:: console

   $ manila share-network-security-service-add share_net2 my_ldap_security_service

   $ manila security-service-show my_ldap_security_service
   +----------------+-------------------------------------------+
   | Property       | Value                                     |
   +----------------+-------------------------------------------+
   | status         | new                                       |
   | domain         | None                                      |
   | password       | None                                      |
   | name           | my_ldap_security_service                  |
   | dns_ip         | 8.8.8.8                                   |
   | created_at     | 2015-09-25T10:19:06.000000                |
   | updated_at     | None                                      |
   | server         | 10.254.0.3                                |
   | share_networks | [u'6d36c41f-d310-4aff-a0c2-ffd870e91cab'] |
   | user           | None                                      |
   | project_id     | 20787a7ba11946adad976463b57d8a2f          |
   | type           | ldap                                      |
   | id             | 413479b2-0d20-4c58-a9d3-b129fa592d8e      |
   | description    | None                                      |
   +----------------+-------------------------------------------+

It is possible to see the list of security services associated
with a given share network. List security services for ``share_net2``
share network with:

.. code-block:: console

   $ manila share-network-security-service-list share_net2
   +--------------------------------------+--------------------------+--------+------+
   | id                                   | name                     | status | type |
   +--------------------------------------+--------------------------+--------+------+
   | 413479b2-0d20-4c58-a9d3-b129fa592d8e | my_ldap_security_service | new    | ldap |
   +--------------------------------------+--------------------------+--------+------+

You also can dissociate a security service from the share network
and confirm that the security service now has an empty list of
share networks:

.. code-block:: console

   $ manila share-network-security-service-remove share_net2 my_ldap_security_service

   $ manila security-service-show my_ldap_security_service
   +----------------+--------------------------------------+
   | Property       | Value                                |
   +----------------+--------------------------------------+
   | status         | new                                  |
   | domain         | None                                 |
   | password       | None                                 |
   | name           | my_ldap_security_service             |
   | dns_ip         | 8.8.8.8                              |
   | created_at     | 2015-09-25T10:19:06.000000           |
   | updated_at     | None                                 |
   | server         | 10.254.0.3                           |
   | share_networks | []                                   |
   | user           | None                                 |
   | project_id     | 20787a7ba11946adad976463b57d8a2f     |
   | type           | ldap                                 |
   | id             | 413479b2-0d20-4c58-a9d3-b129fa592d8e |
   | description    | None                                 |
   +----------------+--------------------------------------+

The Shared File Systems service allows you to update a security service field
using :command:`manila security-service-update` command with optional
arguments such as ``--dns-ip``, ``--server``, ``--domain``,
``--user``, ``--password``, ``--name``, or
``--description``.

To remove a security service not associated with any share networks
run:

.. code-block:: console

   $ manila security-service-delete my_ldap_security_service
