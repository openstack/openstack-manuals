===============
Lay of the Land
===============

This chapter helps you set up your working environment and use it to
take a look around your cloud.

Using the OpenStack Dashboard for Administration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As a cloud administrative user, you can use the OpenStack dashboard to
create and manage projects, users, images, and flavors. Users are
allowed to create and manage images within specified projects and to
share images, depending on the Image service configuration. Typically,
the policy configuration allows admin users only to set quotas and
create and manage services. The dashboard provides an :guilabel:`Admin`
tab with a :guilabel:`System Panel` and an :guilabel:`Identity` tab.
These interfaces give you access to system information and usage as
well as to settings for configuring what
end users can do. Refer to the `OpenStack Administrator
Guide <https://docs.openstack.org/admin-guide/dashboard.html>`__ for
detailed how-to information about using the dashboard as an admin user.

Command-Line Tools
~~~~~~~~~~~~~~~~~~

We recommend using a combination of the OpenStack command-line interface
(CLI) tools and the OpenStack dashboard for administration. Some users
with a background in other cloud technologies may be using the EC2
Compatibility API, which uses naming conventions somewhat different from
the native API.

The pip utility is used to manage package installation from the PyPI
archive and is available in the python-pip package in most Linux
distributions. While each OpenStack project has its own client, they are
being deprecated in favour of a common OpenStack client. It is generally
recommended to install the OpenStack client.

.. tip::

   To perform testing and orchestration, it is usually easier to install the
   OpenStack CLI tools in a dedicated VM in the cloud. We recommend
   that you keep the VM installation simple. All the tools should be installed
   from a single OpenStack release version. If you need to run tools from
   multiple OpenStack releases, then we recommend that you run with multiple
   VMs that are each running a dedicated version.

Install OpenStack command-line clients
--------------------------------------

For instructions on installing, upgrading, or removing command-line clients,
see the `Install the OpenStack command-line clients
<https://docs.openstack.org/user-guide/common/cli-install-openstack-command-line-clients.html>`_
section in OpenStack End User Guide.

.. note::

   If you support the EC2 API on your cloud, you should also install the
   euca2ools package or some other EC2 API tool so that you can get the
   same view your users have. Using EC2 API-based tools is mostly out of
   the scope of this guide, though we discuss getting credentials for use
   with it.

Administrative Command-Line Tools
---------------------------------

There are also several :command:`*-manage` command-line tools. These are
installed with the project's services on the cloud controller and do not
need to be installed separately:

* :command:`nova-manage`
* :command:`glance-manage`
* :command:`keystone-manage`
* :command:`cinder-manage`

Unlike the CLI tools mentioned above, the :command:`*-manage` tools must
be run from the cloud controller, as root, because they need read access
to the config files such as ``/etc/nova/nova.conf`` and to make queries
directly against the database rather than against the OpenStack
:term:`API endpoints <API endpoint>`.

.. warning::

   The existence of the ``*-manage`` tools is a legacy issue. It is a
   goal of the OpenStack project to eventually migrate all of the
   remaining functionality in the ``*-manage`` tools into the API-based
   tools. Until that day, you need to SSH into the
   :term:`cloud controller node` to perform some maintenance operations
   that require one of the ``*-manage`` tools.

Getting Credentials
-------------------

You must have the appropriate credentials if you want to use the
command-line tools to make queries against your OpenStack cloud. By far,
the easiest way to obtain :term:`authentication` credentials to use with
command-line clients is to use the OpenStack dashboard. Select
:guilabel:`Project`, click the :guilabel:`Project` tab, and click
:guilabel:`Access & Security` on the :guilabel:`Compute` category.
On the :guilabel:`Access & Security` page, click the :guilabel:`API Access`
tab to display two buttons, :guilabel:`Download OpenStack RC File` and
:guilabel:`Download EC2 Credentials`, which let you generate files that
you can source in your shell to populate the environment variables the
command-line tools require to know where your service endpoints and your
authentication information are. The user you logged in to the dashboard
dictates the filename for the openrc file, such as ``demo-openrc.sh``.
When logged in as admin, the file is named ``admin-openrc.sh``.

The generated file looks something like this:

.. code-block:: bash

   #!/usr/bin/env bash

   # To use an OpenStack cloud you need to authenticate against the Identity
   # service named keystone, which returns a **Token** and **Service Catalog**.
   # The catalog contains the endpoints for all services the user/tenant has
   # access to - such as Compute, Image Service, Identity, Object Storage, Block
   # Storage, and Networking (code-named nova, glance, keystone, swift,
   # cinder, and neutron).
   #
   # *NOTE*: Using the 3 *Identity API* does not necessarily mean any other
   # OpenStack API is version 3. For example, your cloud provider may implement
   # Image API v1.1, Block Storage API v2, and Compute API v2.0. OS_AUTH_URL is
   # only for the Identity API served through keystone.
   export OS_AUTH_URL=http://203.0.113.10:5000/v3

   # With the addition of Keystone we have standardized on the term **project**
   # as the entity that owns the resources.
   export OS_PROJECT_ID=98333aba48e756fa8f629c83a818ad57
   export OS_PROJECT_NAME="test-project"
   export OS_USER_DOMAIN_NAME="default"
   if [ -z "$OS_USER_DOMAIN_NAME" ]; then unset OS_USER_DOMAIN_NAME; fi

   # In addition to the owning entity (tenant), OpenStack stores the entity
   # performing the action as the **user**.
   export OS_USERNAME="demo"

   # With Keystone you pass the keystone password.
   echo "Please enter your OpenStack Password for project $OS_PROJECT_NAME as user $OS_USERNAME: "
   read -sr OS_PASSWORD_INPUT
   export OS_PASSWORD=$OS_PASSWORD_INPUT

   # If your configuration has multiple regions, we set that information here.
   # OS_REGION_NAME is optional and only valid in certain environments.
   export OS_REGION_NAME="RegionOne"
   # Don't leave a blank variable, unset it if it was empty
   if [ -z "$OS_REGION_NAME" ]; then unset OS_REGION_NAME; fi

   export OS_INTERFACE=public
   export OS_IDENTITY_API_VERSION=3

.. warning::

   This does not save your password in plain text, which is a good
   thing. But when you source or run the script, it prompts you for
   your password and then stores your response in the environment
   variable ``OS_PASSWORD``. It is important to note that this does
   require interactivity. It is possible to store a value directly in
   the script if you require a noninteractive operation, but you then
   need to be extremely cautious with the security and permissions of
   this file.

EC2 compatibility credentials can be downloaded by selecting
:guilabel:`Project`, then :guilabel:`Compute`, then
:guilabel:`Access & Security`, then :guilabel:`API Access` to display the
:guilabel:`Download EC2 Credentials` button. Click the button to generate
a ZIP file with server x509 certificates and a shell script fragment.
Create a new directory in a secure location because these are live credentials
containing all the authentication information required to access your
cloud identity, unlike the default ``user-openrc``. Extract the ZIP file
here. You should have ``cacert.pem``, ``cert.pem``, ``ec2rc.sh``, and
``pk.pem``. The ``ec2rc.sh`` is similar to this:

.. code-block:: bash

   #!/bin/bash

   NOVARC=$(readlink -f "${BASH_SOURCE:-${0}}" 2>/dev/null) ||\
   NOVARC=$(python -c 'import os,sys; \
   print os.path.abspath(os.path.realpath(sys.argv[1]))' "${BASH_SOURCE:-${0}}")
   NOVA_KEY_DIR=${NOVARC%/*}
   export EC2_ACCESS_KEY=df7f93ec47e84ef8a347bbb3d598449a
   export EC2_SECRET_KEY=ead2fff9f8a344e489956deacd47e818
   export EC2_URL=http://203.0.113.10:8773/services/Cloud
   export EC2_USER_ID=42 # nova does not use user id, but bundling requires it
   export EC2_PRIVATE_KEY=${NOVA_KEY_DIR}/pk.pem
   export EC2_CERT=${NOVA_KEY_DIR}/cert.pem
   export NOVA_CERT=${NOVA_KEY_DIR}/cacert.pem
   export EUCALYPTUS_CERT=${NOVA_CERT} # euca-bundle-image seems to require this

   alias ec2-bundle-image="ec2-bundle-image --cert $EC2_CERT --privatekey \
   $EC2_PRIVATE_KEY --user 42 --ec2cert $NOVA_CERT"
   alias ec2-upload-bundle="ec2-upload-bundle -a $EC2_ACCESS_KEY -s \
   $EC2_SECRET_KEY --url $S3_URL --ec2cert $NOVA_CERT"

To put the EC2 credentials into your environment, source the
``ec2rc.sh`` file.

Inspecting API Calls
--------------------

The command-line tools can be made to show the OpenStack API calls they
make by passing the ``--debug`` flag to them. For example:

.. code-block:: console

   # openstack --debug server list

This example shows the HTTP requests from the client and the responses
from the endpoints, which can be helpful in creating custom tools
written to the OpenStack API.

Using cURL for further inspection
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Underlying the use of the command-line tools is the OpenStack API, which
is a RESTful API that runs over HTTP. There may be cases where you want
to interact with the API directly or need to use it because of a
suspected bug in one of the CLI tools. The best way to do this is to use
a combination of `cURL <http://curl.haxx.se/>`_ and another tool,
such as `jq <http://stedolan.github.io/jq/>`_, to parse the JSON from
the responses.

The first thing you must do is authenticate with the cloud using your
credentials to get an :term:`authentication token`.

Your credentials are a combination of username, password, and tenant
(project). You can extract these values from the ``openrc.sh`` discussed
above. The token allows you to interact with your other service
endpoints without needing to reauthenticate for every request. Tokens
are typically good for 24 hours, and when the token expires, you are
alerted with a 401 (Unauthorized) response and you can request another
token.

#. Look at your OpenStack service :term:`catalog`:

   .. code-block:: console

      $ curl -s -X POST http://203.0.113.10:35357/v2.0/tokens \
        -d '{"auth": {"passwordCredentials": {"username":"test-user", "password":"test-password"}, "tenantName":"test-project"}}' \
        -H "Content-type: application/json" | jq .

#. Read through the JSON response to get a feel for how the catalog is
   laid out.

   To make working with subsequent requests easier, store the token in
   an environment variable:

   .. code-block:: console

      $ TOKEN=`curl -s -X POST http://203.0.113.10:35357/v2.0/tokens \
        -d '{"auth": {"passwordCredentials": {"username":"test-user", "password":"test-password"}, "tenantName":"test-project"}}' \
        -H "Content-type: application/json" |  jq -r .access.token.id`

   Now you can refer to your token on the command line as ``$TOKEN``.

#. Pick a service endpoint from your service catalog, such as compute.
   Try a request, for example, listing instances (servers):

   .. code-block:: console

      $ curl -s \
        -H "X-Auth-Token: $TOKEN" \
        http://203.0.113.10:8774/v2.0/98333aba48e756fa8f629c83a818ad57/servers | jq .

To discover how API requests should be structured, read the `OpenStack
API Reference <https://developer.openstack.org/api-guide/quick-start/index.html>`_. To chew
through the responses using jq, see the `jq
Manual <http://stedolan.github.io/jq/manual/>`_.

The ``-s flag`` used in the cURL commands above are used to prevent
the progress meter from being shown. If you are having trouble running
cURL commands, you'll want to remove it. Likewise, to help you
troubleshoot cURL commands, you can include the ``-v`` flag to show you
the verbose output. There are many more extremely useful features in
cURL; refer to the man page for all the options.

Servers and Services
--------------------

As an administrator, you have a few ways to discover what your OpenStack
cloud looks like simply by using the OpenStack tools available. This
section gives you an idea of how to get an overview of your cloud, its
shape, size, and current state.

First, you can discover what servers belong to your OpenStack cloud by
running:

.. code-block:: console

   # openstack service list

The output looks like the following:

.. code-block:: console

   +----------------------------------+----------+----------+
   | ID                               | Name     | Type     |
   +----------------------------------+----------+----------+
   | 0a01b2d1ee5d4ce79ea65f6356a6fffb | nova     | compute  |
   | 769eeea7aaef4724aa98376941d7c364 | glance   | image    |
   | 87f4688f09104d81ab52661d74134652 | keystone | identity |
   | 936cf7f450c2428e9e5746e0ea0a2cc7 | cinder   | volume   |
   | c92b9bdcb42c48ddb7abd926d43999f9 | neutron  | network  |
   | f633b72d040e46cb8700c62e82418b98 | cinderv2 | volumev2 |
   +----------------------------------+----------+----------+

The output shows that there are five compute nodes and one cloud
controller. You see all the services in the up state, which indicates that
the services are up and running. If a service is in a down state, it is
no longer available. This is an indication that you
should troubleshoot why the service is down.

If you are using cinder, run the following command to see a similar
listing:

.. code-block:: console

   # cinder-manage host list | sort
   host              zone
   c01.example.com   nova
   c02.example.com   nova
   c03.example.com   nova
   c04.example.com   nova
   c05.example.com   nova
   cloud.example.com nova

With these two tables, you now have a good overview of what servers and
services make up your cloud.

You can also use the Identity service (keystone) to see what services
are available in your cloud as well as what endpoints have been
configured for the services.

The following command requires you to have your shell environment
configured with the proper administrative variables:

.. code-block:: console

   $ openstack catalog list
   +----------+------------+---------------------------------------------------------------------------------+
   | Name     | Type       | Endpoints                                                                       |
   +----------+------------+---------------------------------------------------------------------------------+
   | nova     | compute    | RegionOne                                                                       |
   |          |            |   public: http://192.168.122.10:8774/v2/9faa845768224258808fc17a1bb27e5e        |
   |          |            | RegionOne                                                                       |
   |          |            |   internal: http://192.168.122.10:8774/v2/9faa845768224258808fc17a1bb27e5e      |
   |          |            | RegionOne                                                                       |
   |          |            |   admin: http://192.168.122.10:8774/v2/9faa845768224258808fc17a1bb27e5e         |
   |          |            |                                                                                 |
   | cinderv2 | volumev2   | RegionOne                                                                       |
   |          |            |   public: http://192.168.122.10:8776/v2/9faa845768224258808fc17a1bb27e5e        |
   |          |            | RegionOne                                                                       |
   |          |            |   internal: http://192.168.122.10:8776/v2/9faa845768224258808fc17a1bb27e5e      |
   |          |            | RegionOne                                                                       |
   |          |            |   admin: http://192.168.122.10:8776/v2/9faa845768224258808fc17a1bb27e5e         |
   |          |            |                                                                                 |

The preceding output has been truncated to show only two services. You
will see one service entry for each service that your cloud provides.
Note how the endpoint domain can be different depending on the endpoint
type. Different endpoint domains per type are not required, but this can
be done for different reasons, such as endpoint privacy or network
traffic segregation.

You can find the version of the Compute installation by using the
OpenStack command-line client:

.. code-block:: console

   # openstack --version

Diagnose Your Compute Nodes
---------------------------

You can obtain extra information about virtual machines that are
running—their CPU usage, the memory, the disk I/O or network I/O—per
instance, by running the :command:`nova diagnostics` command with a server ID:

.. code-block:: console

   $ nova diagnostics <serverID>

The output of this command varies depending on the hypervisor because
hypervisors support different attributes. The following demonstrates
the difference between the two most popular hypervisors.
Here is example output when the hypervisor is Xen:

.. code-block:: console

   +----------------+-----------------+
   |    Property    |      Value      |
   +----------------+-----------------+
   | cpu0           | 4.3627          |
   | memory         | 1171088064.0000 |
   | memory_target  | 1171088064.0000 |
   | vbd_xvda_read  | 0.0             |
   | vbd_xvda_write | 0.0             |
   | vif_0_rx       | 3223.6870       |
   | vif_0_tx       | 0.0             |
   | vif_1_rx       | 104.4955        |
   | vif_1_tx       | 0.0             |
   +----------------+-----------------+

While the command should work with any hypervisor that is controlled
through libvirt (KVM, QEMU, or LXC), it has been tested only with KVM.
Here is the example output when the hypervisor is KVM:

.. code-block:: console

   +------------------+------------+
   | Property         | Value      |
   +------------------+------------+
   | cpu0_time        | 2870000000 |
   | memory           | 524288     |
   | vda_errors       | -1         |
   | vda_read         | 262144     |
   | vda_read_req     | 112        |
   | vda_write        | 5606400    |
   | vda_write_req    | 376        |
   | vnet0_rx         | 63343      |
   | vnet0_rx_drop    | 0          |
   | vnet0_rx_errors  | 0          |
   | vnet0_rx_packets | 431        |
   | vnet0_tx         | 4905       |
   | vnet0_tx_drop    | 0          |
   | vnet0_tx_errors  | 0          |
   | vnet0_tx_packets | 45         |
   +------------------+------------+

Network Inspection
~~~~~~~~~~~~~~~~~~

To see which fixed IP networks are configured in your cloud, you can use
the :command:`openstack` command-line client to get the IP ranges:

.. code-block:: console

   $ openstack subnet list
   +--------------------------------------+----------------+--------------------------------------+-----------------+
   | ID                                   | Name           | Network                              | Subnet          |
   +--------------------------------------+----------------+--------------------------------------+-----------------+
   | 346806ee-a53e-44fd-968a-ddb2bcd2ba96 | public_subnet  | 0bf90de6-fc0f-4dba-b80d-96670dfb331a | 172.24.4.224/28 |
   | f939a1e4-3dc3-4540-a9f6-053e6f04918f | private_subnet | 1f7f429e-c38e-47ba-8acf-c44e3f5e8d71 | 10.0.0.0/24     |
   +--------------------------------------+----------------+--------------------------------------+-----------------+

The OpenStack command-line client can provide some additional details:

.. code-block:: console

   # openstack compute service list
   +----+------------------+------------+----------+---------+-------+----------------------------+
   | Id | Binary           | Host       | Zone     | Status  | State | Updated At                 |
   +----+------------------+------------+----------+---------+-------+----------------------------+
   |  1 | nova-consoleauth | controller | internal | enabled | up    | 2016-08-18T12:16:53.000000 |
   |  2 | nova-scheduler   | controller | internal | enabled | up    | 2016-08-18T12:16:59.000000 |
   |  3 | nova-conductor   | controller | internal | enabled | up    | 2016-08-18T12:16:52.000000 |
   |  7 | nova-compute     | controller | nova     | enabled | up    | 2016-08-18T12:16:58.000000 |
   +----+------------------+------------+----------+---------+-------+----------------------------+


This output shows that two networks are configured, each network
containing 255 IPs (a /24 subnet). The first network has been assigned
to a certain project, while the second network is still open for
assignment. You can assign this network manually; otherwise, it is
automatically assigned when a project launches its first instance.

To find out whether any floating IPs are available in your cloud, run:

.. code-block:: console

   # openstack floating ip list
   +--------------------------------------+---------------------+------------------+--------------------------------------+
   | ID                                   | Floating IP Address | Fixed IP Address | Port                                 |
   +--------------------------------------+---------------------+------------------+--------------------------------------+
   | 340cb36d-6a52-4091-b256-97b6e61cbb20 | 172.24.4.227        | 10.2.1.8         | 1fec8fb8-7a8c-44c2-acd8-f10e2e6cd326 |
   | 8b1bfc0c-7a91-4da0-b3cc-4acae26cbdec | 172.24.4.228        | None             | None                                 |
   +--------------------------------------+---------------------+------------------+--------------------------------------+

Here, two floating IPs are available. The first has been allocated to a
project, while the other is unallocated.

Users and Projects
~~~~~~~~~~~~~~~~~~

To see a list of projects that have been added to the cloud, run:

.. code-block:: console

   $ openstack project list
   +----------------------------------+--------------------+
   | ID                               | Name               |
   +----------------------------------+--------------------+
   | 422c17c0b26f4fbe9449f37a5621a5e6 | alt_demo           |
   | 5dc65773519248f3a580cfe28ba7fa3f | demo               |
   | 9faa845768224258808fc17a1bb27e5e | admin              |
   | a733070a420c4b509784d7ea8f6884f7 | invisible_to_admin |
   | aeb3e976e7794f3f89e4a7965db46c1e | service            |
   +----------------------------------+--------------------+

To see a list of users, run:

.. code-block:: console

   $ openstack user list
   +----------------------------------+----------+
   | ID                               | Name     |
   +----------------------------------+----------+
   | 5837063598694771aedd66aa4cddf0b8 | demo     |
   | 58efd9d852b74b87acc6efafaf31b30e | cinder   |
   | 6845d995a57a441f890abc8f55da8dfb | glance   |
   | ac2d15a1205f46d4837d5336cd4c5f5a | alt_demo |
   | d8f593c3ae2b47289221f17a776a218b | admin    |
   | d959ec0a99e24df0b7cb106ff940df20 | nova     |
   +----------------------------------+----------+

.. note::

   Sometimes a user and a group have a one-to-one mapping. This happens
   for standard system accounts, such as cinder, glance, nova, and
   swift, or when only one user is part of a group.

Running Instances
~~~~~~~~~~~~~~~~~

To see a list of running instances, run:

.. code-block:: console

   $ openstack server list --all-projects
   +--------------------------------------+------+--------+---------------------+------------+
   | ID                                   | Name | Status | Networks            | Image Name |
   +--------------------------------------+------+--------+---------------------+------------+
   | 495b4f5e-0b12-4c5a-b4e0-4326dee17a5a | vm1  | ACTIVE | public=172.24.4.232 | cirros     |
   | e83686f9-16e8-45e6-911d-48f75cb8c0fb | vm2  | ACTIVE | private=10.0.0.7    | cirros     |
   +--------------------------------------+------+--------+---------------------+------------+

Unfortunately, this command does not tell you various details about the
running instances, such as what compute node the instance is running on,
what flavor the instance is, and so on. You can use the following
command to view details about individual instances:

.. code-block:: console

   $ openstack server show <uuid>

For example:

.. code-block:: console

   # openstack server show 81db556b-8aa5-427d-a95c-2a9a6972f630
   +--------------------------------------+----------------------------------------------------------+
   | Field                                | Value                                                    |
   +--------------------------------------+----------------------------------------------------------+
   | OS-DCF:diskConfig                    | AUTO                                                     |
   | OS-EXT-AZ:availability_zone          | nova                                                     |
   | OS-EXT-SRV-ATTR:host                 | c02.example.com                                          |
   | OS-EXT-SRV-ATTR:hypervisor_hostname  | c02.example.com                                          |
   | OS-EXT-SRV-ATTR:instance_name        | instance-00000001                                        |
   | OS-EXT-STS:power_state               | Running                                                  |
   | OS-EXT-STS:task_state                | None                                                     |
   | OS-EXT-STS:vm_state                  | active                                                   |
   | OS-SRV-USG:launched_at               | 2016-10-19T15:18:09.000000                               |
   | OS-SRV-USG:terminated_at             | None                                                     |
   | accessIPv4                           |                                                          |
   | accessIPv6                           |                                                          |
   | addresses                            | private=10.0.0.7                                         |
   | config_drive                         |                                                          |
   | created                              | 2016-10-19T15:17:46Z                                     |
   | flavor                               | m1.tiny (1)                                              |
   | hostId                               | 2b57e2b7a839508337fb55695b8f6e65aa881460a20449a76352040b |
   | id                                   | e83686f9-16e8-45e6-911d-48f75cb8c0fb                     |
   | image                                | cirros (9fef3b2d-c35d-4b61-bea8-09cc6dc41829)            |
   | key_name                             | None                                                     |
   | name                                 | test                                                     |
   | os-extended-volumes:volumes_attached | []                                                       |
   | progress                             | 0                                                        |
   | project_id                           | 1eaaf6ede7a24e78859591444abf314a                         |
   | properties                           |                                                          |
   | security_groups                      | [{u'name': u'default'}]                                  |
   | status                               | ACTIVE                                                   |
   | updated                              | 2016-10-19T15:18:58Z                                     |
   | user_id                              | 7aaa9b5573ce441b98dae857a82ecc68                         |
   +--------------------------------------+----------------------------------------------------------+

This output shows that an instance named ``devstack`` was created from
an Ubuntu 12.04 image using a flavor of ``m1.small`` and is hosted on
the compute node ``c02.example.com``.

Summary
~~~~~~~

We hope you have enjoyed this quick tour of your working environment,
including how to interact with your cloud and extract useful
information. From here, you can use the `OpenStack Administrator
Guide <https://docs.openstack.org/admin-guide/>`_ as your
reference for all of the command-line functionality in your cloud.
