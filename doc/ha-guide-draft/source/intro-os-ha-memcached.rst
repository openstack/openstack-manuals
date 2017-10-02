=========
Memcached
=========

Most OpenStack services can use Memcached to store ephemeral data such as
tokens. Although Memcached does not support typical forms of redundancy such
as clustering, OpenStack services can use almost any number of instances
by configuring multiple hostnames or IP addresses.

The Memcached client implements hashing to balance objects among the instances.
Failure of an instance only impacts a percentage of the objects,
and the client automatically removes it from the list of instances.

Installation
~~~~~~~~~~~~

To install and configure Memcached, read the
`official documentation <https://github.com/Memcached/Memcached/wiki#getting-started>`_.

Memory caching is managed by `oslo.cache
<http://specs.openstack.org/openstack/oslo-specs/specs/kilo/oslo-cache-using-dogpile.html>`_.
This ensures consistency across all projects when using multiple Memcached
servers. The following is an example configuration with three hosts:

.. code-block:: ini

  Memcached_servers = controller1:11211,controller2:11211,controller3:11211

By default, ``controller1`` handles the caching service. If the host goes down,
``controller2`` or ``controller3`` will complete the service.

For more information about Memcached installation, see the
*Environment -> Memcached* section in the
`Installation Guides <https://docs.openstack.org/ocata/install/>`_
depending on your distribution.
