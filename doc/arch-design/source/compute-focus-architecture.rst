============
Architecture
============
The hardware selection covers three areas:

* Compute

* Network

* Storage

Compute-focused OpenStack clouds have high demands on processor and
memory resources, and requires hardware that can handle these demands.
Consider the following factors when selecting compute (server) hardware:

* Server density

* Resource capacity

* Expandability

* Cost

Weigh these considerations against each other to determine the best
design for the desired purpose. For example, increasing server density
means sacrificing resource capacity or expandability.

A compute-focused cloud should have an emphasis on server hardware that
can offer more CPU sockets, more CPU cores, and more RAM. Network
connectivity and storage capacity are less critical.

When designing a compute-focused OpenStack architecture, you must
consider whether you intend to scale up or scale out. Selecting a
smaller number of larger hosts, or a larger number of smaller hosts,
depends on a combination of factors: cost, power, cooling, physical rack
and floor space, support-warranty, and manageability.

Considerations for selecting hardware:

* Most blade servers can support dual-socket multi-core CPUs. To avoid
  this CPU limit, select ``full width`` or ``full height`` blades. Be
  aware, however, that this also decreases server density. For example,
  high density blade servers such as HP BladeSystem or Dell PowerEdge
  M1000e support up to 16 servers in only ten rack units. Using
  half-height blades is twice as dense as using full-height blades,
  which results in only eight servers per ten rack units.

* 1U rack-mounted servers that occupy only a single rack unit may offer
  greater server density than a blade server solution. It is possible
  to place forty 1U servers in a rack, providing space for the top of
  rack (ToR) switches, compared to 32 full width blade servers.

* 2U rack-mounted servers provide quad-socket, multi-core CPU support,
  but with a corresponding decrease in server density (half the density
  that 1U rack-mounted servers offer).

* Larger rack-mounted servers, such as 4U servers, often provide even
  greater CPU capacity, commonly supporting four or even eight CPU
  sockets. These servers have greater expandability, but such servers
  have much lower server density and are often more expensive.

* ``Sled servers`` are rack-mounted servers that support multiple
  independent servers in a single 2U or 3U enclosure. These deliver
  higher density as compared to typical 1U or 2U rack-mounted servers.
  For example, many sled servers offer four independent dual-socket
  nodes in 2U for a total of eight CPU sockets in 2U.

Consider these when choosing server hardware for a compute-focused
OpenStack design architecture:

* Instance density

* Host density

* Power and cooling density

Selecting networking hardware
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Some of the key considerations for networking hardware selection
include:

* Port count

* Port density

* Port speed

* Redundancy

* Power requirements

We recommend designing the network architecture using a scalable network
model that makes it easy to add capacity and bandwidth. A good example
of such a model is the leaf-spline model. In this type of network
design, it is possible to easily add additional bandwidth as well as
scale out to additional racks of gear. It is important to select network
hardware that supports the required port count, port speed, and port
density while also allowing for future growth as workload demands
increase. It is also important to evaluate where in the network
architecture it is valuable to provide redundancy.

Operating system and hypervisor
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The selection of operating system (OS) and hypervisor has a significant
impact on the end point design.

OS and hypervisor selection impact the following areas:

* Cost

* Supportability

* Management tools

* Scale and performance

* Security

* Supported features

* Interoperability

OpenStack components
~~~~~~~~~~~~~~~~~~~~

The selection of OpenStack components is important. There are certain
components that are required, for example the compute and image
services, but others, such as the Orchestration service, may not be
present.

For a compute-focused OpenStack design architecture, the following
components may be present:

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

The exclusion of certain OpenStack components might also limit the
functionality of other components. If a design includes the
Orchestration service but excludes the Telemetry service, then the
design cannot take advantage of Orchestration's auto scaling
functionality as this relies on information from Telemetry.

Networking software
~~~~~~~~~~~~~~~~~~~

OpenStack Networking provides a wide variety of networking services for
instances. There are many additional networking software packages that
might be useful to manage the OpenStack components themselves. The
`OpenStack High Availability Guide <https://docs.openstack.org/ha-guide/>`_
describes some of these software packages in more detail.

For a compute-focused OpenStack cloud, the OpenStack infrastructure
components must be highly available. If the design does not include
hardware load balancing, you must add networking software packages, for
example, HAProxy.

Management software
~~~~~~~~~~~~~~~~~~~

The selected supplemental software solution impacts and affects the
overall OpenStack cloud design. This includes software for providing
clustering, logging, monitoring and alerting.

The availability of design requirements is the main determiner for the
inclusion of clustering software, such as Corosync or Pacemaker.

Operational considerations determine the requirements for logging,
monitoring, and alerting. Each of these sub-categories include various
options.

Some other potential design impacts include:

OS-hypervisor combination
 Ensure that the selected logging, monitoring, or alerting tools
 support the proposed OS-hypervisor combination.

Network hardware
 The logging, monitoring, and alerting software must support the
 network hardware selection.

Database software
~~~~~~~~~~~~~~~~~

A large majority of OpenStack components require access to back-end
database services to store state and configuration information. Select
an appropriate back-end database that satisfies the availability and
fault tolerance requirements of the OpenStack services. OpenStack
services support connecting to any database that the SQLAlchemy Python
drivers support, however most common database deployments make use of
MySQL or some variation of it. We recommend that you make the database
that provides back-end services within a general-purpose cloud highly
available. Some of the more common software solutions include Galera,
MariaDB, and MySQL with multi-master replication.
