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
`official documentation <https://github.com/memcached/memcached/wiki#getting-started>`_.

Memory caching is managed by `oslo.cache
<http://specs.openstack.org/openstack/oslo-specs/specs/kilo/oslo-cache-using-dogpile.html>`_
so the way to use multiple memcached servers is the same for all projects.

Example configuration with three hosts:

.. code-block:: ini

  memcached_servers = controller1:11211,controller2:11211,controller3:11211

By default, ``controller1`` handles the caching service.
If the host goes down, ``controller2`` or ``controller3`` does the job.
For more information about memcached installation, see the
*Environment -> Memcached* section in the
`Installation Tutorials and Guides <http://docs.openstack.org/project-install-guide/newton>`_
depending on your distribution.
