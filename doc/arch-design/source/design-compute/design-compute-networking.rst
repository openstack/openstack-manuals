====================
Network connectivity
====================

The selected server hardware must have the appropriate number of network
connections, as well as the right type of network connections, in order to
support the proposed architecture. Ensure that, at a minimum, there are at
least two diverse network connections coming into each rack.

The selection of form factors or architectures affects the selection of server
hardware. Ensure that the selected server hardware is configured to support
enough storage capacity (or storage expandability) to match the requirements of
selected scale-out storage solution. Similarly, the network architecture
impacts the server hardware selection and vice versa.

While each enterprise install is different, the following networks with their
proposed bandwidth is highly recommended for a basic production OpenStack
install.

**Install or OOB network** - Typically used by most distributions and
provisioning tools as the network for deploying base software to the
OpenStack compute nodes. This network should be connected at a minimum of 1Gb
and no routing is usually needed.

**Internal or Management network** - Used as the internal communication network
between OpenStack compute and control nodes. Can also be used as a network
for iSCSI communication between the compute and iSCSI storage nodes. Again,
this should be a minimum of a 1Gb NIC and should be a non-routed network. This
interface should be redundant for high availability (HA).

**Tenant network** - A private network that enables communication between each
tenant's instances. If using flat networking and provider networks, this
network is optional. This network should also be isolated from all other
networks for security compliance. A 1Gb interface should be sufficient and
redundant for HA.

**Storage network** - A private network which could be connected to the Ceph
frontend or other shared storage. For HA purposes this should be a redundant
configuration with suggested 10Gb NICs. This network isolates the storage for
the instances away from other networks. Under load, this storage traffic
could overwhelm other networks and cause outages on other OpenStack services.

**(Optional) External or Public network** - This network is used to communicate
externally from the VMs to the public network space. These addresses are
typically handled by the neutron agent on the controller nodes and can also
be handled by a SDN other than neutron. However, when using neutron DVR with
OVS, this network must be present on the compute node since north and south
traffic will not be handled by the controller nodes, but by the compute node
itself. For more information on DVR with OVS and compute nodes, see
`Open vSwitch: High availability using DVR
<https://docs.openstack.org/ocata/networking-guide/deploy-ovs-ha-dvr.html>`_
