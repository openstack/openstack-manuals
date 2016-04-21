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

      Edit the ``/etc/keystone/keystone-paste.ini``
      file and remove ``admin_token_auth`` from the
      ``[pipeline:public_api]``, ``[pipeline:admin_api]``,
      and ``[pipeline:api_v3]`` sections.

2. Unset the temporary ``OS_TOKEN`` and ``OS_URL`` environment variables:

   .. code-block:: console

      $ unset OS_TOKEN OS_URL

3. As the ``admin`` user, request an authentication token:

   .. code-block:: console

      $ openstack --os-auth-url http://controller:35357/v3 \
        --os-project-domain-name default --os-user-domain-name default \
        --os-project-name admin --os-username admin token issue
      Password:
      +------------+-----------------------------------------------------------------+
      | Field      | Value                                                           |
      +------------+-----------------------------------------------------------------+
      | expires    | 2016-02-12T20:14:07.056119Z                                     |
      | id         | gAAAAABWvi7_B8kKQD9wdXac8MoZiQldmjEO643d-e_j-XXq9AmIegIbA7UHGPv |
      |            | atnN21qtOMjCFWX7BReJEQnVOAj3nclRQgAYRsfSU_MrsuWb4EDtnjU7HEpoBb4 |
      |            | o6ozsA_NmFWEpLeKy0uNn_WeKbAhYygrsmQGA49dclHVnz-OMVLiyM9ws       |
      | project_id | 343d245e850143a096806dfaefa9afdc                                |
      | user_id    | ac3377633149401296f6c0d92d79dc16                                |
      +------------+-----------------------------------------------------------------+

   .. note::

      This command uses the password for the ``admin`` user.

4. As the ``demo`` user, request an authentication token:

   .. code-block:: console

      $ openstack --os-auth-url http://controller:5000/v3 \
        --os-project-domain-name default --os-user-domain-name default \
        --os-project-name demo --os-username demo token issue
      Password:
      +------------+-----------------------------------------------------------------+
      | Field      | Value                                                           |
      +------------+-----------------------------------------------------------------+
      | expires    | 2016-02-12T20:15:39.014479Z                                     |
      | id         | gAAAAABWvi9bsh7vkiby5BpCCnc-JkbGhm9wH3fabS_cY7uabOubesi-Me6IGWW |
      |            | yQqNegDDZ5jw7grI26vvgy1J5nCVwZ_zFRqPiz_qhbq29mgbQLglbkq6FQvzBRQ |
      |            | JcOzq3uwhzNxszJWmzGC7rJE_H0A_a3UFhqv8M4zMRYSbS2YF0MyFmp_U       |
      | project_id | ed0b60bf607743088218b0a533d5943f                                |
      | user_id    | 58126687cbcc4888bfa9ab73a2256f27                                |
      +------------+-----------------------------------------------------------------+

   .. note::

      This command uses the password for the ``demo``
      user and API port 5000 which only allows regular (non-admin)
      access to the Identity service API.
