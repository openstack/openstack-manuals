Security
~~~~~~~~

OpenStack services support various security methods including password,
policy, and encryption. Additionally, supporting services including the
database server and message broker support at least password security.

To ease the installation process, this guide only covers password
security where applicable. You can create secure passwords manually,
generate them using a tool such as
`pwgen <http://sourceforge.net/projects/pwgen/>`__, or by running the
following command:

.. code-block:: console

   $ openssl rand -hex 10

For OpenStack services, this guide uses ``SERVICE_PASS`` to reference
service account passwords and ``SERVICE_DBPASS`` to reference database
passwords.

The following table provides a list of services that require passwords
and their associated references in the guide:

.. list-table:: **Passwords**
   :widths: 50 60
   :header-rows: 1

   * - Password name
     - Description
   * - Database password (no variable used)
     - Root password for the database
   * - ``ADMIN_PASS``
     - Password of user ``admin``
   * - ``CEILOMETER_DBPASS``
     - Database password for the Telemetry service
   * - ``CEILOMETER_PASS``
     - Password of Telemetry service user ``ceilometer``
   * - ``CINDER_DBPASS``
     - Database password for the Block Storage service
   * - ``CINDER_PASS``
     - Password of Block Storage service user ``cinder``
   * - ``DASH_DBPASS``
     - Database password for the dashboard
   * - ``DEMO_PASS``
     - Password of user ``demo``
   * - ``GLANCE_DBPASS``
     - Database password for Image service
   * - ``GLANCE_PASS``
     - Password of Image service user ``glance``
   * - ``HEAT_DBPASS``
     - Database password for the Orchestration service
   * - ``HEAT_DOMAIN_PASS``
     - Password of Orchestration domain
   * - ``HEAT_PASS``
     - Password of Orchestration service user ``heat``
   * - ``KEYSTONE_DBPASS``
     - Database password of Identity service
   * - ``NEUTRON_DBPASS``
     - Database password for the Networking service
   * - ``NEUTRON_PASS``
     - Password of Networking service user ``neutron``
   * - ``NOVA_DBPASS``
     - Database password for Compute service
   * - ``NOVA_PASS``
     - Password of Compute service user ``nova``
   * - ``RABBIT_PASS``
     - Password of user guest of RabbitMQ
   * - ``SWIFT_PASS``
     - Password of Object Storage service user ``swift``

OpenStack and supporting services require administrative privileges
during installation and operation. In some cases, services perform
modifications to the host that can interfere with deployment automation
tools such as Ansible, Chef, and Puppet. For example, some OpenStack
services add a root wrapper to ``sudo`` that can interfere with security
policies. See the `Administrator Guide <http://docs.openstack.org/
admin-guide/compute-root-wrap-reference.html>`__
for more information.

Also, the Networking service assumes default values for kernel network
parameters and modifies firewall rules. To avoid most issues during your
initial installation, we recommend using a stock deployment of a supported
distribution on your hosts. However, if you choose to automate deployment
of your hosts, review the configuration and policies applied to them before
proceeding further.
