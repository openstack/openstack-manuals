:orphan:

================
debconf concepts
================

This chapter explains how to use the Debian ``debconf`` and
``dbconfig-common`` packages to configure OpenStack services. These
packages enable users to perform configuration tasks. When users
install OpenStack packages, ``debconf`` prompts the user for responses,
which seed the contents of configuration files associated with that package.
After package installation, users can update the configuration of a
package by using the :command:`dpkg-reconfigure` program.

If you are familiar with these packages and pre-seeding, you can proceed
to :doc:`../keystone`.


The Debian packages
-------------------

The rules described here are from the `Debian Policy
Manual <http://www.debian.org/doc/debian-policy/>`__. If any rule
described in this chapter is not respected, you have found a serious bug
that must be fixed.

When you install or upgrade a Debian package, all configuration file
values are preserved. Using the ``debconf`` database as a registry is
considered a bug in Debian. If you edit something in any OpenStack
configuration file, the ``debconf`` package reads that value when it
prepares to prompt the user. For example, to change the log in name for
the RabbitMQ messaging queue for a service, you can edit its value in
the corresponding configuration file.

To opt out of using the ``debconf`` package, run the
:command:`dpkg-reconfigure` command and select non-interactive mode:

.. code-block:: console

   # dpkg-reconfigure -plow debconf

Then, ``debconf`` does not prompt you.

Another way to disable the ``debconf`` package is to prefix the
:command:`apt` command with ``DEBIAN_FRONTEND=noninteractive``,
as follows:

.. code-block:: console

   # DEBIAN_FRONTEND=noninteractive apt-get install nova-api

If you configure a package with ``debconf`` incorrectly, you can
re-configure it, as follows:

.. code-block:: console

   # dpkg-reconfigure PACKAGE-NAME


This calls the post-installation script for the ``PACKAGE-NAME`` package
after the user responds to all prompts. If you cannot install a Debian
package in a non-interactive way, you have found a release-critical bug
in Debian. Report it to the Debian bug tracking system.

Generally, the ``-common`` packages install the configuration files. For
example, the ``glance-common`` package installs the ``glance-api.conf``
and ``glance-registry.conf`` files. So, for the Image service, you must
re-configure the ``glance-common`` package. The same applies for
``cinder-common``, ``nova-common``, and ``heat-common`` packages.

In ``debconf``, the higher the priority for a screen, the greater the
chance that the user sees that screen. If a ``debconf`` screen has
``medium`` priority and you configure the Debian system to show only
``critical`` prompts, which is the default in Debian, the user does not
see that ``debconf`` screen. Instead, the default for the related package
is used. In the Debian OpenStack packages, a number of ``debconf`` screens
are set with ``medium`` priority. Consequently, if you want to respond to
all ``debconf`` screens from the Debian OpenStack packages, you must run
the following command and select the ``medium`` priority before you install
any packages:

.. code-block:: console

   # dpkg-reconfigure debconf

.. note::

   The packages do not require pre-depends. If ``dbconfig-common`` is
   already installed on the system, the user sees all prompts. However,
   you cannot define the order in which the ``debconf`` screens appear.
   The user must make sense of it even if the prompts appear in an
   illogical order.

|

Pre-seed debconf prompts
------------------------

You can pre-seed all ``debconf`` prompts. To pre-seed means to store
responses in the ``debconf`` database so that ``debconf`` does not prompt
the user for responses. Pre-seeding enables a hands-free installation for
users. The package maintainer creates scripts that automatically
configure the services.

The following example shows how to pre-seed an automated MySQL Server
installation:

.. code-block:: bash

    MYSQL_PASSWORD=MYSQL_PASSWORD
    echo "mysql-server-5.5 mysql-server/root_password password ${MYSQL_PASSWORD}
    mysql-server-5.5 mysql-server/root_password seen true
    mysql-server-5.5 mysql-server/root_password_again password ${MYSQL_PASSWORD}
    mysql-server-5.5 mysql-server/root_password_again seen true
    " | debconf-set-selections
    DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes mysql-server

The ``seen true`` option tells ``debconf`` that a specified screen was
already seen by the user so do not show it again. This option is useful
for upgrades.
