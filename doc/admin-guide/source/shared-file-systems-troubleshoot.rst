.. _shared_file_systems_troubleshoot:

========================================
Troubleshoot Shared File Systems service
========================================

Failures in Share File Systems service during a share creation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Problem
-------

New shares can enter ``error`` state during the creation process.

Solution
--------

#. Make sure, that share services are running in debug mode. If the debug mode
   is not set, you will not get any tips from logs how to fix your issue.

#. Find what share service holds a specified share. To do that, run command
   :command:`manila show <share_id_or_name>` and find a share host in the
   output. Host uniquely identifies what share service holds the broken share.

#. Look thought logs of this share service. Usually, it can be found at
   ``/etc/var/log/manila-share.log``. This log should contain kind of
   traceback with extra information to help you to find the origin of issues.

No valid host was found
~~~~~~~~~~~~~~~~~~~~~~~

Problem
-------

If a share type contains invalid extra specs, the scheduler will not be
able to locate a valid host for the shares.

Solution
--------

To diagnose this issue, make sure that scheduler service is running in
debug mode. Try to create a new share and look for message ``Failed to
schedule create_share: No valid host was found.`` in
``/etc/var/log/manila-scheduler.log``.

To solve this issue look carefully through the list of extra specs in
the share type, and the list of share services reported capabilities.
Make sure that extra specs are pointed in the right way.

Created share is unreachable
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Problem
-------

By default, a new share does not have any active access rules.

Solution
--------

To provide access to new share, you need to create
appropriate access rule with the right value.
The value must defines access.

Service becomes unavailable after upgrade
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Problem
-------

After upgrading the Shared File Systems service from version v1 to version
v2.x, you must update the service endpoint in the OpenStack Identity service.
Otherwise, the service may become unavailable.

Solution
--------

#. To get the service type related to the Shared File Systems service, run:

   .. code-block:: console

     # openstack endpoint list

     # openstack endpoint show <share-service-type>

   You will get the endpoints expected from running the Shared File Systems
   service.

#. Make sure that these endpoints are updated. Otherwise, delete the outdated
   endpoints and create new ones.

Failures during management of internal resources
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Problem
-------

The Shared File System service manages internal resources effectively.
Administrators may need to manually adjust internal resources to
handle failures.

Solution
--------

Some drivers in the Shared File Systems service can create service entities,
like servers and networks. If it is necessary, you can log in to
project ``service`` and take manual control over it.
