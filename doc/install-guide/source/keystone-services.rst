==========================================
Create the service entity and API endpoint
==========================================

The Identity service provides a catalog of services and their locations.
Each service that you add to your OpenStack environment requires a
:term:`service` entity and several :term:`API endpoints<API endpoint>`
in the catalog.

**To configure prerequisites**

.. only:: obs or rdo or ubuntu

   By default, the Identity service database contains no information to
   support conventional authentication and catalog services. You must use a
   temporary authentication token that you created in the section called
   :doc:`keystone-install` to initialize the service entity and API endpoint
   for the Identity service.

You must pass the value of the authentication token to the :command:`openstack`
command with the ``--os-token`` parameter or set the OS_TOKEN
environment variable. Similarly, you must also pass the value of the
Identity service URL to the :command:`openstack` command with the ``--os-url``
parameter or set the OS_URL environment variable. This guide uses
environment variables to reduce command length.

.. warning::

   For security reasons, do not use the temporary authentication token
   for longer than necessary to initialize the Identity service.

#. Configure the authentication token:

   .. code-block:: console

      $ export OS_TOKEN=ADMIN_TOKEN

   .. only:: obs or rdo or ubuntu

      Replace ``ADMIN_TOKEN`` with the authentication token that you
      generated in the section called :doc:`keystone-install`.
      For example:

   .. code-block:: console

      $ export OS_TOKEN=294a4c8a8a475f9b9836

#. Configure the endpoint URL:

   .. code-block:: console

      $ export OS_URL=http://controller:35357/v2.0

   .. only:: debian

      .. note::

         The packages can automatically create the service entity and API
         endpoint.

**To create the service entity and API endpoint**

#. The Identity service manages a catalog of services in your OpenStack
   environment. Services use this catalog to determine the other services
   available in your environment.

   Create the service entity for the Identity service:

   .. code-block:: console

      $ openstack service create \
        --name keystone --description "OpenStack Identity" identity
      +-------------+----------------------------------+
      | Field       | Value                            |
      +-------------+----------------------------------+
      | description | OpenStack Identity               |
      | enabled     | True                             |
      | id          | 4ddaae90388b4ebc9d252ec2252d8d10 |
      | name        | keystone                         |
      | type        | identity                         |
      +-------------+----------------------------------+

   .. note::

      OpenStack generates IDs dynamically, so you will see different
      values in the example command output.

#. The Identity service manages a catalog of API endpoints associated with
   the services in your OpenStack environment. Services use this catalog to
   determine how to communicate with other services in your environment.

   OpenStack uses three API endpoint variants for each service: admin,
   internal, and public. The admin API endpoint allows modifying users and
   tenants by default, while the public and internal APIs do not. In a
   production environment, the variants might reside on separate networks
   that service different types of users for security reasons. For
   instance, the public API network might be reachable from outside the
   cloud for management tools, the admin API network might be protected,
   while the internal API network is connected to each host. Also,
   OpenStack supports multiple regions for scalability. For simplicity,
   this guide uses the management network for all endpoint variations and
   the default ``RegionOne`` region.

   Create the Identity service API endpoint:

   .. code-block:: console

      $ openstack endpoint create \
        --publicurl http://controller:5000/v2.0 \
        --internalurl http://controller:5000/v2.0 \
        --adminurl http://controller:35357/v2.0 \
        --region RegionOne \
        identity
      +--------------+----------------------------------+
      | Field        | Value                            |
      +--------------+----------------------------------+
      | adminurl     | http://controller:35357/v2.0     |
      | id           | 4a9ffc04b8eb4848a49625a3df0170e5 |
      | internalurl  | http://controller:5000/v2.0      |
      | publicurl    | http://controller:5000/v2.0      |
      | region       | RegionOne                        |
      | service_id   | 4ddaae90388b4ebc9d252ec2252d8d10 |
      | service_name | keystone                         |
      | service_type | identity                         |
      +--------------+----------------------------------+

   .. note::

      Each service that you add to your OpenStack environment requires one
      or more service entities and one API endpoint in the Identity
      service.
