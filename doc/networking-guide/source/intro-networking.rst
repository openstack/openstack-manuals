==========================
Introduction to networking
==========================

The OpenStack :term:`Networking` service provides an API that allows users
to set up and define network connectivity and addressing in the
cloud. The project code-name for Networking services is neutron.
OpenStack Networking handles the creation and management of a virtual
networking infrastructure, including networks, switches, subnets, and
routers for devices managed by the OpenStack Compute service
(nova). Advanced services such as firewalls or :term:`virtual private
networks (VPNs) <virtual private network (VPN)>` can also be used.

OpenStack Networking consists of the neutron-server, a database for
persistent storage, and any number of plug-in agents, which provide
other services such as interfacing with native Linux networking
mechanisms, external devices, or SDN controllers.

OpenStack Networking is entirely standalone and can be deployed to a
dedicated host. If your deployment uses a controller host to run
centralized Compute components, you can deploy the Networking server
to that specific host instead.

OpenStack Networking integrates with various other OpenStack
components:

* OpenStack :term:`Identity` (keystone) is used for authentication and
  authorization of API requests.

* OpenStack :term:`Compute` (nova) is used to plug each virtual
  NIC on the VM into a particular network.

* OpenStack :term:`dashboard` (horizon) is used by administrators and tenant
  users to create and manage network services through a web-based graphical
  interface.

.. toctree::
   :maxdepth: 2

   intro-basic-networking.rst
   intro-networking-components.rst
   intro-tunnel-technologies.rst
   intro-network-namespaces.rst
   intro-network-address-translation.rst
