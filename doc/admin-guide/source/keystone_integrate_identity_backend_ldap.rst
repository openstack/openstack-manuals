.. _integrate-identity-backend-ldap:

=====================================
Integrate Identity back end with LDAP
=====================================

The Identity back end contains information for users, groups, and group
member lists. Integrating the Identity back end with LDAP allows
administrators to use users and groups in LDAP.

.. important::

   For OpenStack Identity service to access LDAP servers, you must
   define the destination LDAP server in the ``keystone.conf`` file.
   For more information, see :ref:`integrate-identity-with-ldap`.

**To integrate one Identity back end with LDAP**

#. Enable the LDAP Identity driver in the ``keystone.conf`` file. This
   allows LDAP as an identity back end:

   .. code-block:: ini

      [identity]
      #driver = keystone.identity.backends.sql.Identity
      driver = keystone.identity.backends.ldap.Identity

#. Create the organizational units (OU) in the LDAP directory, and define
   the corresponding location in the ``keystone.conf`` file:

   .. code-block:: ini

      [ldap]
      user_tree_dn = ou=Users,dc=example,dc=org
      user_objectclass = inetOrgPerson

      group_tree_dn = ou=Groups,dc=example,dc=org
      group_objectclass = groupOfNames

   .. note::

      These schema attributes are extensible for compatibility with
      various schemas. For example, this entry maps to the person
      attribute in Active Directory:

      .. code-block:: ini

         user_objectclass = person

#. A read-only implementation is recommended for LDAP integration. These
   permissions are applied to object types in the ``keystone.conf``:

   .. code-block:: ini

      [ldap]
      user_allow_create = False
      user_allow_update = False
      user_allow_delete = False

      group_allow_create = False
      group_allow_update = False
      group_allow_delete = False

   Restart the OpenStack Identity service.

   .. warning::

      During service restart, authentication and authorization are
      unavailable.

**To integrate multiple Identity back ends with LDAP**

#. Set the following options in the ``/etc/keystone/keystone.conf``
   file:

   #. Enable the LDAP driver:

      .. code-block:: ini

         [identity]
         #driver = keystone.identity.backends.sql.Identity
         driver = keystone.identity.backends.ldap.Identity

   #. Enable domain-specific drivers:

      .. code-block:: ini

         [identity]
         domain_specific_drivers_enabled = True
         domain_config_dir = /etc/keystone/domains

#. Restart the OpenStack Identity service.

   .. warning::

      During service restart, authentication and authorization are
      unavailable.

#. List the domains using the dashboard, or the OpenStackClient CLI. Refer
   to the `Command List
   <http://docs.openstack.org/developer/python-openstackclient/command-list.html>`__
   for a list of OpenStackClient commands.

#. Create domains using OpenStack dashboard, or the OpenStackClient CLI.

#. For each domain, create a domain-specific configuration file in the
   ``/etc/keystone/domains`` directory. Use the file naming convention
   ``keystone.DOMAIN_NAME.conf``, where DOMAIN\_NAME is the domain name
   assigned in the previous step.

   .. note::

      The options set in the
      ``/etc/keystone/domains/keystone.DOMAIN_NAME.conf`` file will
      override options in the ``/etc/keystone/keystone.conf`` file.

#. Define the destination LDAP server in the
   ``/etc/keystone/domains/keystone.DOMAIN_NAME.conf`` file. For example:

   .. code-block:: ini

      [ldap]
      url = ldap://localhost
      user = dc=Manager,dc=example,dc=org
      password = samplepassword
      suffix = dc=example,dc=org
      use_dumb_member = False
      allow_subtree_delete = False

#. Create the organizational units (OU) in the LDAP directories, and define
   their corresponding locations in the
   ``/etc/keystone/domains/keystone.DOMAIN_NAME.conf`` file. For example:

   .. code-block:: ini

      [ldap]
      user_tree_dn = ou=Users,dc=example,dc=org
      user_objectclass = inetOrgPerson

      group_tree_dn = ou=Groups,dc=example,dc=org
      group_objectclass = groupOfNames

   .. note::

      These schema attributes are extensible for compatibility with
      various schemas. For example, this entry maps to the person
      attribute in Active Directory:

      .. code-block:: ini

         user_objectclass = person

#. A read-only implementation is recommended for LDAP integration. These
   permissions are applied to object types in the
   ``/etc/keystone/domains/keystone.DOMAIN_NAME.conf`` file:

   .. code-block:: ini

      [ldap]
      user_allow_create = False
      user_allow_update = False
      user_allow_delete = False

      group_allow_create = False
      group_allow_update = False
      group_allow_delete = False

#. Restart the OpenStack Identity service.

   .. warning::

      During service restart, authentication and authorization are
      unavailable.

**Additional LDAP integration settings**

Set these options in the ``/etc/keystone/keystone.conf`` file for a
single LDAP server, or ``/etc/keystone/domains/keystone.DOMAIN_NAME.conf``
files for multiple back ends. Example configurations appear below each
setting summary:

Filters
   Use filters to control the scope of data presented through LDAP.

   .. code-block:: ini

      [ldap]
      user_filter = (memberof=cn=openstack-users,ou=workgroups,dc=example,dc=org)
      group_filter =

Identity attribute mapping
   Mask account status values (include any additional attribute
   mappings) for compatibility with various directory services.
   Superfluous accounts are filtered with ``user_filter``.

   Setting attribute ignore to list of attributes stripped off on
   update.

   For example, you can mask Active Directory account status attributes
   in the ``keystone.conf`` file:

   .. code-block:: ini

      [ldap]
      user_id_attribute      = cn
      user_name_attribute    = sn
      user_mail_attribute    = mail
      user_pass_attribute    = userPassword
      user_enabled_attribute = userAccountControl
      user_enabled_mask      = 2
      user_enabled_invert    = false
      user_enabled_default   = 51
      user_default_project_id_attribute =
      user_attribute_ignore = default_project_id,tenants
      user_additional_attribute_mapping =

      group_id_attribute     = cn
      group_name_attribute   = ou
      group_member_attribute = member
      group_desc_attribute   = description
      group_attribute_ignore =
      group_additional_attribute_mapping =

Enabled emulation
   An alternative method to determine if a user is enabled or not is by
   checking if that user is a member of the emulation group.

   Use DN of the group entry to hold enabled user when using enabled
   emulation.

   .. code-block:: ini

      [ldap]
      user_enabled_emulation = false
      user_enabled_emulation_dn = false

When you have finished configuration, restart the OpenStack Identity
service.

.. warning::

   During service restart, authentication and authorization are
   unavailable.
