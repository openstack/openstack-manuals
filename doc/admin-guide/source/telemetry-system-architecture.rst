.. _telemetry-system-architecture:

===================
System architecture
===================

The Telemetry service uses an agent-based architecture. Several modules
combine their responsibilities to collect data, store samples in a
database, or provide an API service for handling incoming requests.

The Telemetry service is built from the following agents and services:

ceilometer-api (deprecated in Ocata)
    Presents aggregated metering data to consumers (such as billing
    engines and analytics tools). Alarm, Meter and Event APIs are now handled
    by aodh, gnocchi, and panko services respectively.

ceilometer-polling
    Polls for different kinds of meter data by using the polling
    plug-ins (pollsters) registered in different namespaces. It provides a
    single polling interface across different namespaces. The ``compute``
    namespace polls the local hypervisor to acquire performance data of local
    instances. The ``central`` namespace polls the public RESTful APIs of other
    OpenStack services such as Compute service and Image service. The ``ipmi``
    namespace polls the local node with IPMI support, in order to acquire IPMI
    sensor data and Intel Node Manager datahost-level information.

ceilometer-agent-notification
    Consumes AMQP messages from other OpenStack services, normalizes messages,
    and publishes them to configured targets.

ceilometer-collector (deprecated in Ocata)
    Consumes AMQP notifications from the agents, then dispatches these
    data to the appropriate data store.

    .. note::

       1. The ``ceilometer-polling`` service provides polling support on any
          namespace but many distributions continue to provide namespace-scoped
          agents: ``ceilometer-agent-central``, ``ceilometer-agent-compute``,
          and ``ceilometer-agent-ipmi``.

       2. The ``ceilometer-api`` and ``ceilometer-collector`` are no longer
          supported since the Ocata release. Storage and API are provided by
          gnocchi, aodh, and panko services.

Except for the ``ceilometer-polling`` agents polling the ``compute`` or
``ipmi`` namespaces, all the other services are placed on one or more
controller nodes.

The Telemetry architecture highly depends on the AMQP service both for
consuming notifications coming from OpenStack services and internal
communication.


.. _telemetry-supported-databases:

Supported databases
~~~~~~~~~~~~~~~~~~~

The other key external component of Telemetry is the database, where
events, samples, alarm definitions, and alarms are stored. Each of the data
models have their own storage service and each support various back ends.

The list of supported base back ends for measurements:

-  `gnocchi <http://gnocchi.xyz/>`__


The list of supported base back ends for alarms:

-  `MySQL <http://www.mysql.com/>`__

-  `PostgreSQL <http://www.postgresql.org/>`__


The list of supported base back ends for events:

-  `ElasticSearch <https://www.elastic.co/>`__

-  `MongoDB <https://www.mongodb.org/>`__

-  `MySQL <http://www.mysql.com/>`__

-  `PostgreSQL <http://www.postgresql.org/>`__

-  `HBase <http://hbase.apache.org/>`__


.. _telemetry-supported-hypervisors:

Supported hypervisors
~~~~~~~~~~~~~~~~~~~~~

The Telemetry service collects information about the virtual machines,
which requires close connection to the hypervisor that runs on the
compute hosts.

The following is a list of supported hypervisors.

-  The following hypervisors are supported via `libvirt <http://libvirt.org/>`__

   *  `Kernel-based Virtual Machine (KVM) <http://www.linux-kvm.org/page/Main_Page>`__

   *  `Quick Emulator (QEMU) <http://wiki.qemu.org/Main_Page>`__

   *  `Linux Containers (LXC) <https://linuxcontainers.org/>`__

   *  `User-mode Linux (UML) <http://user-mode-linux.sourceforge.net/>`__

   .. note::

      For details about hypervisor support in libvirt please check the
      `Libvirt API support matrix <http://libvirt.org/hvsupport.html>`__.

-  `Hyper-V <http://www.microsoft.com/en-us/server-cloud/hyper-v-server/default.aspx>`__

-  `XEN <http://www.xenproject.org/help/documentation.html>`__

-  `VMware vSphere <https://www.vmware.com/support/vsphere-hypervisor.html>`__


Supported networking services
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Telemetry is able to retrieve information from OpenStack Networking and
external networking services:

-  OpenStack Networking:

   -  Basic network meters

   -  Firewall-as-a-Service (FWaaS) meters

   -  Load-Balancer-as-a-Service (LBaaS) meters

   -  VPN-as-a-Service (VPNaaS) meters

-  SDN controller meters:

   -  `OpenDaylight <https://www.opendaylight.org/>`__

   -  `OpenContrail <http://www.opencontrail.org/>`__


.. _telemetry-users-roles-projects:

Users, roles, and projects
~~~~~~~~~~~~~~~~~~~~~~~~~~

This service of OpenStack uses OpenStack Identity for authenticating and
authorizing users. The required configuration options are listed in the
`Telemetry section
<https://docs.openstack.org/ocata/config-reference/telemetry.html>`__ in the
OpenStack Configuration Reference. Alternatively, gnocchi can be configured
without authentication to minimize overhead.

The system uses two roles:``admin`` and ``non-admin``. The authorization
happens before processing each API request. The amount of returned data
depends on the role the requestor owns.

The creation of alarm definitions also highly depends on the role of the
user, who initiated the action. Further details about :ref:`telemetry-alarms`
handling can be found in this guide.
