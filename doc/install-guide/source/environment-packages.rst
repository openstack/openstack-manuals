OpenStack packages
~~~~~~~~~~~~~~~~~~

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

.. only:: ubuntu

   Enable the OpenStack repository
   -------------------------------

   .. code-block:: console

      # apt install software-properties-common
      # add-apt-repository cloud-archive:ocata

   .. end

.. endonly

.. only:: rdo

   Prerequisites
   -------------

   .. warning::

      We recommend disabling EPEL when using RDO packages due to updates
      in EPEL breaking backwards compatibility. Or, preferably pin package
      versions using the ``yum-versionlock`` plugin.

   .. note::

      CentOS does not require the following steps.

   #. On RHEL, register your system with Red Hat Subscription Management, using
      your Customer Portal user name and password:

      .. code-block:: console

         # subscription-manager register --username="USERNAME" --password="PASSWORD"

      .. end

   #. Find entitlement pools containing the channels for your RHEL system:

      .. code-block:: console

         # subscription-manager list --available

      .. end

   #. Use the pool identifiers found in the previous step to attach your RHEL
      entitlements:

      .. code-block:: console

         # subscription-manager attach --pool="POOLID"

      .. end

   #. Enable required repositories:

      .. code-block:: console

         # subscription-manager repos --enable=rhel-7-server-optional-rpms \
           --enable=rhel-7-server-extras-rpms --enable=rhel-7-server-rh-common-rpms

      .. end

.. endonly

.. only:: rdo

   Enable the OpenStack repository
   -------------------------------

   * On CentOS, the ``extras`` repository provides the RPM that enables the
     OpenStack repository. CentOS includes the ``extras`` repository by
     default, so you can simply install the package to enable the OpenStack
     repository.

     .. code-block:: console

        # yum install centos-release-openstack-newton

     .. end

   * On RHEL, download and install the RDO repository RPM to enable the
     OpenStack repository.

     .. code-block:: console

        # yum install https://rdoproject.org/repos/rdo-release.rpm

     .. end

.. only:: obs

   Enable the OpenStack repository
   -------------------------------

   * Enable the Open Build Service repositories based on your openSUSE or
     SLES version:

     **On openSUSE:**

     .. code-block:: console

        # zypper addrepo -f obs://Cloud:OpenStack:Ocata/openSUSE_Leap_42.2 Ocata

     .. end

     .. note::

        The openSUSE distribution uses the concept of patterns to
        represent collections of packages. If you selected 'Minimal
        Server Selection (Text Mode)' during the initial installation,
        you may be presented with a dependency conflict when you
        attempt to install the OpenStack packages. To avoid this,
        remove the minimal\_base-conflicts package:

        .. code-block:: console

           # zypper rm patterns-openSUSE-minimal_base-conflicts

        .. end

     **On SLES:**

     .. code-block:: console

        # zypper addrepo -f obs://Cloud:OpenStack:Ocata/SLE_12_SP2 Ocata

     .. end

     .. note::

        The packages are signed by GPG key ``D85F9316``. You should
        verify the fingerprint of the imported GPG key before using it.

        .. code-block:: console

           Key Name:         Cloud:OpenStack OBS Project <Cloud:OpenStack@build.opensuse.org>
           Key Fingerprint:  35B34E18 ABC1076D 66D5A86B 893A90DA D85F9316
           Key Created:      2015-12-16T16:48:37 CET
           Key Expires:      2018-02-23T16:48:37 CET

        .. end

.. endonly

.. only:: debian

   Enable the backports repository
   -------------------------------

   The Newton release is available directly through the official
   Debian backports repository. To use this repository, follow
   the instruction from the official
   `Debian website <http://backports.debian.org/Instructions/>`_,
   which basically suggest doing the following steps:

   #. On all nodes, adding the Debian 8 (Jessie) backport repository to
      the source list:

      .. code-block:: console

         # echo "deb http://http.debian.net/debian jessie-backports main" \
           >>/etc/apt/sources.list

      .. end

      .. note::

         Later you can use the following command to install a package:

         .. code-block:: console

            # apt -t jessie-backports install ``PACKAGE``

         .. end

.. endonly

Finalize the installation
-------------------------

1. Upgrade the packages on all nodes:

   .. only:: ubuntu or debian

      .. code-block:: console

         # apt update && apt dist-upgrade

      .. end

   .. endonly

   .. only:: rdo

      .. code-block:: console

         # yum upgrade

      .. end

   .. endonly

   .. only:: obs

      .. code-block:: console

         # zypper refresh && zypper dist-upgrade

      .. end

   .. endonly

   .. note::

      If the upgrade process includes a new kernel, reboot your host
      to activate it.

2. Install the OpenStack client:

   .. only:: debian or ubuntu

      .. code-block:: console

         # apt install python-openstackclient

      .. end

   .. endonly

   .. only:: rdo

      .. code-block:: console

         # yum install python-openstackclient

      .. end

   .. endonly

   .. only:: obs

      .. code-block:: console

         # zypper install python-openstackclient

      .. end

   .. endonly

.. only:: rdo

   3. RHEL and CentOS enable :term:`SELinux` by default. Install the
      ``openstack-selinux`` package to automatically manage security
      policies for OpenStack services:

      .. code-block:: console

         # yum install openstack-selinux

      .. end

.. endonly
