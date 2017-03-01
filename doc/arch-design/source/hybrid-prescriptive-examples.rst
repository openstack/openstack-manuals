=====================
Prescriptive examples
=====================

Hybrid cloud environments are designed for these use cases:

* Bursting workloads from private to public OpenStack clouds
* Bursting workloads from private to public non-OpenStack clouds
* High availability across clouds (for technical diversity)

This chapter provides examples of environments that address
each of these use cases.

Bursting to a public OpenStack cloud
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Company A's data center is running low on capacity.
It is not possible to expand the data center in the foreseeable future.
In order to accommodate the continuously growing need for
development resources in the organization,
Company A decides to use resources in the public cloud.

Company A has an established data center with a substantial amount
of hardware. Migrating the workloads to a public cloud is not feasible.

The company has an internal cloud management platform that directs
requests to the appropriate cloud, depending on the local capacity.
This is a custom in-house application written for this specific purpose.

This solution is depicted in the figure below:

.. figure:: figures/Multi-Cloud_Priv-Pub3.png
   :width: 100%

This example shows two clouds with a Cloud Management
Platform (CMP) connecting them. This guide does not
discuss a specific CMP, but describes how the Orchestration and
Telemetry services handle, manage, and control workloads.

The private OpenStack cloud has at least one controller and at least
one compute node. It includes metering using the Telemetry service.
The Telemetry service captures the load increase and the CMP
processes the information.  If there is available capacity,
the CMP uses the OpenStack API to call the Orchestration service.
This creates instances on the private cloud in response to user requests.
When capacity is not available on the private cloud, the CMP issues
a request to the Orchestration service API of the public cloud.
This creates the instance on the public cloud.

In this example, Company A does not direct the deployments to an
external public cloud due to concerns regarding resource control,
security, and increased operational expense.

Bursting to a public non-OpenStack cloud
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The second example examines bursting workloads from the private cloud
into a non-OpenStack public cloud using Amazon Web Services (AWS)
to take advantage of additional capacity and to scale applications.

The following diagram demonstrates an OpenStack-to-AWS hybrid cloud:

.. figure:: figures/Multi-Cloud_Priv-AWS4.png
   :width: 100%

Company B states that its developers are already using AWS
and do not want to change to a different provider.

If the CMP is capable of connecting to an external cloud
provider with an appropriate API, the workflow process remains
the same as the previous scenario.
The actions the CMP takes, such as monitoring loads and
creating new instances, stay the same.
However, the CMP performs actions in the public cloud
using applicable API calls.

If the public cloud is AWS, the CMP would use the
EC2 API to create a new instance and assign an Elastic IP.
It can then add that IP to HAProxy in the private cloud.
The CMP can also reference AWS-specific
tools such as CloudWatch and CloudFormation.

Several open source tool kits for building CMPs are
available and can handle this kind of translation.
Examples include ManageIQ, jClouds, and JumpGate.

High availability and disaster recovery
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Company C requires their local data center to be able to
recover from failure.  Some of the workloads currently in
use are running on their private OpenStack cloud.
Protecting the data involves Block Storage, Object Storage,
and a database. The architecture supports the failure of
large components of the system while ensuring that the
system continues to deliver services.
While the services remain available to users, the failed
components are restored in the background based on standard
best practice data replication policies.
To achieve these objectives, Company C replicates data to
a second cloud in a geographically distant location.
The following diagram describes this system:

.. figure:: figures/Multi-Cloud_failover2.png
   :width: 100%

This example includes two private OpenStack clouds connected with a CMP.
The source cloud, OpenStack Cloud 1, includes a controller and
at least one instance running MySQL. It also includes at least
one Block Storage volume and one Object Storage volume.
This means that data is available to the users at all times.
The details of the method for protecting each of these sources
of data differs.

Object Storage relies on the replication capabilities of
the Object Storage provider.
Company C enables OpenStack Object Storage so that it creates
geographically separated replicas that take advantage of this feature.
The company configures storage so that at least one replica
exists in each cloud. In order to make this work, the company
configures a single array spanning both clouds with OpenStack Identity.
Using Federated Identity, the array talks to both clouds, communicating
with OpenStack Object Storage through the Swift proxy.

For Block Storage, the replication is a little more difficult,
and involves tools outside of OpenStack itself.
The OpenStack Block Storage volume is not set as the drive itself
but as a logical object that points to a physical back end.
Disaster recovery is configured for Block Storage for
synchronous backup for the highest level of data protection,
but asynchronous backup could have been set as an alternative
that is not as latency sensitive.
For asynchronous backup, the Block Storage API makes it possible
to export the data and also the metadata of a particular volume,
so that it can be moved and replicated elsewhere.
More information can be found here:
`Add volume metadata support to Cinder backup
<https://blueprints.launchpad.net/cinder/+spec/cinder-backup-volume-metadata-support>`_.

The synchronous backups create an identical volume in both
clouds and chooses the appropriate flavor so that each cloud
has an identical back end. This is done by creating volumes
through the CMP. After this is configured, a solution
involving DRDB synchronizes the physical drives.

The database component is backed up using synchronous backups.
MySQL does not support geographically diverse replication,
so disaster recovery is provided by replicating the file itself.
As it is not possible to use Object Storage as the back end of
a database like MySQL, Swift replication is not an option.
Company C decides not to store the data on another geo-tiered
storage system, such as Ceph, as Block Storage.
This would have given another layer of protection.
Another option would have been to store the database on an OpenStack
Block Storage volume and backing it up like any other Block Storage.
