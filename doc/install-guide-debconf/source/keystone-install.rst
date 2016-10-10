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

      # export OS_BOOTSTRAP_USERNAME=${ADMIN_USER_NAME}

      # export OS_BOOTSTRAP_PROJECT_NAME=${ADMIN_TENANT_NAME}

      # export OS_BOOTSTRAP_PASSWORD=${ADMIN_USER_PW}

      # keystone-manage bootstrap

      # export OS_PROJECT_DOMAIN_ID=default

      # export OS_USER_DOMAIN_ID=default

      # export OS_USERNAME=admin

      # export OS_PASSWORD=${ADMIN_USER_PW}

      # export OS_TENANT_NAME=${ADMIN_TENANT_NAME}

      # export OS_PROJECT_NAME=${ADMIN_TENANT_NAME}

      # export OS_AUTH_URL=http://127.0.0.1:35357/v3/

      # export OS_IDENTITY_API_VERSION=3

      # export OS_AUTH_VERSION=3

      # export OS_PROJECT_DOMAIN_ID=default

      # export OS_USER_DOMAIN_ID=default

      # export OS_NO_CACHE=1

      # openstack project set \
        --description "Default Debian admin project" \
        $ADMIN_TENANT_NAME

      # openstack project create --or-show service \
        --description "Default Debian service project"

      # openstack user set \
        --description "Default Debian admin user" \
        --email ${ADMIN_USER_EMAIL} \
        --enable $ADMIN_USER_NAME

   The Keystone package will then create roles for ``admin``,
   ``KeystoneAdmin``, ``KeystoneServiceAdmin``, ``heat_stack_owner``,
   ``Member`` and ``ResellerAdmin``, and will add them to the ``admin``
   project. For each of these, it is equivalent to:

   .. code-block:: console

      # openstack role create --or-show FOO

      # openstack role add --project admin \
        --user admin FOO

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

#. Register the keystone endpoint

   In Debian, the Keystone package offers automatic registration of
   Keystone in the service catalogue. This is equivalent of running the
   below commands:

   .. code-block:: console

      # OS_TOKEN=`openstack token issue -c id -f value` \
        openstack service create \
        --os-url=http://127.0.0.1:35357/v3/ \
        --name keystone \
        --description "OpenStack Identity" \
        identity

      # OS_TOKEN=`openstack token issue -c id -f value`
        openstack endpoint create \
        --os-url=http://127.0.0.1:35357/v3/ \
        keystone public http://controller:5000/v2.0

      # OS_TOKEN=`openstack token issue -c id -f value`
        openstack endpoint create \
        --os-url=http://127.0.0.1:35357/v3/ \
        keystone internal http://controller:5000/v2.0

      # OS_TOKEN=`openstack token issue -c id -f value`
        openstack endpoint create \
        --os-url=http://127.0.0.1:35357/v3/ \
        keystone admin http://controller:35357/v2.0

   .. image:: figures/debconf-screenshots/keystone_7_register_endpoint.png
