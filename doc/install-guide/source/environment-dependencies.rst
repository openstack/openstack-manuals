==============================
OpenStack service dependencies
==============================

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

      .. note::

         Fedora does not require this package.

   3. Because Fedora does not provide the ``openstack-selinux`` package
      ensure that SELinux is disabled.

      .. code-block:: console

         # sestatus
         SELinux status:                 disabled

      If ``SELinux status`` is ``enabled`` disable SELinux by editing the file
      ``/etc/selinux/config`` and restarting the system afterwards:

      .. code-block:: ini

         SELINUX=disabled

      .. note::

         CentOS and RHEL do not require this step.

Install the OpenStack client
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

SQL database
~~~~~~~~~~~~

Most OpenStack services use an SQL database to store information. The
database typically runs on the controller node. The procedures in this
guide use MariaDB or MySQL depending on the distribution. OpenStack
services also support other SQL databases including
`PostgreSQL <http://www.postgresql.org/>`__.

Install and configure the database server
-----------------------------------------

#. Install the packages:

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

         # yum install mariadb mariadb-server python2-PyMySQL

   .. only:: obs

      .. code-block:: console

         # zypper install mariadb-client mariadb python-PyMySQL

.. only:: ubuntu or debian

   2. Choose a suitable password for the database root account.

   3. Create and edit the ``/etc/mysql/conf.d/mysqld_openstack.cnf`` file
      and complete the following actions:

      - In the ``[mysqld]`` section, set the
        ``bind-address`` key to the management IP
        address of the controller node to enable access by other
        nodes via the management network:

        .. code-block:: ini

           [mysqld]
           ...
           bind-address = 10.0.0.11

      - In the ``[mysqld]`` section, set the following keys to enable
        useful options and the UTF-8 character set:

        .. code-block:: ini

           [mysqld]
           ...
           default-storage-engine = innodb
           innodb_file_per_table
           collation-server = utf8_general_ci
           init-connect = 'SET NAMES utf8'
           character-set-server = utf8


.. only:: obs or rdo

   2. Create and edit the ``/etc/my.cnf.d/mariadb_openstack.cnf`` file
      and complete the following actions:

      - In the ``[mysqld]`` section, set the
        ``bind-address`` key to the management IP
        address of the controller node to enable access by other
        nodes via the management network:

        .. code-block:: ini

           [mysqld]
           ...
           bind-address = 10.0.0.11

      - In the ``[mysqld]`` section, set the following keys to enable
        useful options and the UTF-8 character set:

        .. only:: rdo

           .. code-block:: ini

              [mysqld]
              ...
              default-storage-engine = innodb
              innodb_file_per_table
              collation-server = utf8_general_ci
              init-connect = 'SET NAMES utf8'
              character-set-server = utf8

        .. only:: obs

           .. code-block:: ini

              [mysqld]
              ...
              default-storage-engine = innodb
              innodb_file_per_table
              collation-server = utf8_general_ci
              character-set-server = utf8


To finalize installation
------------------------

.. only:: ubuntu or debian

   #. Restart the database service:

      .. code-block:: console

         # service mysql restart

.. only:: rdo or obs

   #. Start the database service and configure it to start when the system
      boots:

      .. only:: rdo

         .. code-block:: console

            # systemctl enable mariadb.service
            # systemctl start mariadb.service

      .. only:: obs

         .. code-block:: console

            # systemctl enable mysql.service
            # systemctl start mysql.service

.. only:: ubuntu or rdo or obs

   2. Secure the database service by running the
      ``mysql_secure_installation`` script.

|

Message queue
~~~~~~~~~~~~~

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

Install the message queue service
---------------------------------

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


Configure the message queue service
-----------------------------------

.. only:: rdo or obs

   #. Start the message queue service and configure it to start when the
      system boots:

      .. code-block:: console

         # systemctl enable rabbitmq-server.service
         # systemctl start rabbitmq-server.service

      .. only:: obs

         In case the message queue service does not start and
         returns a ``nodedown`` error, perform the following actions:

         * Copy the ``/usr/lib/systemd/system/epmd.socket`` file to the
           ``/etc/systemd/system`` directory.

         * Edit the ``/etc/systemd/system/epmd.socket`` file to contain
           the following:

           .. code-block:: ini

              [Socket]
              ...
              ListenStream=MANAGEMENT_INTERFACE_IP_ADDRESS:4369

           Replace ``MANAGEMENT_INTERFACE_IP_ADDRESS`` with the IP address
           of the management network interface on your controller node.

         * Start the message queue service again.

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

.. only:: ubuntu or debian

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
