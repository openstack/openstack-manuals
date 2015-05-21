=================================
Manage projects, users, and roles
=================================
As a cloud administrator, you manage projects, users, and
roles. Projects are organizational units in the cloud to which
you can assign users. Projects are also known as ``tenants`` or
``accounts``. Users can be members of one or more projects. Roles
define which actions users can perform. You assign roles to
user-project pairs.

You can define actions for OpenStack service roles in the
``/etc/PROJECT``/policy.json files. For example, define actions for
Compute service roles in the ``/etc/nova/policy.json`` file.

You can manage projects, users, and roles independently from each other.

During cloud set up, the operator defines at least one project, user,
and role.

Learn how to add, update, and delete projects and users, assign users to
one or more projects, and change or remove the assignment. To enable or
temporarily disable a project or user, you update that project or user.
You can also change quotas at the project level.

Before you can delete a user account, you must remove the user account
from its primary project.

Before you can run keystone client commands, you must download and
source an OpenStack RC file. See `Download and source the OpenStack RC
file
<http://docs.openstack.org/user-guide/common/cli_set_environment_variables_using_openstack_rc.html>`__.

Services
~~~~~~~~

To look at your service catalog, use these keystone client commands.

``service-create``
^^^^^^^^^^^^^^^^^^

Keyword arguments:

-  Name

-  Type

-  Description

Example:

.. code::

    $ keystone service-create \
    --name nova \
    --type compute \
    --description "Nova Compute Service"

``service-list``
^^^^^^^^^^^^^^^^

Example:

.. code::

    $ keystone service-list

``service-get``
^^^^^^^^^^^^^^^

Arguments

-  service\_id

Example:

.. code::

    $ keystone service-get 08741d8ed88242ca88d1f61484a0fe3b

``service-delete``
^^^^^^^^^^^^^^^^^^

Arguments

-  service\_id

Example:

.. code::

    $ keystone service-delete 08741d8ed88242ca88d1f61484a0fe3b

Create a tenant (project)
^^^^^^^^^^^^^^^^^^^^^^^^^

A tenant is a group of zero or more users. In nova, a tenant owns
virtual machines. In swift, a tenant owns containers. In the Dashboard,
tenants are represented as projects. Users can be associated with more
than one tenant. Each tenant and user pairing can have a role associated
with it.

#. To list all projects with their ID, name, and whether they are
   enabled or disabled:

   .. code::

       $ keystone tenant-list

   .. code::

       +----------------------------------+--------------------+---------+
       |                id                |        name        | enabled |
       +----------------------------------+--------------------+---------+
       | f7ac731cc11f40efbc03a9f9e1d1d21f |       admin        |   True  |
       | c150ab41f0d9443f8874e32e725a4cc8 |      alt_demo      |   True  |
       | a9debfe41a6d4d09a677da737b907d5e |        demo        |   True  |
       | 9208739195a34c628c58c95d157917d7 | invisible_to_admin |   True  |
       | 3943a53dc92a49b2827fae94363851e1 |      service       |   True  |
       | 80cab5e1f02045abad92a2864cfd76cb |    test_project    |   True  |
       +----------------------------------+--------------------+---------+

#. Create a project named ``new-project``:

   .. code::

       $ keystone tenant-create --name new-project --description 'my new project'

   By default, the project is enabled.

   .. code::

       +-------------+----------------------------------+
       |   Property  |              Value               |
       +-------------+----------------------------------+
       | description |          my new project          |
       |   enabled   |               True               |
       |      id     | 1a4a0618b306462c9830f876b0bd6af2 |
       |     name    |           new-project            |
       +-------------+----------------------------------+

   Note the ID for the project so you can update it in the next
   procedure.

Update a project
^^^^^^^^^^^^^^^^

Specify the project ID to update a project. You can update the name,
description, and enabled status of a project.

#. To temporarily disable a project:

   .. code::

       $ keystone tenant-update PROJECT_ID --enabled false

#. To enable a disabled project:

   .. code::

       $ keystone tenant-update PROJECT_ID --enabled true

#. To update the name of a project:

   .. code::

       $ keystone tenant-update PROJECT_ID --name project-new

#. To verify your changes, show information for the updated project:

   .. code::

       $ keystone tenant-get PROJECT_ID

   .. code::

       +-------------+----------------------------------+
       |   Property  |              Value               |
       +-------------+----------------------------------+
       | description |          my new project          |
       |   enabled   |               True               |
       |      id     | 1a4a0618b306462c9830f876b0bd6af2 |
       |     name    |           project-new            |
       +-------------+----------------------------------+

Delete a project
^^^^^^^^^^^^^^^^

-  To delete a project:

   .. code::

       $ keystone tenant-delete PROJECT_ID

Create a user
^^^^^^^^^^^^^

#. To list all users:

   .. code::

       $ keystone user-list

   The output shows the ID, name, enabled status, and e-mail address for
   each user:

   .. code::

       +----------------------------------+----------+---------+----------------------+
       |                id                |   name   | enabled |        email         |
       +----------------------------------+----------+---------+----------------------+
       | 352b37f5c89144d4ad0534139266d51f |  admin   |   True  |  admin@example.com   |
       | 86c0de739bcb4802b8dc786921355813 |   demo   |   True  |   demo@example.com   |
       | 32ec34aae8ea432e8af560a1cec0e881 |  glance  |   True  |  glance@example.com  |
       | 7047fcb7908e420cb36e13bbd72c972c |   nova   |   True  |   nova@example.com   |
       +----------------------------------+----------+---------+----------------------+

#. To create a user, you must specify a name. Optionally, you can
   specify a tenant ID, password, and email address. It is recommended
   that you include the tenant ID and password because the user cannot
   log in to the dashboard without this information.

   To create the ``new-user`` user:

   .. code::

       $ keystone user-create --name new-user --tenant_id 1a4a0618b306462c9830f876b0bd6af2 --pass PASSWORD

   .. code::

       +----------+----------------------------------+
       | Property |              Value               |
       +----------+----------------------------------+
       |  email   |                                  |
       | enabled  |               True               |
       |    id    | 6e5140962b424cb9814fb172889d3be2 |
       |   name   |             new-user             |
       | tenantId | 1a4a0618b306462c9830f876b0bd6af2 |
       +----------+----------------------------------+

Update a user
^^^^^^^^^^^^^

You can update the name, email address, and enabled status for a user.

#. To temporarily disable a user account:

   .. code::

       $ keystone user-update USER_ID --enabled false

   If you disable a user account, the user cannot log in to the
   dashboard. However, data for the user account is maintained, so you
   can enable the user at any time.

#. To enable a disabled user account:

   .. code::

       $ keystone user-update USER_ID --enabled true

#. To change the name and description for a user account:

   .. code::

       $ keystone user-update USER_ID --name user-new --email new-user@example.com

   .. code::

       User has been updated.

Delete a user
^^^^^^^^^^^^^

-  To delete a specified user account:

   .. code::

       $ keystone user-delete USER_ID

Create and assign a role
^^^^^^^^^^^^^^^^^^^^^^^^

Users can be members of multiple projects. To assign users to multiple
projects, define a role and assign that role to a user-project pair.

#. To list the available roles:

   .. code::

       $ keystone role-list

   .. code::

       +----------------------------------+---------------+
       |                id                |      name     |
       +----------------------------------+---------------+
       | 71ccc37d41c8491c975ae72676db687f |     Member    |
       | 149f50a1fe684bfa88dae76a48d26ef7 | ResellerAdmin |
       | 9fe2ff9ee4384b1894a90878d3e92bab |    _member_   |
       | 6ecf391421604da985db2f141e46a7c8 |     admin     |
       | deb4fffd123c4d02a907c2c74559dccf |  anotherrole  |
       +----------------------------------+---------------+

#. To create the ``new-role`` role:

   .. code::

       $ keystone role-create --name new-role

   .. code::

       +----------+----------------------------------+
       | Property |              Value               |
       +----------+----------------------------------+
       |    id    | bef1f95537914b1295da6aa038ef4de6 |
       |   name   |             new-role             |
       +----------+----------------------------------+

#. To assign a user to a project, you must assign the role to a
   user-project pair. To do this, you need the user, role, and project
   IDs.

   #. To list users:

      .. code::

          $ keystone user-list

      .. code::

          +----------------------------------+----------+---------+----------------------+
          |                id                |   name   | enabled |        email         |
          +----------------------------------+----------+---------+----------------------+
          | 352b37f5c89144d4ad0534139266d51f |  admin   |   True  |  admin@example.com   |
          | 981422ec906d4842b2fc2a8658a5b534 | alt_demo |   True  | alt_demo@example.com |
          | 036e22a764ae497992f5fb8e9fd79896 |  cinder  |   True  |  cinder@example.com  |
          | 86c0de739bcb4802b8dc786921355813 |   demo   |   True  |   demo@example.com   |
          | 32ec34aae8ea432e8af560a1cec0e881 |  glance  |   True  |  glance@example.com  |
          | 7047fcb7908e420cb36e13bbd72c972c |   nova   |   True  |   nova@example.com   |
          +----------------------------------+----------+---------+----------------------+

      Note the ID of the user to which you want to assign the role.

   #. To list role IDs:

      .. code::

          $ keystone role-list

      .. code::

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

      Note the ID of the role that you want to assign.

   #. To list projects:

      .. code::

          $ keystone tenant-list

      .. code::

          +----------------------------------+--------------------+---------+
          |                id                |        name        | enabled |
          +----------------------------------+--------------------+---------+
          | f7ac731cc11f40efbc03a9f9e1d1d21f |       admin        |   True  |
          | c150ab41f0d9443f8874e32e725a4cc8 |      alt_demo      |   True  |
          | a9debfe41a6d4d09a677da737b907d5e |        demo        |   True  |
          | 9208739195a34c628c58c95d157917d7 | invisible_to_admin |   True  |
          | caa9b4ce7d5c4225aa25d6ff8b35c31f |      new-user      |   True  |
          | 1a4a0618b306462c9830f876b0bd6af2 |    project-new     |   True  |
          | 3943a53dc92a49b2827fae94363851e1 |      service       |   True  |
          | 80cab5e1f02045abad92a2864cfd76cb |    test_project    |   True  |
          +----------------------------------+--------------------+---------+

      Note the ID of the project to which you want to assign the role.

#. Assign a role to a user-project pair. In this example, you assign the
   ``new-role`` role to the ``demo`` and ``test-project`` pair:

   .. code::

       $ keystone user-role-add --user USER_ID --role ROLE_ID --tenant TENANT_ID

#. To verify the role assignment:

   .. code::

       $ keystone user-role-list --user USER_ID --tenant TENANT_ID

   .. code::

       +----------------------------------+----------+----------------------------------+----------------------------------+
       |                id                |   name   |             user_id              |            tenant_id             |
       +----------------------------------+----------+----------------------------------+----------------------------------+
       | bef1f95537914b1295da6aa038ef4de6 | new-role | 86c0de739bcb4802b8dc786921355813 | 80cab5e1f02045abad92a2864cfd76cb |
       +----------------------------------+----------+----------------------------------+----------------------------------+

#. To get details for a specified role:

   .. code::

       $ keystone role-get ROLE_ID

   .. code::

       +----------+----------------------------------+
       | Property |              Value               |
       +----------+----------------------------------+
       |    id    | bef1f95537914b1295da6aa038ef4de6 |
       |   name   |             new-role             |
       +----------+----------------------------------+

#. To remove a role from a user-project pair:

   .. code::

       $ keystone user-role-remove --user USER_ID --role ROLE_ID --tenant TENANT_ID

#. To verify the role removal, run the following command:

   .. code::

       $ keystone user-role-list --user USER_ID --tenant TENANT_ID

   If the role was removed, the command output omits the removed role.

