======================================
OpenStack packages for RHEL and CentOS
======================================

.. contents:: :depth: 3

Distributions release OpenStack packages as part of the distribution or
using other methods because of differing release schedules. **Perform
these procedures on all nodes (controller, compute, network, dashboard,
storage etc. nodes).**

.. warning::

   Your hosts must contain the latest versions of base installation
   packages available for your distribution before proceeding further.

.. warning::

   The following instructions refer to RDO: a free, community supported
   distribution of OpenStack for RHEL and CentOS. For the Red Hat-supported
   *Red Hat OpenStack Platform*, `see here
   <https://www.redhat.com/en/technologies/linux-platforms/openstack-platform>`_.

   According to RDO Packstack documentation, RDO should work on RHEL but is
   currently only tested on CentOS Stream.

.. note::

   Disable or remove any automatic update services because they can
   impact your OpenStack environment.

Operating System
----------------

.. list-table:: **Operating System**
   :header-rows: 1

   * - OS
     - Compatible Releases
     - Maintained Releases
   * - CentOS 7 / RHEL 7
     - ? to Train
     - *None*
   * - CentOS Stream 8 / RHEL 8
     - Ussuri to Yoga
     - *None*
   * - CentOS Stream 9 / RHEL 9
     - Xena and following releases
     - Zed, 2023.1 Antelope (SLURP), 2023.2 Bobcat, 2024.1 Caracal (SLURP)

Prerequisites
-------------

.. warning::

   We recommend disabling EPEL when using RDO packages due to updates
   in EPEL breaking backwards compatibility. Or, preferably pin package
   versions using the ``yum-versionlock`` plugin.

   If EPEL is needed, also consider `lowering its priority in DNF
   <https://dnf.readthedocs.io/en/latest/conf_ref.html#repo-options>`_.

CentOS Stream
~~~~~~~~~~~~~

Enable PowerTools/CRB repository:

  .. code-block:: console

   # ### CentOS Stream 9
   # dnf install dnf-plugins-core
   # dnf config-manager --set-enabled crb

RHEL
~~~~

* When using RHEL, it is assumed that you have registered your system using
  Red Hat Subscription Management.   For more information on registering a RHEL
  9 system, see the `Red Hat Enterprise Linux 9 Installation Guide
  <https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/performing_a_standard_rhel_9_installation/assembly_installing-on-amd64-intel-64-and-64-bit-arm_installing-rhel#post-installation-tasks_assembly_installing-on-amd64-intel-64-and-64-bit-arm>`_.

* Enable the required repositories:

  .. code-block:: console

      # ### RHEL 9
      # subscription-manager repos --enable=rhel-9-for-x86_64-baseos-rpms \
         --enable=rhel-9-for-x86_64-appstream-rpms \
         --enable=rhel-9-for-x86_64-supplementary-rpms

* Enable CodeReady Linux Builder (CRB) repository:

  .. code-block:: console

      # ### RHEL 9
      # subscription-manager repos --enable=codeready-builder-for-rhel-9-x86_64-rpms


Enable the OpenStack repository
-------------------------------

To choose which OpenStack release to install, `check the release page
<https://releases.openstack.org/>`_.

CentOS Stream
~~~~~~~~~~~~~

* On CentOS Stream, the ``extras`` repository provides the RPM that enables the
  OpenStack repository. CentOS includes the ``extras`` repository by
  default, so you can simply install the package to enable the OpenStack
  repository:

  .. code-block:: console

   # ### CentOS Stream 9
   # dnf install centos-release-openstack-<release>

   # ### So for example
   # ### 2024.2 Dalmatian
   # dnf install centos-release-openstack-dalmatian
   # ### 2024.1 Caracal
   # dnf install centos-release-openstack-caracal
   # ### 2023.2 Bobcat
   # dnf install centos-release-openstack-bobcat

RHEL
~~~~

* On RHEL, download and install the RDO repository RPM to enable the
  OpenStack repository.

  .. code-block:: console

   # ### RHEL 9
   # dnf install https://trunk.rdoproject.org/rdo_release/rdo-release.el9s.rpm

  **The RDO repository RPM installs the latest available OpenStack release.**

Finalize the installation
-------------------------

1. Upgrade the packages on all nodes:

   .. code-block:: console

      # dnf upgrade

   .. note::

      If the upgrade process includes a new kernel, reboot your host
      to activate it.

2. Install the appropriate OpenStack client for your version.

   .. code-block:: console

      # ### EL9
      # dnf install python3-openstackclient

3. RHEL and CentOS enable :term:`SELinux` by default. Install the
   ``openstack-selinux`` package to automatically manage security
   policies for OpenStack services:

   .. code-block:: console

      # ### EL9
      # dnf install openstack-selinux

Older versions
--------------

.. warning::

   Information here is kept for historical/archival purposes. Includes
   unmaintained/end of life operating systems and OpenStack releases.
   **Do not follow these instructions**.

Prerequisites
~~~~~~~~~~~~~

**RHEL**

* When using RHEL, it is assumed that you have registered your system using
  Red Hat Subscription Management. For more information on registering a RHEL 7
  system, see the `Red Hat Enterprise Linux 7 System Administrator's Guide
  <https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/System_Administrators_Guide/part-Subscription_and_Support.html>`_
  For more information on registering a RHEL 8 system, see the
  `Red Hat Enterprise Linux 8 Installation Guide
  <https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/performing_a_standard_rhel_installation/post-installation-tasks_installing-rhel>`_.

* Enable the required repositories:

  .. code-block:: console

      # ### RHEL 7
      # subscription-manager repos --enable=rhel-7-server-rpms \
         --enable=rhel-7-server-optional-rpms \
         --enable=rhel-7-server-extras-rpms \
         --enable=rhel-7-server-rh-common-rpms

      # ### RHEL 8
      # subscription-manager repos --enable=rhel-8-for-x86_64-baseos-rpms \
         --enable=rhel-8-for-x86_64-appstream-rpms \
         --enable=rhel-8-for-x86_64-supplementary-rpms

* Enable Powertools CodeReady Linux Builder (CRB) repository:

  .. code-block:: console

      # ### RHEL 8
      # subscription-manager repos --enable=codeready-builder-for-rhel-8-x86_64-rpms

Enable the OpenStack repository
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* On CentOS, the ``extras`` repository provides the RPM that enables the
  OpenStack repository. CentOS includes the ``extras`` repository by
  default, so you can simply install the package to enable the OpenStack
  repository. For CentOS8, you will also need to enable the PowerTools
  repository.

  **When installing the Victoria release, run:**

  .. code-block:: console

     # yum install centos-release-openstack-victoria
     # yum config-manager --set-enabled powertools

  **When installing the Ussuri release, run:**

  .. code-block:: console

     # yum install centos-release-openstack-ussuri
     # yum config-manager --set-enabled powertools

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

Further references
------------------

* `Red Hat - Introduction to Red Hat OpenStack Platform / Understanding Red Hat OpenStack Platform
  <https://access.redhat.com/documentation/en-us/red_hat_openstack_platform/17.1/html/introduction_to_red_hat_openstack_platform/assembly_understanding-red-hat-openstack-platform>`_
* `RDO - Overview of available RDO repos <https://www.rdoproject.org/what/repos/>`_
* `RDO - Packstack <https://www.rdoproject.org/install/packstack/>`_
