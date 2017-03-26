===========================================================
Cloud Controller and Storage Proxy Failures and Maintenance
===========================================================

The cloud controller and storage proxy are very similar to each other
when it comes to expected and unexpected downtime. One of each server
type typically runs in the cloud, which makes them very noticeable when
they are not running.

For the cloud controller, the good news is if your cloud is using the
FlatDHCP multi-host HA network mode, existing instances and volumes
continue to operate while the cloud controller is offline. For the
storage proxy, however, no storage traffic is possible until it is back
up and running.

Planned Maintenance
~~~~~~~~~~~~~~~~~~~

One way to plan for cloud controller or storage proxy maintenance is to
simply do it off-hours, such as at 1 a.m. or 2 a.m. This strategy
affects fewer users. If your cloud controller or storage proxy is too
important to have unavailable at any point in time, you must look into
high-availability options.

Rebooting a Cloud Controller or Storage Proxy
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

All in all, just issue the :command:`reboot` command. The operating system
cleanly shuts down services and then automatically reboots. If you want
to be very thorough, run your backup jobs just before you
reboot.

After a cloud controller reboots, ensure that all required services were
successfully started. The following commands use :command:`ps` and
:command:`grep` to determine if nova, glance, and keystone are currently
running:

.. code-block:: console

   # ps aux | grep nova-
   # ps aux | grep glance-
   # ps aux | grep keystone
   # ps aux | grep cinder

Also check that all services are functioning. The following set of
commands sources the ``openrc`` file, then runs some basic glance, nova,
and openstack commands. If the commands work as expected, you can be
confident that those services are in working condition:

.. code-block:: console

   # . openrc
   # openstack image list
   # openstack server list
   # openstack project list

For the storage proxy, ensure that the :term:`Object Storage service <Object
Storage service (swift)>` has resumed:

.. code-block:: console

   # ps aux | grep swift

Also check that it is functioning:

.. code-block:: console

   # swift stat

Total Cloud Controller Failure
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The cloud controller could completely fail if, for example, its
motherboard goes bad. Users will immediately notice the loss of a cloud
controller since it provides core functionality to your cloud
environment. If your infrastructure monitoring does not alert you that
your cloud controller has failed, your users definitely will.
Unfortunately, this is a rough situation. The cloud controller is an
integral part of your cloud. If you have only one controller, you will
have many missing services if it goes down.

To avoid this situation, create a highly available cloud controller
cluster. This is outside the scope of this document, but you can read
more in the `OpenStack High Availability
Guide <https://docs.openstack.org/ha-guide/index.html>`_.

The next best approach is to use a configuration-management tool, such
as Puppet, to automatically build a cloud controller. This should not
take more than 15 minutes if you have a spare server available. After
the controller rebuilds, restore any backups taken
(see :doc:`ops-backup-recovery`).

Also, in practice, the ``nova-compute`` services on the compute nodes do
not always reconnect cleanly to rabbitmq hosted on the controller when
it comes back up after a long reboot; a restart on the nova services on
the compute nodes is required.
