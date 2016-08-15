Technical considerations
~~~~~~~~~~~~~~~~~~~~~~~~

Some of the key technical considerations that are critical to a
storage-focused OpenStack design architecture include:

Input-Output requirements
 Input-Output performance requirements require researching and
 modeling before deciding on a final storage framework. Running
 benchmarks for Input-Output performance provides a baseline for
 expected performance levels. If these tests include details, then
 the resulting data can help model behavior and results during
 different workloads. Running scripted smaller benchmarks during the
 lifecycle of the architecture helps record the system health at
 different points in time. The data from these scripted benchmarks
 assist in future scoping and gaining a deeper understanding of an
 organization's needs.

Scale
 Scaling storage solutions in a storage-focused OpenStack
 architecture design is driven by initial requirements, including
 :term:`IOPS <Input/output Operations Per Second (IOPS)>`, capacity,
 bandwidth, and future needs. Planning capacity based on projected
 needs over the course of a budget cycle is important for a design.
 The architecture should balance cost and capacity, while also allowing
 flexibility to implement new technologies and methods as they become
 available.

Security
 Designing security around data has multiple points of focus that
 vary depending on SLAs, legal requirements, industry regulations,
 and certifications needed for systems or people. Consider compliance
 with HIPPA, ISO9000, and SOX based on the type of data. For certain
 organizations, multiple levels of access control are important.

OpenStack compatibility
 Interoperability and integration with OpenStack can be paramount in
 deciding on a storage hardware and storage management platform.
 Interoperability and integration includes factors such as OpenStack
 Block Storage interoperability, OpenStack Object Storage
 compatibility, and hypervisor compatibility (which affects the
 ability to use storage for ephemeral instance storage).

Storage management
 You must address a range of storage management-related
 considerations in the design of a storage-focused OpenStack cloud.
 These considerations include, but are not limited to, backup
 strategy (and restore strategy, since a backup that cannot be
 restored is useless), data valuation-hierarchical storage
 management, retention strategy, data placement, and workflow
 automation.

Data grids
 Data grids are helpful when answering questions around data
 valuation. Data grids improve decision making through correlation of
 access patterns, ownership, and business-unit revenue with other
 metadata values to deliver actionable information about data.

When building a storage-focused OpenStack architecture, strive to build
a flexible design based on an industry standard core. One way of
accomplishing this might be through the use of different back ends
serving different use cases.
