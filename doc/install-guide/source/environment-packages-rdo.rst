OpenStack packages for RHEL and CentOS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Distributions release OpenStack packages as part of the distribution or
using other methods because of differing release schedules. Perform
these procedures on all nodes.

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
   ``rhel-7-server-rpms`` repository enabled by default.

   For more information on registering the system, see the
   `Red Hat Enterprise Linux 7 System Administrator's Guide
   <https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/System_Administrators_Guide/part-Subscription_and_Support.html>`_.

#. In addition to ``rhel-7-server-rpms``, you also need to have the
   ``rhel-7-server-optional-rpms``, ``rhel-7-server-extras-rpms``, and
   ``rhel-7-server-rh-common-rpms`` repositories enabled:

   .. code-block:: console

      # subscription-manager repos --enable=rhel-7-server-optional-rpms \
        --enable=rhel-7-server-extras-rpms --enable=rhel-7-server-rh-common-rpms

   .. end

Enable the OpenStack repository
-------------------------------

* On CentOS, the ``extras`` repository provides the RPM that enables the
  OpenStack repository. CentOS includes the ``extras`` repository by
  default, so you can simply install the package to enable the OpenStack
  repository.

  **When installing the Pike release, run:**

  .. code-block:: console

     # yum install centos-release-openstack-pike

  .. end

  **When installing the Queens release, run:**

  .. code-block:: console

     # yum install centos-release-openstack-queens

  .. end

* On RHEL, download and install the RDO repository RPM to enable the
  OpenStack repository.

  .. code-block:: console

     # yum install https://rdoproject.org/repos/rdo-release.rpm

  .. end

  The RDO repository RPM installs the latest available OpenStack release.

Finalize the installation
-------------------------

1. Upgrade the packages on all nodes:

   .. code-block:: console

      # yum upgrade

   .. end

   .. note::

      If the upgrade process includes a new kernel, reboot your host
      to activate it.

2. Install the OpenStack client:

   .. code-block:: console

      # yum install python-openstackclient

   .. end

3. RHEL and CentOS enable :term:`SELinux` by default. Install the
   ``openstack-selinux`` package to automatically manage security
   policies for OpenStack services:

   .. code-block:: console

      # yum install openstack-selinux

   .. end
