=================================
Create projects, users, and roles
=================================

The Identity service provides authentication services for each OpenStack
service. The authentication service uses a combination of :term:`domains
<domain>`, :term:`projects<project>` (tenants), :term:`users<user>`, and
:term:`roles<role>`.

.. note::

   For simplicity, this guide implicitly uses the ``default`` domain.

.. only:: debian

   .. note::

      The packages can automatically create the service entity and API
      endpoint.

To create tenants, users, and roles
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Create an administrative project, user, and role for administrative
   operations in your environment:

   a. Create the ``admin`` project:

      .. code-block:: console

         $ openstack project create --description "Admin Project" admin
         +-------------+----------------------------------+
         | Field       | Value                            |
         +-------------+----------------------------------+
         | description | Admin Project                    |
         | enabled     | True                             |
         | id          | cf12a15c5ea84b019aec3dc45580896b |
         | name        | admin                            |
         +-------------+----------------------------------+

      .. note::

         OpenStack generates IDs dynamically, so you will see different
         values in the example command output.

   b. Create the ``admin`` user:

      .. code-block:: console

         $ openstack user create --password-prompt admin
         User Password:
         Repeat User Password:
         +------------+----------------------------------+
         | Field      | Value                            |
         +------------+----------------------------------+
         | email      | None                             |
         | enabled    | True                             |
         | id         | 4d411f2291f34941b30eef9bd797505a |
         | name       | admin                            |
         | username   | admin                            |
         +------------+----------------------------------+

   c. Create the ``admin`` role:

      .. code-block:: console

         $ openstack role create admin
         +-------+----------------------------------+
         | Field | Value                            |
         +-------+----------------------------------+
         | id    | cd2cb9a39e874ea69e5d4b896eb16128 |
         | name  | admin                            |
         +-------+----------------------------------+

   d. Add the ``admin`` role to the ``admin`` project and user:

      .. code-block:: console

         $ openstack role add --project admin --user admin admin
         +-------+----------------------------------+
         | Field | Value                            |
         +-------+----------------------------------+
         | id    | cd2cb9a39e874ea69e5d4b896eb16128 |
         | name  | admin                            |
         +-------+----------------------------------+

      .. note::

         Any roles that you create must map to roles specified in the
         :file:`policy.json` file in the configuration file directory of each
         OpenStack service. The default policy for most services grants
         administrative access to the ``admin`` role. For more information,
         see the `Operations Guide - Managing Projects and
         Users <http://docs.openstack.org/openstack-ops/content/projects_users.html>`__.

#. This guide uses a service project that contains a unique user for each
   service that you add to your environment.

   a. Create the ``service`` project:

      .. code-block:: console

         $ openstack project create --description "Service Project" service
         +-------------+----------------------------------+
         | Field       | Value                            |
         +-------------+----------------------------------+
         | description | Service Project                  |
         | enabled     | True                             |
         | id          | 55cbd79c0c014c8a95534ebd16213ca1 |
         | name        | service                          |
         +-------------+----------------------------------+

#. Regular (non-admin) tasks should use an unprivileged project and user.
   As an example, this guide creates the ``demo`` project and user.

   a. Create the ``demo`` project:

      .. code-block:: console

         $ openstack project create --description "Demo Project" demo
         +-------------+----------------------------------+
         | Field       | Value                            |
         +-------------+----------------------------------+
         | description | Demo Project                     |
         | enabled     | True                             |
         | id          | ab8ea576c0574b6092bb99150449b2d3 |
         | name        | demo                             |
         +-------------+----------------------------------+

      .. note::

         Do not repeat this step when creating additional users for this
         project.

   b. Create the ``demo`` user:

      .. code-block:: console

         $ openstack user create --password-prompt demo
         User Password:
         Repeat User Password:
         +------------+----------------------------------+
         | Field      | Value                            |
         +------------+----------------------------------+
         | email      | None                             |
         | enabled    | True                             |
         | id         | 3a81e6c8103b46709ef8d141308d4c72 |
         | name       | demo                             |
         | username   | demo                             |
         +------------+----------------------------------+

   c. Create the ``user`` role:

      .. code-block:: console

         $ openstack role create user
         +-------+----------------------------------+
         | Field | Value                            |
         +-------+----------------------------------+
         | id    | 9fe2ff9ee4384b1894a90878d3e92bab |
         | name  | user                             |
         +-------+----------------------------------+

   d. Add the ``user`` role to the ``demo`` project and user:

      .. code-block:: console

         $ openstack role add --project demo --user demo user
         +-------+----------------------------------+
         | Field | Value                            |
         +-------+----------------------------------+
         | id    | 9fe2ff9ee4384b1894a90878d3e92bab |
         | name  | user                             |
         +-------+----------------------------------+

.. note::

   You can repeat this procedure to create additional projects and
   users.
