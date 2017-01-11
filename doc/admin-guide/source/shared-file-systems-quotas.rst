.. _shared_file_systems_quotas:

=================
Quotas and limits
=================

Limits
~~~~~~

Limits are the resource limitations that are allowed for each project.
An administrator can configure limits in the ``manila.conf`` file.

Users can query their rate and absolute limits.

To see the absolute limits, run:

.. code-block:: console

   $ manila absolute-limits
   +----------------------------+-------+
   | Name                       | Value |
   +----------------------------+-------+
   | maxTotalShareGigabytes     | 1000  |
   | maxTotalShareNetworks      | 10    |
   | maxTotalShareSnapshots     | 50    |
   | maxTotalShares             | 50    |
   | maxTotalSnapshotGigabytes  | 1000  |
   | totalShareGigabytesUsed    | 1     |
   | totalShareNetworksUsed     | 2     |
   | totalShareSnapshotsUsed    | 1     |
   | totalSharesUsed            | 1     |
   | totalSnapshotGigabytesUsed | 1     |
   +----------------------------+-------+

Rate limits control the frequency at which users can issue specific API
requests. Administrators use rate limiting to configure limits on the type and
number of API calls that can be made in a specific time interval. For example,
a rate limit can control the number of ``GET`` requests processed
during a one-minute period.

To set the API rate limits, modify the
``etc/manila/api-paste.ini`` file, which is a part of the WSGI pipeline and
defines the actual limits. You need to restart ``manila-api`` service after
you edit the ``etc/manila/api-paste.ini`` file.

.. code-block:: ini

   [filter:ratelimit]
   paste.filter_factory = manila.api.v1.limits:RateLimitingMiddleware.factory
   limits = (POST, "*/shares", ^/shares, 120, MINUTE);(PUT, "*/shares", .*, 120, MINUTE);(DELETE, "*", .*, 120, MINUTE)

Also, add the ``ratelimit`` to ``noauth``, ``keystone``, ``keystone_nolimit``
parameters in the ``[composite:openstack_share_api]`` and
``[composite:openstack_share_api_v2]`` groups.

.. code-block:: ini

   [composite:openstack_share_api]
   use = call:manila.api.middleware.auth:pipeline_factory
   noauth = cors faultwrap ssl ratelimit sizelimit noauth api
   keystone = cors faultwrap ssl ratelimit sizelimit authtoken keystonecontext api
   keystone_nolimit = cors faultwrap ssl ratelimit sizelimit authtoken keystonecontext api

   [composite:openstack_share_api_v2]
   use = call:manila.api.middleware.auth:pipeline_factory
   noauth = cors faultwrap ssl ratelimit sizelimit noauth apiv2
   keystone = cors faultwrap ssl ratelimit sizelimit authtoken keystonecontext apiv2
   keystone_nolimit = cors faultwrap ssl ratelimit sizelimit authtoken keystonecontext apiv2

To see the rate limits, run:

.. code-block:: console

   $ manila rate-limits
   +--------+------------+-------+--------+--------+----------------------+
   | Verb   | URI        | Value | Remain | Unit   | Next_Available       |
   +--------+------------+-------+--------+--------+----------------------+
   | DELETE | "*"        | 120   | 120    | MINUTE | 2015-10-20T15:17:20Z |
   | POST   | "*/shares" | 120   | 120    | MINUTE | 2015-10-20T15:17:20Z |
   | PUT    | "*/shares" | 120   | 120    | MINUTE | 2015-10-20T15:17:20Z |
   +--------+------------+-------+--------+--------+----------------------+

Quotas
~~~~~~

Quota sets provide quota management support.

To list the quotas for a project or user, use the :command:`manila quota-show`
command. If you specify the optional ``--user`` parameter, you get the
quotas for this user in the specified project. If you omit this parameter,
you get the quotas for the specified project.

.. note::

   The Shared File Systems service does not perform mapping of usernames and
   project names to IDs. Provide only ID values to get correct setup
   of quotas. Setting it by names you set quota for nonexistent project/user.
   In case quota is not set explicitly by project/user ID,
   The Shared File Systems service just applies default quotas.

.. code-block:: console

   $ manila quota-show --tenant %project_id% --user %user_id%
   +--------------------+-------+
   | Property           | Value |
   +--------------------+-------+
   | gigabytes          | 1000  |
   | snapshot_gigabytes | 1000  |
   | snapshots          | 50    |
   | shares             | 50    |
   | share_networks     | 10    |
   +--------------------+-------+

There are default quotas for a project that are set from the
``manila.conf`` file. To list the default quotas for a project, use
the :command:`manila quota-defaults` command:

.. code-block:: console

   $ manila quota-defaults --tenant %project_id%
   +--------------------+-------+
   | Property           | Value |
   +--------------------+-------+
   | gigabytes          | 1000  |
   | snapshot_gigabytes | 1000  |
   | snapshots          | 50    |
   | shares             | 50    |
   | share_networks     | 10    |
   +--------------------+-------+

The administrator can update the quotas for a specific project, or for a
specific user by providing both the ``--tenant`` and ``--user`` optional
arguments. It is possible to update the ``shares``, ``snapshots``,
``gigabytes``, ``snapshot-gigabytes``, and ``share-networks`` quotas.

.. code-block:: console

   $ manila quota-update %project_id% --user %user_id% --shares 49 --snapshots 49

As administrator, you can also permit or deny the force-update of a quota that
is already used, or if the requested value exceeds the configured quota limit.
To force-update a quota, use ``force`` optional key.

.. code-block:: console

   $ manila quota-update %project_id% --shares 51 --snapshots 51 --force

To revert quotas to default for a project or for a user, delete quotas:

.. code-block:: console

   $ manila quota-delete --tenant %project_id% --user %user_id%
