User requirements
~~~~~~~~~~~~~~~~~

Defining user requirements for a massively scalable OpenStack design
architecture dictates approaching the design from two different, yet sometimes
opposing, perspectives: the cloud user, and the cloud operator. The
expectations and perceptions of the consumption and management of resources of
a massively scalable OpenStack cloud from these two perspectives are
distinctly different.

Massively scalable OpenStack clouds have the following user requirements:

* The cloud user expects repeatable, dependable, and deterministic processes
  for launching and deploying cloud resources. You could deliver this through
  a web-based interface or publicly available API endpoints. All appropriate
  options for requesting cloud resources must be available through some type
  of user interface, a command-line interface (CLI), or API endpoints.

* Cloud users expect a fully self-service and on-demand consumption model.
  When an OpenStack cloud reaches the massively scalable size, expect
  consumption as a service in each and every way.

* For a user of a massively scalable OpenStack public cloud, there are no
  expectations for control over security, performance, or availability. Users
  expect only SLAs related to uptime of API services, and very basic SLAs for
  services offered. It is the user's responsibility to address these issues on
  their own. The exception to this expectation is the rare case of a massively
  scalable cloud infrastructure built for a private or government organization
  that has specific requirements.

The cloud user's requirements and expectations that determine the cloud design
focus on the consumption model. The user expects to consume cloud resources in
an automated and deterministic way, without any need for knowledge of the
capacity, scalability, or other attributes of the cloud's underlying
infrastructure.

Operator requirements
---------------------

While the cloud user can be completely unaware of the underlying
infrastructure of the cloud and its attributes, the operator must build and
support the infrastructure for operating at scale. This presents a very
demanding set of requirements for building such a cloud from the operator's
perspective:

* Everything must be capable of automation. For example, everything from
  compute hardware, storage hardware, networking hardware, to the installation
  and configuration of the supporting software. Manual processes are
  impractical in a massively scalable OpenStack design architecture.

* The cloud operator requires that capital expenditure (CapEx) is minimized at
  all layers of the stack. Operators of massively scalable OpenStack clouds
  require the use of dependable commodity hardware and freely available open
  source software components to reduce deployment costs and operational
  expenses. Initiatives like OpenCompute (more information available at
  `Open Compute Project <http://www.opencompute.org>`_)
  provide additional information and pointers. To
  cut costs, many operators sacrifice redundancy. For example, using redundant
  power supplies, network connections, and rack switches.

* Companies operating a massively scalable OpenStack cloud also require that
  operational expenditures (OpEx) be minimized as much as possible. We
  recommend using cloud-optimized hardware when managing operational overhead.
  Some of the factors to consider include power, cooling, and the physical
  design of the chassis. Through customization, it is possible to optimize the
  hardware and systems for this type of workload because of the scale of these
  implementations.

* Massively scalable OpenStack clouds require extensive metering and
  monitoring functionality to maximize the operational efficiency by keeping
  the operator informed about the status and state of the infrastructure. This
  includes full scale metering of the hardware and software status. A
  corresponding framework of logging and alerting is also required to store
  and enable operations to act on the meters provided by the metering and
  monitoring solutions. The cloud operator also needs a solution that uses the
  data provided by the metering and monitoring solution to provide capacity
  planning and capacity trending analysis.

* Invariably, massively scalable OpenStack clouds extend over several sites.
  Therefore, the user-operator requirements for a multi-site OpenStack
  architecture design are also applicable here. This includes various legal
  requirements; other jurisdictional legal or compliance requirements; image
  consistency-availability; storage replication and availability (both block
  and file/object storage); and authentication, authorization, and auditing
  (AAA). See :doc:`multi-site` for more details on requirements and
  considerations for multi-site OpenStack clouds.

* The design architecture of a massively scalable OpenStack cloud must address
  considerations around physical facilities such as space, floor weight, rack
  height and type, environmental considerations, power usage and power usage
  efficiency (PUE), and physical security.
