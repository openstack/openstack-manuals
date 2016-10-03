=====================
Specialized use cases
=====================

.. toctree::
   :maxdepth: 2

   specialized-multi-hypervisor.rst
   specialized-networking.rst
   specialized-software-defined-networking.rst
   specialized-desktop-as-a-service.rst
   specialized-openstack-on-openstack.rst
   specialized-hardware.rst
   specialized-single-site.rst
   specialized-add-region.rst
   specialized-scaling-multiple-cells.rst


This section provides details and design considerations for
specialized cases:

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
