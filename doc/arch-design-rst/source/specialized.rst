=================
Specialized cases
=================

.. toctree::
   :maxdepth: 2

   specialized/multi-hypervisor-specialized.rst
   specialized/networking-specialized.rst
   specialized/software-defined-networking-specialized.rst
   specialized/desktop-as-a-service-specialized.rst
   specialized/openstack-on-openstack-specialized.rst
   specialized/hardware-specialized.rst

Although most OpenStack architecture designs fall into one
of the seven major scenarios outlined in other sections
(compute focused, network focused, storage focused, general
purpose, multi-site, hybrid cloud, and massively scalable),
there are a few use cases that do not fit into these categories.
This section discusses these specialized cases and provide some
additional details and design considerations for each use case:

* :doc:`Specialized networking <specialized/networking-specialized>`:
  describes running networking-oriented software that may involve reading
  packets directly from the wire or participating in routing protocols.
* :doc:`Software-defined networking (SDN)
  <specialized/software-defined-networking-specialized>`:
  describes both running an SDN controller from within OpenStack
  as well as participating in a software-defined network.
* :doc:`Desktop-as-a-Service
  <specialized/desktop-as-a-service-specialized>`:
  describes running a virtualized desktop environment in a cloud
  (:term:`Desktop-as-a-Service`).
  This applies to private and public clouds.
* :doc:`OpenStack on OpenStack
  <specialized/openstack-on-openstack-specialized>`:
  describes building a multi-tiered cloud by running OpenStack
  on top of an OpenStack installation.
* :doc:`Specialized hardware <specialized/hardware-specialized>`:
  describes the use of specialized hardware devices from within
  the OpenStack environment.
