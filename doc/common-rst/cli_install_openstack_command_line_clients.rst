==========================================
Install the OpenStack command-line clients
==========================================

Install the prerequisite software and the Python package for each
OpenStack client.

Install the prerequisite software
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Most Linux distributions include packaged versions of the command-line
clients that you can install directly, see Installing_from_packages_.

If you need to install the command-line packages source packages, the
following table lists the software that you need to have to run the
command-line clients, and provides installation instructions as needed.

+-----------------------+-----------------------------------------------------+
| Prerequisite          | Description                                         |
+=======================+=====================================================+
| Python 2.7 or later   | Currently, the clients do not support Python 3.     |
+-----------------------+-----------------------------------------------------+
| setuptools package    | Installed by default on Mac OS X.                   |
|                       |                                                     |
|                       | Many Linux distributions provide packages to make   |
|                       | setuptools easy to install. Search your package     |
|                       | manager for setuptools to find an installation      |
|                       | package. If you cannot find one, download the       |
|                       | setuptools package directly from                    |
|                       | https://pypi.python.org/pypi/setuptools.            |
|                       |                                                     |
|                       | The recommended way to install setuptools on        |
|                       | Microsoft Windows is to follow the documentation    |
|                       | provided on the setuptools website                  |
|                       | (https://pypi.python.org/pypi/setuptools).          |
|                       | Another option is to use the unofficial binary      |
|                       | installer maintained by Christoph Gohlke            |
|                       | (`http://www.lfd.uci.edu/~gohlke/pythonlibs/        |
|                       | #setuptools <http://www.lfd.uci.edu/~gohlke/        |
|                       | pythonlibs/#setuptools>`__).                        |
+-----------------------+-----------------------------------------------------+
| pip package           | To install the clients on a Linux, Mac OS X, or     |
|                       | Microsoft Windows system, use pip. It is easy to    |
|                       | use, ensures that you get the latest version of the |
|                       | clients from the                                    |
|                       | `Python Package Index <https://pypi.python.org/>`__,|
|                       | and lets you update or remove the packages later on.|
|                       |                                                     |
|                       | Since the installation process compiles source      |
|                       | files, this requires the related Python development |
|                       | package for your operating system and distribution. |
|                       |                                                     |
|                       | Install pip through the package manager for your    |
|                       | system:                                             |
|                       |                                                     |
|                       | **MacOS**                                           |
|                       |                                                     |
|                       | .. code-block:: console                             |
|                       |                                                     |
|                       |    # easy_install pip                               |
|                       |                                                     |
|                       | **Microsoft Windows**                               |
|                       |                                                     |
|                       | Ensure that the ``C:\Python27\Scripts`` directory is|
|                       | defined in the ``PATH`` environment variable, and   |
|                       | use the ``easy_install`` command from the setuptools|
|                       | package:                                            |
|                       |                                                     |
|                       | .. code-block:: console                             |
|                       |                                                     |
|                       |    C:\>easy_install pip                             |
|                       |                                                     |
|                       | Another option is to use the unofficial binary      |
|                       | installer provided by Christoph Gohlke              |
|                       | (http://www.lfd.uci.edu/~gohlke/pythonlibs/#pip).   |
|                       |                                                     |
|                       | **Ubuntu and Debian**                               |
|                       |                                                     |
|                       | .. code-block:: console                             |
|                       |                                                     |
|                       |    # apt-get install python-dev python-pip          |
|                       |                                                     |
|                       | Note that extra dependencies may be required, per   |
|                       | operating system, depending on the package being    |
|                       | installed, such as is the case with Tempest.        |
|                       |                                                     |
|                       | **Red Hat Enterprise Linux, CentOS, or Fedora.**    |
|                       |                                                     |
|                       | A packaged version enables you to use yum to install|
|                       | the package:                                        |
|                       |                                                     |
|                       | .. code-block:: console                             |
|                       |                                                     |
|                       |    # yum install python-devel python-pip            |
|                       |                                                     |
|                       | There are also packaged versions of the clients     |
|                       | available in `RDO <https://www.rdoproject.org/>`__  |
|                       | that enable yum to install the clients as described |
|                       | in Installing_from_packages_.                       |
|                       |                                                     |
|                       | **SUSE Linux Enterprise Server**                    |
|                       |                                                     |
|                       | A packaged version available in the Open Build      |
|                       | Service (`https://build.opensuse.org/package/show?  |
|                       | package=python-pip&project=Cloud:OpenStack:Master   |
|                       | <https://build.opensuse.org/package/show?package=pyt|
|                       | hon-pip&project=Cloud:OpenStack:Master>`__)         |
|                       | enables you to use YaST or zypper to install the    |
|                       | package.                                            |
|                       |                                                     |
|                       | First, add the Open Build Service repository:       |
|                       |                                                     |
|                       | .. code-block:: console                             |
|                       |                                                     |
|                       |    # zypper addrepo -f obs://Cloud:OpenStack: \     |
|                       |    Liberty/SLE_12 Liberty                           |
|                       |                                                     |
|                       | Then install pip and use it to manage client        |
|                       | installation:                                       |
|                       |                                                     |
|                       | .. code-block:: console                             |
|                       |                                                     |
|                       |    # zypper install python-devel python-pip         |
|                       |                                                     |
|                       | There are also packaged versions of the clients     |
|                       | available that enable zypper to install the clients |
|                       | as described in Installing_from_packages_.          |
|                       |                                                     |
|                       | **openSUSE**                                        |
|                       |                                                     |
|                       | You can install pip and use it to manage client     |
|                       | installation:                                       |
|                       |                                                     |
|                       | .. code-block:: console                             |
|                       |                                                     |
|                       |    # zypper install python-devel python-pip         |
|                       |                                                     |
|                       | There are also packaged versions of the clients     |
|                       | available that enable zypper to install the clients |
|                       | as described in Installing_from_packages_.          |
+-----------------------+-----------------------------------------------------+

Install the OpenStack client
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following example shows the command for installing the OpenStack client
with ``pip``, which supports multiple services.

.. code-block:: console

   # pip install python-openstackclient

The following clients, while valid, are de-emphasized in favor of a common
client. Instead of installing and learning all these clients, we recommend
installing and using the OpenStack client. You may need to install an
individual project's client because coverage is not yet sufficient in the
OpenStack client. If you need to install an individual client's project,
replace the ``<project>`` name in this ``pip install`` command using the
list below.

.. code-block:: console

    # pip install python-<project>client

*  ``barbican`` - Key Manager Service API

*  ``ceilometer`` - Telemetry API

*  ``cinder`` - Block Storage API and extensions

*  ``cloudkitty`` - Rating service API

*  ``designate`` - DNS service API

*  ``glance`` - Image service API

*  ``gnocchi`` - Telemetry API v3

*  ``heat`` - Orchestration API

*  ``magnum`` - Containers service API

*  ``manila`` - Shared file systems API

*  ``mistral`` - Workflow service API

*  ``monasca`` - Monitoring API

*  ``murano`` - Application catalog API

*  ``neutron`` - Networking API

*  ``nova`` - Compute API and extensions

*  ``sahara`` - Data Processing API

*  ``senlin`` - Clustering service API

*  ``swift`` - Object Storage API

*  ``trove`` - Database service API

*  ``tuskar`` - Deployment service API

*  ``openstack`` - Common OpenStack client supporting multiple services

The following CLIs are deprecated in favor of ``openstack``, the
Common OpenStack client supporting multiple services:

*  ``keystone`` - Identity service API and extensions

While you can install the ``keystone`` client for interacting with version 2.0
of the service's API, you should use the ``openstack`` client for all Identity
interactions.

Installing with pip
-------------------

Use pip to install the OpenStack clients on a Linux, Mac OS X, or
Microsoft Windows system. It is easy to use and ensures that you get the
latest version of the client from the `Python Package
Index <https://pypi.python.org/pypi>`__. Also, pip enables you to update
or remove a package.

Install each client separately by using the following command:

*  For Mac OS X or Linux:

   .. code-block:: console

      # pip install python-PROJECTclient

*  For Microsoft Windows:

   .. code-block:: console

      C:\>pip install python-PROJECTclient

.. _Installing_from_packages:

Installing from packages
------------------------

RDO, openSUSE, SUSE Linux Enterprise, Debian, and Ubuntu have client packages
that can be installed without ``pip``.

*  On Red Hat Enterprise Linux, CentOS, or Fedora, use ``yum`` to install
   the clients from the packaged versions available in
   `RDO <https://www.rdoproject.org/>`__:

   .. code-block:: console

      # yum install python-PROJECTclient

* For Ubuntu or Debian, use ``apt-get`` to install the clients from the
  packaged versions:

  .. code-block:: console

     # apt-get install python-PROJECTclient

*  For openSUSE, use ``zypper`` to install the clients from the distribution
   packages service:

   .. code-block:: console

      # zypper install python-PROJECTclient

*  For SUSE Linux Enterprise Server, use ``zypper`` to install the clients from
   the distribution packages in the Open Build Service. First, add the Open
   Build Service repository:

   .. code-block:: console

      # zypper addrepo -f obs://Cloud:OpenStack:Liberty/SLE_12 Liberty

   Then you can install the packages:

   .. code-block:: console

      # zypper install python-PROJECTclient

Upgrade or remove clients
~~~~~~~~~~~~~~~~~~~~~~~~~

To upgrade a client, add the `--upgrade` option to the
:command:`pip install` command:

.. code-block:: console

   # pip install --upgrade python-PROJECTclient

To remove the client, run the :command:`pip uninstall` command:

.. code-block:: console

   # pip uninstall python-PROJECTclient

What's next
~~~~~~~~~~~

Before you can run client commands, you must create and source the
``PROJECT-openrc.sh`` file to set environment variables. See
:doc:`../common/cli_set_environment_variables_using_openstack_rc`.
