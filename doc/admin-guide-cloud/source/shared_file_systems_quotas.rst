.. _shared_file_systems_quotas:

=================
Quotas and limits
=================

Limits
~~~~~~

Limits are the resource limitations that are allowed for each tenant (project).
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
a rate limit can control the number of GET requests that can be processed
during a one-minute period.

To set the API rate limits, add configuration to the
``etc/manila/api-paste.ini`` file that is a part of the WSGI pipeline and
defines the actual limits. You need to restart ``manila-api`` service after
you edit the ``etc/manila/api-paste.ini`` file.

.. code-block:: ini

   [filter:ratelimit]
   paste.filter_factory = manila.api.v1.limits:RateLimitingMiddleware.factory
   limits = (POST, "*/shares", ^/shares, 120, MINUTE);(PUT, "*/shares", .*, 120, MINUTE);(DELETE, "*", .*, 120, MINUTE)

Also, add ``ratelimit`` to ``noauth``, ``keystone``, ``keystone_nolimit``
parameters in the ``[composite:openstack_share_api]`` group.

.. code-block:: ini

   [composite:openstack_share_api]
   noauth = faultwrap ssl ratelimit sizelimit noauth api
   keystone = faultwrap ssl ratelimit sizelimit authtoken keystonecontext api
   keystone_nolimit = faultwrap ssl ratelimit sizelimit authtoken keystonecontext api

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

Quota sets provide quotas management support.

To list the quotas for a tenant or user, use the :command:`manila quota-show`
command. If you specify the optional :option:`--user` parameter, you get the
quotas for this user in the specified tenant. If you omit this parameter,
you get the quotas for the specified project.

.. code-block:: console

   $ manila quota-show --tenant demo --user demo
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

   $ manila quota-defaults --tenant demo
   +--------------------+-------+
   | Property           | Value |
   +--------------------+-------+
   | gigabytes          | 1000  |
   | snapshot_gigabytes | 1000  |
   | snapshots          | 50    |
   | shares             | 50    |
   | share_networks     | 10    |
   +--------------------+-------+

The administrator can update the quotas for a specified tenant or for a
specified user by providing both the ``--tenant`` and ``--user`` optional
arguments. It is possible to update the ``snapshots``, ``gigabytes``,
``snapshot-gigabytes``, and ``share-networks`` quotas.

.. code-block:: console

   $ manila quota-update demo --user demo --shares 49 --snapshots 49

As administrator, you can also permit or deny the force-update of a quota that
is already used and the requested value exceeds the configured quota. To
force-update a quota, use ``force`` optional key.

.. code-block:: console

   $ manila quota-update demo --shares 51 --snapshots 51 --force

To revert quotas to default for a project or for a user, delete quotas:

.. code-block:: console

   $ manila quota-delete --tenant demo --user demo
