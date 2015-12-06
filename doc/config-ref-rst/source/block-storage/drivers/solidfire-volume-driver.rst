=========
SolidFire
=========

The SolidFire Cluster is a high performance all SSD iSCSI storage device that
provides massive scale out capability and extreme fault tolerance.  A key
feature of the SolidFire cluster is the ability to set and modify during
operation specific QoS levels on a volume for volume basis. The SolidFire
cluster offers this along with de-duplication, compression, and an architecture
that takes full advantage of SSDs.

To configure the use of a SolidFire cluster with Block Storage, modify your
``cinder.conf`` file as follows:

.. code-block:: ini

    volume_driver = cinder.volume.drivers.solidfire.SolidFireDriver
    san_ip = 172.17.1.182         # the address of your MVIP
    san_login = sfadmin           # your cluster admin login
    san_password = sfpassword     # your cluster admin password
    sf_account_prefix = ''        # prefix for tenant account creation on solidfire cluster

.. warning::

    Older versions of the SolidFire driver (prior to Icehouse) created a unique
    account prefixed with ``$cinder-volume-service-hostname-$tenant-id`` on the
    SolidFire cluster for each tenant. Unfortunately, this account formation
    resulted in issues for High Availability (HA) installations and
    installations where the cinder-volume service can move to a new node. The
    current default implementation does not experience this issue as no prefix
    is used. For installations created on a prior release, the OLD default
    behavior can be configured by using the keyword "hostname" in
    sf_account_prefix.

.. include:: ../../tables/cinder-solidfire.rst
