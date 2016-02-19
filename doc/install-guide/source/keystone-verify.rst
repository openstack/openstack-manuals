Verify operation
~~~~~~~~~~~~~~~~

Verify operation of the Identity service before installing other
services.

.. note::

   Perform these commands on the controller node.

.. only:: obs or ubuntu

   #. For security reasons, disable the temporary authentication
      token mechanism:

      Edit the ``/etc/keystone/keystone-paste.ini``
      file and remove ``admin_token_auth`` from the
      ``[pipeline:public_api]``, ``[pipeline:admin_api]``,
      and ``[pipeline:api_v3]`` sections.

.. only:: rdo

   #. For security reasons, disable the temporary authentication
      token mechanism:

      Edit the ``/usr/share/keystone/keystone-dist-paste.ini``
      file and remove ``admin_token_auth`` from the
      ``[pipeline:public_api]``, ``[pipeline:admin_api]``,
      and ``[pipeline:api_v3]`` sections.

2. Unset the temporary ``OS_TOKEN`` and ``OS_URL`` environment variables:

   .. code-block:: console

      $ unset OS_TOKEN OS_URL

3. As the ``admin`` user, request an authentication token:

   .. code-block:: console

      $ openstack --os-auth-url http://controller:35357/v3 \
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

4. As the ``demo`` user, request an authentication token:

   .. code-block:: console

      $ openstack --os-auth-url http://controller:5000/v3 \
        --os-project-domain-id default --os-user-domain-id default \
        --os-project-name demo --os-username demo --os-auth-type password \
        token issue
      Password:
      +------------+----------------------------------+
      | Field      | Value                            |
      +------------+----------------------------------+
      | expires    | 2014-10-10T12:51:33Z             |
      | id         | 1b87ceae9e08411ba4a16e4dada04802 |
      | project_id | 4aa51bb942be4dd0ac0555d7591f80a6 |
      | user_id    | 7004dfa0dda84d63aef81cf7f100af01 |
      +------------+----------------------------------+

   .. note::

      This command uses the password for the ``demo``
      user and API port 5000 which only allows regular (non-admin)
      access to the Identity service API.
