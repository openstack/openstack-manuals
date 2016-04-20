Create a domain, projects, users, and roles
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Identity service provides authentication services for each OpenStack
service. The authentication service uses a combination of :term:`domains
<domain>`, :term:`projects<project>` (tenants), :term:`users<user>`, and
:term:`roles<role>`.

#. Create the ``default`` domain:

   .. code-block:: console

      $ openstack domain create --description "Default Domain" default
      +-------------+----------------------------------+
      | Field       | Value                            |
      +-------------+----------------------------------+
      | description | Default Domain                   |
      | enabled     | True                             |
      | id          | e0353a670a9e496da891347c589539e9 |
      | name        | default                          |
      +-------------+----------------------------------+

#. Create an administrative project, user, and role for administrative
   operations in your environment:

   * Create the ``admin`` project:

     .. code-block:: console

        $ openstack project create --domain default \
          --description "Admin Project" admin
        +-------------+----------------------------------+
        | Field       | Value                            |
        +-------------+----------------------------------+
        | description | Admin Project                    |
        | domain_id   | e0353a670a9e496da891347c589539e9 |
        | enabled     | True                             |
        | id          | 343d245e850143a096806dfaefa9afdc |
        | is_domain   | False                            |
        | name        | admin                            |
        | parent_id   | None                             |
        +-------------+----------------------------------+

     .. note::

        OpenStack generates IDs dynamically, so you will see different
        values in the example command output.

   * Create the ``admin`` user:

     .. code-block:: console

        $ openstack user create --domain default \
          --password-prompt admin
        User Password:
        Repeat User Password:
        +-----------+----------------------------------+
        | Field     | Value                            |
        +-----------+----------------------------------+
        | domain_id | e0353a670a9e496da891347c589539e9 |
        | enabled   | True                             |
        | id        | ac3377633149401296f6c0d92d79dc16 |
        | name      | admin                            |
        +-----------+----------------------------------+

   * Create the ``admin`` role:

     .. code-block:: console

        $ openstack role create admin
        +-----------+----------------------------------+
        | Field     | Value                            |
        +-----------+----------------------------------+
        | domain_id | None                             |
        | id        | cd2cb9a39e874ea69e5d4b896eb16128 |
        | name      | admin                            |
        +-----------+----------------------------------+

   * Add the ``admin`` role to the ``admin`` project and user:

     .. code-block:: console

        $ openstack role add --project admin --user admin admin

     .. note::

        This command provides no output.

     .. note::

        Any roles that you create must map to roles specified in the
        ``policy.json`` file in the configuration file directory of each
        OpenStack service. The default policy for most services grants
        administrative access to the ``admin`` role. For more information,
        see the `Operations Guide - Managing Projects and
        Users <http://docs.openstack.org/openstack-ops/content/projects_users.html>`__.

#. This guide uses a service project that contains a unique user for each
   service that you add to your environment. Create the ``service``
   project:

   .. code-block:: console

      $ openstack project create --domain default \
        --description "Service Project" service
      +-------------+----------------------------------+
      | Field       | Value                            |
      +-------------+----------------------------------+
      | description | Service Project                  |
      | domain_id   | e0353a670a9e496da891347c589539e9 |
      | enabled     | True                             |
      | id          | 894cdfa366d34e9d835d3de01e752262 |
      | is_domain   | False                            |
      | name        | service                          |
      | parent_id   | None                             |
      +-------------+----------------------------------+

#. Regular (non-admin) tasks should use an unprivileged project and user.
   As an example, this guide creates the ``demo`` project and user.

   * Create the ``demo`` project:

     .. code-block:: console

        $ openstack project create --domain default \
          --description "Demo Project" demo
        +-------------+----------------------------------+
        | Field       | Value                            |
        +-------------+----------------------------------+
        | description | Demo Project                     |
        | domain_id   | e0353a670a9e496da891347c589539e9 |
        | enabled     | True                             |
        | id          | ed0b60bf607743088218b0a533d5943f |
        | is_domain   | False                            |
        | name        | demo                             |
        | parent_id   | None                             |
        +-------------+----------------------------------+

     .. note::

         Do not repeat this step when creating additional users for this
         project.

   * Create the ``demo`` user:

     .. code-block:: console

        $ openstack user create --domain default \
          --password-prompt demo
        User Password:
        Repeat User Password:
        +-----------+----------------------------------+
        | Field     | Value                            |
        +-----------+----------------------------------+
        | domain_id | e0353a670a9e496da891347c589539e9 |
        | enabled   | True                             |
        | id        | 58126687cbcc4888bfa9ab73a2256f27 |
        | name      | demo                             |
        +-----------+----------------------------------+

   * Create the ``user`` role:

     .. code-block:: console

        $ openstack role create user
        +-----------+----------------------------------+
        | Field     | Value                            |
        +-----------+----------------------------------+
        | domain_id | None                             |
        | id        | 997ce8d05fc143ac97d83fdfb5998552 |
        | name      | user                             |
        +-----------+----------------------------------+

   * Add the ``user`` role to the ``demo`` project and user:

     .. code-block:: console

        $ openstack role add --project demo --user demo user

     .. note::

        This command provides no output.

.. note::

   You can repeat this procedure to create additional projects and
   users.
