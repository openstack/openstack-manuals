========================
Technical considerations
========================

There are many technical considerations to take into account with regard
to designing a multi-site OpenStack implementation. An OpenStack cloud
can be designed in a variety of ways to handle individual application
needs. A multi-site deployment has additional challenges compared to
single site installations and therefore is a more complex solution.

When determining capacity options be sure to take into account not just
the technical issues, but also the economic or operational issues that
might arise from specific decisions.

Inter-site link capacity describes the capabilities of the connectivity
between the different OpenStack sites. This includes parameters such as
bandwidth, latency, whether or not a link is dedicated, and any business
policies applied to the connection. The capability and number of the
links between sites determine what kind of options are available for
deployment. For example, if two sites have a pair of high-bandwidth
links available between them, it may be wise to configure a separate
storage replication network between the two sites to support a single
Swift endpoint and a shared Object Storage capability between them. An
example of this technique, as well as a configuration walk-through, is
available at `Dedicated replication network
<https://docs.openstack.org/developer/swift/replication_network.html#dedicated-replication-network>`_.
Another option in this scenario is to build a dedicated set of project
private networks across the secondary link, using overlay networks with
a third party mapping the site overlays to each other.

The capacity requirements of the links between sites is driven by
application behavior. If the link latency is too high, certain
applications that use a large number of small packets, for example RPC
calls, may encounter issues communicating with each other or operating
properly. Additionally, OpenStack may encounter similar types of issues.
To mitigate this, Identity service call timeouts can be tuned to prevent
issues authenticating against a central Identity service.

Another network capacity consideration for a multi-site deployment is
the amount and performance of overlay networks available for project
networks. If using shared project networks across zones, it is imperative
that an external overlay manager or controller be used to map these
overlays together. It is necessary to ensure the amount of possible IDs
between the zones are identical.

.. note::

   As of the Kilo release, OpenStack Networking was not capable of
   managing tunnel IDs across installations. So if one site runs out of
   IDs, but another does not, that project's network is unable to reach
   the other site.

Capacity can take other forms as well. The ability for a region to grow
depends on scaling out the number of available compute nodes. This topic
is covered in greater detail in the section for compute-focused
deployments. However, it may be necessary to grow cells in an individual
region, depending on the size of your cluster and the ratio of virtual
machines per hypervisor.

A third form of capacity comes in the multi-region-capable components of
OpenStack. Centralized Object Storage is capable of serving objects
through a single namespace across multiple regions. Since this works by
accessing the object store through swift proxy, it is possible to
overload the proxies. There are two options available to mitigate this
issue:

* Deploy a large number of swift proxies. The drawback is that the
  proxies are not load-balanced and a large file request could
  continually hit the same proxy.

* Add a caching HTTP proxy and load balancer in front of the swift
  proxies. Since swift objects are returned to the requester via HTTP,
  this load balancer would alleviate the load required on the swift
  proxies.

Utilization
~~~~~~~~~~~

While constructing a multi-site OpenStack environment is the goal of
this guide, the real test is whether an application can utilize it.

The Identity service is normally the first interface for OpenStack users
and is required for almost all major operations within OpenStack.
Therefore, it is important that you provide users with a single URL for
Identity service authentication, and document the configuration of
regions within the Identity service. Each of the sites defined in your
installation is considered to be a region in Identity nomenclature. This
is important for the users, as it is required to define the region name
when providing actions to an API endpoint or in the dashboard.

Load balancing is another common issue with multi-site installations.
While it is still possible to run HAproxy instances with
Load-Balancer-as-a-Service, these are defined to a specific region. Some
applications can manage this using internal mechanisms. Other
applications may require the implementation of an external system,
including global services load balancers or anycast-advertised DNS.

Depending on the storage model chosen during site design, storage
replication and availability are also a concern for end-users. If an
application can support regions, then it is possible to keep the object
storage system separated by region. In this case, users who want to have
an object available to more than one region need to perform cross-site
replication. However, with a centralized swift proxy, the user may need
to benchmark the replication timing of the Object Storage back end.
Benchmarking allows the operational staff to provide users with an
understanding of the amount of time required for a stored or modified
object to become available to the entire environment.

Performance
~~~~~~~~~~~

Determining the performance of a multi-site installation involves
considerations that do not come into play in a single-site deployment.
Being a distributed deployment, performance in multi-site deployments
may be affected in certain situations.

Since multi-site systems can be geographically separated, there may be
greater latency or jitter when communicating across regions. This can
especially impact systems like the OpenStack Identity service when
making authentication attempts from regions that do not contain the
centralized Identity implementation. It can also affect applications
which rely on Remote Procedure Call (RPC) for normal operation. An
example of this can be seen in high performance computing workloads.

Storage availability can also be impacted by the architecture of a
multi-site deployment. A centralized Object Storage service requires
more time for an object to be available to instances locally in regions
where the object was not created. Some applications may need to be tuned
to account for this effect. Block Storage does not currently have a
method for replicating data across multiple regions, so applications
that depend on available block storage need to manually cope with this
limitation by creating duplicate block storage entries in each region.

OpenStack components
~~~~~~~~~~~~~~~~~~~~

Most OpenStack installations require a bare minimum set of pieces to
function. These include the OpenStack Identity (keystone) for
authentication, OpenStack Compute (nova) for compute, OpenStack Image
service (glance) for image storage, OpenStack Networking (neutron) for
networking, and potentially an object store in the form of OpenStack
Object Storage (swift). Deploying a multi-site installation also demands
extra components in order to coordinate between regions. A centralized
Identity service is necessary to provide the single authentication
point. A centralized dashboard is also recommended to provide a single
login point and a mapping to the API and CLI options available. A
centralized Object Storage service may also be used, but will require
the installation of the swift proxy service.

It may also be helpful to install a few extra options in order to
facilitate certain use cases. For example, installing Designate may
assist in automatically generating DNS domains for each region with an
automatically-populated zone full of resource records for each instance.
This facilitates using DNS as a mechanism for determining which region
will be selected for certain applications.

Another useful tool for managing a multi-site installation is
Orchestration (heat). The Orchestration service allows the use of
templates to define a set of instances to be launched together or for
scaling existing sets. It can also be used to set up matching or
differentiated groupings based on regions. For instance, if an
application requires an equally balanced number of nodes across sites,
the same heat template can be used to cover each site with small
alterations to only the region name.
