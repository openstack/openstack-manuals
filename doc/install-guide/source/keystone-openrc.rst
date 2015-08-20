===========================================
Create OpenStack client environment scripts
===========================================

The previous section used a combination of environment variables and
command options to interact with the Identity service via the
:command:`openstack` client. To increase efficiency of client
operations, OpenStack supports simple client environment scripts also
known as OpenRC files. These scripts typically contain common options for
all clients, but also support unique options. For more information, see the
`OpenStack User Guide <http://docs.openstack.org/user-guide/common/
cli_set_environment_variables_using_openstack_rc.html>`__.

To create the scripts
~~~~~~~~~~~~~~~~~~~~~

Create client environment scripts for the ``admin`` and ``demo``
projects and users. Future portions of this guide reference these
scripts to load appropriate credentials for client operations.

#. Edit the :file:`admin-openrc.sh` file and add the following content:

   .. code-block:: bash
      :linenos:

      export OS_PROJECT_DOMAIN_ID=default
      export OS_USER_DOMAIN_ID=default
      export OS_PROJECT_NAME=admin
      export OS_TENANT_NAME=admin
      export OS_USERNAME=admin
      export OS_PASSWORD=ADMIN_PASS
      export OS_AUTH_URL=http://controller:35357/v3

   Replace ``ADMIN_PASS`` with the password you chose
   for the ``admin`` user in the Identity service.

#. Edit the :file:`demo-openrc.sh` file and add the following content:

   .. code-block:: bash
      :linenos:

      export OS_PROJECT_DOMAIN_ID=default
      export OS_USER_DOMAIN_ID=default
      export OS_PROJECT_NAME=demo
      export OS_TENANT_NAME=demo
      export OS_USERNAME=demo
      export OS_PASSWORD=DEMO_PASS
      export OS_AUTH_URL=http://controller:5000/v3

   Replace ``DEMO_PASS`` with the password you chose
   for the ``demo`` user in the Identity service.

To load client environment scripts
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To run clients as a specific project and user, you can simply load
the associated client environment script prior to running them.
For example:

#. Load the :file:`admin-openrc.sh` file to populate
   environment variables with the location of the Identity service
   and the ``admin`` project and user credentials:

   .. code-block:: console

      $ source admin-openrc.sh

#. Request an authentication token:

   .. code-block:: console

      $ openstack token issue
      +------------+----------------------------------+
      | Field      | Value                            |
      +------------+----------------------------------+
      | expires    | 2015-03-25T01:45:49.950092Z      |
      | id         | cd4110152ac24bdeaa82e1443c910c36 |
      | project_id | cf12a15c5ea84b019aec3dc45580896b |
      | user_id    | 4d411f2291f34941b30eef9bd797505a |
      +------------+----------------------------------+
