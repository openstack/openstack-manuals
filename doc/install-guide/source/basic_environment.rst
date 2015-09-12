=================
Basic environment
=================

.. note::

   The draft version of this guide focuses on the future Liberty
   release and will not work for the current Kilo release. If you want
   to install Kilo, you must use the `Kilo
   version <http://docs.openstack.org>`__ of this guide instead.

This section explains how to configure each node in the
:ref:`overview-example-architectures`, including the two-node architecture
with legacy networking :ref:`figure-legacy-network-hw` and three-node
architecture with OpenStack Networking (neutron)
:ref:`figure-neutron-network-hw`.

Although most environments include Identity, Image service, Compute, at least
one networking service, and the dashboard, the Object Storage service can
operate independently. If your use case only involves Object Storage, you can
skip to :ref:`swift` after configuring the appropriate nodes for it. However,
the dashboard requires at least the Image service and Compute.

You must use an account with administrative privileges to configure each node.
Either run the commands as the ``root`` user or configure the ``sudo``
utility.

The :command:`systemctl enable` call on openSUSE outputs a warning message
when the service uses SysV Init scripts instead of native systemd files. This
warning can be ignored.


Before you begin
~~~~~~~~~~~~~~~~

For best performance, we recommend that your environment meets or
exceeds the hardware requirements in
:ref:`figure-neutron-network-hw` or
:ref:`figure-legacy-network-hw`.  However, OpenStack does not require a
significant amount of resources and the following minimum requirements
should support a proof-of-concept environment with core services
and several :term:`CirrOS` instances:

-  Controller Node: 1 processor, 2 GB memory, and 5 GB storage

-  Network Node: 1 processor, 512 MB memory, and 5 GB storage

-  Compute Node: 1 processor, 2 GB memory, and 10 GB storage

To minimize clutter and provide more resources for OpenStack, we
recommend a minimal installation of your Linux distribution. Also, we
strongly recommend that you install a 64-bit version of your
distribution on at least the compute node. If you install a 32-bit
version of your distribution on the compute node, attempting to start an
instance using a 64-bit image will fail.

A single disk partition on each node works for most basic installations.
However, you should consider :term:`Logical Volume Manager (LVM)` for
installations with optional services such as Block Storage.

Many users build their test environment on a
:term:`virtual machine (VM)`. The primary benefits of VMs include
the following:

-  One physical server can support multiple nodes, each with almost any
   number of network interfaces.

-  Ability to take periodic "snap shots" throughout the installation
   process and "roll back" to a working configuration in the event of a
   problem.

However, VMs will reduce performance of your instances, particularly if
your hypervisor and/or processor lacks support for hardware acceleration
of nested VMs.

.. note::

   If you choose to install on VMs, make sure your hypervisor permits
   :term:`promiscuous mode` and disables MAC address filtering on the
   :term:`external network`.

For more information about system requirements, see the `OpenStack
Operations Guide <http://docs.openstack.org/ops/>`_.


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
   * - ``SAHARA_DBPASS``
     - Database password of Data processing service
   * - ``SWIFT_PASS``
     - Password of Object Storage service user ``swift``
   * - ``TROVE_DBPASS``
     - Database password of Database service
   * - ``TROVE_PASS``
     - Password of Database service user ``trove``

|

OpenStack and supporting services require administrative privileges
during installation and operation. In some cases, services perform
modifications to the host that can interfere with deployment automation
tools such as Ansible, Chef, and Puppet. For example, some OpenStack
services add a root wrapper to ``sudo`` that can interfere with security
policies. See the `Cloud Administrator Guide <http://docs.openstack.org/
admin-guide-cloud/compute-root-wrap-reference.html>`__
for more information.

Also, the Networking service assumes default
values for kernel network parameters and modifies firewall rules. To
avoid most issues during your initial installation, we recommend using a
stock deployment of a supported distribution on your hosts. However, if
you choose to automate deployment of your hosts, review the
configuration and policies applied to them before proceeding further.


Networking, NTP, OpenStack service dependencies
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. toctree::
   :maxdepth: 2

   basics-networking.rst
   basics-ntp.rst
   basics-packages.rst
