========
Overview
========

The :term:`OpenStack` project is an open source cloud computing platform that
supports all types of cloud environments. The project aims for simple
implementation, massive scalability, and a rich set of features. Cloud
computing experts from around the world contribute to the project.

OpenStack provides an :term:`Infrastructure-as-a-Service (IaaS)` solution
through a variety of complementary services. Each service offers an
:term:`Application Programming Interface (API)` that facilitates this
integration.

This guide covers step-by-step deployment of the major OpenStack
services using a functional example architecture suitable for
new users of OpenStack with sufficient Linux experience.

After becoming familiar with basic installation, configuration, operation,
and troubleshooting of these OpenStack services, you should consider the
following steps toward deployment using a production architecture:

* Determine and implement the necessary core and optional services to
  meet performance and redundancy requirements.

* Increase security using methods such as firewalls, encryption, and
  service policies.

* Implement a deployment tool such as Ansible, Chef, Puppet, or Salt
  to automate deployment and management of the production environment.

.. _overview-example-architectures:

Example architecture
~~~~~~~~~~~~~~~~~~~~

The example architecture requires at least two nodes (hosts) to launch a basic
:term:`virtual machine <virtual machine (VM)>` or instance. Optional
services such as Block Storage and Object Storage require additional nodes.

This example architecture differs from a minimal production architecture as
follows:

* Networking agents reside on the controller node instead of one or more
  dedicated network nodes.

* Overlay (tunnel) traffic for self-service networks traverses the management
  network instead of a dedicated network.

For more information on production architectures, see the
`Architecture Design Guide <https://docs.openstack.org/arch-design/>`__,
`OpenStack Operations Guide <https://docs.openstack.org/ops/>`__, and
`OpenStack Networking Guide <https://docs.openstack.org/newton/networking-guide/>`__.

.. _figure-hwreqs:

.. figure:: figures/hwreqs.png
   :alt: Hardware requirements

   **Hardware requirements**

Controller
----------

The controller node runs the Identity service, Image service, management
portions of Compute, management portion of Networking, various Networking
agents, and the Dashboard. It also includes supporting services such as
an SQL database, :term:`message queue`, and :term:`NTP <Network Time Protocol
(NTP)>`.

Optionally, the controller node runs portions of the Block Storage, Object
Storage, Orchestration, and Telemetry services.

The controller node requires a minimum of two network interfaces.

Compute
-------

The compute node runs the :term:`hypervisor` portion of Compute that
operates instances. By default, Compute uses the
:term:`KVM <kernel-based VM (KVM)>` hypervisor. The compute node also
runs a Networking service agent that connects instances to virtual networks
and provides firewalling services to instances via
:term:`security groups <security group>`.

You can deploy more than one compute node. Each node requires a minimum
of two network interfaces.

Block Storage
-------------

The optional Block Storage node contains the disks that the Block
Storage and Shared File System services provision for instances.

For simplicity, service traffic between compute nodes and this node
uses the management network. Production environments should implement
a separate storage network to increase performance and security.

You can deploy more than one block storage node. Each node requires a
minimum of one network interface.

Object Storage
--------------

The optional Object Storage node contain the disks that the
Object Storage service uses for storing accounts, containers, and
objects.

For simplicity, service traffic between compute nodes and this node
uses the management network. Production environments should implement
a separate storage network to increase performance and security.

This service requires two nodes. Each node requires a minimum of one
network interface. You can deploy more than two object storage nodes.

Networking
~~~~~~~~~~

Choose one of the following virtual networking options.

.. _network1:

Networking Option 1: Provider networks
--------------------------------------

The provider networks option deploys the OpenStack Networking service
in the simplest way possible with primarily layer-2 (bridging/switching)
services and VLAN segmentation of networks. Essentially, it bridges virtual
networks to physical networks and relies on physical network infrastructure
for layer-3 (routing) services. Additionally, a :term:`DHCP<Dynamic Host
Configuration Protocol (DHCP)>` service provides IP address information to
instances.

.. warning::

   This option lacks support for self-service (private) networks, layer-3
   (routing) services, and advanced services such as
   :term:`LBaaS <Load-Balancer-as-a-Service (LBaaS)>` and
   :term:`FWaaS<FireWall-as-a-Service (FWaaS)>`.
   Consider the self-service networks option below if you desire these features.

.. _figure-network1-services:

.. figure:: figures/network1-services.png
   :alt: Networking Option 1: Provider networks - Service layout

.. _network2:

Networking Option 2: Self-service networks
------------------------------------------

The self-service networks option augments the provider networks option
with layer-3 (routing) services that enable
:term:`self-service` networks using overlay segmentation methods such
as :term:`VXLAN <Virtual Extensible LAN (VXLAN)>`. Essentially, it routes
virtual networks to physical networks using :term:`NAT<Network Address
Translation (NAT)>`. Additionally, this option provides the foundation for
advanced services such as LBaaS and FWaaS.

.. _figure-network2-services:

.. figure:: figures/network2-services.png
   :alt: Networking Option 2: Self-service networks - Service layout
