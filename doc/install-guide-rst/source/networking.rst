==========================
Add a networking component
==========================

This chapter explains how to install and configure either OpenStack
Networking (neutron), or the legacy ``nova-network`` component. The
``nova-network`` service enables you to deploy one network type per
instance and is suitable for basic network functionality. OpenStack
Networking enables you to deploy multiple network types per instance
and includes :term:`plug-in` s for a variety of products that support
:term:`virtual networking`.

For more information, see the
`Networking <http://docs.openstack.org/admin-guide-cloud/content/ch_networking.html>`__
chapter of the OpenStack Cloud Administrator Guide.

OpenStack Networking (neutron)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. toctree::

   neutron-concepts.rst
   neutron-controller-node.rst

.. todo
   section_getstart_networking.xml
   section_neutron-network-node.xml
   section_neutron-compute-node.xml
   section_neutron-initial-networks.xml


Legacy networking (nova-network)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. todo
   section_nova-networking.xml
   section_nova-networking-controller-node.xml
   section_nova-networking-compute-node.xml
   section_nova-networking-initial-network.xml


Next steps
~~~~~~~~~~

Your OpenStack environment now includes the core components necessary
to launch a basic instance. You can :doc:`launch an
instance <launch-instance-neutron>` or add more OpenStack services
to your environment.
