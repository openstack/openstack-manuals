=========
Memcached
=========

Memcached is a general-purpose distributed memory caching system. It
is used to speed up dynamic database-driven websites by caching data
and objects in RAM to reduce the number of times an external data
source must be read.

Memcached is a memory cache demon that can be used by most OpenStack
services to store ephemeral data, such as tokens.

Access to Memcached is not handled by HAProxy because replicated
access is currently in an experimental state. Instead, OpenStack
services must be supplied with the full list of hosts running
Memcached.

The Memcached client implements hashing to balance objects among the
instances. Failure of an instance impacts only a percentage of the
objects and the client automatically removes it from the list of
instances. The SLA is several minutes.
