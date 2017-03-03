==========================================
Install the OpenStack command-line clients
==========================================

Install the prerequisite software and the Python package for each
OpenStack client.

Install the prerequisite software
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Most Linux distributions include packaged versions of the command-line clients.
You can directly install the clients from the packages with prerequisites.
For more information, see Installing_from_packages_.

If you need to install the source package for the command-line package,
the following table lists the software needed to run the
command-line clients, and provides installation instructions as needed.

.. list-table:: OpenStack command-line clients prerequisites
   :header-rows: 1
   :widths: 20 80

   * - Prerequisite
     - Description
   * - Python 2.7 or later
     - Supports Python 2.7, 3.4, and 3.5.
   * - setuptools package
     - Installed by default on Mac OS X.

       Many Linux distributions provide packages to make setuptools
       easy to install. Search your package manager for setuptools to
       find an installation package.
       If you cannot find one, download the setuptools package
       directly from `Python Setuptools
       <https://pypi.python.org/pypi/setuptools>`_.

       The recommended way to install setuptools on Microsoft Windows
       is to follow the documentation provided on the `Python Setuptools
       <https://pypi.python.org/pypi/setuptools>`_ website.

       Another option is to use the `unofficial binary installer
       maintained by Christoph Gohlke
       <http://www.lfd.uci.edu/~gohlke/pythonlibs/#setuptools>`_.
   * - pip package
     - To install the clients on a Linux, Mac OS X, or Microsoft Windows
       system, use pip. It is easy to use, ensures that you get the latest
       version of the clients from the `Python Package Index
       <https://pypi.python.org/>`__, and lets you update or remove
       the packages later on.

       Since the installation process compiles source files, this requires
       the related Python development package for your operating system
       and distribution.

       Install pip through the package manager for your system:

       **MacOS**

       .. code-block:: console

          # easy_install pip

       **Microsoft Windows**

       Ensure that the ``C:\Python27\Scripts`` directory is defined in the
       ``PATH`` environment variable, and use the ``easy_install`` command
       from the setuptools package:

       .. code-block:: console

          C:\>easy_install pip

       Another option is to use the `unofficial binary installer provided by
       Christoph Gohlke <http://www.lfd.uci.edu/~gohlke/pythonlibs/#pip>`_.

       **Ubuntu or Debian**

       .. code-block:: console

          # apt install python-dev python-pip

       Note that extra dependencies may be required, per operating system,
       depending on the package being installed, such as is the case with
       Tempest.

       **Red Hat Enterprise Linux or CentOS**

       A packaged version enables you to use yum to install the package:

       .. code-block:: console

          # yum install python-devel python-pip

       On Red Hat Enterprise Linux, this command assumes that you have enabled
       the OpenStack repository. For more information, see the
       `Installation Tutorial for Red Hat Enterprise Linux and CentOS
       <https://docs.openstack.org/ocata/install-guide-rdo/environment-packages.html>`_.

       There are also packaged versions of the clients available that enable
       :command:`yum` to install the clients as described in
       Installing_from_packages_.

       **Fedora**

       A packaged version enables you to use :command:`dnf` to install the
       package:

       .. code-block:: console

          # dnf install python-devel python-pip

       **SUSE Linux Enterprise Server**

       A packaged version available in `the Open Build Service
       <https://build.opensuse.org/package/show?package=python-pip&project=Cloud:OpenStack:Master>`__
       enables you to use YaST or zypper to install the package.

       First, add the Open Build Service repository as described in the
       `Installation Tutorial
       <https://docs.openstack.org/ocata/install-guide-obs/environment-packages.html>`_.

       Then install pip and use it to manage client installation:

       .. code-block:: console

          # zypper install python-devel python-pip

       There are also packaged versions of the clients available that enable
       zypper to install the clients as described in Installing_from_packages_.

       **openSUSE**

       You can install pip and use it to manage client installation:

       .. code-block:: console

          # zypper install python-devel python-pip

       There are also packaged versions of the clients available that enable
       zypper to install the clients as described in Installing_from_packages_.

Install the OpenStack client
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following example shows the command for installing the OpenStack client
with ``pip``, which supports multiple services.

.. code-block:: console

   # pip install python-openstackclient

The following individual clients are deprecated in favor of a common client.
Instead of installing and learning all these clients, we recommend
installing and using the OpenStack client. You may need to install an
individual project's client because coverage is not yet sufficient in the
OpenStack client. If you need to install an individual client's project,
replace the ``PROJECT`` name in this ``pip install`` command using the
list below.

.. code-block:: console

    # pip install python-PROJECTclient

*  ``barbican`` - Key Manager Service API
*  ``ceilometer`` - Telemetry API
*  ``cinder`` - Block Storage API and extensions
*  ``cloudkitty`` - Rating service API
*  ``designate`` - DNS service API
*  ``fuel`` - Deployment service API
*  ``glance`` - Image service API
*  ``gnocchi`` - Telemetry API v3
*  ``heat`` - Orchestration API
*  ``magnum`` - Container Infrastructure Management service API
*  ``manila`` - Shared file systems API
*  ``mistral`` - Workflow service API
*  ``monasca`` - Monitoring API
*  ``murano`` - Application catalog API
*  ``neutron`` - Networking API
*  ``nova`` - Compute API and extensions
*  ``senlin`` - Clustering service API
*  ``swift`` - Object Storage API
*  ``trove`` - Database service API

.. _Installing_with_pip:

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
that can be installed without pip.

.. note::

   The packaged version might install older clients.
   If you want to make sure the latest clients are installed,
   you might need to :ref:`install the clients with pip <installing_with_pip>`.

*  On Red Hat Enterprise Linux or CentOS, use ``yum`` to install the clients
   from the packaged versions:

   .. code-block:: console

      # yum install python-PROJECTclient

   This command assumes that you have enabled the OpenStack repository for your
   distribution. For more information, see the
   `Installation Tutorial for Red Hat Enterprise Linux and CentOS
   <https://docs.openstack.org/ocata/install-guide-rdo/environment-packages.html>`_.

* For Ubuntu or Debian, use ``apt-get`` to install the clients from the
  packaged versions:

  .. code-block:: console

     # apt-get install python-PROJECTclient

*  For openSUSE, use ``zypper`` to install the clients from the distribution
   packages service:

   .. code-block:: console

      # zypper install python-PROJECTclient

*  For SUSE Linux Enterprise Server, use ``zypper`` to install the clients from
   the packaged versions:

   .. code-block:: console

      # zypper install python-PROJECTclient

   This command assumes that you have enabled the OpenStack repository for your
   distribution. For more information, see the
   `Installation Tutorial for openSUSE and SUSE Linux Enterprise
   <https://docs.openstack.org/ocata/install-guide-obs/environment-packages.html>`_.

Upgrade or remove clients
~~~~~~~~~~~~~~~~~~~~~~~~~

To upgrade a client with :command:`pip`, add the ``--upgrade`` option to the
:command:`pip install` command:

.. code-block:: console

   # pip install --upgrade python-PROJECTclient

To remove the client with pip, run the :command:`pip uninstall` command:

.. code-block:: console

   # pip uninstall python-PROJECTclient

What's next
~~~~~~~~~~~

Before you can run client commands, you must create and source the
``PROJECT-openrc.sh`` file to set environment variables. See
:doc:`../common/cli-set-environment-variables-using-openstack-rc`.
