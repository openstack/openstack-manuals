=============================
EMC VMAX iSCSI and FC drivers
=============================

The EMC VMAX drivers, ``EMCVMAXISCSIDriver`` and ``EMCVMAXFCDriver``, support
the use of EMC VMAX storage arrays with Block Storage. They both provide
equivalent functions and differ only in support for their respective host
attachment methods.

The drivers perform volume operations by communicating with the back-end VMAX
storage. It uses a CIM client in Python called ``PyWBEM`` to perform CIM
operations over HTTP.

The EMC CIM Object Manager (ECOM) is packaged with the EMC SMI-S provider. It
is a CIM server that enables CIM clients to perform CIM operations over HTTP by
using SMI-S in the back end for VMAX storage operations.

The EMC SMI-S Provider supports the SNIA Storage Management Initiative (SMI),
an ANSI standard for storage management. It supports the VMAX storage system.

System requirements
~~~~~~~~~~~~~~~~~~~

The Cinder driver supports both VMAX-2 and VMAX-3 series.

For VMAX-2 series, minimum SMI-S version V4.6.2.29 is required.

For VMAX-3 series, Solutions Enabler 8.1.2 is required. However,
this version is compatible with VMAX-2 series also.

Note: For Mitaka, Solutions Enabler 8.2 and greater have not yet been
qualified for VMAX-2 or VMAX-3 series.

You can download SMI-S from the EMC's support web site (login is required).
See the EMC SMI-S Provider release notes for installation instructions.

Ensure that there is only one SMI-S (ECOM) server active on the same VMAX
array.


Required VMAX Software Suites for OpenStack
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There are five Software Suites available for the VMAX3:

- Base Suite
- Advanced Suite
- Local Replication Suite
- Remote Replication Suite
- Total Productivity Pack

Openstack requires the Advanced Suite and the Local Replication Suite
or the Total Productivity Pack (it includes the Advanced Suite and the
Local Replication Suite) for the VMAX3.

There are four bundled Software Suites for the VMAX2:

- Advanced Software Suite
- Base Software Suite
- Enginuity Suite
- Symmetrix Management Suite

OpenStack requires the Advanced Software Bundle for the VMAX2.

or

The VMAX2 Optional Software are:

- EMC Storage Analytics (ESA)
- FAST VP
- Ionix ControlCenter and ProSphere Package
- Open Replicator for Symmetrix
- PowerPath
- RecoverPoint EX
- SRDF for VMAX 10K
- Storage Configuration Advisor
- TimeFinder for VMAX10K

OpenStack requires TimeFinder for VMAX10K for the VMAX2.

Each are licensed separately. For further details on how to get the
relevant license(s), reference eLicensing Support below.


eLicensing Support
~~~~~~~~~~~~~~~~~~

To activate your entitlements and obtain your VMAX license files, visit the
Service Center on `<https://support.emc.com>`_, as directed on your License
Authorization Code (LAC) letter emailed to you.

-  For help with missing or incorrect entitlements after activation
   (that is, expected functionality remains unavailable because it is not
   licensed), contact your EMC account representative or authorized reseller.

-  For help with any errors applying license files through Solutions Enabler,
   contact the EMC Customer Support Center.

-  If you are missing a LAC letter or require further instructions on
   activating your licenses through the Online Support site, contact EMC's
   worldwide Licensing team at ``licensing@emc.com`` or call:

   North America, Latin America, APJK, Australia, New Zealand: SVC4EMC
   (800-782-4362) and follow the voice prompts.

   EMEA: +353 (0) 21 4879862 and follow the voice prompts.


Supported operations
~~~~~~~~~~~~~~~~~~~~

VMAX drivers support these operations:

-  Create, delete, attach, and detach volumes.
-  Create, list, and delete volume snapshots.
-  Copy an image to a volume.
-  Copy a volume to an image.
-  Clone a volume.
-  Extend a volume.
-  Retype a volume.
-  Create a volume from a snapshot.
-  Create and delete consistency groups.
-  Create and delete consistency group snapshots.
-  Modify consistency groups (add/remove volumes).

VMAX drivers also support the following features:
-  Dynamic masking view creation.
-  Dynamic determination of the target iSCSI IP address.

VMAX2
-  FAST automated storage tiering policy.
-  Striped volume creation.

VMAX3
-  SLO support.
-  Dynamic masking view creation.
-  SnapVX support.
-  Extend volume and iSCSI support.


Set up the VMAX drivers
~~~~~~~~~~~~~~~~~~~~~~~

#. Install the ``python-pywbem`` package for your distribution.

   -  On Ubuntu:

      .. code-block:: console

         # apt-get install python-pywbem

   -  On openSUSE:

      .. code-block:: console

         # zypper install python-pywbem

   -  On Red Hat Enterprise Linux, CentOS, and Fedora:

      .. code-block:: console

         # yum install pywbem

#. Install iSCSI Utilities (for iSCSI drivers only).

   #. Download and configure the Cinder node as an iSCSI initiator.
   #. Install the ``open-iscsi`` package.

      -  On Ubuntu:

         .. code-block:: console

            # apt-get install open-iscsi

      -  On openSUSE:

         .. code-block:: console

            # zypper install open-iscsi

      -  On Red Hat Enterprise Linux, CentOS, and Fedora:

         .. code-block:: console

            # yum install scsi-target-utils.x86_64

   #. Enable the iSCSI driver to start automatically.

#. Download SMI-S from ``support.emc.com`` and install it. Add your VMAX arrays
   to SMI-S.

   You can install SMI-S on a non-OpenStack host. Supported platforms include
   different flavors of Windows, Red Hat, and SUSE Linux. SMI-S can be
   installed on a physical server or a VM hosted by an ESX server. Note that
   the supported hypervisor for a VM running SMI-S is ESX only. See the EMC
   SMI-S Provider release notes for more information on supported platforms and
   installation instructions.

   .. note::

      You must discover storage arrays on the SMI-S server before you can use
      the VMAX drivers. Follow instructions in the SMI-S release notes.

   SMI-S is usually installed at ``/opt/emc/ECIM/ECOM/bin`` on Linux and
   ``C:\Program Files\EMC\ECIM\ECOM\bin`` on Windows. After you install and
   configure SMI-S, go to that directory and type ``TestSmiProvider.exe``
   for windows and ``./TestSmiProvider`` for linux

   Use ``addsys`` in ``TestSmiProvider`` to add an array. Use ``dv`` and
   examine the output after the array is added. Make sure that the arrays are
   recognized by the SMI-S server before using the EMC VMAX drivers.

#. Configure Block Storage

   Add the following entries to ``/etc/cinder/cinder.conf``:

   .. code-block:: ini

      enabled_backends = CONF_GROUP_ISCSI, CONF_GROUP_FC

      [CONF_GROUP_ISCSI]
      volume_driver = cinder.volume.drivers.emc.emc_vmax_iscsi.EMCVMAXISCSIDriver
      cinder_emc_config_file = /etc/cinder/cinder_emc_config_CONF_GROUP_ISCSI.xml
      volume_backend_name = ISCSI_backend

      [CONF_GROUP_FC]
      volume_driver = cinder.volume.drivers.emc.emc_vmax_fc.EMCVMAXFCDriver
      cinder_emc_config_file = /etc/cinder/cinder_emc_config_CONF_GROUP_FC.xml
      volume_backend_name = FC_backend

   In this example, two back-end configuration groups are enabled:
   ``CONF_GROUP_ISCSI`` and ``CONF_GROUP_FC``. Each configuration group has a
   section describing unique parameters for connections, drivers, the
   ``volume_backend_name``, and the name of the EMC-specific configuration file
   containing additional settings. Note that the file name is in the format
   ``/etc/cinder/cinder_emc_config_[confGroup].xml``.

   Once the ``cinder.conf`` and EMC-specific configuration files have been
   created, :command:`cinder` commands need to be issued in order to create and
   associate OpenStack volume types with the declared ``volume_backend_names``:

   .. code-block:: console

      $ cinder type-create VMAX_ISCSI
      $ cinder type-key VMAX_ISCSI set volume_backend_name=ISCSI_backend
      $ cinder type-create VMAX_FC
      $ cinder type-key VMAX_FC set volume_backend_name=FC_backend

   By issuing these commands, the Block Storage volume type ``VMAX_ISCSI`` is
   associated with the ``ISCSI_backend``, and the type ``VMAX_FC`` is
   associated with the ``FC_backend``.


   Create the ``/etc/cinder/cinder_emc_config_CONF_GROUP_ISCSI.xml`` file.
   You do not need to restart the service for this change.

   Add the following lines to the XML file:

   VMAX2
     .. code-block:: xml

       <?xml version="1.0" encoding="UTF-8" ?>
       <EMC>
         <EcomServerIp>1.1.1.1</EcomServerIp>
         <EcomServerPort>00</EcomServerPort>
         <EcomUserName>user1</EcomUserName>
         <EcomPassword>password1</EcomPassword>
         <PortGroups>
           <PortGroup>OS-PORTGROUP1-PG</PortGroup>
           <PortGroup>OS-PORTGROUP2-PG</PortGroup>
         </PortGroups>
         <Array>111111111111</Array>
         <Pool>FC_GOLD1</Pool>
         <FastPolicy>GOLD1</FastPolicy>
       </EMC>

   VMAX3
     .. code-block:: xml

       <?xml version="1.0" encoding="UTF-8" ?>
       <EMC>
         <EcomServerIp>1.1.1.1</EcomServerIp>
         <EcomServerPort>00</EcomServerPort>
         <EcomUserName>user1</EcomUserName>
         <EcomPassword>password1</EcomPassword>
         <PortGroups>
           <PortGroup>OS-PORTGROUP1-PG</PortGroup>
           <PortGroup>OS-PORTGROUP2-PG</PortGroup>
         </PortGroups>
         <Array>111111111111</Array>
         <Pool>SRP_1</Pool>
         <Slo>Gold</Slo>
         <Workload>OLTP</Workload>
       </EMC>

   Where:

``EcomServerIp``
    IP address of the ECOM server which is packaged with SMI-S.

``EcomServerPort``
    Port number of the ECOM server which is packaged with SMI-S.

``EcomUserName`` and ``EcomPassword``
    Cedentials for the ECOM server.

``PortGroups``
    Supplies the names of VMAX port groups that have been pre-configured to
    expose volumes managed by this backend. Each supplied port group should
    have sufficient number and distribution of ports (across directors and
    switches) as to ensure adequate bandwidth and failure protection for the
    volume connections. PortGroups can contain one or more port groups of
    either iSCSI or FC ports. When a dynamic masking view is created by the
    VMAX driver, the port group is chosen randomly from the PortGroup list, to
    evenly distribute load across the set of groups provided. Make sure that
    the PortGroups set contains either all FC or all iSCSI port groups (for a
    given back end), as appropriate for the configured driver (iSCSI or FC).

``Array``
    Unique VMAX array serial number.

``Pool``
    Unique pool name within a given array. For back ends not using FAST
    automated tiering, the pool is a single pool that has been created by the
    administrator. For back ends exposing FAST policy automated tiering, the
    pool is the bind pool to be used with the FAST policy.

``VMAX2 FastPolicy``
    Name of the FAST Policy to be used. By including this tag, volumes managed
    by this back end are treated as under FAST control. Omitting the
    ``FastPolicy`` tag means FAST is not enabled on the provided storage pool.

``VMAX3 Slo``
    The Service Level Objective (SLO) that manages the underlying storage to
    provide expected performance. Omitting the ``Slo`` tag means ``Optimised``
    SLO will be used instead.

``VMAX3 Workload``
    When a workload type is added, the latency range is reduced due to the
    added information. Omitting the ``Workload`` tag means the latency
    range will be the widest for its SLO type.

FC Zoning with VMAX
~~~~~~~~~~~~~~~~~~~

Zone Manager is recommended when using the VMAX FC driver, especially for
larger configurations where pre-zoning would be too complex and open-zoning
would raise security concerns.

iSCSI with VMAX
~~~~~~~~~~~~~~~

-  Make sure the ``iscsi-initiator-utils`` package is installed on the host.

-  Verify host is able to ping VMAX iSCSI target ports.

VMAX masking view and group naming info
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Masking view names
------------------

Masking views are dynamically created by the VMAX FC and iSCSI drivers using
the following naming conventions:

.. code-block:: none

   OS-[shortHostName]-[poolName]-I-MV (for Masking Views using iSCSI)
   OS-[shortHostName]-[poolName]-F-MV (for Masking Views using FC)
   or
   OS-[shortHostName]-[fastPolicy]-I-MV (where FAST policy is used)
   OS-[shortHostName]-[fastPolicy]-F-MV (where FAST policy is used)

Initiator group names
---------------------

For each host that is attached to VMAX volumes using the drivers, an initiator
group is created or re-used (per attachment type). All initiators of the
appropriate type known for that host are included in the group. At each new
attach volume operation, the VMAX driver retrieves the initiators (either WWNNs
or IQNs) from OpenStack and adds or updates the contents of the Initiator Group
as required. Names are of the following format:

.. code-block:: none

   OS-[shortHostName]-I-IG (for iSCSI initiators)
   OS-[shortHostName]-F-IG (for Fibre Channel initiators)

.. note::

   Hosts attaching to OpenStack managed VMAX storage cannot also attach to
   storage on the same VMAX that are not managed by OpenStack.

FA port groups
--------------

VMAX array FA ports to be used in a new masking view are chosen from the list
provided in the EMC configuration file.

Storage group names
-------------------

As volumes are attached to a host, they are either added to an existing storage
group (if it exists) or a new storage group is created and the volume is then
added. Storage groups contain volumes created from a pool (either single-pool
or FAST-controlled), attached to a single host, over a single connection type
(iSCSI or FC). Names are formed:

.. code-block:: none

   OS-[shortHostName]-[poolName]-I-SG (attached over iSCSI)
   OS-[shortHostName]-[poolName]-F-SG (attached over Fibre Channel
   or
   OS-[shortHostName]-[fastPolicy]-I-SG (where FAST policy is used)
   OS-[shortHostName]-[fastPolicy]-F-SG (where FAST policy is used)

VMAX2 concatenated or striped volumes
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In order to support later expansion of created volumes, the VMAX Block Storage
drivers create concatenated volumes as the default layout. If later expansion
is not required, users can opt to create striped volumes in order to optimize
I/O performance.

Below is an example of how to create striped volumes. First, create a volume
type. Then define the extra spec for the volume type
``storagetype:stripecount`` representing the number of meta members in the
striped volume. The example below means that each volume created under the
``GoldStriped`` volume type will be striped and made up of 4 meta members.

.. code-block:: console

   $ cinder type-create GoldStriped
   $ cinder type-key GoldStriped set volume_backend_name=GOLD_BACKEND
   $ cinder type-key GoldStriped set storagetype:stripecount=4
