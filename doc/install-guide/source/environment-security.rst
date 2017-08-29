Security
~~~~~~~~

OpenStack services support various security methods including password,
policy, and encryption. Additionally, supporting services including the
database server and message broker support password security.

To ease the installation process, this guide only covers password
security where applicable. You can create secure passwords manually,
but the database connection string in services configuration file
cannot accept special characters like "@". We recommend you generate
them using a tool such as
`pwgen <https://sourceforge.net/projects/pwgen/>`_, or by running the
following command:

.. code-block:: console

   $ openssl rand -hex 10

.. end

For OpenStack services, this guide uses ``SERVICE_PASS`` to reference
service account passwords and ``SERVICE_DBPASS`` to reference database
passwords.

The following table provides a list of services that require passwords
and their associated references in the guide.

.. list-table:: **Passwords**
   :widths: 50 60
   :header-rows: 1

   * - Password name
     - Description
   * - Database password (no variable used)
     - Root password for the database
   * - ``ADMIN_PASS``
     - Password of user ``admin``
   * - ``CINDER_DBPASS``
     - Database password for the Block Storage service
   * - ``CINDER_PASS``
     - Password of Block Storage service user ``cinder``
   * - ``DASH_DBPASS``
     - Database password for the Dashboard
   * - ``DEMO_PASS``
     - Password of user ``demo``
   * - ``GLANCE_DBPASS``
     - Database password for Image service
   * - ``GLANCE_PASS``
     - Password of Image service user ``glance``
   * - ``KEYSTONE_DBPASS``
     - Database password of Identity service
   * - ``METADATA_SECRET``
     - Secret for the metadata proxy
   * - ``NEUTRON_DBPASS``
     - Database password for the Networking service
   * - ``NEUTRON_PASS``
     - Password of Networking service user ``neutron``
   * - ``NOVA_DBPASS``
     - Database password for Compute service
   * - ``NOVA_PASS``
     - Password of Compute service user ``nova``
   * - ``PLACEMENT_PASS``
     - Password of the Placement service user ``placement``
   * - ``RABBIT_PASS``
     - Password of RabbitMQ user ``openstack``

OpenStack and supporting services require administrative privileges
during installation and operation. In some cases, services perform
modifications to the host that can interfere with deployment automation
tools such as Ansible, Chef, and Puppet. For example, some OpenStack
services add a root wrapper to ``sudo`` that can interfere with security
policies. See the
`Compute service documentation for Pike <https://docs.openstack.org/nova/pike/admin/root-wrap-reference.html>`__
for more information.

The Networking service assumes default values for kernel network
parameters and modifies firewall rules. To avoid most issues during your
initial installation, we recommend using a stock deployment of a supported
distribution on your hosts. However, if you choose to automate deployment
of your hosts, review the configuration and policies applied to them before
proceeding further.
