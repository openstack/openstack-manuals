.. meta::
   :scope: admin_only

============================================
Create and manage services and service users
============================================
The Identity Service enables you to define services, as
follows:

- Service catalog template. The Identity Service acts
  as a service catalog of endpoints for other OpenStack
  services. The :file:`etc/default_catalog.templates`
  template file defines the endpoints for services. When
  the Identity Service uses a template file back end,
  any changes that are made to the endpoints are cached.
  These changes do not persist when you restart the
  service or reboot the machine.
- An SQL back end for the catalog service. When the
  Identity Service is online, you must add the services
  to the catalog. When you deploy a system for
  production, use the SQL back end.

The ``auth_token`` middleware supports the
use of either a shared secret or users for each
service.

To authenticate users against the Identity Service, you must
create a service user for each OpenStack service. For example,
create a service user for the Compute, Block Storage, and
Networking services.

To configure the OpenStack services with service users,
create a project for all services and create users for each
service. Assign the admin role to each service user and
project pair. This role enables users to validate tokens and
authenticate and authorize other user requests.

Create a service
~~~~~~~~~~~~~~~~

#. List the available services:

   .. code::

      $ keystone service-list
      +----------------------------------+----------+----------+---------------------------+
      |                id                |   name   |   type   |        description        |
      +----------------------------------+----------+----------+---------------------------+
      | 9816f1faaa7c4842b90fb4821cd09223 |  cinder  |  volume  |   Cinder Volume Service   |
      | da8cf9f8546b4a428c43d5e032fe4afc |   ec2    |   ec2    |  EC2 Compatibility Layer  |
      | 5f105eeb55924b7290c8675ad7e294ae |  glance  |  image   |    Glance Image Service   |
      | dcaa566e912e4c0e900dc86804e3dde0 | keystone | identity | Keystone Identity Service |
      | 4a715cfbc3664e9ebf388534ff2be76a |   nova   | compute  |    Nova Compute Service   |
      | 6feb2e0b98874d88bee221974770e372 |    s3    |    s3    |             S3            |
      +----------------------------------+----------+----------+---------------------------+

#. To create a service, run this command::

   $ keystone service-create --name SERVICE_NAME --type SERVICE_TYPE --description SERVICE-DESCRIPTION

   The arguments are:
      - ``service_name``: the unique name of the new service.
      - ``service_type``: the service type, such as ``identity``,
        ``compute``, ``network``, ``image``, ``object-store``
        or any other service identifier string.
      - ``service_description``: the description of the service.

   For example, to create a ``swift`` service of type
   ``object-store``, run this command:

   .. code::

      $ keystone service-create --name swift --type object-store --description "object store service"
      +-------------+----------------------------------+
      |   Property  |              Value               |
      +-------------+----------------------------------+
      | description |       object store service       |
      |   enabled   |               True               |
      |      id     | 84c23f4b942c44c38b9c42c5e517cd9a |
      |     name    |              swift               |
      |     type    |           object-store           |
      +-------------+----------------------------------+

#. To get details for a service, run this command::

      $ keystone service-get SERVICE_ID

   For example:

   .. code::

      $ keystone service-get 84c23f4b942c44c38b9c42c5e517cd9a
      +-------------+----------------------------------+
      |   Property  |              Value               |
      +-------------+----------------------------------+
      | description |       object store service       |
      |   enabled   |               True               |
      |      id     | 84c23f4b942c44c38b9c42c5e517cd9a |
      |     name    |              swift               |
      |     type    |           object-store           |
      +-------------+----------------------------------+

Create service users
~~~~~~~~~~~~~~~~~~~~

#. Create a project for the service users.
   Typically, this project is named ``service``,
   but choose any name you like::

   $ keystone tenant-create --name service

   The output shows the ID for the project.

   Make a note of this ID. You need it to create
   service users and assign roles.

   .. code::

      +-------------+----------------------------------+
      |   Property  |              Value               |
      +-------------+----------------------------------+
      | description |                                  |
      |   enabled   |               True               |
      |      id     | 3e9f3f5399624b2db548d7f871bd5322 |
      |     name    |              service             |
      +-------------+----------------------------------+

#. Create service users for the relevant services for your
   deployment.

#. To assign the admin role to the service user-project pairs,
   run this command to get the ID of the admin role:

   .. code::

      $ keystone role-list
      +----------------------------------+---------------+
      |                id                |      name     |
      +----------------------------------+---------------+
      | 71ccc37d41c8491c975ae72676db687f |     Member    |
      | 149f50a1fe684bfa88dae76a48d26ef7 | ResellerAdmin |
      | 9fe2ff9ee4384b1894a90878d3e92bab |    _member_   |
      | 6ecf391421604da985db2f141e46a7c8 |     admin     |
      | deb4fffd123c4d02a907c2c74559dccf |  anotherrole  |
      | bef1f95537914b1295da6aa038ef4de6 |    new-role   |
      +----------------------------------+---------------+

#. Assign the admin role to the user-project pair::

   $ keystone user-role-add --user SERVICE_USER_ID --role ADMIN_ROLE_ID --tenant SERVICE_PROJECT_ID

Delete a service
~~~~~~~~~~~~~~~~
To delete a specified service, specify its ID::

$ keystone service-delete SERVICE_ID
