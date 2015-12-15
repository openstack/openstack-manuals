.. _shared_file_systems_troubleshoot:

========================================
Troubleshoot Shared File Systems service
========================================

Failures in Share File Systems service during a share creation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If new shares go into ``error`` state during creation, follow next steps:

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

You should manage share types very carefully. If share type contains invalid
extra spec scheduler will never find a valid host for shares of this type.
To diagnose this issue, make sure that scheduler service is running in
debug mode, try to create a new share and look for message ``Failed to
schedule create_share: No valid host was found.`` in
``/etc/var/log/manila-scheduler.log``.

To solve this issue look carefully through the list of extra specs in the
share type and list of share services reported capabilities. Make sure
that extra specs are pointed in the right way.

Created share is unreachable
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

By default, a new share does not have any active access rules. To provide
access to new created share, you need to create appropriate access rule with
right value that defines access.

Service becomes unavailable after upgrade
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

After upgrading the Shared File Systems service from version v1 to version
v2.x, please be attentive to update the service endpoint in the OpenStack
Identity service. Use :command:`keystone service-list` to get service
type related to Shared File Systems service and then :command:`keystone
service-list --service <share-service-type>` command. You will get the
endpoints expected from running the Shared File Systems service. Make sure
that these endpoints are updated.
If it is not true, you need to delete the outdated endpoints and create
new ones.

Failures during management of internal resources
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Some drivers in the Shared File Systems service can create service entities,
like servers and networks. If it is necessary to reach it you can log in to
tenant ``service`` and get manual control over it.
