.. _shared_file_systems_quotas:

=================
Quotas and limits
=================

Limits
------

Limits are the resource limitations that are allowed for each tenant (project).
An administrator can configure limits in the :file:`/etc/manila/manila.conf`
file.

Users can query their rate and absolute limits.
The absolute limits contain information about:

- Total maximum share memory, in GBs.

- Total maximum snapshot memory, in GBs.

- Number of share-networks.

- Number of share-snapshots.

- Number of shares.

- Shares and total used memory, in GBs.

To see the absolute limits, run:

.. code:: console

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

To see the rate limits, run:

.. code:: console

 $ manila rate-limits

Quotas
------

Quota sets provide quotas management support.

To list the quotas for a tenant or user, use **manila quota-show** command.
If you specify the optional ``--user`` parameter, you get the quotas for this
user in the specified tenant. If you omit this parameter, you get the quotas
for the specified project.

.. code:: console

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

There are default quotas for a project that are set from
:file:`/etc/manila/manila.conf` file. To list default quotas for a project, use
**manila quota-defaults** command:

.. code:: console

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

Administrator can update the quotas for a specified tenant or for a specified
user by providing both ``--tenant`` and ``--user`` optional arguments.
It is possible to update ``snapshots``, ``gigabytes``, ``snapshot-gigabytes``,
and ``share-networks`` quotas.

.. code:: console

 $ manila quota-update demo --user demo --shares 49 --snapshots 49

As administrator, you can also permit or deny the force-update of a quota that
is already used and the requested value exceeds the configured quota. To
force-update a quota, use ``force`` optional key.

.. code:: console

 $ manila quota-update demo --shares 51 --snapshots 51 --force

To revert quotas to default for a project or for a user, delete quotas:

.. code:: console

 $ manila quota-delete --tenant demo --user demo

It is possible to set quotas for a quota class and then check that the quotas
were updated:

.. code:: console

 $ manila quota-class-update my_custom_class --shares 49 --snapshot_gigabytes 999

 $ manila quota-class-show my_custom_class
 +--------------------+-------+
 | Property           | Value |
 +--------------------+-------+
 | gigabytes          | 1000  |
 | snapshot_gigabytes | 999   |
 | snapshots          | 50    |
 | shares             | 49    |
 | share_networks     | 10    |
 +--------------------+-------+
