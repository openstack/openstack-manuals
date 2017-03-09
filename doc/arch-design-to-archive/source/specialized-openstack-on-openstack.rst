======================
OpenStack on OpenStack
======================

In some cases, users may run OpenStack nested on top
of another OpenStack cloud. This scenario describes how to
manage and provision complete OpenStack environments on instances
supported by hypervisors and servers, which an underlying OpenStack
environment controls.

Public cloud providers can use this technique to manage the
upgrade and maintenance process on complete OpenStack environments.
Developers and those testing OpenStack can also use this
technique to provision their own OpenStack environments on
available OpenStack Compute resources, whether public or private.

Challenges
~~~~~~~~~~

The network aspect of deploying a nested cloud is the most
complicated aspect of this architecture.
You must expose VLANs to the physical ports on which the underlying
cloud runs because the bare metal cloud owns all the hardware.
You must also expose them to the nested levels as well.
Alternatively, you can use the network overlay technologies on the
OpenStack environment running on the host OpenStack environment to
provide the required software defined networking for the deployment.

Hypervisor
~~~~~~~~~~

In this example architecture, consider which
approach you should take to provide a nested
hypervisor in OpenStack. This decision influences which
operating systems you use for the deployment of the nested
OpenStack deployments.

Possible solutions: deployment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Deployment of a full stack can be challenging but you can mitigate
this difficulty by creating a Heat template to deploy the
entire stack, or a configuration management system. After creating
the Heat template, you can automate the deployment of additional stacks.

The OpenStack-on-OpenStack project (:term:`TripleO`)
addresses this issue. Currently, however, the project does
not completely cover nested stacks. For more information, see
https://wiki.openstack.org/wiki/TripleO.

Possible solutions: hypervisor
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In the case of running TripleO, the underlying OpenStack
cloud deploys the compute nodes as bare-metal. You then deploy
OpenStack on these Compute bare-metal servers with the
appropriate hypervisor, such as KVM.

In the case of running smaller OpenStack clouds for testing
purposes, where performance is not a critical factor, you can use
QEMU instead. It is also possible to run a KVM hypervisor in an instance
(see `davejingtian.org
<http://davejingtian.org/2014/03/30/nested-kvm-just-for-fun/>`_),
though this is not a supported configuration, and could be a
complex solution for such a use case.

Diagram
~~~~~~~

.. figure:: figures/Specialized_OOO.png
   :width: 100%
