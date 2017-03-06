=================
Specialized cases
=================

.. toctree::
   :maxdepth: 2

   specialized-multi-hypervisor.rst
   specialized-networking.rst
   specialized-software-defined-networking.rst
   specialized-desktop-as-a-service.rst
   specialized-openstack-on-openstack.rst
   specialized-hardware.rst

Although most OpenStack architecture designs fall into one
of the seven major scenarios outlined in other sections
(compute focused, network focused, storage focused, general
purpose, multi-site, hybrid cloud, and massively scalable),
there are a few use cases that do not fit into these categories.
This section discusses these specialized cases and provide some
additional details and design considerations for each use case:

* :doc:`Specialized networking <specialized-networking>`:
  describes running networking-oriented software that may involve reading
  packets directly from the wire or participating in routing protocols.
* :doc:`Software-defined networking (SDN)
  <specialized-software-defined-networking>`:
  describes both running an SDN controller from within OpenStack
  as well as participating in a software-defined network.
* :doc:`Desktop-as-a-Service <specialized-desktop-as-a-service>`:
  describes running a virtualized desktop environment in a cloud
  (:term:`Desktop-as-a-Service`).
  This applies to private and public clouds.
* :doc:`OpenStack on OpenStack <specialized-openstack-on-openstack>`:
  describes building a multi-tiered cloud by running OpenStack
  on top of an OpenStack installation.
* :doc:`Specialized hardware <specialized-hardware>`:
  describes the use of specialized hardware devices from within
  the OpenStack environment.
