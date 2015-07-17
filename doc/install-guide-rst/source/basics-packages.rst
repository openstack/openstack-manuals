OpenStack packages
~~~~~~~~~~~~~~~~~~

Distributions release OpenStack packages as part of the distribution or
using other methods because of differing release schedules. Perform
these procedures on all nodes.

.. note::

   Disable or remove any automatic update services because they can
   impact your OpenStack environment.

.. only:: ubuntu

   **To enable the OpenStack repository**

   * Install the Ubuntu Cloud archive keyring and repository:

     .. code-block:: console

        # apt-get install ubuntu-cloud-keyring
        # echo "deb http://ubuntu-cloud.archive.canonical.com/ubuntu" \
          "trusty-updates/kilo main" > /etc/apt/sources.list.d/ \
          cloudarchive-kilo.list

.. only:: rdo

   **To configure prerequisites**

   #. On RHEL and CentOS, enable the
      `EPEL <https://fedoraproject.org/wiki/EPEL>`_ repository:

      .. code-block:: console

         # yum install http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm

      .. note::

         Fedora does not require this repository.

   #. On RHEL, enable additional repositories using the subscription
      manager:

      .. code-block:: console

         # subscription-manager repos --enable=rhel-7-server-optional-rpms
         # subscription-manager repos --enable=rhel-7-server-extras-rpms

      .. note::

         CentOS and Fedora do not require these repositories.

.. only:: rdo

   **To enable the OpenStack repository**


   * Install the ``rdo-release-kilo`` package to enable the RDO repository:

     .. code-block:: console

        # yum install http://rdo.fedorapeople.org/openstack-kilo/rdo-release-kilo.rpm

.. only:: obs

   **To enable the OpenStack repository**

   * Enable the Open Build Service repositories based on your openSUSE or
     SLES version:

     **On openSUSE 13.2:**

     .. code-block:: console

        # zypper addrepo -f obs://Cloud:OpenStack:Kilo/openSUSE_13.2 Kilo

     The openSUSE distribution uses the concept of patterns to represent
     collections of packages. If you selected 'Minimal Server Selection (Text
     Mode)' during the initial installation, you may be presented with a
     dependency conflict when you attempt to install the OpenStack packages.
     To avoid this, remove the minimal\_base-conflicts package:

     .. code-block:: console

        # zypper rm patterns-openSUSE-minimal_base-conflicts

     **On SLES 12:**

     .. code-block:: console

        # zypper addrepo -f obs://Cloud:OpenStack:Kilo/SLE_12 Kilo

     .. note::

        The packages are signed by GPG key 893A90DAD85F9316. You should
        verify the fingerprint of the imported GPG key before using it.

        ::

          Key ID: 893A90DAD85F9316
          Key Name: Cloud:OpenStack OBS Project <Cloud:OpenStack@build.opensuse.org>
          Key Fingerprint: 35B34E18ABC1076D66D5A86B893A90DAD85F9316
          Key Created: Tue Oct  8 13:34:21 2013
          Key Expires: Thu Dec 17 13:34:21 2015

.. only:: debian

   ** To use the Debian Wheezy backports archive for Juno**

   The Juno release is available only in Debian Experimental (otherwise
   called rc-buggy), as Jessie is frozen soon, and will contain Icehouse.
   However, the Debian maintainers of OpenStack also maintain a
   non-official Debian repository for OpenStack containing Wheezy
   backports.

   #. On all nodes, install the Debian Wheezy backport repository Juno:

      .. code-block:: console

         # echo "deb http://archive.gplhost.com/debian juno-backports main" \
           >>/etc/apt/sources.list

   #. Install the Debian Wheezy OpenStack repository for Juno:

      .. code-block:: console

         # echo "deb http://archive.gplhost.com/debian juno-backports main" \
           >>/etc/apt/sources.list

   #. Update the repository database and install the key:

      ::

        $ apt-get update && apt-get install gplhost-archive-keyring

   #. Update the package database, upgrade your system, and reboot
      for all changes to take effect:

      .. code-block:: console

         $ apt-get update && apt-get dist-upgrade
         $ reboot

   Numerous archive.gplhost.com mirrors are available around the world. All
   are available with both FTP and HTTP protocols (you should use the
   closest mirror). The list of mirrors is available at
   `http://archive.gplhost.com/readme.mirrors
   <http://archive.gplhost.com/readme.mirrors>`_ .

   **Manually install python-argparse**

   The Debian OpenStack packages are maintained on Debian Sid (also known
   as Debian Unstable) - the current development version. Backported
   packages run correctly on Debian Wheezy with one caveat:

   All OpenStack packages are written in Python. All packages support
   version 2.7; porting to Python version 3 is ongoing. Note that Debian
   Wheezy uses Python 2.6 and 2.7, with Python 2.7 as the default
   interpreter; Sid has only Python 2.7. There is one packaging change
   between these two. In Python 2.6, you installed the ``python-argparse``
   package separately. In Python 2.7, this package is installed by default.
   Unfortunately, in Python 2.7, this package does not include ``Provides:
   python-argparse`` directive.

   #. Because the packages are maintained in Sid where the
      ``Provides: python-argparse`` directive causes an error, and the Debian
      OpenStack maintainer wants to maintain one version of the OpenStack
      packages, you must manually install the ``python-argparse`` on each
      OpenStack system that runs Debian Wheezy before you install the other
      OpenStack packages. Use the following command to install the package:

      .. code-block:: console

         # apt-get install python-argparse

      This caveat applies to most OpenStack packages in Wheezy.

|

**To finalize the installation**

.. only:: ubuntu or debian

   * Upgrade the packages on your system:

     ::

       $ apt-get update && apt-get dist-upgrade

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

     ::

       $ zypper refresh && zypper dist-upgrade

     .. note::

        If the upgrade process includes a new kernel, reboot your system
        to activate it.

.. only:: rdo

   2. RHEL and CentOS enable :term:`SELinux` by default. Install the
      ``openstack-selinux`` package to automatically manage security
      policies for OpenStack services:

      .. code-block:: console

         # yum install openstack-selinux

      .. note::

         Fedora does not require this package.

      .. note::

         The installation process for this package can take a while.
