
=================
Install memcached
=================

[TODO:  Verify that Oslo supports hash synchronization;
if so, this should not take more than load balancing.]

[TODO: This hands off to two different docs for install information.
We should choose one or explain the specific purpose of each.]

Most OpenStack services can use memcached
to store ephemeral data such as tokens.
Although memcached does not support
typical forms of redundancy such as clustering,
OpenStack services can use almost any number of instances
by configuring multiple hostnames or IP addresses.
The memcached client implements hashing
to balance objects among the instances.
Failure of an instance only impacts a percentage of the objects
and the client automatically removes it from the list of instances.

To install and configure memcached, read the
`official documentation <https://code.google.com/p/memcached/wiki/NewStart>`_.

Memory caching is managed by `oslo.cache
<http://specs.openstack.org/openstack/oslo-specs/specs/kilo/oslo-cache-using-dogpile.html>`_
so the way to use multiple memcached servers is the same for all projects.

[TODO: Should this show three hosts?]

Example configuration with two hosts:

::

  memcached_servers = controller1:11211,controller2:11211

By default, `controller1` handles the caching service but,
if the host goes down, `controller2` does the job.
For more information about memcached installation,
see the `OpenStack Administrator Guide
<http://docs.openstack.org/admin-guide/>`_.
