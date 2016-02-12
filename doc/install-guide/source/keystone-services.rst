Create the service entity and API endpoints
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Identity service provides a catalog of services and their locations.
Each service that you add to your OpenStack environment requires a
:term:`service` entity and several :term:`API endpoints<API endpoint>`
in the catalog.

Prerequisites
-------------

.. only:: obs or rdo or ubuntu

   By default, the Identity service database contains no information to
   support conventional authentication and catalog services. You must use a
   temporary authentication token that you created in the section called
   :doc:`keystone-install` to initialize the service entity and API endpoint
   for the Identity service.

.. only:: debian

   .. note::

      The packages can automatically create the service entity and API
      endpoints.

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

      $ export OS_URL=http://controller:35357/v3

   .. only:: debian

      .. note::

         The packages can automatically create the service entity and API
         endpoint.

#. Configure the Identity API version:

   .. code-block:: console

      $ export OS_IDENTITY_API_VERSION=3

Create the service entity and API endpoints
-------------------------------------------

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
   tenants by default, while the public and internal APIs do not allow these
   operations. In a production environment, the variants might reside on
   separate networks that service different types of users for security
   reasons. For instance, the public API network might be visible from the
   Internet so customers can manage their clouds. The admin API network
   might be restricted to operators within the organization that manages
   cloud infrastructure. The internal API network might be restricted to
   the hosts that contain OpenStack services. Also, OpenStack supports
   multiple regions for scalability. For simplicity, this guide uses the
   management network for all endpoint variations and the default
   ``RegionOne`` region.

   Create the Identity service API endpoints:

   .. code-block:: console

      $ openstack endpoint create --region RegionOne \
        identity public http://controller:5000/v3
      +--------------+----------------------------------+
      | Field        | Value                            |
      +--------------+----------------------------------+
      | enabled      | True                             |
      | id           | 30fff543e7dc4b7d9a0fb13791b78bf4 |
      | interface    | public                           |
      | region       | RegionOne                        |
      | region_id    | RegionOne                        |
      | service_id   | 8c8c0927262a45ad9066cfe70d46892c |
      | service_name | keystone                         |
      | service_type | identity                         |
      | url          | http://controller:5000/v3        |
      +--------------+----------------------------------+

      $ openstack endpoint create --region RegionOne \
        identity internal http://controller:5000/v3
      +--------------+----------------------------------+
      | Field        | Value                            |
      +--------------+----------------------------------+
      | enabled      | True                             |
      | id           | 57cfa543e7dc4b712c0ab137911bc4fe |
      | interface    | internal                         |
      | region       | RegionOne                        |
      | region_id    | RegionOne                        |
      | service_id   | 6f8de927262ac12f6066cfe70d99ac51 |
      | service_name | keystone                         |
      | service_type | identity                         |
      | url          | http://controller:5000/v3        |
      +--------------+----------------------------------+

      $ openstack endpoint create --region RegionOne \
        identity admin http://controller:35357/v3
      +--------------+----------------------------------+
      | Field        | Value                            |
      +--------------+----------------------------------+
      | enabled      | True                             |
      | id           | 78c3dfa3e7dc44c98ab1b1379122ecb1 |
      | interface    | admin                            |
      | region       | RegionOne                        |
      | region_id    | RegionOne                        |
      | service_id   | 34ab3d27262ac449cba6cfe704dbc11f |
      | service_name | keystone                         |
      | service_type | identity                         |
      | url          | http://controller:35357/v3       |
      +--------------+----------------------------------+

   .. note::

      Each service that you add to your OpenStack environment requires one
      or more service entities and three API endpoint variants in the Identity
      service.
