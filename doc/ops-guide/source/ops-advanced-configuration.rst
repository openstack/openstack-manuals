======================
Advanced Configuration
======================

OpenStack is intended to work well across a variety of installation
flavors, from very small private clouds to large public clouds. To
achieve this, the developers add configuration options to their code
that allow the behavior of the various components to be tweaked
depending on your needs. Unfortunately, it is not possible to cover all
possible deployments with the default configuration values.

At the time of writing, OpenStack has more than 3,000 configuration
options. You can see them documented at the
`OpenStack Configuration Reference
<https://docs.openstack.org/ocata/config-reference/config-overview.html>`_.
This chapter cannot hope to document all of these, but we do try to
introduce the important concepts so that you know where to go digging
for more information.

Differences Between Various Drivers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Many OpenStack projects implement a driver layer, and each of these
drivers will implement its own configuration options. For example, in
OpenStack Compute (nova), there are various hypervisor drivers
implemented—libvirt, xenserver, hyper-v, and vmware, for example. Not
all of these hypervisor drivers have the same features, and each has
different tuning requirements.

.. note::

   The currently implemented hypervisors are listed on the `OpenStack
   Configuration Reference
   <https://docs.openstack.org/ocata/config-reference/compute/hypervisors.html>`__.
   You can see a matrix of the various features in OpenStack Compute
   (nova) hypervisor drivers at the `Hypervisor support matrix
   page <https://docs.openstack.org/developer/nova/support-matrix.html>`_.

The point we are trying to make here is that just because an option
exists doesn't mean that option is relevant to your driver choices.
Normally, the documentation notes which drivers the configuration
applies to.

Implementing Periodic Tasks
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Another common concept across various OpenStack projects is that of
periodic tasks. Periodic tasks are much like cron jobs on traditional
Unix systems, but they are run inside an OpenStack process. For example,
when OpenStack Compute (nova) needs to work out what images it can
remove from its local cache, it runs a periodic task to do this.

Periodic tasks are important to understand because of limitations in the
threading model that OpenStack uses. OpenStack uses cooperative
threading in Python, which means that if something long and complicated
is running, it will block other tasks inside that process from running
unless it voluntarily yields execution to another cooperative thread.

A tangible example of this is the ``nova-compute`` process. In order to
manage the image cache with libvirt, ``nova-compute`` has a periodic
process that scans the contents of the image cache. Part of this scan is
calculating a checksum for each of the images and making sure that
checksum matches what ``nova-compute`` expects it to be. However, images
can be very large, and these checksums can take a long time to generate.
At one point, before it was reported as a bug and fixed,
``nova-compute`` would block on this task and stop responding to RPC
requests. This was visible to users as failure of operations such as
spawning or deleting instances.

The take away from this is if you observe an OpenStack process that
appears to "stop" for a while and then continue to process normally, you
should check that periodic tasks aren't the problem. One way to do this
is to disable the periodic tasks by setting their interval to zero.
Additionally, you can configure how often these periodic tasks run—in
some cases, it might make sense to run them at a different frequency
from the default.

The frequency is defined separately for each periodic task. Therefore,
to disable every periodic task in OpenStack Compute (nova), you would
need to set a number of configuration options to zero. The current list
of configuration options you would need to set to zero are:

* ``bandwidth_poll_interval``
* ``sync_power_state_interval``
* ``heal_instance_info_cache_interval``
* ``host_state_interval``
* ``image_cache_manager_interval``
* ``reclaim_instance_interval``
* ``volume_usage_poll_interval``
* ``shelved_poll_interval``
* ``shelved_offload_time``
* ``instance_delete_interval``

To set a configuration option to zero, include a line such as
``image_cache_manager_interval=0`` in your ``nova.conf`` file.

This list will change between releases, so please refer to your
configuration guide for up-to-date information.

Specific Configuration Topics
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This section covers specific examples of configuration options you might
consider tuning. It is by no means an exhaustive list.

Security Configuration for Compute, Networking, and Storage
-----------------------------------------------------------

The `OpenStack Security Guide <https://docs.openstack.org/sec/>`_
provides a deep dive into securing an OpenStack cloud, including
SSL/TLS, key management, PKI and certificate management, data transport
and privacy concerns, and compliance.

High Availability
-----------------

The `OpenStack High Availability
Guide <https://docs.openstack.org/ha-guide/index.html>`_ offers
suggestions for elimination of a single point of failure that could
cause system downtime. While it is not a completely prescriptive
document, it offers methods and techniques for avoiding downtime and
data loss.

Enabling IPv6 Support
---------------------

You can follow the progress being made on IPV6 support by watching the
`neutron IPv6 Subteam at
work <https://wiki.openstack.org/wiki/Meetings/Neutron-IPv6-Subteam>`_.

By modifying your configuration setup, you can set up IPv6 when using
``nova-network`` for networking, and a tested setup is documented for
FlatDHCP and a multi-host configuration. The key is to make
``nova-network`` think a ``radvd`` command ran successfully. The entire
configuration is detailed in a Cybera blog post, `“An IPv6 enabled
cloud” <http://www.cybera.ca/news-and-events/tech-radar/an-ipv6-enabled-cloud/>`_.

Geographical Considerations for Object Storage
----------------------------------------------

Support for global clustering of object storage servers is available for
all supported releases. You would implement these global clusters to
ensure replication across geographic areas in case of a natural disaster
and also to ensure that users can write or access their objects more
quickly based on the closest data center. You configure a default region
with one zone for each cluster, but be sure your network (WAN) can
handle the additional request and response load between zones as you add
more zones and build a ring that handles more zones. Refer to
`Geographically Distributed Clusters
<https://docs.openstack.org/developer/swift/admin_guide.html#geographically-distributed-clusters>`_
in the documentation for additional information.
