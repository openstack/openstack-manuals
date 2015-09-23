.. _shared_file_systems_troubleshoot:

========================================
Troubleshoot Shared File Systems service
========================================

Failures in share service during share creation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If new shares go into ``error`` state during creation, follow next steps:

1. Make sure, that share services are running into debug mode. If it is not
   true, you will not get any tips from logs how to fix your issue.

2. Find what a share service holds specified share. Do to that, run command
   :command:`manila show <share_id_or_name>` and find share host in the
   output. Host uniquely identifies share service holds broken share.

3. Look thought logs of this share service. Usually, it can be found at
   ``/etc/var/log/manila-share.log``. This log should contain kind of
   traceback with extra information to help you find origin of issues.

No valid host was found
~~~~~~~~~~~~~~~~~~~~~~~

You should manage share types very carefully. If share type contains invalid
extra spec scheduler will never find valid host for share of this type.
To diagnose this issue, make sure that scheduler service is running in
debug mode, try to create a new share and look for message ``Failed to
schedule create_share: No valid host was found.`` in
``/etc/var/log/manila-scheduler.log``.

To solve this issue look carefully through list of extra specs in share type
and list of share service reported capabilities and make sure that extra specs
are pointed in the right way.


Created share is unreachable
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

By default new share doesn't have any active access rules. So, to provide
access to new created share, you need to create appropriate access rule with
right value that defines access.

Service become unavailable after upgrade
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

After upgrading Shared File Systems service from version v1 to version v2.x,
please be attentive to update service endpoint in OpenStack Identity Service.
Use :command:`keystone service-list` to get service type related to Shared
File Systems service and then :command:`keystone service-list --service
<share-service-type>`. You will get endpoints expected from running
Shared File Systems service. Make sure that these endpoints are update.
If it is not true, you need delete outdated endpoints and create a new one.



Failures during management of internal resources
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Some drivers in Shared File Systems service can create service entities, like
servers and networks. If it is necessary to reach it you can login in
tenant ``service`` and get manual control over it.
