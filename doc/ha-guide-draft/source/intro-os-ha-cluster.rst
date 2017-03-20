================
Cluster managers
================

At its core, a cluster is a distributed finite state machine capable
of co-ordinating the startup and recovery of inter-related services
across a set of machines.

Even a distributed or replicated application that is able to survive failures
on one or more machines can benefit from a cluster manager because a cluster
manager has the following capabilities:

#. Awareness of other applications in the stack

   While SYS-V init replacements like systemd can provide
   deterministic recovery of a complex stack of services, the
   recovery is limited to one machine and lacks the context of what
   is happening on other machines. This context is crucial to
   determine the difference between a local failure, and clean startup
   and recovery after a total site failure.

#. Awareness of instances on other machines

   Services like RabbitMQ and Galera have complicated boot-up
   sequences that require co-ordination, and often serialization, of
   startup operations across all machines in the cluster. This is
   especially true after a site-wide failure or shutdown where you must
   first determine the last machine to be active.

#. A shared implementation and calculation of `quorum
   <https://en.wikipedia.org/wiki/Quorum_(Distributed_Systems)>`_

   It is very important that all members of the system share the same
   view of who their peers are and whether or not they are in the
   majority. Failure to do this leads very quickly to an internal
   `split-brain <https://en.wikipedia.org/wiki/Split-brain_(computing)>`_
   state. This is where different parts of the system are pulling in
   different and incompatible directions.

#. Data integrity through fencing (a non-responsive process does not
   imply it is not doing anything)

   A single application does not have sufficient context to know the
   difference between failure of a machine and failure of the
   application on a machine. The usual practice is to assume the
   machine is dead and continue working, however this is highly risky. A
   rogue process or machine could still be responding to requests and
   generally causing havoc. The safer approach is to make use of
   remotely accessible power switches and/or network switches and SAN
   controllers to fence (isolate) the machine before continuing.

#. Automated recovery of failed instances

   While the application can still run after the failure of several
   instances, it may not have sufficient capacity to serve the
   required volume of requests. A cluster can automatically recover
   failed instances to prevent additional load induced failures.

Pacemaker
~~~~~~~~~
.. to do: description and point to ref arch example using pacemaker

`Pacemaker <http://clusterlabs.org>`_.

Systemd
~~~~~~~
.. to do: description and point to ref arch example using Systemd and link
