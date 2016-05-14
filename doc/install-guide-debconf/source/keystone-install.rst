.. _keystone-install:

Install and configure
~~~~~~~~~~~~~~~~~~~~~

This section describes how to install and configure the OpenStack
Identity service, code-named keystone, on the controller node. For
performance, this configuration deploys Fernet tokens and the Apache
HTTP server to handle requests.

Install and configure the components
------------------------------------

#. Run the following command to install the packages:

   .. code-block:: console

      # apt-get install keystone

#. Respond to prompts for :doc:`debconf/debconf-dbconfig-common`,
   which will fill the below database access directive.

   .. code-block:: ini

      [database]
      ...
      connection = mysql+pymysql://keystone:KEYSTONE_DBPASS@controller/keystone

   If you decide to not use ``dbconfig-common``, then you have to
   create the database and manage its access rights yourself, and run the
   following by hand.

   .. code-block:: console

      # keystone-manage db_sync

#. Generate a random value to use as the administration token during
   initial configuration:

   .. code-block:: console

      $ openssl rand -hex 10

#. Configure the initial administration token:

   .. image:: figures/debconf-screenshots/keystone_1_admin_token.png
      :scale: 50

   Use the random value that you generated in a previous step. If you
   install using non-interactive mode or you do not specify this token, the
   configuration tool generates a random value.

   Later on, the package will configure the below directive with the value
   you entered:

   .. code-block:: ini

      [DEFAULT]
      ...
      admin_token = ADMIN_TOKEN

#. Create the ``admin`` project and user:

   During the final stage of the package installation, it is possible to
   automatically create an ``admin`` and ``service`` project, and an ``admin``
   user. This can later be used for other OpenStack services to contact the
   Identity service. This is the equivalent of running the below commands:

   .. code-block:: console

      # openstack --os-token ${AUTH_TOKEN} \
        --os-url=http://127.0.0.1:35357/v3/ \
        --os-domain-name default \
        --os-identity-api-version=3 \
        project create --or-show \
        admin --domain default \
        --description "Default Debian admin project"

      # openstack --os-token ${AUTH_TOKEN} \
        --os-url=http://127.0.0.1:35357/v3/ \
        --os-domain-name default \
        --os-identity-api-version=3 \
        project create --or-show \
        service --domain default \
        --description "Default Debian admin project"

      # openstack --os-token ${AUTH_TOKEN} \
        --os-url=http://127.0.0.1:35357/v3/ \
        --os-domain-name default \
        --os-identity-api-version=3 \
        user create --or-show \
        --password ADMIN_PASS \
        --project admin \
        --email root@localhost \
        --enable \
        admin \
        --domain default \
        --description "Default Debian admin user"

      # openstack --os-token ${AUTH_TOKEN} \
        --os-url=http://127.0.0.1:35357/v3/ \
        --os-domain-name default \
        --os-identity-api-version=3 \
        role create --or-show admin

      # openstack  --os-token ${AUTH_TOKEN} \
        --os-url=http://127.0.0.1:35357/v3/ \
        --os-domain-name default \
        --os-identity-api-version=3 \
        role add --project admin --user admin admin

   .. image:: figures/debconf-screenshots/keystone_2_register_admin_tenant_yes_no.png
      :scale: 50

   .. image:: figures/debconf-screenshots/keystone_3_admin_user_name.png
      :scale: 50

   .. image:: figures/debconf-screenshots/keystone_4_admin_user_email.png
      :scale: 50

   .. image:: figures/debconf-screenshots/keystone_5_admin_user_pass.png
      :scale: 50

   .. image:: figures/debconf-screenshots/keystone_6_admin_user_pass_confirm.png
      :scale: 50

   In Debian, the Keystone package offers automatic registration of
   Keystone in the service catalogue. This is equivalent of running the
   below commands:

   .. code-block:: console

      # openstack --os-token ${AUTH_TOKEN} \
        --os-url=http://127.0.0.1:35357/v3/ \
        --os-domain-name default \
        --os-identity-api-version=3 \
        service create \
        --name keystone \
        --description "OpenStack Identity" \
        identity

      # openstack --os-token ${AUTH_TOKEN} \
        --os-url=http://127.0.0.1:35357/v3/ \
        --os-domain-name default \
        --os-identity-api-version=3 \
        keystone public http://controller:5000/v2.0

      # openstack --os-token ${AUTH_TOKEN} \
        --os-url=http://127.0.0.1:35357/v3/ \
        --os-domain-name default \
        --os-identity-api-version=3 \
        keystone internal http://controller:5000/v2.0

      # openstack --os-token ${AUTH_TOKEN} \
        --os-url=http://127.0.0.1:35357/v3/ \
        --os-domain-name default \
        --os-identity-api-version=3 \
        keystone admin http://controller:35357/v2.0

   .. image:: figures/debconf-screenshots/keystone_7_register_endpoint.png
