OpenStack packages for RHEL and CentOS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Distributions release OpenStack packages as part of the distribution or
using other methods because of differing release schedules. Perform
these procedures on all nodes.

.. warning::

   Starting with the Ussuri release, you will need to use either CentOS8
   or RHEL 8. Previous OpenStack releases will need to use either CentOS7
   or RHEL 7. Instructions are included for both distributions and
   versions where different.

.. note::

   The set up of OpenStack packages described here needs to be done on
   all nodes: controller, compute, and Block Storage nodes.

.. warning::

   Your hosts must contain the latest versions of base installation
   packages available for your distribution before proceeding further.

.. note::

   Disable or remove any automatic update services because they can
   impact your OpenStack environment.

Prerequisites
-------------

.. warning::

   We recommend disabling EPEL when using RDO packages due to updates
   in EPEL breaking backwards compatibility. Or, preferably pin package
   versions using the ``yum-versionlock`` plugin.

.. note::

   The following steps apply to RHEL only. CentOS does not require these
   steps.

#. When using RHEL, it is assumed that you have registered your system using
   Red Hat Subscription Management and that you have the
   ``rhel-7-server-rpms`` or ``rhel-8-for-x86_64-baseos-rpms`` repository
   enabled by default depending on your version.

   For more information on registering a RHEL 7 system, see the
   `Red Hat Enterprise Linux 7 System Administrator's Guide
   <https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/System_Administrators_Guide/part-Subscription_and_Support.html>`_.

#. In addition to ``rhel-7-server-rpms`` on a RHEL 7 system, you also need to
   have the ``rhel-7-server-optional-rpms``, ``rhel-7-server-extras-rpms``,
   and ``rhel-7-server-rh-common-rpms`` repositories enabled:

   .. code-block:: console

      # subscription-manager repos --enable=rhel-7-server-optional-rpms \
        --enable=rhel-7-server-extras-rpms --enable=rhel-7-server-rh-common-rpms

   For more information on registering a RHEL 8 system, see the
   `Red Hat Enterprise Linux 8 Installation Guide
   <https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/performing_a_standard_rhel_installation/post-installation-tasks_installing-rhel>`_.

   In addition to ``rhel-8-for-x86_64-baseos-rpms`` on a RHEL 8 system, you
   also need to have the ``rhel-8-for-x86_64-appstream-rpms``,
   ``rhel-8-for-x86_64-supplementary-rpms``, and ``codeready-builder-for-rhel-8-x86_64-rpms``
   repositories enabled:

   .. code-block:: console

      # subscription-manager repos --enable=rhel-8-for-x86_64-appstream-rpms \
        --enable=rhel-8-for-x86_64-supplementary-rpms --enable=codeready-builder-for-rhel-8-x86_64-rpms

Enable the OpenStack repository
-------------------------------

* On CentOS, the ``extras`` repository provides the RPM that enables the
  OpenStack repository. CentOS includes the ``extras`` repository by
  default, so you can simply install the package to enable the OpenStack
  repository. For CentOS8, you will also need to enable the PowerTools
  repository.

  **When installing the Ussuri release, run:**

  .. code-block:: console

     # yum install centos-release-openstack-ussuri
     # yum config-manager --set-enabled PowerTools

  **When installing the Train release, run:**

  .. code-block:: console

     # yum install centos-release-openstack-train

  **When installing the Stein release, run:**

  .. code-block:: console

     # yum install centos-release-openstack-stein

  **When installing the Rocky release, run:**

  .. code-block:: console

     # yum install centos-release-openstack-rocky

  **When installing the Queens release, run:**

  .. code-block:: console

     # yum install centos-release-openstack-queens

  **When installing the Pike release, run:**

  .. code-block:: console

     # yum install centos-release-openstack-pike

* On RHEL, download and install the RDO repository RPM to enable the
  OpenStack repository.

  **On RHEL 7:**

  .. code-block:: console

     # yum install https://rdoproject.org/repos/rdo-release.rpm

  **On RHEL 8:**

  .. code-block:: console

     # dnf install https://www.rdoproject.org/repos/rdo-release.el8.rpm

  The RDO repository RPM installs the latest available OpenStack release.

Finalize the installation
-------------------------

1. Upgrade the packages on all nodes:

   .. code-block:: console

      # yum upgrade

   .. note::

      If the upgrade process includes a new kernel, reboot your host
      to activate it.

2. Install the appropriate OpenStack client for your version.

   **For CentOS 7 and RHEL 7**

   .. code-block:: console

      # yum install python-openstackclient

   **For CentOS 8 and RHEL 8**

   .. code-block:: console

      # yum install python3-openstackclient

3. RHEL and CentOS enable :term:`SELinux` by default. Install the
   ``openstack-selinux`` package to automatically manage security
   policies for OpenStack services:

   .. code-block:: console

      # yum install openstack-selinux
