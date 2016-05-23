========================
Multi-hypervisor example
========================

A financial company requires its applications migrated
from a traditional, virtualized environment to an API driven,
orchestrated environment. The new environment needs
multiple hypervisors since many of the company's applications
have strict hypervisor requirements.

Currently, the company's vSphere environment runs 20 VMware
ESXi hypervisors. These hypervisors support 300 instances of
various sizes. Approximately 50 of these instances must run
on ESXi. The remaining 250 or so have more flexible requirements.

The financial company decides to manage the
overall system with a common OpenStack platform.

.. figure:: figures/Compute_NSX.png
   :width: 100%

Architecture planning teams decided to run a host aggregate
containing KVM hypervisors for the general purpose instances.
A separate host aggregate targets instances requiring ESXi.

Images in the OpenStack Image service have particular
hypervisor metadata attached. When a user requests a
certain image, the instance spawns on the relevant aggregate.

Images for ESXi use the VMDK format. You can convert
QEMU disk images to VMDK, VMFS Flat Disks. These disk images
can also be thin, thick, zeroed-thick, and eager-zeroed-thick.
After exporting a VMFS thin disk from VMFS to the
OpenStack Image service (a non-VMFS location), it becomes a
preallocated flat disk. This impacts the transfer time from the
OpenStack Image service to the data store since transfers require
moving the full preallocated flat disk rather than the thin disk.

The VMware host aggregate compute nodes communicate with
vCenter rather than spawning directly on a hypervisor.
The vCenter then requests scheduling for the instance to run on
an ESXi hypervisor.

This functionality requires that VMware Distributed Resource
Scheduler (DRS) is enabled on a cluster and set to **Fully Automated**.
The vSphere requires shared storage because the DRS uses vMotion
which is a service that relies on shared storage.

This solution to the company's migration uses shared storage
to provide Block Storage capabilities to the KVM instances while
also providing vSphere storage. The new environment provides this
storage functionality using a dedicated data network. The
compute hosts should have dedicated NICs to support the
dedicated data network. vSphere supports OpenStack Block Storage. This
support gives storage from a VMFS datastore to an instance. For the
financial company, Block Storage in their new architecture supports
both hypervisors.

OpenStack Networking provides network connectivity in this new
architecture, with the VMware NSX plug-in driver configured. legacy
networking (nova-network) supports both hypervisors in this new
architecture example, but has limitations. Specifically, vSphere
with legacy networking does not support security groups. The new
architecture uses VMware NSX as a part of the design. When users launch an
instance within either of the host aggregates, VMware NSX ensures the
instance attaches to the appropriate network overlay-based logical networks.

The architecture planning teams also consider OpenStack Compute integration.
When running vSphere in an OpenStack environment, nova-compute
communications with vCenter appear as a single large hypervisor.
This hypervisor represents the entire ESXi cluster. Multiple nova-compute
instances can represent multiple ESXi clusters. They can connect to
multiple vCenter servers. If the process running nova-compute
crashes it cuts the connection to the vCenter server.
Any ESXi clusters will stop running, and you will not be able to
provision further instances on the vCenter, even if you enable high
availability. You must monitor the nova-compute service connected
to vSphere carefully for any disruptions as a result of this failure point.
