====================
Desktop-as-a-Service
====================

Virtual Desktop Infrastructure (VDI) is a service that hosts
user desktop environments on remote servers. This application
is very sensitive to network latency and requires a high
performance compute environment. Traditionally these types of
services do not use cloud environments because few clouds
support such a demanding workload for user-facing applications.
As cloud environments become more robust, vendors are starting
to provide services that provide virtual desktops in the cloud.
OpenStack may soon provide the infrastructure for these types of deployments.

Challenges
~~~~~~~~~~

Designing an infrastructure that is suitable to host virtual
desktops is a very different task to that of most virtual workloads.
For example, the design must consider:

* Boot storms, when a high volume of logins occur in a short period of time
* The performance of the applications running on virtual desktops
* Operating systems and their compatibility with the OpenStack hypervisor

Broker
~~~~~~

The connection broker determines which remote desktop host
users can access. Medium and large scale environments require a broker
since its service represents a central component of the architecture.
The broker is a complete management product, and enables automated
deployment and provisioning of remote desktop hosts.

Possible solutions
~~~~~~~~~~~~~~~~~~

There are a number of commercial products currently available that
provide a broker solution. However, no native OpenStack projects
provide broker services.
Not providing a broker is also an option, but managing this manually
would not suffice for a large scale, enterprise solution.

Diagram
~~~~~~~

.. figure:: figures/Specialized_VDI1.png
