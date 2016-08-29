Methodology
~~~~~~~~~~~

The best way to design your cloud architecture is through creating and
testing use cases. Planning for applications that support thousands of
sessions per second, variable workloads, and complex, changing data,
requires you to identify the key meters. Identifying these key meters,
such as number of concurrent transactions per second, and size of
database, makes it possible to build a method for testing your
assumptions.

Use a functional user scenario to develop test cases, and to measure
overall project trajectory.

.. note::

   If you do not want to use an application to develop user
   requirements automatically, you need to create requirements to build
   test harnesses and develop usable meters.

Establishing these meters allows you to respond to changes quickly
without having to set exact requirements in advance. This creates ways
to configure the system, rather than redesigning it every time there is
a requirements change.

.. important::

   It is important to limit scope creep. Ensure you address tool
   limitations, but do not recreate the entire suite of tools. Work
   with technical product owners to establish critical features that
   are needed for a successful cloud deployment.

Application cloud readiness
---------------------------

The cloud does more than host virtual machines and their applications.
This *lift and shift* approach works in certain situations, but there is
a fundamental difference between clouds and traditional bare-metal-based
environments, or even traditional virtualized environments.

In traditional environments, with traditional enterprise applications,
the applications and the servers that run on them are *pets*. They are
lovingly crafted and cared for, the servers have names like Gandalf or
Tardis, and if they get sick someone nurses them back to health. All of
this is designed so that the application does not experience an outage.

In cloud environments, servers are more like cattle. There are thousands
of them, they get names like NY-1138-Q, and if they get sick, they get
put down and a sysadmin installs another one. Traditional applications
that are unprepared for this kind of environment may suffer outages,
loss of data, or complete failure.

There are other reasons to design applications with the cloud in mind.
Some are defensive, such as the fact that because applications cannot be
certain of exactly where or on what hardware they will be launched, they
need to be flexible, or at least adaptable. Others are proactive. For
example, one of the advantages of using the cloud is scalability.
Applications need to be designed in such a way that they can take
advantage of these and other opportunities.

Determining whether an application is cloud-ready
-------------------------------------------------

There are several factors to take into consideration when looking at
whether an application is a good fit for the cloud.

Structure
 A large, monolithic, single-tiered, legacy application typically is
 not a good fit for the cloud. Efficiencies are gained when load can
 be spread over several instances, so that a failure in one part of
 the system can be mitigated without affecting other parts of the
 system, or so that scaling can take place where the app needs it.

Dependencies
 Applications that depend on specific hardware, such as a particular
 chip set or an external device such as a fingerprint reader, might
 not be a good fit for the cloud, unless those dependencies are
 specifically addressed. Similarly, if an application depends on an
 operating system or set of libraries that cannot be used in the
 cloud, or cannot be virtualized, that is a problem.

Connectivity
 Self-contained applications, or those that depend on resources that
 are not reachable by the cloud in question, will not run. In some
 situations, you can work around these issues with custom network
 setup, but how well this works depends on the chosen cloud
 environment.

Durability and resilience
 Despite the existence of SLAs, things break: servers go down,
 network connections are disrupted, or too many projects on a server
 make a server unusable. An application must be sturdy enough to
 contend with these issues.

Designing for the cloud
-----------------------

Here are some guidelines to keep in mind when designing an application
for the cloud:

*  Be a pessimist: Assume everything fails and design backwards.

*  Put your eggs in multiple baskets: Leverage multiple providers,
   geographic regions and availability zones to accommodate for local
   availability issues. Design for portability.

*  Think efficiency: Inefficient designs will not scale. Efficient
   designs become cheaper as they scale. Kill off unneeded components or
   capacity.

*  Be paranoid: Design for defense in depth and zero tolerance by
   building in security at every level and between every component.
   Trust no one.

*  But not too paranoid: Not every application needs the platinum
   solution. Architect for different SLA's, service tiers, and security
   levels.

*  Manage the data: Data is usually the most inflexible and complex area
   of a cloud and cloud integration architecture. Do not short change
   the effort in analyzing and addressing data needs.

*  Hands off: Leverage automation to increase consistency and quality
   and reduce response times.

*  Divide and conquer: Pursue partitioning and parallel layering
   wherever possible. Make components as small and portable as possible.
   Use load balancing between layers.

*  Think elasticity: Increasing resources should result in a
   proportional increase in performance and scalability. Decreasing
   resources should have the opposite effect.

*  Be dynamic: Enable dynamic configuration changes such as auto
   scaling, failure recovery and resource discovery to adapt to changing
   environments, faults, and workload volumes.

*  Stay close: Reduce latency by moving highly interactive components
   and data near each other.

*  Keep it loose: Loose coupling, service interfaces, separation of
   concerns, abstraction, and well defined API's deliver flexibility.

*  Be cost aware: Autoscaling, data transmission, virtual software
   licenses, reserved instances, and similar costs can rapidly increase
   monthly usage charges. Monitor usage closely.
