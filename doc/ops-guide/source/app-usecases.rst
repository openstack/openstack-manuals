=========
Use Cases
=========

This appendix contains a small selection of use cases from the
community, with more technical detail than usual. Further examples can
be found on the `OpenStack website <https://www.openstack.org/user-stories/>`_.

NeCTAR
~~~~~~

Who uses it: researchers from the Australian publicly funded research
sector. Use is across a wide variety of disciplines, with the purpose of
instances ranging from running simple web servers to using hundreds of
cores for high-throughput computing.

Deployment
----------

Using OpenStack Compute cells, the NeCTAR Research Cloud spans eight
sites with approximately 4,000 cores per site.

Each site runs a different configuration, as a resource cells in an
OpenStack Compute cells setup. Some sites span multiple data centers,
some use off compute node storage with a shared file system, and some
use on compute node storage with a non-shared file system. Each site
deploys the Image service with an Object Storage back end. A central
Identity, dashboard, and Compute API service are used. A login to the
dashboard triggers a SAML login with Shibboleth, which creates an
account in the Identity service with an SQL back end. An Object Storage
Global Cluster is used across several sites.

Compute nodes have 24 to 48 cores, with at least 4 GB of RAM per core
and approximately 40 GB of ephemeral storage per core.

All sites are based on Ubuntu 14.04, with KVM as the hypervisor. The
OpenStack version in use is typically the current stable version, with 5
to 10 percent back-ported code from trunk and modifications.

Resources
---------

-  `OpenStack.org case
   study <https://www.openstack.org/user-stories/nectar/>`_

-  `NeCTAR-RC GitHub <https://github.com/NeCTAR-RC/>`_

-  `NeCTAR website <https://www.nectar.org.au/>`_

MIT CSAIL
~~~~~~~~~

Who uses it: researchers from the MIT Computer Science and Artificial
Intelligence Lab.

Deployment
----------

The CSAIL cloud is currently 64 physical nodes with a total of 768
physical cores and 3,456 GB of RAM. Persistent data storage is largely
outside the cloud on NFS, with cloud resources focused on compute
resources. There are more than 130 users in more than 40 projects,
typically running 2,000–2,500 vCPUs in 300 to 400 instances.

We initially deployed on Ubuntu 12.04 with the Essex release of
OpenStack using FlatDHCP multi-host networking.

The software stack is still Ubuntu 12.04 LTS, but now with OpenStack
Havana from the Ubuntu Cloud Archive. KVM is the hypervisor, deployed
using `FAI <http://fai-project.org/>`_ and Puppet for configuration
management. The FAI and Puppet combination is used lab-wide, not only
for OpenStack. There is a single cloud controller node, which also acts
as network controller, with the remainder of the server hardware
dedicated to compute nodes.

Host aggregates and instance-type extra specs are used to provide two
different resource allocation ratios. The default resource allocation
ratios we use are 4:1 CPU and 1.5:1 RAM. Compute-intensive workloads use
instance types that require non-oversubscribed hosts where ``cpu_ratio``
and ``ram_ratio`` are both set to 1.0. Since we have hyper-threading
enabled on our compute nodes, this provides one vCPU per CPU thread, or
two vCPUs per physical core.

With our upgrade to Grizzly in August 2013, we moved to OpenStack
Networking, neutron (quantum at the time). Compute nodes have
two-gigabit network interfaces and a separate management card for IPMI
management. One network interface is used for node-to-node
communications. The other is used as a trunk port for OpenStack managed
VLANs. The controller node uses two bonded 10g network interfaces for
its public IP communications. Big pipes are used here because images are
served over this port, and it is also used to connect to iSCSI storage,
back-ending the image storage and database. The controller node also has
a gigabit interface that is used in trunk mode for OpenStack managed
VLAN traffic. This port handles traffic to the dhcp-agent and
metadata-proxy.

We approximate the older ``nova-network`` multi-host HA setup by using
"provider VLAN networks" that connect instances directly to existing
publicly addressable networks and use existing physical routers as their
default gateway. This means that if our network controller goes down,
running instances still have their network available, and no single
Linux host becomes a traffic bottleneck. We are able to do this because
we have a sufficient supply of IPv4 addresses to cover all of our
instances and thus don't need NAT and don't use floating IP addresses.
We provide a single generic public network to all projects and
additional existing VLANs on a project-by-project basis as needed.
Individual projects are also allowed to create their own private GRE
based networks.

Resources
---------

-  `CSAIL homepage <http://www.csail.mit.edu/>`_

DAIR
~~~~

Who uses it: DAIR is an integrated virtual environment that leverages
the CANARIE network to develop and test new information communication
technology (ICT) and other digital technologies. It combines such
digital infrastructure as advanced networking and cloud computing and
storage to create an environment for developing and testing innovative
ICT applications, protocols, and services; performing at-scale
experimentation for deployment; and facilitating a faster time to
market.

Deployment
----------

DAIR is hosted at two different data centers across Canada: one in
Alberta and the other in Quebec. It consists of a cloud controller at
each location, although, one is designated the "master" controller that
is in charge of central authentication and quotas. This is done through
custom scripts and light modifications to OpenStack. DAIR is currently
running Havana.

For Object Storage, each region has a swift environment.

A NetApp appliance is used in each region for both block storage and
instance storage. There are future plans to move the instances off the
NetApp appliance and onto a distributed file system such as :term:`Ceph` or
GlusterFS.

VlanManager is used extensively for network management. All servers have
two bonded 10GbE NICs that are connected to two redundant switches. DAIR
is set up to use single-node networking where the cloud controller is
the gateway for all instances on all compute nodes. Internal OpenStack
traffic (for example, storage traffic) does not go through the cloud
controller.

Resources
---------

-  `DAIR homepage <http://www.canarie.ca/cloud/>`__

CERN
~~~~

Who uses it: researchers at CERN (European Organization for Nuclear
Research) conducting high-energy physics research.

Deployment
----------

The environment is largely based on Scientific Linux 6, which is Red Hat
compatible. We use KVM as our primary hypervisor, although tests are
ongoing with Hyper-V on Windows Server 2008.

We use the Puppet Labs OpenStack modules to configure Compute, Image
service, Identity, and dashboard. Puppet is used widely for instance
configuration, and Foreman is used as a GUI for reporting and instance
provisioning.

Users and groups are managed through Active Directory and imported into
the Identity service using LDAP. CLIs are available for nova and
Euca2ools to do this.

There are three clouds currently running at CERN, totaling about 4,700
compute nodes, with approximately 120,000 cores. The CERN IT cloud aims
to expand to 300,000 cores by 2015.

Resources
---------

-  `OpenStack in Production: A tale of 3 OpenStack
   Clouds <http://openstack-in-production.blogspot.de/2013/09/a-tale-of-3-openstack-clouds-50000.html>`_

-  `Review of CERN Data Centre
   Infrastructure <http://cds.cern.ch/record/1457989/files/chep%202012%20CERN%20infrastructure%20final.pdf?version=1>`_

-  `CERN Cloud Infrastructure User
   Guide <http://information-technology.web.cern.ch/book/cern-private-cloud-user-guide>`_
