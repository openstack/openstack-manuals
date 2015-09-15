.. highlight:: ini
   :linenothreshold: 1

==============================
OpenStack service dependencies
==============================

OpenStack packages
------------------

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

   **To use the Debian 8 (Jessie) backports archive for Kilo**

   The Kilo release is available directly through the official
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


**To finalize the installation**

.. only:: ubuntu or debian

   * Upgrade the packages on your system:

     .. code-block:: console

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

   3. Because Fedora does not provide the ``openstack-selinux`` package
      ensure that SELinux is disabled.

      .. code-block: console

         # sestatus
         SELinux status:                 disabled

      If ``SELinux status`` is ``enabled`` disable SELinux by editing the file
      ``/etc/selinux/config`` and restarting the system afterwards:

      .. code-block: ini

         SELINUX=disabled

      .. note::

         CentOS and RHEL do not require this step.

|

SQL database
------------

Most OpenStack services use an SQL database to store information. The
database typically runs on the controller node. The procedures in this
guide use MariaDB or MySQL depending on the distribution. OpenStack
services also support other SQL databases including
`PostgreSQL <http://www.postgresql.org/>`__.


**To install and configure the database server**

1. Install the packages:

   .. only:: rdo or ubuntu or obs

      .. note::

         The Python MySQL library is compatible with MariaDB.

   .. only:: ubuntu

      .. code-block:: console

         # apt-get install mariadb-server python-pymysql

   .. only:: debian

      .. code-block:: console

         # apt-get install mysql-server python-pymysql

   .. only:: rdo

      .. code-block:: console

         # yum install mariadb mariadb-server PyMySQL

   .. only:: obs

      .. code-block:: console

         # zypper install mariadb-client mariadb python-mysql

.. only:: ubuntu or debian

   2. Choose a suitable password for the database root account.

   3. Create and edit the :file:`/etc/mysql/conf.d/mysqld_openstack.cnf` file
      and complete the following actions:

      - In the ``[mysqld]`` section, set the
        ``bind-address`` key to the management IP
        address of the controller node to enable access by other
        nodes via the management network:

        .. code:: ini

           [mysqld]
           ...
           bind-address = 10.0.0.11

      - In the ``[mysqld]`` section, set the following keys to enable
        useful options and the UTF-8 character set:

        .. code:: ini

           [mysqld]
           ...
           default-storage-engine = innodb
           innodb_file_per_table
           collation-server = utf8_general_ci
           init-connect = 'SET NAMES utf8'
           character-set-server = utf8


.. only:: obs or rdo

   2. Create and edit the :file:`/etc/my.cnf.d/mariadb_openstack.cnf` file
      and complete the following actions:

      - In the ``[mysqld]`` section, set the
        ``bind-address`` key to the management IP
        address of the controller node to enable access by other
        nodes via the management network:

        .. code:: ini

           [mysqld]
           ...
           bind-address = 10.0.0.11

      - In the ``[mysqld]`` section, set the following keys to enable
        useful options and the UTF-8 character set:

        .. code:: ini

           [mysqld]
           ...
           default-storage-engine = innodb
           innodb_file_per_table
           collation-server = utf8_general_ci
           init-connect = 'SET NAMES utf8'
           character-set-server = utf8

**To finalize installation**

.. only:: ubuntu or debian

   1. Restart the database service:

      .. code-block:: console

         # service mysql restart

.. only:: rdo or obs

   1. Start the database service and configure it to start when the system
      boots:

      .. only:: rdo

         .. code-block:: console

            # systemctl enable mariadb.service
            # systemctl start mariadb.service

      .. only:: obs

         .. code-block:: console

            # systemctl enable mysql.service
            # systemctl start mysql.service

.. only:: ubuntu

   2. Secure the database service:

      .. literalinclude:: mariadb_output.txt

.. only:: rdo or obs

   2. Secure the database service including choosing a suitable
      password for the root account:

      .. literalinclude:: mariadb_output.txt

|

Message queue
-------------

OpenStack uses a :term:`message queue` to coordinate operations and
status information among services. The message queue service typically
runs on the controller node. OpenStack supports several message queue
services including `RabbitMQ <http://www.rabbitmq.com>`__,
`Qpid <http://qpid.apache.org>`__, and `ZeroMQ <http://zeromq.org>`__.
However, most distributions that package OpenStack support a particular
message queue service. This guide implements the RabbitMQ message queue
service because most distributions support it. If you prefer to
implement a different message queue service, consult the documentation
associated with it.

**To install the message queue service**

* Install the package:

  .. only:: ubuntu or debian

     .. code-block:: console

        # apt-get install rabbitmq-server

  .. only:: rdo

     .. code-block:: console

        # yum install rabbitmq-server

  .. only:: obs

     .. code-block:: console

        # zypper install rabbitmq-server


**To configure the message queue service**

#. Start the message queue service and configure it to start when the
   system boots:

   .. only:: rdo or obs

      .. code-block:: console

         # systemctl enable rabbitmq-server.service
         # systemctl start rabbitmq-server.service

#. Add the ``openstack`` user:

   .. code-block:: console

      # rabbitmqctl add_user openstack RABBIT_PASS
        Creating user "openstack" ...

   Replace ``RABBIT_PASS`` with a suitable password.

#. Permit configuration, write, and read access for the
   ``openstack`` user:

   .. code-block:: console

      # rabbitmqctl set_permissions openstack ".*" ".*" ".*"
        Setting permissions for user "openstack" in vhost "/" ...
