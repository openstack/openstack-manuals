OpenStack packages
~~~~~~~~~~~~~~~~~~

Distributions release OpenStack packages as part of the distribution or
using other methods because of differing release schedules. Perform
these procedures on all nodes.

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

      # apt-get install software-properties-common
      # add-apt-repository cloud-archive:liberty

.. only:: rdo

   Prerequisites
   -------------

   #. Enable the `EPEL <https://fedoraproject.org/wiki/EPEL>`_ repository:

      .. code-block:: console

         # yum install http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm

   #. On RHEL, enable additional repositories using the subscription
      manager:

      .. code-block:: console

         # subscription-manager repos --enable=rhel-7-server-optional-rpms
         # subscription-manager repos --enable=rhel-7-server-extras-rpms

      .. note::

         CentOS does not require these repositories.

.. only:: rdo

   Enable the OpenStack repository
   -------------------------------

   * Install the ``rdo-release-liberty`` package to enable the RDO repository:

     .. code-block:: console

        # yum install http://rdo.fedorapeople.org/openstack-liberty/rdo-release-liberty.rpm

.. only:: obs

   Enable the OpenStack repository
   -------------------------------

   * Enable the Open Build Service repositories based on your openSUSE or
     SLES version:

     **On openSUSE 13.2:**

     .. code-block:: console

        # zypper addrepo -f obs://Cloud:OpenStack:Liberty/openSUSE_13.2 Liberty

     The openSUSE distribution uses the concept of patterns to represent
     collections of packages. If you selected 'Minimal Server Selection (Text
     Mode)' during the initial installation, you may be presented with a
     dependency conflict when you attempt to install the OpenStack packages.
     To avoid this, remove the minimal\_base-conflicts package:

     .. code-block:: console

        # zypper rm patterns-openSUSE-minimal_base-conflicts

     **On SLES 12:**

     .. code-block:: console

        # zypper addrepo -f obs://Cloud:OpenStack:Liberty/SLE_12 Liberty

     .. note::

        The packages are signed by GPG key ``D85F9316``. You should
        verify the fingerprint of the imported GPG key before using it.

        .. code-block:: console

           Key Name:         Cloud:OpenStack OBS Project <Cloud:OpenStack@build.opensuse.org>
           Key Fingerprint:  35B34E18 ABC1076D 66D5A86B 893A90DA D85F9316
           Key Created:      Tue 08 Oct 2013 01:34:21 PM UTC
           Key Expires:      Thu 17 Dec 2015 01:34:21 PM UTC

.. only:: debian

   Enable the backports repository
   -------------------------------

   The Liberty release is available directly through the official
   Debian backports repository. To use this repository, follow
   the instruction from the official
   `Debian website <http://backports.debian.org/Instructions/>`_,
   which basically suggest doing the following steps:


   #. On all nodes, adding the Debian 8 (Jessie) backport repository to
      the source list:

      .. code-block:: console

         # echo "deb deb http://http.debian.net/debian jessie-backports main" \
           >>/etc/apt/sources.list

      .. note::

         Later you can use the following command to install a package:

         .. code-block:: console

            # apt-get -t jessie-backports install ``PACKAGE``

Finalize the installation
-------------------------

.. only:: ubuntu or debian

   * Upgrade the packages on your system:

     .. code-block:: console

        # apt-get update && apt-get dist-upgrade

     .. note::

      If the upgrade process includes a new kernel, reboot your system
      to activate it.

.. only:: rdo

   #. Upgrade the packages on your system:

      .. code-block:: console

         # yum upgrade

      .. note::

         If the upgrade process includes a new kernel, reboot your system
         to activate it.

.. only:: obs

   * Upgrade the packages on your system:

     .. code-block:: console

        # zypper refresh && zypper dist-upgrade

     .. note::

        If the upgrade process includes a new kernel, reboot your system
        to activate it.

.. only:: rdo

   2. RHEL and CentOS enable :term:`SELinux` by default. Install the
      ``openstack-selinux`` package to automatically manage security
      policies for OpenStack services:

      .. code-block:: console

         # yum install openstack-selinux

Install the OpenStack client
----------------------------

Throughout the guide the OpenStack client will be used to perform actions on
the installed services.

* Install the package:

.. only:: debian or ubuntu

   .. code-block:: console

      # apt-get install python-openstackclient

.. only:: rdo

   .. code-block:: console

      # yum install python-openstackclient

.. only:: obs

   .. code-block:: console

      # zypper install python-openstackclient
