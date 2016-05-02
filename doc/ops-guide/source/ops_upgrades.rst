========
Upgrades
========

With the exception of Object Storage, upgrading from one version of
OpenStack to another can take a great deal of effort. This chapter
provides some guidance on the operational aspects that you should
consider for performing an upgrade for a basic architecture.

Pre-upgrade considerations
~~~~~~~~~~~~~~~~~~~~~~~~~~

Upgrade planning
----------------

-  Thoroughly review the `release
   notes <http://wiki.openstack.org/wiki/ReleaseNotes/>`_ to learn
   about new, updated, and deprecated features. Find incompatibilities
   between versions.

-  Consider the impact of an upgrade to users. The upgrade process
   interrupts management of your environment including the dashboard. If
   you properly prepare for the upgrade, existing instances, networking,
   and storage should continue to operate. However, instances might
   experience intermittent network interruptions.

-  Consider the approach to upgrading your environment. You can perform
   an upgrade with operational instances, but this is a dangerous
   approach. You might consider using live migration to temporarily
   relocate instances to other compute nodes while performing upgrades.
   However, you must ensure database consistency throughout the process;
   otherwise your environment might become unstable. Also, don't forget
   to provide sufficient notice to your users, including giving them
   plenty of time to perform their own backups.

-  Consider adopting structure and options from the service
   configuration files and merging them with existing configuration
   files. The `OpenStack Configuration
   Reference <http://docs.openstack.org/liberty/config-reference/content/>`_
   contains new, updated, and deprecated options for most services.

-  Like all major system upgrades, your upgrade could fail for one or
   more reasons. You should prepare for this situation by having the
   ability to roll back your environment to the previous release,
   including databases, configuration files, and packages. We provide an
   example process for rolling back your environment in
   :ref:`rolling_back_a_failed_upgrade`.

-  Develop an upgrade procedure and assess it thoroughly by using a test
   environment similar to your production environment.

Pre-upgrade testing environment
-------------------------------

The most important step is the pre-upgrade testing. If you are upgrading
immediately after release of a new version, undiscovered bugs might
hinder your progress. Some deployers prefer to wait until the first
point release is announced. However, if you have a significant
deployment, you might follow the development and testing of the release
to ensure that bugs for your use cases are fixed.

Each OpenStack cloud is different even if you have a near-identical
architecture as described in this guide. As a result, you must still
test upgrades between versions in your environment using an approximate
clone of your environment.

However, that is not to say that it needs to be the same size or use
identical hardware as the production environment. It is important to
consider the hardware and scale of the cloud that you are upgrading. The
following tips can help you minimise the cost:

Use your own cloud
    The simplest place to start testing the next version of OpenStack is
    by setting up a new environment inside your own cloud. This might
    seem odd, especially the double virtualization used in running
    compute nodes. But it is a sure way to very quickly test your
    configuration.

Use a public cloud
    Consider using a public cloud to test the scalability limits of your
    cloud controller configuration. Most public clouds bill by the hour,
    which means it can be inexpensive to perform even a test with many
    nodes.

Make another storage endpoint on the same system
    If you use an external storage plug-in or shared file system with
    your cloud, you can test whether it works by creating a second share
    or endpoint. This allows you to test the system before entrusting
    the new version on to your storage.

Watch the network
    Even at smaller-scale testing, look for excess network packets to
    determine whether something is going horribly wrong in
    inter-component communication.

To set up the test environment, you can use one of several methods:

-  Do a full manual install by using the `OpenStack Installation
   Guide <http://docs.openstack.org/index.html#install-guides>`_ for
   your platform. Review the final configuration files and installed
   packages.

-  Create a clone of your automated configuration infrastructure with
   changed package repository URLs.

   Alter the configuration until it works.

Either approach is valid. Use the approach that matches your experience.

An upgrade pre-testing system is excellent for getting the configuration
to work. However, it is important to note that the historical use of the
system and differences in user interaction can affect the success of
upgrades.

If possible, we highly recommend that you dump your production database
tables and test the upgrade in your development environment using this
data. Several MySQL bugs have been uncovered during database migrations
because of slight table differences between a fresh installation and
tables that migrated from one version to another. This will have impact
on large real datasets, which you do not want to encounter during a
production outage.

Artificial scale testing can go only so far. After your cloud is
upgraded, you must pay careful attention to the performance aspects of
your cloud.

Upgrade Levels
--------------

Upgrade levels are a feature added to OpenStack Compute since the
Grizzly release to provide version locking on the RPC (Message Queue)
communications between the various Compute services.

This functionality is an important piece of the puzzle when it comes to
live upgrades and is conceptually similar to the existing API versioning
that allows OpenStack services of different versions to communicate
without issue.

Without upgrade levels, an X+1 version Compute service can receive and
understand X version RPC messages, but it can only send out X+1 version
RPC messages. For example, if a nova-conductor process has been upgraded
to X+1 version, then the conductor service will be able to understand
messages from X version nova-compute processes, but those compute
services will not be able to understand messages sent by the conductor
service.

During an upgrade, operators can add configuration options to
``nova.conf`` which lock the version of RPC messages and allow live
upgrading of the services without interruption caused by version
mismatch. The configuration options allow the specification of RPC
version numbers if desired, but release name alias are also supported.
For example:

.. code-block:: ini

   [upgrade_levels]
   compute=X+1
   conductor=X+1
   scheduler=X+1

will keep the RPC version locked across the specified services to the
RPC version used in X+1. As all instances of a particular service are
upgraded to the newer version, the corresponding line can be removed
from ``nova.conf``.

Using this functionality, ideally one would lock the RPC version to the
OpenStack version being upgraded from on nova-compute nodes, to ensure
that, for example X+1 version nova-compute processes will continue to
work with X version nova-conductor processes while the upgrade
completes. Once the upgrade of nova-compute processes is complete, the
operator can move onto upgrading nova-conductor and remove the version
locking for nova-compute in ``nova.conf``.

General upgrade process
~~~~~~~~~~~~~~~~~~~~~~~

This section describes the process to upgrade a basic OpenStack
deployment based on the basic two-node architecture in the `OpenStack
Installation
Guide <http://docs.openstack.org/index.html#install-guides>`_. All
nodes must run a supported distribution of Linux with a recent kernel
and the current release packages.


Service specific upgrade instructions
-------------------------------------

* `Upgrading the Networking Service <http://docs.openstack.org/developer/neutron/devref/upgrade.html>`_

Prerequisites
-------------

-  Perform some cleaning of the environment prior to starting the
   upgrade process to ensure a consistent state. For example, instances
   not fully purged from the system after deletion might cause
   indeterminate behavior.

-  For environments using the OpenStack Networking service (neutron),
   verify the release version of the database. For example:

   .. code-block:: console

      # su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf \
        --config-file /etc/neutron/plugins/ml2/ml2_conf.ini current" neutron

Perform a backup
----------------

#. Save the configuration files on all nodes. For example:

   .. code-block:: console

      # for i in keystone glance nova neutron openstack-dashboard cinder heat ceilometer; \
        do mkdir $i-kilo; \
        done
      # for i in keystone glance nova neutron openstack-dashboard cinder heat ceilometer; \
        do cp -r /etc/$i/* $i-kilo/; \
        done

   .. note::

      You can modify this example script on each node to handle different
      services.

#. Make a full database backup of your production data. As of Kilo,
   database downgrades are not supported, and the only method available to
   get back to a prior database version will be to restore from backup.

   .. code-block:: console

      # mysqldump -u root -p --opt --add-drop-database --all-databases > icehouse-db-backup.sql

   .. note::

      Consider updating your SQL server configuration as described in the
      `OpenStack Installation
      Guide <http://docs.openstack.org/index.html#install-guides>`_.

Manage repositories
-------------------

On all nodes:

#. Remove the repository for the previous release packages.

#. Add the repository for the new release packages.

#. Update the repository database.

Upgrade packages on each node
-----------------------------

Depending on your specific configuration, upgrading all packages might
restart or break services supplemental to your OpenStack environment.
For example, if you use the TGT iSCSI framework for Block Storage
volumes and the upgrade includes new packages for it, the package
manager might restart the TGT iSCSI services and impact connectivity to
volumes.

If the package manager prompts you to update configuration files, reject
the changes. The package manager appends a suffix to newer versions of
configuration files. Consider reviewing and adopting content from these
files.

.. note::

   You may need to explicitly install the ``ipset`` package if your
   distribution does not install it as a dependency.

Update services
---------------

To update a service on each node, you generally modify one or more
configuration files, stop the service, synchronize the database schema,
and start the service. Some services require different steps. We
recommend verifying operation of each service before proceeding to the
next service.

The order you should upgrade services, and any changes from the general
upgrade process is described below:

**Controller node**

#.  OpenStack Identity - Clear any expired tokens before synchronizing
    the database.

#.  OpenStack Image service

#.  OpenStack Compute, including networking components.

#.  OpenStack Networking

#.  OpenStack Block Storage

#.  OpenStack dashboard - In typical environments, updating the
    dashboard only requires restarting the Apache HTTP service.

#.  OpenStack Orchestration

#.  OpenStack Telemetry - In typical environments, updating the
    Telemetry service only requires restarting the service.

#.  OpenStack Compute - Edit the configuration file and restart the
    service.

#. OpenStack Networking - Edit the configuration file and restart the
    service.

**Compute nodes**

-  OpenStack Block Storage - Updating the Block Storage service only
   requires restarting the service.

**Storage nodes**

-  OpenStack Networking - Edit the configuration file and restart the
   service.

Final steps
-----------

On all distributions, you must perform some final tasks to complete the
upgrade process.

#. Decrease DHCP timeouts by modifying ``/etc/nova/nova.conf`` on the
   compute nodes back to the original value for your environment.

#. Update all ``.ini`` files to match passwords and pipelines as required
   for the OpenStack release in your environment.

#. After migration, users see different results from
   :command:`nova image-list` and :command:`glance image-list`. To ensure
   users see the same images in the list
   commands, edit the ``/etc/glance/policy.json`` and
   ``/etc/nova/policy.json`` files to contain
   ``"context_is_admin": "role:admin"``, which limits access to private
   images for projects.

#. Verify proper operation of your environment. Then, notify your users
   that their cloud is operating normally again.

.. _rolling_back_a_failed_upgrade:

Rolling back a failed upgrade
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Upgrades involve complex operations and can fail. Before attempting any
upgrade, you should make a full database backup of your production data.
As of Kilo, database downgrades are not supported, and the only method
available to get back to a prior database version will be to restore
from backup.

This section provides guidance for rolling back to a previous release of
OpenStack. All distributions follow a similar procedure.

A common scenario is to take down production management services in
preparation for an upgrade, completed part of the upgrade process, and
discovered one or more problems not encountered during testing. As a
consequence, you must roll back your environment to the original "known
good" state. You also made sure that you did not make any state changes
after attempting the upgrade process; no new instances, networks,
storage volumes, and so on. Any of these new resources will be in a
frozen state after the databases are restored from backup.

Within this scope, you must complete these steps to successfully roll
back your environment:

#. Roll back configuration files.

#. Restore databases from backup.

#. Roll back packages.

You should verify that you have the requisite backups to restore.
Rolling back upgrades is a tricky process because distributions tend to
put much more effort into testing upgrades than downgrades. Broken
downgrades take significantly more effort to troubleshoot and, resolve
than broken upgrades. Only you can weigh the risks of trying to push a
failed upgrade forward versus rolling it back. Generally, consider
rolling back as the very last option.

The following steps described for Ubuntu have worked on at least one
production environment, but they might not work for all environments.

**To perform the rollback**

#. Stop all OpenStack services.

#. Copy contents of configuration backup directories that you created
   during the upgrade process back to ``/etc/<service>`` directory.

#. Restore databases from the ``RELEASE_NAME-db-backup.sql`` backup file
   that you created with the :command:`mysqldump` command during the upgrade
   process:

   .. code-block:: console

      # mysql -u root -p < RELEASE_NAME-db-backup.sql

#. Downgrade OpenStack packages.

   .. warning::

      Downgrading packages is by far the most complicated step; it is
      highly dependent on the distribution and the overall administration
      of the system.

   #. Determine which OpenStack packages are installed on your system. Use the
      :command:`dpkg --get-selections` command. Filter for OpenStack
      packages, filter again to omit packages explicitly marked in the
      ``deinstall`` state, and save the final output to a file. For example,
      the following command covers a controller node with keystone, glance,
      nova, neutron, and cinder:

      .. code-block:: console

         # dpkg --get-selections | grep -e keystone -e glance -e nova -e neutron \
         -e cinder | grep -v deinstall | tee openstack-selections
         cinder-api                                      install
         cinder-common                                   install
         cinder-scheduler                                install
         cinder-volume                                   install
         glance                                          install
         glance-api                                      install
         glance-common                                   install
         glance-registry                                 install
         neutron-common                                  install
         neutron-dhcp-agent                              install
         neutron-l3-agent                                install
         neutron-lbaas-agent                             install
         neutron-metadata-agent                          install
         neutron-plugin-openvswitch                      install
         neutron-plugin-openvswitch-agent                install
         neutron-server                                  install
         nova-api                                        install
         nova-cert                                       install
         nova-common                                     install
         nova-conductor                                  install
         nova-consoleauth                                install
         nova-novncproxy                                 install
         nova-objectstore                                install
         nova-scheduler                                  install
         python-cinder                                   install
         python-cinderclient                             install
         python-glance                                   install
         python-glanceclient                             install
         python-keystone                                 install
         python-keystoneclient                           install
         python-neutron                                  install
         python-neutronclient                            install
         python-nova                                     install
         python-novaclient                               install

      .. note::

         Depending on the type of server, the contents and order of your
         package list might vary from this example.

   #. You can determine the package versions available for reversion by using
      the ``apt-cache policy`` command. If you removed the Grizzly
      repositories, you must first reinstall them and run ``apt-get update``:

      .. code-block:: console

         # apt-cache policy nova-common
         nova-common:
         Installed: 1:2013.2-0ubuntu1~cloud0
         Candidate: 1:2013.2-0ubuntu1~cloud0
         Version table:
         *** 1:2013.2-0ubuntu1~cloud0 0
               500 http://ubuntu-cloud.archive.canonical.com/ubuntu/
                   precise-updates/havana/main amd64 Packages
               100 /var/lib/dpkg/status
             1:2013.1.4-0ubuntu1~cloud0 0
               500 http://ubuntu-cloud.archive.canonical.com/ubuntu/
                   precise-updates/grizzly/main amd64 Packages
            2012.1.3+stable-20130423-e52e6912-0ubuntu1.2 0
               500 http://us.archive.ubuntu.com/ubuntu/
                   precise-updates/main amd64 Packages
               500 http://security.ubuntu.com/ubuntu/
                   precise-security/main amd64 Packages
            2012.1-0ubuntu2 0
               500 http://us.archive.ubuntu.com/ubuntu/
                   precise/main amd64 Packages

      This tells us the currently installed version of the package, newest
      candidate version, and all versions along with the repository that
      contains each version. Look for the appropriate Grizzly
      version— ``1:2013.1.4-0ubuntu1~cloud0`` in this case. The process of
      manually picking through this list of packages is rather tedious and
      prone to errors. You should consider using the following script to help
      with this process:

      .. code-block:: console

         # for i in `cut -f 1 openstack-selections | sed 's/neutron/quantum/;'`;
           do echo -n $i ;apt-cache policy $i | grep -B 1 grizzly |
           grep -v Packages | awk '{print "="$1}';done | tr '\n' ' ' |
           tee openstack-grizzly-versions
         cinder-api=1:2013.1.4-0ubuntu1~cloud0
         cinder-common=1:2013.1.4-0ubuntu1~cloud0
         cinder-scheduler=1:2013.1.4-0ubuntu1~cloud0
         cinder-volume=1:2013.1.4-0ubuntu1~cloud0
         glance=1:2013.1.4-0ubuntu1~cloud0
         glance-api=1:2013.1.4-0ubuntu1~cloud0
         glance-common=1:2013.1.4-0ubuntu1~cloud0
         glance-registry=1:2013.1.4-0ubuntu1~cloud0
         quantum-common=1:2013.1.4-0ubuntu1~cloud0
         quantum-dhcp-agent=1:2013.1.4-0ubuntu1~cloud0
         quantum-l3-agent=1:2013.1.4-0ubuntu1~cloud0
         quantum-lbaas-agent=1:2013.1.4-0ubuntu1~cloud0
         quantum-metadata-agent=1:2013.1.4-0ubuntu1~cloud0
         quantum-plugin-openvswitch=1:2013.1.4-0ubuntu1~cloud0
         quantum-plugin-openvswitch-agent=1:2013.1.4-0ubuntu1~cloud0
         quantum-server=1:2013.1.4-0ubuntu1~cloud0
         nova-api=1:2013.1.4-0ubuntu1~cloud0
         nova-cert=1:2013.1.4-0ubuntu1~cloud0
         nova-common=1:2013.1.4-0ubuntu1~cloud0
         nova-conductor=1:2013.1.4-0ubuntu1~cloud0
         nova-consoleauth=1:2013.1.4-0ubuntu1~cloud0
         nova-novncproxy=1:2013.1.4-0ubuntu1~cloud0
         nova-objectstore=1:2013.1.4-0ubuntu1~cloud0
         nova-scheduler=1:2013.1.4-0ubuntu1~cloud0
         python-cinder=1:2013.1.4-0ubuntu1~cloud0
         python-cinderclient=1:1.0.3-0ubuntu1~cloud0
         python-glance=1:2013.1.4-0ubuntu1~cloud0
         python-glanceclient=1:0.9.0-0ubuntu1.2~cloud0
         python-quantum=1:2013.1.4-0ubuntu1~cloud0
         python-quantumclient=1:2.2.0-0ubuntu1~cloud0
         python-nova=1:2013.1.4-0ubuntu1~cloud0
         python-novaclient=1:2.13.0-0ubuntu1~cloud0

      .. note::

         If you decide to continue this step manually, don't forget to change
         ``neutron`` to ``quantum`` where applicable.

   #. Use the :command:`apt-get install` command to install specific versions of each
      package by specifying ``<package-name>=<version>``. The script in the
      previous step conveniently created a list of ``package=version`` pairs
      for you:

      .. code-block:: console

         # apt-get install `cat openstack-grizzly-versions`

      This step completes the rollback procedure. You should remove the
      upgrade release repository and run :command:`apt-get update` to prevent
      accidental upgrades until you solve whatever issue caused you to roll
      back your environment.
