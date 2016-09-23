=========================================
What to do when things are running slowly
=========================================

When you are getting slow responses from various services, it can be
hard to know where to start looking. The first thing to check is the
extent of the slowness: is it specific to a single service, or varied
among different services? If your problem is isolated to a specific
service, it can temporarily be fixed by restarting the service, but that
is often only a fix for the symptom and not the actual problem.

This is a collection of ideas from experienced operators on common
things to look at that may be the cause of slowness. It is not, however,
designed to be an exhaustive list.

OpenStack Identity service
~~~~~~~~~~~~~~~~~~~~~~~~~~

If OpenStack :term:`Identity service <Identity service (keystone)>` is
responding slowly, it could be due to the token table getting large.
This can be fixed by running the :command:`keystone-manage token_flush`
command.

Additionally, for Identity-related issues, try the tips
in :ref:`sql_backend`.

OpenStack Image service
~~~~~~~~~~~~~~~~~~~~~~~

OpenStack :term:`Image service <Image service (glance)>` can be slowed down
by things related to the Identity service, but the Image service itself can be
slowed down if connectivity to the back-end storage in use is slow or otherwise
problematic. For example, your back-end NFS server might have gone down.

OpenStack Block Storage service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack :term:`Block Storage service <Block Storage service (cinder)>` is
similar to the Image service, so start by checking Identity-related services,
and the back-end storage.
Additionally, both the Block Storage and Image services rely on AMQP and
SQL functionality, so consider these when debugging.

OpenStack Compute service
~~~~~~~~~~~~~~~~~~~~~~~~~

Services related to OpenStack Compute are normally fairly fast and rely
on a couple of backend services: Identity for authentication and
authorization), and AMQP for interoperability. Any slowness related to
services is normally related to one of these. Also, as with all other
services, SQL is used extensively.

OpenStack Networking service
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Slowness in the OpenStack :term:`Networking service <Networking service
(neutron)>` can be caused by services that it relies upon, but it can
also be related to either physical or virtual networking. For example:
network namespaces that do not exist or are not tied to interfaces correctly;
DHCP daemons that have hung or are not running; a cable being physically
disconnected; a switch not being configured correctly. When debugging
Networking service problems, begin by verifying all physical networking
functionality (switch configuration, physical cabling, etc.). After the
physical networking is verified, check to be sure all of the Networking
services are running (neutron-server, neutron-dhcp-agent, etc.), then check
on AMQP and SQL back ends.

AMQP broker
~~~~~~~~~~~

Regardless of which AMQP broker you use, such as RabbitMQ, there are
common issues which not only slow down operations, but can also cause
real problems. Sometimes messages queued for services stay on the queues
and are not consumed. This can be due to dead or stagnant services and
can be commonly cleared up by either restarting the AMQP-related
services or the OpenStack service in question.

.. _sql_backend:

SQL back end
~~~~~~~~~~~~

Whether you use SQLite or an RDBMS (such as MySQL), SQL interoperability
is essential to a functioning OpenStack environment. A large or
fragmented SQLite file can cause slowness when using files as a back
end. A locked or long-running query can cause delays for most RDBMS
services. In this case, do not kill the query immediately, but look into
it to see if it is a problem with something that is hung, or something
that is just taking a long time to run and needs to finish on its own.
The administration of an RDBMS is outside the scope of this document,
but it should be noted that a properly functioning RDBMS is essential to
most OpenStack services.
