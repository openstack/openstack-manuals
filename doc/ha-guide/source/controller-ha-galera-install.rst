Installation
=============

Using Galera Cluster requires that you install two packages. The first is
the database server, which must include the wsrep API patch. The second
package is the Galera Replication Plugin, which enables the write-set
replication service functionality with the database server.

There are three implementations of Galera Cluster: MySQL, MariaDB and
Percona XtraDB. For each implementation, there is a software repository that
provides binary packages for Debian, Red Hat, and SUSE-based Linux
distributions.


Enabling the repository
~~~~~~~~~~~~~~~~~~~~~~~~

Galera Cluster is not available in the base repositories of Linux
distributions. In order to install it with your package manage, you must
first enable the repository on your system. The particular methods for
doing so vary depending on which distribution you use for OpenStack and
which database server you want to use.

Debian
-------

For Debian and Debian-based distributions, such as Ubuntu, complete the
following steps:

#. Add the GnuPG key for the database repository that you want to use.

   .. code-block:: console

      # apt-key adv --recv-keys --keyserver \
             keyserver.ubuntu.com BC19DDBA

   Note that the particular key value in this command varies depending on
   which database software repository you want to use.

   +--------------------------+------------------------+
   | Database                 | Key                    |
   +==========================+========================+
   | Galera Cluster for MySQL | ``BC19DDBA``           |
   +--------------------------+------------------------+
   | MariaDB Galera Cluster   | ``0xcbcb082a1bb943db`` |
   +--------------------------+------------------------+
   | Percona XtraDB Cluster   | ``1C4CBDCDCD2EFD2A``   |
   +--------------------------+------------------------+

#. Add the repository to your sources list. Using your preferred text
   editor, create a ``galera.list`` file in the ``/etc/apt/sources.list.d/``
   directory. For the contents of this file, use the lines that pertain to
   the software repository you want to install:

   .. code-block:: linux-config

     # Galera Cluster for MySQL
     deb http://releases.galeracluster.com/DISTRO RELEASE main

     # MariaDB Galera Cluster
     deb http://mirror.jmu.edu/pub/mariadb/repo/VERSION/DISTRO RELEASE main

     # Percona XtraDB Cluster
     deb http://repo.percona.com/apt RELEASE main

   For each entry: Replace all instances of ``DISTRO`` with the distribution
   that you use, such as ``debian`` or ``ubuntu``. Replace all instances of
   ``RELEASE`` with the release of that distribution, such as ``wheezy`` or
   ``trusty``. Replace all instances of ``VERSION`` with the version of the
   database server that you want to install, such as ``5.6`` or ``10.0``.

   .. note:: In the event that you do not know the release code-name for
             your distribution, you can use the following command to
             find it out:

             .. code-block:: console

                $ lsb_release -a


#. Update the local cache.

   .. code-block:: console

      # apt-get update

Packages in the Galera Cluster Debian repository are now available for
installation on your system.

Red Hat
--------

For Red Hat Enterprise Linux and Red Hat-based Linux distributions, the
process is more straightforward. In this file, only enter the text for
the repository you want to use.

- For Galera Cluster for MySQL, using your preferred text editor, create a
  ``Galera.repo`` file in the ``/etc/yum.repos.d/`` directory.

  .. code-block:: linux-config

     [galera]
     name = Galera Cluster for MySQL
     baseurl = http://releases.galeracluster.com/DISTRO/RELEASE/ARCH
     gpgkey = http://releases.galeracluster.com/GPG-KEY-galeracluster.com
     gpgcheck = 1

  Replace ``DISTRO`` with the name of the distribution you use, such as
  ``centos`` or ``fedora``. Replace ``RELEASE`` with the release number,
  such as ``7`` for CentOS 7. Replace ``ARCH`` with your system
  architecture, such as ``x86_64``

- For MariaDB Galera Cluster, using your preferred text editor, create a
  ``Galera.repo`` file in the ``/etc/yum.repos.d/`` directory.

  .. code-block:: linux-config

     [mariadb]
     name = MariaDB Galera Cluster
     baseurl = http://yum.mariadb.org/VERSION/PACKAGE
     gpgkey = https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
     gpgcheck = 1

  Replace ``VERSION`` with the version of MariaDB you want to install, such
  as ``5.6`` or ``10.0``. Replace ``PACKAGE`` with the package type and
  architecture, such as ``rhel6-amd64`` for Red Hat 6 on 64-bit
  architecture.

- For Percona XtraDB Cluster, run the following command:

  .. code-block:: console

     # yum install http://www.percona.com/downloads/percona-release/redhat/0.1-3/percona-release-0.1-3.noarch.rpm

  Bear in mind that the Percona repository only supports Red Hat Enterprise
  Linux and CentOS distributions.

Packages in the Galera Cluster Red Hat repository are not available for
installation on your system.



SUSE
-----

For SUSE Enterprise Linux and SUSE-based distributions, such as openSUSE
binary installations are only available for Galera Cluster for MySQL and
MariaDB Galera Cluster.

#. Create a ``Galera.repo`` file in the local directory. For Galera Cluster
   for MySQL, use the following content:

   .. code-block:: linux-config

      [galera]
      name = Galera Cluster for MySQL
      baseurl = http://releases.galeracluster.com/DISTRO/RELEASE
      gpgkey = http://releases.galeracluster.com/GPG-KEY-galeracluster.com
      gpgcheck = 1

   In the text: Replace ``DISTRO`` with the name of the distribution you
   use, such as ``sles`` or ``opensuse``. Replace ``RELEASE`` with the
   version number of that distribution.

   For MariaDB Galera Cluster, instead use this content:

   .. code-block:: linux-config

      [mariadb]
      name = MariaDB Galera Cluster
      baseurl = http://yum.mariadb.org/VERSION/PACKAGE
      gpgkey = https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
      gpgcheck = 1

   In the text: Replace ``VERSION`` with the version of MariaDB you want to
   install, such as ``5.6`` or ``10.0``. Replace package with the package
   architecture you want to use, such as ``opensuse13-amd64``.

#. Add the repository to your system:

   .. code-block:: console

      $ sudo zypper addrepo Galera.repo

#. Refresh ``zypper``:

   .. code-block:: console

      $ sudo zypper refresh

Packages in the Galera Cluster SUSE repository are now available for
installation.


Installing Galera Cluster
~~~~~~~~~~~~~~~~~~~~~~~~~~

When you finish enabling the software repository for Galera Cluster, you can
install it using your package manager. The particular command and packages
you need to install varies depending on which database server you want to
install and which Linux distribution you use:

Galera Cluster for MySQL:


- For Debian and Debian-based distributions, such as Ubuntu, run the
  following command:

  .. code-block:: console

     # apt-get install galera-3 mysql-wsrep-5.6

- For Red Hat Enterprise Linux and Red Hat-based distributions, such as
  Fedora or CentOS, instead run this command:

  .. code-block:: console

     # yum install galera-3 mysql-wsrep-5.6

- For SUSE Enterprise Linux Server and SUSE-based distributions, such as
  openSUSE, instead run this command:

  .. code-block:: console

     # zypper install galera-3 mysql-wsrep-5.6


MariaDB Galera Cluster:

- For Debian and Debian-based distributions, such as Ubuntu, run the
  following command:

  .. code-block:: console

     # apt-get install galera mariadb-galera-server

- For Red Hat Enterprise Linux and Red Hat-based distributions, such as
  Fedora or CentOS, instead run this command:

  .. code-block:: console

     # yum install galera MariaDB-Galera-server

- For SUSE Enterprise Linux Server and SUSE-based distributions, such as
  openSUSE, instead run this command:

  .. code-block:: console

     # zypper install galera MariaDB-Galera-server


Percona XtraDB Cluster:


- For Debian and Debian-based distributions, such as Ubuntu, run the
  following command:

  .. code-block:: console

     # apt-get install percona-xtradb-cluster

- For Red Hat Enterprise Linux and Red Hat-based distributions, such as
  Fedora or CentOS, instead run this command:

 .. code-block:: console

   # yum install Percona-XtraDB-Cluster

Galera Cluster is now installed on your system. You must repeat this
process for each controller node in your cluster.

.. warning:: In the event that you already installed the standalone version
             of MySQL, MariaDB or Percona XtraDB, this installation purges all
             privileges on your OpenStack database server. You must reapply the
             privileges listed in the installation guide.
