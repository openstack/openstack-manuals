.. _integrate-assignment-backend-ldap:

=======================================
Integrate assignment back end with LDAP
=======================================

When you configure the OpenStack Identity service to use LDAP servers,
you can split authentication and authorization using the *assignment*
feature. Integrating the *assignment* back end with LDAP allows
administrators to use projects (tenant), roles, domains, and role
assignments in LDAP.

.. note::

   Be aware of domain-specific back end limitations when configuring
   OpenStack Identity. The OpenStack Identity service
   does not support domain-specific assignment back ends.
   Using LDAP as an assignment back end is not
   recommended.

.. important::

   For OpenStack Identity assignments to access LDAP servers, you must
   define the destination LDAP server in the ``keystone.conf`` file.
   For more information, see :ref:`integrate-identity-with-ldap`.

**To integrate assignment back ends with LDAP**

#. Enable the assignment driver. In the ``[assignment]`` section, set the
   ``driver`` configuration key to
   ``keystone.assignment.backends.sql.Assignment``:

   .. code-block:: ini

      [assignment]
      #driver = keystone.assignment.backends.sql.Assignment
      driver = keystone.assignment.backends.ldap.Assignment

#. Create the organizational units (OU) in the LDAP directory, and define
   their corresponding location in the ``keystone.conf`` file:

   .. code-block:: ini

      [ldap]
      role_tree_dn =
      role_objectclass = inetOrgPerson

      project_tree_dn = ou=Groups,dc=example,dc=org
      project_objectclass = groupOfNames

   .. note::

      These schema attributes are extensible for compatibility with
      various schemas. For example, this entry maps to the groupOfNames
      attribute in Active Directory:

      .. code-block:: ini

         project_objectclass = groupOfNames

#. A read-only implementation is recommended for LDAP integration. These
   permissions are applied to object types in the ``keystone.conf`` file:

   .. code-block:: ini

      [ldap]
      role_allow_create = False
      role_allow_update = False
      role_allow_delete = False

      project_allow_create = False
      project_allow_update = False
      project_allow_delete = False

#. Restart the OpenStack Identity service.

   .. warning::

      During service restart, authentication and authorization are
      unavailable.

**Additional LDAP integration settings.**

Set these options in the ``/etc/keystone/keystone.conf`` file for a
single LDAP server, or ``/etc/keystone/domains/keystone.DOMAIN_NAME.conf``
files for multiple back ends.

Filters
  Use filters to control the scope of data presented through LDAP.

  .. code-block:: ini

     [ldap]
     project_filter = (member=cn=openstack-user,ou=workgroups,
     dc=example,dc=org)
     role_filter =

  .. warning::

     Filtering method

Assignment attribute mapping
  Mask account status values (include any additional attribute
  mappings) for compatibility with various directory services.
  Superfluous accounts are filtered with user\_filter.

  Setting attribute ignore to list of attributes stripped off on
  update.

  .. code-block:: ini

     [ldap]
     role_id_attribute = cn
     role_name_attribute = ou
     role_member_attribute = roleOccupant
     role_additional_attribute_mapping =
     role_attribute_ignore =

     project_id_attribute = cn
     project_name_attribute = ou
     project_member_attribute = member
     project_desc_attribute = description
     project_enabled_attribute = enabled
     project_domain_id_attribute = businessCategory
     project_additional_attribute_mapping =
     project_attribute_ignore =

Enabled emulation
  An alternative method to determine if a project is enabled or not is
  to check if that project is a member of the emulation group.

  Use DN of the group entry to hold enabled projects when using
  enabled emulation.

  .. code-block:: ini

     [ldap]
     project_enabled_emulation = false
     project_enabled_emulation_dn = false
