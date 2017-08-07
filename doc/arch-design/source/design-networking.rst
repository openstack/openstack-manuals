.. _network-design:

====================
Network architecture
====================

.. toctree::
   :maxdepth: 2

   design-networking/design-networking-concepts
   design-networking/design-networking-design
   design-networking/design-networking-services

OpenStack provides a rich networking environment. This chapter
details the requirements and options to consider when designing your
cloud. This includes examples of network implementations to
consider, information about some OpenStack network layouts and networking
services that are essential for stable operation.

.. warning::

   If this is the first time you are deploying a cloud infrastructure
   in your organization, your first conversations should be with your
   networking team. Network usage in a running cloud is vastly different
   from traditional network deployments and has the potential to be
   disruptive at both a connectivity and a policy level.

   For example, you must plan the number of IP addresses that you need for
   both your guest instances as well as management infrastructure.
   Additionally, you must research and discuss cloud network connectivity
   through proxy servers and firewalls.
