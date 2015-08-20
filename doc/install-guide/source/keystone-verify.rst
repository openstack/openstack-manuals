================
Verify operation
================

Verify operation of the Identity service before installing other
services.

.. only:: obs or ubuntu

   1. For security reasons, disable the temporary authentication
      token mechanism:

      Edit the :file:`/etc/keystone/keystone-paste.ini`
      file and remove ``admin_token_auth`` from the
      ``[pipeline:public_api]``, ``[pipeline:admin_api]``,
      and ``[pipeline:api_v3]`` sections.

.. only:: rdo

   1. For security reasons, disable the temporary authentication
      token mechanism:

      Edit the :file:`/usr/share/keystone/keystone-dist-paste.ini`
      file and remove ``admin_token_auth`` from the
      ``[pipeline:public_api]``, ``[pipeline:admin_api]``,
      and ``[pipeline:api_v3]`` sections.

2. Unset the temporary ``OS_TOKEN`` and ``OS_URL`` environment variables:

   .. code-block:: console

      $ unset OS_TOKEN OS_URL

3. As the ``admin`` user, request an authentication token from
   the Identity version 2.0 API:

   .. code-block:: console

      $ openstack --os-auth-url http://controller:35357 \
        --os-project-name admin --os-username admin \
        --os-auth-type password token issue
      Password:
      +------------+----------------------------------+
      | Field      | Value                            |
      +------------+----------------------------------+
      | expires    | 2015-03-24T18:55:01Z             |
      | id         | ff5ed908984c4a4190f584d826d75fed |
      | project_id | cf12a15c5ea84b019aec3dc45580896b |
      | user_id    | 4d411f2291f34941b30eef9bd797505a |
      +------------+----------------------------------+

   .. note::

      This command uses the password for the ``admin`` user.

4. The Identity version 3 API adds support for domains that contain
   projects and users. Projects and users can use the same names in
   different domains. Therefore, in order to use the version 3 API,
   requests must also explicitly contain at least the ``default``
   domain or use IDs. For simplicity, this guide explicitly uses
   the ``default`` domain so examples can use names instead of IDs.

   .. code-block:: console

      $ openstack --os-auth-url http://controller:35357 \
        --os-project-domain-id default --os-user-domain-id default \
        --os-project-name admin --os-username admin --os-auth-type password \
        token issue
      Password:
      +------------+----------------------------------+
      | Field      | Value                            |
      +------------+----------------------------------+
      | expires    | 2015-03-24T18:55:01Z             |
      | id         | ff5ed908984c4a4190f584d826d75fed |
      | project_id | cf12a15c5ea84b019aec3dc45580896b |
      | user_id    | 4d411f2291f34941b30eef9bd797505a |
      +------------+----------------------------------+

   .. note::

      This command uses the password for the ``admin`` user.

5. As the ``admin`` user, list projects to verify that the
   ``admin`` user can execute admin-only CLI commands and
   that the Identity service contains the projects that you
   created in :doc:`keystone-users`:

   .. code-block:: console

      $ openstack --os-auth-url http://controller:35357 \
        --os-project-name admin --os-username admin \
        --os-auth-type password project list
      Password:
      +----------------------------------+---------+
      | ID                               | Name    |
      +----------------------------------+---------+
      | 55cbd79c0c014c8a95534ebd16213ca1 | service |
      | ab8ea576c0574b6092bb99150449b2d3 | demo    |
      | cf12a15c5ea84b019aec3dc45580896b | admin   |
      +----------------------------------+---------+

   .. note::

      This command uses the password for the ``admin`` user.

6. As the ``admin`` user, list users to verify that the Identity service
   contains the users that you created in :doc:`keystone-users`:

   .. code-block:: console

      $ openstack --os-auth-url http://controller:35357 \
        --os-project-name admin --os-username admin \
        --os-auth-type password user list
      Password:
      +----------------------------------+-------+
      | ID                               | Name  |
      +----------------------------------+-------+
      | 4d411f2291f34941b30eef9bd797505a | admin |
      | 3a81e6c8103b46709ef8d141308d4c72 | demo  |
      +----------------------------------+-------+

   .. note::

      This command uses the password for the ``admin`` user.

7. As the ``admin`` user, list roles to verify that the Identity service
   contains the role that you created in :doc:`keystone-users`:

   .. code-block:: console

      $ openstack --os-auth-url http://controller:35357 \
        --os-project-name admin --os-username admin \
        --os-auth-type password role list
      Password:
      +----------------------------------+-------+
      | ID                               | Name  |
      +----------------------------------+-------+
      | 9fe2ff9ee4384b1894a90878d3e92bab | user  |
      | cd2cb9a39e874ea69e5d4b896eb16128 | admin |
      +----------------------------------+-------+

   .. note::

      This command uses the password for the ``admin`` user.

8. As the ``demo`` user, request an authentication token from
   the Identity version 3 API:

   .. code-block:: console

      $ openstack --os-auth-url http://controller:5000 \
        --os-project-domain-id default --os-user-domain-id default \
        --os-project-name demo --os-username demo --os-auth-type password \
        token issue
      Password:
      +------------+----------------------------------+
      |  Property  |              Value               |
      +------------+----------------------------------+
      |   expires  |       2014-10-10T12:51:33Z       |
      |     id     | 1b87ceae9e08411ba4a16e4dada04802 |
      | project_id | 4aa51bb942be4dd0ac0555d7591f80a6 |
      |  user_id   | 7004dfa0dda84d63aef81cf7f100af01 |
      +------------+----------------------------------+

   .. note::

      This command uses the password for the ``demo``
      user and API port 5000 which only allows regular (non-admin)
      access to the Identity service API.

9. As the ``demo`` user, attempt to list users
   to verify that it cannot execute admin-only CLI commands:

   .. code-block:: console

      $ openstack --os-auth-url http://controller:5000 \
        --os-project-domain-id default --os-user-domain-id default \
        --os-project-name demo --os-username demo \
        --os-auth-type password user list
      Password:
      ERROR: openstack You are not authorized to perform the
      requested action, admin_required. (HTTP 403)
