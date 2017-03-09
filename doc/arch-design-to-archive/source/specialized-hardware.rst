====================
Specialized hardware
====================

Certain workloads require specialized hardware devices that
have significant virtualization or sharing challenges.
Applications such as load balancers, highly parallel brute
force computing, and direct to wire networking may need
capabilities that basic OpenStack components do not provide.

Challenges
~~~~~~~~~~

Some applications need access to hardware devices to either
improve performance or provide capabilities that are not
virtual CPU, RAM, network, or storage. These can be a shared
resource, such as a cryptography processor, or a dedicated
resource, such as a Graphics Processing Unit (GPU). OpenStack can
provide some of these, while others may need extra work.

Solutions
~~~~~~~~~

To provide cryptography offloading to a set of instances,
you can use Image service configuration options.
For example, assign the cryptography chip to a device node in the guest.
The OpenStack Command Line Reference contains further information on
configuring this solution in the section `Image service property keys
<https://docs.openstack.org/cli-reference/glance.html#image-service-property-keys>`_.
A challenge, however, is this option allows all guests using the
configured images to access the hypervisor cryptography device.

If you require direct access to a specific device, PCI pass-through
enables you to dedicate the device to a single instance per hypervisor.
You must define a flavor that has the PCI device specifically in order
to properly schedule instances.
More information regarding PCI pass-through, including instructions for
implementing and using it, is available at
`https://wiki.openstack.org/wiki/Pci_passthrough <https://wiki.openstack.org/
wiki/Pci_passthrough#How_to_check_PCI_status_with_PCI_api_patches>`_.

.. figure:: figures/Specialized_Hardware2.png
   :width: 100%
