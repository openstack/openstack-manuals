==================
Software selection
==================

Software selection, particularly for a general purpose OpenStack architecture
design involves three areas:

* Operating system (OS) and hypervisor

* OpenStack components

* Supplemental software

Operating system and hypervisor
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The operating system (OS) and hypervisor have a significant impact on
the overall design. Selecting a particular operating system and
hypervisor can directly affect server hardware selection. Make sure the
storage hardware and topology support the selected operating system and
hypervisor combination. Also ensure the networking hardware selection
and topology will work with the chosen operating system and hypervisor
combination.

Some areas that could be impacted by the selection of OS and hypervisor
include:

Cost
 Selecting a commercially supported hypervisor, such as Microsoft
 Hyper-V, will result in a different cost model rather than
 community-supported open source hypervisors including
 :term:`KVM<kernel-based VM (KVM)>`, Kinstance or :term:`Xen`. When
 comparing open source OS solutions, choosing Ubuntu over Red Hat
 (or vice versa) will have an impact on cost due to support
 contracts.

Support
 Depending on the selected hypervisor, staff should have the
 appropriate training and knowledge to support the selected OS and
 hypervisor combination. If they do not, training will need to be
 provided which could have a cost impact on the design.

Management tools
 The management tools used for Ubuntu and Kinstance differ from the
 management tools for VMware vSphere. Although both OS and hypervisor
 combinations are supported by OpenStack, there is
 different impact to the rest of the design as a result of the
 selection of one combination versus the other.

Scale and performance
 Ensure that selected OS and hypervisor combinations meet the
 appropriate scale and performance requirements. The chosen
 architecture will need to meet the targeted instance-host ratios
 with the selected OS-hypervisor combinations.

Security
 Ensure that the design can accommodate regular periodic
 installations of application security patches while maintaining
 required workloads. The frequency of security patches for the
 proposed OS-hypervisor combination will have an impact on
 performance and the patch installation process could affect
 maintenance windows.

Supported features
 Determine which OpenStack features are required. This will often
 determine the selection of the OS-hypervisor combination. Some
 features are only available with specific operating systems or
 hypervisors.

Interoperability
 You will need to consider how the OS and hypervisor combination
 interactions with other operating systems and hypervisors, including
 other software solutions. Operational troubleshooting tools for one
 OS-hypervisor combination may differ from the tools used for another
 OS-hypervisor combination and, as a result, the design will need to
 address if the two sets of tools need to interoperate.

OpenStack components
~~~~~~~~~~~~~~~~~~~~

Selecting which OpenStack components are included in the overall design
is important. Some OpenStack components, like compute and Image service,
are required in every architecture. Other components, like
Orchestration, are not always required.

A compute-focused OpenStack design architecture may contain the following
components:

* Identity (keystone)

* Dashboard (horizon)

* Compute (nova)

* Object Storage (swift)

* Image (glance)

* Networking (neutron)

* Orchestration (heat)

  .. note::

     A compute-focused design is less likely to include OpenStack Block
     Storage. However, there may be some situations where the need for
     performance requires a block storage component to improve data I-O.

Excluding certain OpenStack components can limit or constrain the
functionality of other components. For example, if the architecture
includes Orchestration but excludes Telemetry, then the design will not
be able to take advantage of Orchestrations' auto scaling functionality.
It is important to research the component interdependencies in
conjunction with the technical requirements before deciding on the final
architecture.

Networking software
~~~~~~~~~~~~~~~~~~~

OpenStack Networking (neutron) provides a wide variety of networking
services for instances. There are many additional networking software
packages that can be useful when managing OpenStack components. Some
examples include:

* Software to provide load balancing

* Network redundancy protocols

* Routing daemons

Some of these software packages are described in more detail in the
`OpenStack network nodes chapter <http://docs.openstack.org/ha-guide
/networking-ha.html>`_ in the OpenStack High Availability Guide.

For a general purpose OpenStack cloud, the OpenStack infrastructure
components need to be highly available. If the design does not include
hardware load balancing, networking software packages like HAProxy will
need to be included.

For a compute-focused OpenStack cloud, the OpenStack infrastructure
components must be highly available. If the design does not include
hardware load balancing, you must add networking software packages, for
example, HAProxy.

Management software
~~~~~~~~~~~~~~~~~~~

Management software includes software for providing:

* Clustering

* Logging

* Monitoring

* Alerting

.. important::

   The factors for determining which software packages in this category
   to select is outside the scope of this design guide.

The selected supplemental software solution impacts and affects the overall
OpenStack cloud design. This includes software for providing clustering,
logging, monitoring and alerting.

The inclusion of clustering software, such as Corosync or Pacemaker, is
primarily determined by the availability of the cloud infrastructure and
the complexity of supporting the configuration after it is deployed. The
`OpenStack High Availability Guide <http://docs.openstack.org/ha-guide/>`_
provides more details on the installation and configuration of Corosync
and Pacemaker, should these packages need to be included in the design.

Operational considerations determine the requirements for logging,
monitoring, and alerting. Each of these sub-categories include various
options.

For example, in the logging sub-category you could select Logstash,
Splunk, Log Insight, or another log aggregation-consolidation tool.
Store logs in a centralized location to facilitate performing analytics
against the data. Log data analytics engines can also provide automation
and issue notification, by providing a mechanism to both alert and
automatically attempt to remediate some of the more commonly known
issues.

If these software packages are required, the design must account for the
additional resource consumption (CPU, RAM, storage, and network
bandwidth). Some other potential design impacts include:

* OS-hypervisor combination
   Ensure that the selected logging, monitoring, or alerting tools support
   the proposed OS-hypervisor combination.

* Network hardware
   The network hardware selection needs to be supported by the logging,
   monitoring, and alerting software.

Database software
~~~~~~~~~~~~~~~~~

Most OpenStack components require access to back-end database services
to store state and configuration information. Choose an appropriate
back-end database which satisfies the availability and fault tolerance
requirements of the OpenStack services.

MySQL is the default database for OpenStack, but other compatible
databases are available.

.. note::

   Telemetry uses MongoDB.

The chosen high availability database solution changes according to the
selected database. MySQL, for example, provides several options. Use a
replication technology such as Galera for active-active clustering. For
active-passive use some form of shared storage. Each of these potential
solutions has an impact on the design:

* Solutions that employ Galera/MariaDB require at least three MySQL
  nodes.

* MongoDB has its own design considerations for high availability.

* OpenStack design, generally, does not include shared storage.
  However, for some high availability designs, certain components might
  require it depending on the specific implementation.


Licensing
~~~~~~~~~

The many different forms of license agreements for software are often written
with the use of dedicated hardware in mind.  This model is relevant for the
cloud platform itself, including the hypervisor operating system, supporting
software for items such as database, RPC, backup, and so on.  Consideration
must be made when offering Compute service instances and applications to end
users of the cloud, since the license terms for that software may need some
adjustment to be able to operate economically in the cloud.

Multi-site OpenStack deployments present additional licensing
considerations over and above regular OpenStack clouds, particularly
where site licenses are in use to provide cost efficient access to
software licenses. The licensing for host operating systems, guest
operating systems, OpenStack distributions (if applicable),
software-defined infrastructure including network controllers and
storage systems, and even individual applications need to be evaluated.

Topics to consider include:

* The definition of what constitutes a site in the relevant licenses,
  as the term does not necessarily denote a geographic or otherwise
  physically isolated location.

* Differentiations between "hot" (active) and "cold" (inactive) sites,
  where significant savings may be made in situations where one site is
  a cold standby for disaster recovery purposes only.

* Certain locations might require local vendors to provide support and
  services for each site which may vary with the licensing agreement in
  place.
