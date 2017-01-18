.. _telemetry-measurements:

============
Measurements
============

The Telemetry service collects meters within an OpenStack deployment.
This section provides a brief summary about meters format and origin and
also contains the list of available meters.

Telemetry collects meters by polling the infrastructure elements and
also by consuming the notifications emitted by other OpenStack services.
For more information about the polling mechanism and notifications see
:ref:`telemetry-data-collection`. There are several meters which are collected
by polling and by consuming. The origin for each meter is listed in the tables
below.

.. note::

   You may need to configure Telemetry or other OpenStack services in
   order to be able to collect all the samples you need. For further
   information about configuration requirements see the `Telemetry chapter
   <http://docs.openstack.org/project-install-guide/telemetry/newton/>`__
   in the Installation Tutorials and Guides. Also check the `Telemetry manual
   installation <http://docs.openstack.org/developer/ceilometer/install/manual.html>`__
   description.

Telemetry uses the following meter types:

+--------------+--------------------------------------------------------------+
| Type         | Description                                                  |
+==============+==============================================================+
| Cumulative   | Increasing over time (instance hours)                        |
+--------------+--------------------------------------------------------------+
| Delta        | Changing over time (bandwidth)                               |
+--------------+--------------------------------------------------------------+
| Gauge        | Discrete items (floating IPs, image uploads) and fluctuating |
|              | values (disk I/O)                                            |
+--------------+--------------------------------------------------------------+

|

Telemetry provides the possibility to store metadata for samples. This
metadata can be extended for OpenStack Compute and OpenStack Object
Storage.

In order to add additional metadata information to OpenStack Compute you
have two options to choose from. The first one is to specify them when
you boot up a new instance. The additional information will be stored
with the sample in the form of ``resource_metadata.user_metadata.*``.
The new field should be defined by using the prefix ``metering.``. The
modified boot command look like the following:

.. code-block:: console

   $ openstack server create --property metering.custom_metadata=a_value my_vm

The other option is to set the ``reserved_metadata_keys`` to the list of
metadata keys that you would like to be included in
``resource_metadata`` of the instance related samples that are collected
for OpenStack Compute. This option is included in the ``DEFAULT``
section of the ``ceilometer.conf`` configuration file.

You might also specify headers whose values will be stored along with
the sample data of OpenStack Object Storage. The additional information
is also stored under ``resource_metadata``. The format of the new field
is ``resource_metadata.http_header_$name``, where ``$name`` is the name of
the header with ``-`` replaced by ``_``.

For specifying the new header, you need to set ``metadata_headers`` option
under the ``[filter:ceilometer]`` section in ``proxy-server.conf`` under the
``swift`` folder. You can use this additional data for instance to distinguish
external and internal users.

Measurements are grouped by services which are polled by
Telemetry or emit notifications that this service consumes.

.. note::

   The Telemetry service supports storing notifications as events. This
   functionality was added later, therefore the list of meters still
   contains existence type and other event related items. The proper
   way of using Telemetry is to configure it to use the event store and
   turn off the collection of the event related meters. For further
   information about events see `Events section
   <http://docs.openstack.org/developer/ceilometer/events.html>`__
   in the Telemetry documentation. For further information about how to
   turn on and off meters see :ref:`telemetry-pipeline-configuration`. Please
   also note that currently no migration is available to move the already
   existing event type samples to the event store.

.. _telemetry-compute-meters:

OpenStack Compute
~~~~~~~~~~~~~~~~~

The following meters are collected for OpenStack Compute:

+-----------+-------+------+----------+----------+---------+------------------+
| Name      | Type  | Unit | Resource | Origin   | Support | Note             |
+===========+=======+======+==========+==========+=========+==================+
| **Meters added in the Icehouse release or earlier**                         |
+-----------+-------+------+----------+----------+---------+------------------+
| instance  | Gauge | inst\| instance | Notific\ | Libvirt,| Existence of     |
|           |       | ance | ID       | ation,   | Hyper-V,| instance         |
|           |       |      |          | Pollster | vSphere |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| instance:\| Gauge | inst\| instance | Notific\ | Libvirt,| Existence of     |
| <type>    |       | ance | ID       | ation,   | Hyper-V,| instance <type>  |
|           |       |      |          | Pollster | vSphere | (OpenStack types)|
+-----------+-------+------+----------+----------+---------+------------------+
| memory    | Gauge | MB   | instance | Notific\ | Libvirt,| Volume of RAM    |
|           |       |      | ID       | ation    | Hyper-V | allocated to the |
|           |       |      |          |          |         | instance         |
+-----------+-------+------+----------+----------+---------+------------------+
| memory.\  | Gauge | MB   | instance | Pollster | vSphere | Volume of RAM    |
| usage     |       |      | ID       |          |         | used by the      |
|           |       |      |          |          |         | instance from the|
|           |       |      |          |          |         | amount of its    |
|           |       |      |          |          |         | allocated memory |
+-----------+-------+------+----------+----------+---------+------------------+
| cpu       | Cumu\ | ns   | instance | Pollster | Libvirt,| CPU time used    |
|           | lative|      | ID       |          | Hyper-V |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| cpu_util  | Gauge | %    | instance | Pollster | vSphere | Average CPU      |
|           |       |      | ID       |          |         | utilization      |
+-----------+-------+------+----------+----------+---------+------------------+
| vcpus     | Gauge | vcpu | instance | Notific\ | Libvirt,| Number of virtual|
|           |       |      | ID       | ation    | Hyper-V | CPUs allocated to|
|           |       |      |          |          |         | the instance     |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.read\| Cumul\| req\ | instance | Pollster | Libvirt,| Number of read   |
| .requests | ative | uest | ID       |          | Hyper-V | requests         |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.read\| Gauge | requ\| instance | Pollster | Libvirt,| Average rate of  |
| .requests\|       | est/s| ID       |          | Hyper-V,| read requests    |
| .rate     |       |      |          |          | vSphere |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.writ\| Cumul\| req\ | instance | Pollster | Libvirt,| Number of write  |
| e.requests| ative | uest | ID       |          | Hyper-V | requests         |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.writ\| Gauge | requ\| instance | Pollster | Libvirt,| Average rate of  |
| e.request\|       | est/s| ID       |          | Hyper-V,| write requests   |
| s.rate    |       |      |          |          | vSphere |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.read\| Cumu\ | B    | instance | Pollster | Libvirt,| Volume of reads  |
| .bytes    | lative|      | ID       |          | Hyper-V |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.read\| Gauge | B/s  | instance | Pollster | Libvirt,| Average rate of  |
| .bytes.\  |       |      | ID       |          | Hyper-V,| reads            |
| rate      |       |      |          |          | vSphere |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.writ\| Cumu\ | B    | instance | Pollster | Libvirt,| Volume of writes |
| e.bytes   | lative|      | ID       |          | Hyper-V |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.writ\| Gauge | B/s  | instance | Pollster | Libvirt,| Average rate of  |
| e.bytes.\ |       |      | ID       |          | Hyper-V,| writes           |
| rate      |       |      |          |          | vSphere |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.root\| Gauge | GB   | instance | Notific\ | Libvirt,| Size of root disk|
| .size     |       |      | ID       | ation    | Hyper-V |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.ephe\| Gauge | GB   | instance | Notific\ | Libvirt,| Size of ephemeral|
| meral.size|       |      | ID       | ation    | Hyper-V | disk             |
+-----------+-------+------+----------+----------+---------+------------------+
| network.\ | Cumu\ | B    | interface| Pollster | Libvirt,| Number of        |
| incoming.\| lative|      | ID       |          | Hyper-V | incoming bytes   |
| bytes     |       |      |          |          |         |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| network.\ | Gauge | B/s  | interface| Pollster | Libvirt,| Average rate of  |
| incoming.\|       |      | ID       |          | Hyper-V,| incoming bytes   |
| bytes.rate|       |      |          |          | vSphere |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| network.\ | Cumu\ | B    | interface| Pollster | Libvirt,| Number of        |
| outgoing\ | lative|      | ID       |          | Hyper-V | outgoing bytes   |
| .bytes    |       |      |          |          |         |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| network.\ | Gauge | B/s  | interface| Pollster | Libvirt,| Average rate of  |
| outgoing.\|       |      | ID       |          | Hyper-V,| outgoing bytes   |
| bytes.rate|       |      |          |          | vSphere |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| network.\ | Cumu\ | pac\ | interface| Pollster | Libvirt,| Number of        |
| incoming\ | lative| ket  | ID       |          | Hyper-V | incoming packets |
| .packets  |       |      |          |          |         |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| network.\ | Gauge | pack\| interface| Pollster | Libvirt,| Average rate of  |
| incoming\ |       | et/s | ID       |          | Hyper-V,| incoming packets |
| .packets\ |       |      |          |          | vSphere |                  |
| .rate     |       |      |          |          |         |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| network.\ | Cumu\ | pac\ | interface| Pollster | Libvirt,| Number of        |
| outgoing\ | lative| ket  | ID       |          | Hyper-V | outgoing packets |
| .packets  |       |      |          |          |         |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| network.\ | Gauge | pac\ | interface| Pollster | Libvirt,| Average rate of  |
| outgoing\ |       | ket/s| ID       |          | Hyper-V,| outgoing packets |
| .packets\ |       |      |          |          | vSphere |                  |
| .rate     |       |      |          |          |         |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| **Meters added or hypervisor support changed in the Juno release**          |
+-----------+-------+------+----------+----------+---------+------------------+
| instance  | Gauge | ins\ | instance | Notific\ | Libvirt,| Existence of     |
|           |       | tance| ID       | ation,   | Hyper-V,| instance         |
|           |       |      |          | Pollster | vSphere,|                  |
|           |       |      |          |          | XenAPI  |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| instance\ | Gauge | ins\ | instance | Notific\ | Libvirt,| Existence of     |
| :<type>   |       | tance| ID       | ation,   | Hyper-V,| instance <type>  |
|           |       |      |          | Pollster | vSphere,| (OpenStack types)|
|           |       |      |          |          | XenAPI  |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| memory.\  | Gauge | MB   | instance | Pollster | vSphere,| Volume of RAM    |
| usage     |       |      | ID       |          | XenAPI  | used by the      |
|           |       |      |          |          |         | instance from the|
|           |       |      |          |          |         | amount of its    |
|           |       |      |          |          |         | allocated memory |
+-----------+-------+------+----------+----------+---------+------------------+
| cpu_util  | Gauge | %    | instance | Pollster | vSphere,| Average CPU      |
|           |       |      | ID       |          | XenAPI  | utilization      |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.read\| Gauge | B/s  | instance | Pollster | Libvirt,| Average rate of  |
| .bytes.\  |       |      | ID       |          | Hyper-V,| reads            |
| rate      |       |      |          |          | vSphere,|                  |
|           |       |      |          |          | XenAPI  |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.\    | Gauge | B/s  | instance | Pollster | Libvirt,| Average rate of  |
| write.\   |       |      | ID       |          | Hyper-V,| writes           |
| bytes.rate|       |      |          |          | vSphere,|                  |
|           |       |      |          |          | XenAPI  |                  |
|           |       |      |          |          |         |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.dev\ | Cumu\ | req\ | disk ID  | Pollster | Libvirt,| Number of read   |
| ice.read\ | lative| uest |          |          | Hyper-V | requests         |
| .requests |       |      |          |          |         |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.dev\ | Gauge | requ\| disk ID  | Pollster | Libvirt,| Average rate of  |
| ice.read\ |       | est/s|          |          | Hyper-V,| read requests    |
| .requests\|       |      |          |          | vSphere |                  |
| .rate     |       |      |          |          |         |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.dev\ | Cumu\ | req\ | disk ID  | Pollster | Libvirt,| Number of write  |
| ice.write\| lative| uest |          |          | Hyper-V | requests         |
| .requests |       |      |          |          |         |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.dev\ | Gauge | requ\| disk ID  | Pollster | Libvirt,| Average rate of  |
| ice.write\|       | est/s|          |          | Hyper-V,| write requests   |
| .requests\|       |      |          |          | vSphere |                  |
| .rate     |       |      |          |          |         |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.dev\ | Cumu\ | B    | disk ID  | Pollster | Libvirt,| Volume of reads  |
| ice.read\ | lative|      |          |          | Hyper-V |                  |
| .bytes    |       |      |          |          |         |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.dev\ | Gauge | B/s  | disk ID  | Pollster | Libvirt,| Average rate of  |
| ice.read\ |       |      |          |          | Hyper-V,| reads            |
| .bytes    |       |      |          |          | vSphere |                  |
| .rate     |       |      |          |          |         |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.dev\ | Cumu\ | B    | disk ID  | Pollster | Libvirt,| Volume of writes |
| ice.write\| lative|      |          |          | Hyper-V |                  |
| .bytes    |       |      |          |          |         |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.dev\ | Gauge | B/s  | disk ID  | Pollster | Libvirt,| Average rate of  |
| ice.write\|       |      |          |          | Hyper-V,| writes           |
| .bytes    |       |      |          |          | vSphere |                  |
| .rate     |       |      |          |          |         |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| network.\ | Gauge | B/s  | interface| Pollster | Libvirt,| Average rate of  |
| incoming.\|       |      | ID       |          | Hyper-V,| incoming bytes   |
| bytes.rate|       |      |          |          | vSphere,|                  |
|           |       |      |          |          | XenAPI  |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| network.\ | Gauge | B/s  | interface| Pollster | Libvirt,| Average rate of  |
| outgoing.\|       |      | ID       |          | Hyper-V,| outgoing bytes   |
| bytes.rate|       |      |          |          | vSphere,|                  |
|           |       |      |          |          | XenAPI  |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| network.\ | Gauge | pack\| interface| Pollster | Libvirt,| Average rate of  |
| incoming.\|       | et/s | ID       |          | Hyper-V,| incoming packets |
| packets.\ |       |      |          |          | vSphere,|                  |
| rate      |       |      |          |          | XenAPI  |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| network.\ | Gauge | pack\| interface| Pollster | Libvirt,| Average rate of  |
| outgoing.\|       | et/s | ID       |          | Hyper-V,| outgoing packets |
| packets.\ |       |      |          |          | vSphere,|                  |
| rate      |       |      |          |          | XenAPI  |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| **Meters added or hypervisor support changed in the Kilo release**          |
+-----------+-------+------+----------+----------+---------+------------------+
| memory.\  | Gauge | MB   | instance | Pollster | Libvirt,| Volume of RAM    |
| usage     |       |      | ID       |          | Hyper-V,| used by the inst\|
|           |       |      |          |          | vSphere,| ance from the    |
|           |       |      |          |          | XenAPI  | amount of its    |
|           |       |      |          |          |         | allocated memory |
+-----------+-------+------+----------+----------+---------+------------------+
| memory.r\ | Gauge | MB   | instance | Pollster | Libvirt | Volume of RAM u\ |
| esident   |       |      | ID       |          |         | sed by the inst\ |
|           |       |      |          |          |         | ance on the phy\ |
|           |       |      |          |          |         | sical machine    |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.lat\ | Gauge | ms   | instance | Pollster | Hyper-V | Average disk la\ |
| ency      |       |      | ID       |          |         | tency            |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.iop\ | Gauge | coun\| instance | Pollster | Hyper-V | Average disk io\ |
| s         |       | t/s  | ID       |          |         | ps               |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.dev\ | Gauge | ms   | disk ID  | Pollster | Hyper-V | Average disk la\ |
| ice.late\ |       |      |          |          |         | tency per device |
| ncy       |       |      |          |          |         |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.dev\ | Gauge | coun\| disk ID  | Pollster | Hyper-V | Average disk io\ |
| ice.iops  |       | t/s  |          |          |         | ps per device    |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.cap\ | Gauge | B    | instance | Pollster | Libvirt | The amount of d\ |
| acity     |       |      | ID       |          |         | isk that the in\ |
|           |       |      |          |          |         | stance can see   |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.all\ | Gauge | B    | instance | Pollster | Libvirt | The amount of d\ |
| ocation   |       |      | ID       |          |         | isk occupied by  |
|           |       |      |          |          |         | the instance o\  |
|           |       |      |          |          |         | n the host mach\ |
|           |       |      |          |          |         | ine              |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.usa\ | Gauge | B    | instance | Pollster | Libvirt | The physical si\ |
| ge        |       |      | ID       |          |         | ze in bytes of   |
|           |       |      |          |          |         | the image conta\ |
|           |       |      |          |          |         | iner on the host |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.dev\ | Gauge | B    | disk ID  | Pollster | Libvirt | The amount of d\ |
| ice.capa\ |       |      |          |          |         | isk per device   |
| city      |       |      |          |          |         | that the instan\ |
|           |       |      |          |          |         | ce can see       |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.dev\ | Gauge | B    | disk ID  | Pollster | Libvirt | The amount of d\ |
| ice.allo\ |       |      |          |          |         | isk per device   |
| cation    |       |      |          |          |         | occupied by the  |
|           |       |      |          |          |         | instance on th\  |
|           |       |      |          |          |         | e host machine   |
+-----------+-------+------+----------+----------+---------+------------------+
| disk.dev\ | Gauge | B    | disk ID  | Pollster | Libvirt | The physical si\ |
| ice.usag\ |       |      |          |          |         | ze in bytes of   |
| e         |       |      |          |          |         | the image conta\ |
|           |       |      |          |          |         | iner on the hos\ |
|           |       |      |          |          |         | t per device     |
+-----------+-------+------+----------+----------+---------+------------------+
| **Meters deprecated in the Kilo release**                                   |
+-----------+-------+------+----------+----------+---------+------------------+
| instance\ | Gauge | ins\ | instance | Notific\ | Libvirt,| Existence of     |
| :<type>   |       | tance| ID       | ation,   | Hyper-V,| instance <type>  |
|           |       |      |          | Pollster | vSphere,| (OpenStack types)|
|           |       |      |          |          | XenAPI  |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| **Meters added in the Liberty release**                                     |
+-----------+-------+------+----------+----------+---------+------------------+
| cpu.delta | Delta | ns   | instance | Pollster | Libvirt,| CPU time used s\ |
|           |       |      | ID       |          | Hyper-V | ince previous d\ |
|           |       |      |          |          |         | atapoint         |
+-----------+-------+------+----------+----------+---------+------------------+
| **Meters added in the Newton release**                                      |
+-----------+-------+------+----------+----------+---------+------------------+
| cpu_l3_c\ | Gauge | B    | instance | Pollster | Libvirt | L3 cache used b\ |
| ache      |       |      | ID       |          |         | y the instance   |
+-----------+-------+------+----------+----------+---------+------------------+
| memory.b\ | Gauge | B/s  | instance | Pollster | Libvirt | Total system ba\ |
| andwidth\ |       |      | ID       |          |         | ndwidth from on\ |
| .total    |       |      |          |          |         | e level of cache |
+-----------+-------+------+----------+----------+---------+------------------+
| memory.b\ | Gauge | B/s  | instance | Pollster | Libvirt | Bandwidth of me\ |
| andwidth\ |       |      | ID       |          |         | mory traffic fo\ |
| .local    |       |      |          |          |         | r a memory cont\ |
|           |       |      |          |          |         | roller           |
+-----------+-------+------+----------+----------+---------+------------------+
| perf.cpu\ | Gauge | cyc\ | instance | Pollster | Libvirt | the number of c\ |
| .cycles   |       | le   | ID       |          |         | pu cycles one i\ |
|           |       |      |          |          |         | nstruction needs |
+-----------+-------+------+----------+----------+---------+------------------+
| perf.ins\ | Gauge | inst\| instance | Pollster | Libvirt | the count of in\ |
| tructions |       | ruct\| ID       |          |         | structions       |
|           |       | ion  |          |          |         |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| perf.cac\ | Gauge | cou\ | instance | Pollster | Libvirt | the count of ca\ |
| he.refer\ |       | nt   | ID       |          |         | che hits         |
| ences     |       |      |          |          |         |                  |
+-----------+-------+------+----------+----------+---------+------------------+
| perf.cac\ | Gauge | cou\ | instance | Pollster | Libvirt | the count of ca\ |
| he.misses |       | nt   | ID       |          |         | che misses       |
+-----------+-------+------+----------+----------+---------+------------------+

|

.. note::

   1. In the Ocata release, the ``instance`` meter is no longer supported..

   2. The ``instance:<type>`` meter can be replaced by using extra parameters in
      both the samples and statistics queries. Sample queries look like:

   .. code-block:: console

      statistics:

        ceilometer statistics -m instance -g resource_metadata.instance_type

      samples:

        ceilometer sample-list -m instance -q metadata.instance_type=<value>

The Telemetry service supports to create new meters by using
transformers. For more details about transformers see
:ref:`telemetry-transformers`. Among the meters gathered from libvirt and
Hyper-V there are a few ones which are generated from other meters. The list of
meters that are created by using the ``rate_of_change`` transformer from the
above table is the following:

-  cpu\_util

-  disk.read.requests.rate

-  disk.write.requests.rate

-  disk.read.bytes.rate

-  disk.write.bytes.rate

-  disk.device.read.requests.rate

-  disk.device.write.requests.rate

-  disk.device.read.bytes.rate

-  disk.device.write.bytes.rate

-  network.incoming.bytes.rate

-  network.outgoing.bytes.rate

-  network.incoming.packets.rate

-  network.outgoing.packets.rate

.. note::

    To enable the libvirt ``memory.usage`` support, you need to install
    libvirt version 1.1.1+, QEMU version 1.5+, and you also need to
    prepare suitable balloon driver in the image. It is applicable
    particularly for Windows guests, most modern Linux distributions
    already have it built in. Telemetry is not able to fetch the
    ``memory.usage`` samples without the image balloon driver.

OpenStack Compute is capable of collecting ``CPU`` related meters from
the compute host machines. In order to use that you need to set the
``compute_monitors`` option to ``ComputeDriverCPUMonitor`` in the
``nova.conf`` configuration file. For further information see the
Compute configuration section in the `Compute chapter
<http://docs.openstack.org/newton/config-reference/compute/config-options.html>`__
of the OpenStack Configuration Reference.

The following host machine related meters are collected for OpenStack
Compute:

+---------------------+-------+------+----------+-------------+---------------+
| Name                | Type  | Unit | Resource | Origin      | Note          |
+=====================+=======+======+==========+=============+===============+
| **Meters added in the Icehouse release or earlier**                         |
+---------------------+-------+------+----------+-------------+---------------+
| compute.node.cpu.\  | Gauge | MHz  | host ID  | Notification| CPU frequency |
| frequency           |       |      |          |             |               |
+---------------------+-------+------+----------+-------------+---------------+
| compute.node.cpu.\  | Cumu\ | ns   | host ID  | Notification| CPU kernel    |
| kernel.time         | lative|      |          |             | time          |
+---------------------+-------+------+----------+-------------+---------------+
| compute.node.cpu.\  | Cumu\ | ns   | host ID  | Notification| CPU idle time |
| idle.time           | lative|      |          |             |               |
+---------------------+-------+------+----------+-------------+---------------+
| compute.node.cpu.\  | Cumu\ | ns   | host ID  | Notification| CPU user mode |
| user.time           | lative|      |          |             | time          |
+---------------------+-------+------+----------+-------------+---------------+
| compute.node.cpu.\  | Cumu\ | ns   | host ID  | Notification| CPU I/O wait  |
| iowait.time         | lative|      |          |             | time          |
+---------------------+-------+------+----------+-------------+---------------+
| compute.node.cpu.\  | Gauge | %    | host ID  | Notification| CPU kernel    |
| kernel.percent      |       |      |          |             | percentage    |
+---------------------+-------+------+----------+-------------+---------------+
| compute.node.cpu.\  | Gauge | %    | host ID  | Notification| CPU idle      |
| idle.percent        |       |      |          |             | percentage    |
+---------------------+-------+------+----------+-------------+---------------+
| compute.node.cpu.\  | Gauge | %    | host ID  | Notification| CPU user mode |
| user.percent        |       |      |          |             | percentage    |
+---------------------+-------+------+----------+-------------+---------------+
| compute.node.cpu.\  | Gauge | %    | host ID  | Notification| CPU I/O wait  |
| iowait.percent      |       |      |          |             | percentage    |
+---------------------+-------+------+----------+-------------+---------------+
| compute.node.cpu.\  | Gauge | %    | host ID  | Notification| CPU           |
| percent             |       |      |          |             | utilization   |
+---------------------+-------+------+----------+-------------+---------------+

.. _telemetry-bare-metal-service:

Bare metal service
~~~~~~~~~~~~~~~~~~

Telemetry captures notifications that are emitted by the Bare metal
service. The source of the notifications are IPMI sensors that collect
data from the host machine.

.. note::

   The sensor data is not available in the Bare metal service by
   default. To enable the meters and configure this module to emit
   notifications about the measured values see the `Installation
   Guide <http://docs.openstack.org/project-install-guide/baremetal/newton>`__
   for the Bare metal service.

The following meters are recorded for the Bare metal service:

+------------------+-------+------+----------+-------------+------------------+
| Name             | Type  | Unit | Resource | Origin      | Note             |
+==================+=======+======+==========+=============+==================+
| **Meters added in the Juno release**                                        |
+------------------+-------+------+----------+-------------+------------------+
| hardware.ipmi.fan| Gauge | RPM  | fan      | Notification| Fan rounds per   |
|                  |       |      | sensor   |             | minute (RPM)     |
+------------------+-------+------+----------+-------------+------------------+
| hardware.ipmi\   | Gauge | C    | temper\  | Notification| Temperature read\|
| .temperature     |       |      | ature    |             | ing from sensor  |
|                  |       |      | sensor   |             |                  |
+------------------+-------+------+----------+-------------+------------------+
| hardware.ipmi\   | Gauge | W    | current  | Notification| Current reading  |
| .current         |       |      | sensor   |             | from sensor      |
+------------------+-------+------+----------+-------------+------------------+
| hardware.ipmi\   | Gauge | V    | voltage  | Notification| Voltage reading  |
| .voltage         |       |      | sensor   |             | from sensor      |
+------------------+-------+------+----------+-------------+------------------+

IPMI based meters
~~~~~~~~~~~~~~~~~
Another way of gathering IPMI based data is to use IPMI sensors
independently from the Bare metal service's components. Same meters as
:ref:`telemetry-bare-metal-service` could be fetched except that origin is
``Pollster`` instead of ``Notification``.

You need to deploy the ceilometer-agent-ipmi on each IPMI-capable node
in order to poll local sensor data. For further information about the
IPMI agent see :ref:`telemetry-ipmi-agent`.

.. warning::

   To avoid duplication of metering data and unnecessary load on the
   IPMI interface, do not deploy the IPMI agent on nodes that are
   managed by the Bare metal service and keep the
   ``conductor.send_sensor_data`` option set to ``False`` in the
   ``ironic.conf`` configuration file.

Besides generic IPMI sensor data, the following Intel Node Manager
meters are recorded from capable platform:

+---------------------+-------+------+----------+----------+------------------+
| Name                | Type  | Unit | Resource | Origin   | Note             |
+=====================+=======+======+==========+==========+==================+
| **Meters added in the Juno release**                                        |
+---------------------+-------+------+----------+----------+------------------+
| hardware.ipmi.node\ | Gauge | W    | host ID  | Pollster | Current power    |
| .power              |       |      |          |          | of the system    |
+---------------------+-------+------+----------+----------+------------------+
| hardware.ipmi.node\ | Gauge | C    | host ID  | Pollster | Current tempera\ |
| .temperature        |       |      |          |          | ture of the      |
|                     |       |      |          |          | system           |
+---------------------+-------+------+----------+----------+------------------+
| **Meters added in the Kilo release**                                        |
+---------------------+-------+------+----------+----------+------------------+
| hardware.ipmi.node\ | Gauge | C    | host ID  | Pollster | Inlet temperatu\ |
| .inlet_temperature  |       |      |          |          | re of the system |
+---------------------+-------+------+----------+----------+------------------+
| hardware.ipmi.node\ | Gauge | C    | host ID  | Pollster | Outlet temperat\ |
| .outlet_temperature |       |      |          |          | ure of the system|
+---------------------+-------+------+----------+----------+------------------+
| hardware.ipmi.node\ | Gauge | CFM  | host ID  | Pollster | Volumetric airf\ |
| .airflow            |       |      |          |          | low of the syst\ |
|                     |       |      |          |          | em, expressed as |
|                     |       |      |          |          | 1/10th of CFM    |
+---------------------+-------+------+----------+----------+------------------+
| hardware.ipmi.node\ | Gauge | CUPS | host ID  | Pollster | CUPS(Compute Us\ |
| .cups               |       |      |          |          | age Per Second)  |
|                     |       |      |          |          | index data of the|
|                     |       |      |          |          | system           |
+---------------------+-------+------+----------+----------+------------------+
| hardware.ipmi.node\ | Gauge | %    | host ID  | Pollster | CPU CUPS utiliz\ |
| .cpu_util           |       |      |          |          | ation of the     |
|                     |       |      |          |          | system           |
+---------------------+-------+------+----------+----------+------------------+
| hardware.ipmi.node\ | Gauge | %    | host ID  | Pollster | Memory CUPS      |
| .mem_util           |       |      |          |          | utilization of   |
|                     |       |      |          |          | the system       |
+---------------------+-------+------+----------+----------+------------------+
| hardware.ipmi.node\ | Gauge | %    | host ID  | Pollster | IO CUPS          |
| .io_util            |       |      |          |          | utilization of   |
|                     |       |      |          |          | the system       |
+---------------------+-------+------+----------+----------+------------------+

|

+------------------------------------+----------------------------------------+
| Meters renamed in the Kilo release                                          |
+====================================+========================================+
| **Original Name**                  | **New Name**                           |
+------------------------------------+----------------------------------------+
| hardware.ipmi.node.temperature     | hardware.ipmi.node.inlet_temperature   |
+------------------------------------+----------------------------------------+
| hardware.ipmi.node.\               | hardware.ipmi.node.temperature         |
| inlet_temperature                  |                                        |
+------------------------------------+----------------------------------------+

SNMP based meters
~~~~~~~~~~~~~~~~~

Telemetry supports gathering SNMP based generic host meters. In order to
be able to collect this data you need to run snmpd on each target host.

The following meters are available about the host machines by using
SNMP:

+---------------------+-------+------+----------+----------+------------------+
| Name                | Type  | Unit | Resource | Origin   | Note             |
+=====================+=======+======+==========+==========+==================+
| **Meters added in the Kilo release**                                        |
+---------------------+-------+------+----------+----------+------------------+
| hardware.cpu.load.\ | Gauge | proc\| host ID  | Pollster | CPU load in the  |
| 1min                |       | ess  |          |          | past 1 minute    |
+---------------------+-------+------+----------+----------+------------------+
| hardware.cpu.load.\ | Gauge | proc\| host ID  | Pollster | CPU load in the  |
| 5min                |       | ess  |          |          | past 5 minutes   |
+---------------------+-------+------+----------+----------+------------------+
| hardware.cpu.load.\ | Gauge | proc\| host ID  | Pollster | CPU load in the  |
| 15min               |       | ess  |          |          | past 15 minutes  |
+---------------------+-------+------+----------+----------+------------------+
| hardware.disk.size\ | Gauge | KB   | disk ID  | Pollster | Total disk size  |
| .total              |       |      |          |          |                  |
+---------------------+-------+------+----------+----------+------------------+
| hardware.disk.size\ | Gauge | KB   | disk ID  | Pollster | Used disk size   |
| .used               |       |      |          |          |                  |
+---------------------+-------+------+----------+----------+------------------+
| hardware.memory.to\ | Gauge | KB   | host ID  | Pollster | Total physical   |
| tal                 |       |      |          |          | memory size      |
+---------------------+-------+------+----------+----------+------------------+
| hardware.memory.us\ | Gauge | KB   | host ID  | Pollster | Used physical m\ |
| ed                  |       |      |          |          | emory size       |
+---------------------+-------+------+----------+----------+------------------+
| hardware.memory.bu\ | Gauge | KB   | host ID  | Pollster | Physical memory  |
| ffer                |       |      |          |          | buffer size      |
+---------------------+-------+------+----------+----------+------------------+
| hardware.memory.ca\ | Gauge | KB   | host ID  | Pollster | Cached physical  |
| ched                |       |      |          |          | memory size      |
+---------------------+-------+------+----------+----------+------------------+
| hardware.memory.sw\ | Gauge | KB   | host ID  | Pollster | Total swap space |
| ap.total            |       |      |          |          | size             |
+---------------------+-------+------+----------+----------+------------------+
| hardware.memory.sw\ | Gauge | KB   | host ID  | Pollster | Available swap   |
| ap.avail            |       |      |          |          | space size       |
+---------------------+-------+------+----------+----------+------------------+
| hardware.network.i\ | Cumul\| B    | interface| Pollster | Bytes received   |
| ncoming.bytes       | ative |      | ID       |          | by network inte\ |
|                     |       |      |          |          | rface            |
+---------------------+-------+------+----------+----------+------------------+
| hardware.network.o\ | Cumul\| B    | interface| Pollster | Bytes sent by n\ |
| utgoing.bytes       | ative |      | ID       |          | etwork interface |
+---------------------+-------+------+----------+----------+------------------+
| hardware.network.o\ | Cumul\| pack\| interface| Pollster | Sending error o\ |
| utgoing.errors      | ative | et   | ID       |          | f network inter\ |
|                     |       |      |          |          | face             |
+---------------------+-------+------+----------+----------+------------------+
| hardware.network.i\ | Cumul\| data\| host ID  | Pollster | Number of recei\ |
| p.incoming.datagra\ | ative | grams|          |          | ved datagrams    |
| ms                  |       |      |          |          |                  |
+---------------------+-------+------+----------+----------+------------------+
| hardware.network.i\ | Cumul\| data\| host ID  | Pollster | Number of sent   |
| p.outgoing.datagra\ | ative | grams|          |          | datagrams        |
| ms                  |       |      |          |          |                  |
+---------------------+-------+------+----------+----------+------------------+
| hardware.system_st\ | Cumul\| bloc\| host ID  | Pollster | Aggregated numb\ |
| ats.io.incoming.bl\ | ative | ks   |          |          | er of blocks re\ |
| ocks                |       |      |          |          | ceived to block  |
|                     |       |      |          |          | device           |
+---------------------+-------+------+----------+----------+------------------+
| hardware.system_st\ | Cumul\| bloc\| host ID  | Pollster | Aggregated numb\ |
| ats.io.outgoing.bl\ | ative | ks   |          |          | er of blocks se\ |
| ocks                |       |      |          |          | nt to block dev\ |
|                     |       |      |          |          | ice              |
+---------------------+-------+------+----------+----------+------------------+
| hardware.system_st\ | Gauge | %    | host ID  | Pollster | CPU idle percen\ |
| ats.cpu.idle        |       |      |          |          | tage             |
+---------------------+-------+------+----------+----------+------------------+
| **Meters added in the Mitaka release**                                      |
+---------------------+-------+------+----------+----------+------------------+
| hardware.cpu.util   | Gauge | %    | host ID  | Pollster | cpu usage        |
|                     |       |      |          |          | percentage       |
+---------------------+-------+------+----------+----------+------------------+

OpenStack Image service
~~~~~~~~~~~~~~~~~~~~~~~

The following meters are collected for OpenStack Image service:

+--------------------+--------+------+----------+----------+------------------+
| Name               | Type   | Unit | Resource | Origin   | Note             |
+====================+========+======+==========+==========+==================+
| **Meters added in the Icehouse release or earlier**                         |
+--------------------+--------+------+----------+----------+------------------+
| image              | Gauge  | image| image ID | Notifica\| Existence of the |
|                    |        |      |          | tion, Po\| image            |
|                    |        |      |          | llster   |                  |
+--------------------+--------+------+----------+----------+------------------+
| image.size         | Gauge  | image| image ID | Notifica\| Size of the upl\ |
|                    |        |      |          | tion, Po\| oaded image      |
|                    |        |      |          | llster   |                  |
+--------------------+--------+------+----------+----------+------------------+
| image.update       | Delta  | image| image ID | Notifica\| Number of updat\ |
|                    |        |      |          | tion     | es on the image  |
+--------------------+--------+------+----------+----------+------------------+
| image.upload       | Delta  | image| image ID | Notifica\| Number of uploa\ |
|                    |        |      |          | tion     | ds on the image  |
+--------------------+--------+------+----------+----------+------------------+
| image.delete       | Delta  | image| image ID | Notifica\| Number of delet\ |
|                    |        |      |          | tion     | es on the image  |
+--------------------+--------+------+----------+----------+------------------+
| image.download     | Delta  | B    | image ID | Notifica\| Image is downlo\ |
|                    |        |      |          | tion     | aded             |
+--------------------+--------+------+----------+----------+------------------+
| image.serve        | Delta  | B    | image ID | Notifica\| Image is served  |
|                    |        |      |          | tion     | out              |
+--------------------+--------+------+----------+----------+------------------+

OpenStack Block Storage
~~~~~~~~~~~~~~~~~~~~~~~

The following meters are collected for OpenStack Block Storage:

+--------------------+-------+--------+----------+----------+-----------------+
| Name               | Type  | Unit   | Resource | Origin   | Note            |
+====================+=======+========+==========+==========+=================+
| **Meters added in the Icehouse release or earlier**                         |
+--------------------+-------+--------+----------+----------+-----------------+
| volume             | Gauge | volume | volume ID| Notifica\| Existence of the|
|                    |       |        |          | tion     | volume          |
+--------------------+-------+--------+----------+----------+-----------------+
| volume.size        | Gauge | GB     | volume ID| Notifica\| Size of the vol\|
|                    |       |        |          | tion     | ume             |
+--------------------+-------+--------+----------+----------+-----------------+
| **Meters added in the Juno release**                                        |
+--------------------+-------+--------+----------+----------+-----------------+
| snapshot           | Gauge | snapsh\| snapshot | Notifica\| Existence of the|
|                    |       | ot     | ID       | tion     | snapshot        |
+--------------------+-------+--------+----------+----------+-----------------+
| snapshot.size      | Gauge | GB     | snapshot | Notifica\| Size of the sna\|
|                    |       |        | ID       | tion     | pshot           |
+--------------------+-------+--------+----------+----------+-----------------+
| **Meters added in the Kilo release**                                        |
+--------------------+-------+--------+----------+----------+-----------------+
| volume.create.(sta\| Delta | volume | volume ID| Notifica\| Creation of the |
| rt|end)            |       |        |          | tion     | volume          |
+--------------------+-------+--------+----------+----------+-----------------+
| volume.delete.(sta\| Delta | volume | volume ID| Notifica\| Deletion of the |
| rt|end)            |       |        |          | tion     | volume          |
+--------------------+-------+--------+----------+----------+-----------------+
| volume.update.(sta\| Delta | volume | volume ID| Notifica\| Update the name |
| rt|end)            |       |        |          | tion     | or description  |
|                    |       |        |          |          | of the volume   |
+--------------------+-------+--------+----------+----------+-----------------+
| volume.resize.(sta\| Delta | volume | volume ID| Notifica\| Update the size |
| rt|end)            |       |        |          | tion     | of the volume   |
+--------------------+-------+--------+----------+----------+-----------------+
| volume.attach.(sta\| Delta | volume | volume ID| Notifica\| Attaching the v\|
| rt|end)            |       |        |          | tion     | olume to an ins\|
|                    |       |        |          |          | tance           |
+--------------------+-------+--------+----------+----------+-----------------+
| volume.detach.(sta\| Delta | volume | volume ID| Notifica\| Detaching the v\|
| rt|end)            |       |        |          | tion     | olume from an i\|
|                    |       |        |          |          | nstance         |
+--------------------+-------+--------+----------+----------+-----------------+
| snapshot.create.(s\| Delta | snapsh\| snapshot | Notifica\| Creation of the |
| tart|end)          |       | ot     | ID       | tion     | snapshot        |
+--------------------+-------+--------+----------+----------+-----------------+
| snapshot.delete.(s\| Delta | snapsh\| snapshot | Notifica\| Deletion of the |
| tart|end)          |       | ot     | ID       | tion     | snapshot        |
+--------------------+-------+--------+----------+----------+-----------------+
| volume.backup.crea\| Delta | volume | backup ID| Notifica\| Creation of the |
| te.(start|end)     |       |        |          | tion     | volume backup   |
+--------------------+-------+--------+----------+----------+-----------------+
| volume.backup.dele\| Delta | volume | backup ID| Notifica\| Deletion of the |
| te.(start|end)     |       |        |          | tion     | volume backup   |
+--------------------+-------+--------+----------+----------+-----------------+
| volume.backup.rest\| Delta | volume | backup ID| Notifica\| Restoration of  |
| ore.(start|end)    |       |        |          | tion     | the volume back\|
|                    |       |        |          |          | up              |
+--------------------+-------+--------+----------+----------+-----------------+

.. _telemetry-object-storage-meter:

OpenStack Object Storage
~~~~~~~~~~~~~~~~~~~~~~~~

The following meters are collected for OpenStack Object Storage:

+--------------------+-------+-------+------------+---------+-----------------+
| Name               | Type  | Unit  | Resource   | Origin  | Note            |
+====================+=======+=======+============+=========+=================+
| **Meters added in the Icehouse release or earlier**                         |
+--------------------+-------+-------+------------+---------+-----------------+
| storage.objects    | Gauge | object| storage ID | Pollster| Number of objec\|
|                    |       |       |            |         | ts              |
+--------------------+-------+-------+------------+---------+-----------------+
| storage.objects.si\| Gauge | B     | storage ID | Pollster| Total size of s\|
| ze                 |       |       |            |         | tored objects   |
+--------------------+-------+-------+------------+---------+-----------------+
| storage.objects.co\| Gauge | conta\| storage ID | Pollster| Number of conta\|
| ntainers           |       | iner  |            |         | iners           |
+--------------------+-------+-------+------------+---------+-----------------+
| storage.objects.in\| Delta | B     | storage ID | Notific\| Number of incom\|
| coming.bytes       |       |       |            | ation   | ing bytes       |
+--------------------+-------+-------+------------+---------+-----------------+
| storage.objects.ou\| Delta | B     | storage ID | Notific\| Number of outgo\|
| tgoing.bytes       |       |       |            | ation   | ing bytes       |
+--------------------+-------+-------+------------+---------+-----------------+
| storage.api.request| Delta | requ\ | storage ID | Notific\| Number of API r\|
|                    |       | est   |            | ation   | equests against |
|                    |       |       |            |         | OpenStack Obje\ |
|                    |       |       |            |         | ct Storage      |
+--------------------+-------+-------+------------+---------+-----------------+
| storage.containers\| Gauge | object| storage ID\| Pollster| Number of objec\|
| .objects           |       |       | /container |         | ts in container |
+--------------------+-------+-------+------------+---------+-----------------+
| storage.containers\| Gauge | B     | storage ID\| Pollster| Total size of s\|
| .objects.size      |       |       | /container |         | tored objects i\|
|                    |       |       |            |         | n container     |
+--------------------+-------+-------+------------+---------+-----------------+
| **meters deprecated in the Kilo release**                                   |
+------------------+-------+------+----------+-------------+------------------+
| storage.objects.in\| Delta | B     | storage ID | Notific\| Number of incom\|
| coming.bytes       |       |       |            | ation   | ing bytes       |
+--------------------+-------+-------+------------+---------+-----------------+
| storage.objects.ou\| Delta | B     | storage ID | Notific\| Number of outgo\|
| tgoing.bytes       |       |       |            | ation   | ing bytes       |
+--------------------+-------+-------+------------+---------+-----------------+
| storage.api.request| Delta | requ\ | storage ID | Notific\| Number of API r\|
|                    |       | est   |            | ation   | equests against |
|                    |       |       |            |         | OpenStack Obje\ |
|                    |       |       |            |         | ct Storage      |
+--------------------+-------+-------+------------+---------+-----------------+


Ceph Object Storage
~~~~~~~~~~~~~~~~~~~
In order to gather meters from Ceph, you have to install and configure
the Ceph Object Gateway (radosgw) as it is described in the `Installation
Manual <http://docs.ceph.com/docs/master/radosgw/>`__. You have to enable
`usage logging <http://ceph.com/docs/master/man/8/radosgw/#usage-logging>`__ in
order to get the related meters from Ceph. You will also need an
``admin`` user with ``users``, ``buckets``, ``metadata`` and ``usage``
``caps`` configured.

In order to access Ceph from Telemetry, you need to specify a
``service group`` for ``radosgw`` in the ``ceilometer.conf``
configuration file along with ``access_key`` and ``secret_key`` of the
``admin`` user mentioned above.

The following meters are collected for Ceph Object Storage:

+------------------+------+--------+------------+----------+------------------+
| Name             | Type | Unit   | Resource   | Origin   | Note             |
+==================+======+========+============+==========+==================+
| **Meters added in the Kilo release**                                        |
+------------------+------+--------+------------+----------+------------------+
| radosgw.objects  | Gauge| object | storage ID | Pollster | Number of objects|
+------------------+------+--------+------------+----------+------------------+
| radosgw.objects.\| Gauge| B      | storage ID | Pollster | Total size of s\ |
| size             |      |        |            |          | tored objects    |
+------------------+------+--------+------------+----------+------------------+
| radosgw.objects.\| Gauge| contai\| storage ID | Pollster | Number of conta\ |
| containers       |      | ner    |            |          | iners            |
+------------------+------+--------+------------+----------+------------------+
| radosgw.api.requ\| Gauge| request| storage ID | Pollster | Number of API r\ |
| est              |      |        |            |          | equests against  |
|                  |      |        |            |          | Ceph Object Ga\  |
|                  |      |        |            |          | teway (radosgw)  |
+------------------+------+--------+------------+----------+------------------+
| radosgw.containe\| Gauge| object | storage ID\| Pollster | Number of objec\ |
| rs.objects       |      |        | /container |          | ts in container  |
+------------------+------+--------+------------+----------+------------------+
| radosgw.containe\| Gauge| B      | storage ID\| Pollster | Total size of s\ |
| rs.objects.size  |      |        | /container |          | tored objects in |
|                  |      |        |            |          | container        |
+------------------+------+--------+------------+----------+------------------+

.. note::

    The ``usage`` related information may not be updated right after an
    upload or download, because the Ceph Object Gateway needs time to
    update the usage properties. For instance, the default configuration
    needs approximately 30 minutes to generate the usage logs.

OpenStack Identity
~~~~~~~~~~~~~~~~~~

The following meters are collected for OpenStack Identity:

+-------------------+------+--------+-----------+-----------+-----------------+
| Name              | Type | Unit   | Resource  | Origin    | Note            |
+===================+======+========+===========+===========+=================+
| **Meters added in the Juno release**                                        |
+-------------------+------+--------+-----------+-----------+-----------------+
| identity.authent\ | Delta| user   | user ID   | Notifica\ | User successful\|
| icate.success     |      |        |           | tion      | ly authenticated|
+-------------------+------+--------+-----------+-----------+-----------------+
| identity.authent\ | Delta| user   | user ID   | Notifica\ | User pending au\|
| icate.pending     |      |        |           | tion      | thentication    |
+-------------------+------+--------+-----------+-----------+-----------------+
| identity.authent\ | Delta| user   | user ID   | Notifica\ | User failed to  |
| icate.failure     |      |        |           | tion      | authenticate    |
+-------------------+------+--------+-----------+-----------+-----------------+
| identity.user.cr\ | Delta| user   | user ID   | Notifica\ | User is created |
| eated             |      |        |           | tion      |                 |
+-------------------+------+--------+-----------+-----------+-----------------+
| identity.user.de\ | Delta| user   | user ID   | Notifica\ | User is deleted |
| leted             |      |        |           | tion      |                 |
+-------------------+------+--------+-----------+-----------+-----------------+
| identity.user.up\ | Delta| user   | user ID   | Notifica\ | User is updated |
| dated             |      |        |           | tion      |                 |
+-------------------+------+--------+-----------+-----------+-----------------+
| identity.group.c\ | Delta| group  | group ID  | Notifica\ | Group is created|
| reated            |      |        |           | tion      |                 |
+-------------------+------+--------+-----------+-----------+-----------------+
| identity.group.d\ | Delta| group  | group ID  | Notifica\ | Group is deleted|
| eleted            |      |        |           | tion      |                 |
+-------------------+------+--------+-----------+-----------+-----------------+
| identity.group.u\ | Delta| group  | group ID  | Notifica\ | Group is updated|
| pdated            |      |        |           | tion      |                 |
+-------------------+------+--------+-----------+-----------+-----------------+
| identity.role.cr\ | Delta| role   | role ID   | Notifica\ | Role is created |
| eated             |      |        |           | tion      |                 |
+-------------------+------+--------+-----------+-----------+-----------------+
| identity.role.de\ | Delta| role   | role ID   | Notifica\ | Role is deleted |
| leted             |      |        |           | tion      |                 |
+-------------------+------+--------+-----------+-----------+-----------------+
| identity.role.up\ | Delta| role   | role ID   | Notifica\ | Role is updated |
| dated             |      |        |           | tion      |                 |
+-------------------+------+--------+-----------+-----------+-----------------+
| identity.project\ | Delta| project| project ID| Notifica\ | Project is crea\|
| .created          |      |        |           | tion      | ted             |
+-------------------+------+--------+-----------+-----------+-----------------+
| identity.project\ | Delta| project| project ID| Notifica\ | Project is dele\|
| .deleted          |      |        |           | tion      | ted             |
+-------------------+------+--------+-----------+-----------+-----------------+
| identity.project\ | Delta| project| project ID| Notifica\ | Project is upda\|
| .updated          |      |        |           | tion      | ted             |
+-------------------+------+--------+-----------+-----------+-----------------+
| identity.trust.c\ | Delta| trust  | trust ID  | Notifica\ | Trust is created|
| reated            |      |        |           | tion      |                 |
+-------------------+------+--------+-----------+-----------+-----------------+
| identity.trust.d\ | Delta| trust  | trust ID  | Notifica\ | Trust is deleted|
| eleted            |      |        |           | tion      |                 |
+-------------------+------+--------+-----------+-----------+-----------------+
| **Meters added in the Kilo release**                                        |
+-------------------+------+--------+-----------+-----------+-----------------+
| identity.role_as\ | Delta| role_a\| role ID   | Notifica\ | Role is added to|
| signment.created  |      | ssignm\|           | tion      | an actor on a   |
|                   |      | ent    |           |           | target          |
+-------------------+------+--------+-----------+-----------+-----------------+
| identity.role_as\ | Delta| role_a\| role ID   | Notifica\ | Role is removed |
| signment.deleted  |      | ssignm\|           | tion      | from an actor   |
|                   |      | ent    |           |           | on a target     |
+-------------------+------+--------+-----------+-----------+-----------------+
| **All meters thoroughly deprecated in the liberty release**                 |
+------------------+-------+------+----------+-------------+------------------+

OpenStack Networking
~~~~~~~~~~~~~~~~~~~~

The following meters are collected for OpenStack Networking:

+-----------------+-------+--------+-----------+-----------+------------------+
| Name            | Type  | Unit   | Resource  | Origin    | Note             |
+=================+=======+========+===========+===========+==================+
| **Meters added in the Icehouse release or earlier**                         |
+-----------------+-------+--------+-----------+-----------+------------------+
| network         | Gauge | networ\| network ID| Notifica\ | Existence of ne\ |
|                 |       | k      |           | tion      | twork            |
+-----------------+-------+--------+-----------+-----------+------------------+
| network.create  | Delta | networ\| network ID| Notifica\ | Creation reques\ |
|                 |       | k      |           | tion      | ts for this net\ |
|                 |       |        |           |           | work             |
+-----------------+-------+--------+-----------+-----------+------------------+
| network.update  | Delta | networ\| network ID| Notifica\ | Update requests  |
|                 |       | k      |           | tion      | for this network |
+-----------------+-------+--------+-----------+-----------+------------------+
| subnet          | Gauge | subnet | subnet ID | Notifica\ | Existence of su\ |
|                 |       |        |           | tion      | bnet             |
+-----------------+-------+--------+-----------+-----------+------------------+
| subnet.create   | Delta | subnet | subnet ID | Notifica\ | Creation reques\ |
|                 |       |        |           | tion      | ts for this sub\ |
|                 |       |        |           |           | net              |
+-----------------+-------+--------+-----------+-----------+------------------+
| subnet.update   | Delta | subnet | subnet ID | Notifica\ | Update requests  |
|                 |       |        |           | tion      | for this subnet  |
+-----------------+-------+--------+-----------+-----------+------------------+
| port            | Gauge | port   | port ID   | Notifica\ | Existence of po\ |
|                 |       |        |           | tion      | rt               |
+-----------------+-------+--------+-----------+-----------+------------------+
| port.create     | Delta | port   | port ID   | Notifica\ | Creation reques\ |
|                 |       |        |           | tion      | ts for this port |
+-----------------+-------+--------+-----------+-----------+------------------+
| port.update     | Delta | port   | port ID   | Notifica\ | Update requests  |
|                 |       |        |           | tion      | for this port    |
+-----------------+-------+--------+-----------+-----------+------------------+
| router          | Gauge | router | router ID | Notifica\ | Existence of ro\ |
|                 |       |        |           | tion      | uter             |
+-----------------+-------+--------+-----------+-----------+------------------+
| router.create   | Delta | router | router ID | Notifica\ | Creation reques\ |
|                 |       |        |           | tion      | ts for this rou\ |
|                 |       |        |           |           | ter              |
+-----------------+-------+--------+-----------+-----------+------------------+
| router.update   | Delta | router | router ID | Notifica\ | Update requests  |
|                 |       |        |           | tion      | for this router  |
+-----------------+-------+--------+-----------+-----------+------------------+
| ip.floating     | Gauge | ip     | ip ID     | Notifica\ | Existence of IP  |
|                 |       |        |           | tion, Po\ |                  |
|                 |       |        |           | llster    |                  |
+-----------------+-------+--------+-----------+-----------+------------------+
| ip.floating.cr\ | Delta | ip     | ip ID     | Notifica\ | Creation reques\ |
| eate            |       |        |           | tion      | ts for this IP   |
+-----------------+-------+--------+-----------+-----------+------------------+
| ip.floating.up\ | Delta | ip     | ip ID     | Notifica\ | Update requests  |
| date            |       |        |           | tion      | for this IP      |
+-----------------+-------+--------+-----------+-----------+------------------+
| bandwidth       | Delta | B      | label ID  | Notifica\ | Bytes through t\ |
|                 |       |        |           | tion      | his l3 metering  |
|                 |       |        |           |           | label            |
+-----------------+-------+--------+-----------+-----------+------------------+

SDN controllers
~~~~~~~~~~~~~~~

The following meters are collected for SDN:

+-----------------+---------+--------+-----------+----------+-----------------+
| Name            | Type    | Unit   | Resource  | Origin   | Note            |
+=================+=========+========+===========+==========+=================+
| **Meters added in the Icehouse release or earlier**                         |
+-----------------+---------+--------+-----------+----------+-----------------+
| switch          | Gauge   | switch | switch ID | Pollster | Existence of sw\|
|                 |         |        |           |          | itch            |
+-----------------+---------+--------+-----------+----------+-----------------+
| switch.port     | Gauge   | port   | switch ID | Pollster | Existence of po\|
|                 |         |        |           |          | rt              |
+-----------------+---------+--------+-----------+----------+-----------------+
| switch.port.re\ | Cumula\ | packet | switch ID | Pollster | Packets receive\|
| ceive.packets   | tive    |        |           |          | d on port       |
+-----------------+---------+--------+-----------+----------+-----------------+
| switch.port.tr\ | Cumula\ | packet | switch ID | Pollster | Packets transmi\|
| ansmit.packets  | tive    |        |           |          | tted on port    |
+-----------------+---------+--------+-----------+----------+-----------------+
| switch.port.re\ | Cumula\ | B      | switch ID | Pollster | Bytes received  |
| ceive.bytes     | tive    |        |           |          | on port         |
+-----------------+---------+--------+-----------+----------+-----------------+
| switch.port.tr\ | Cumula\ | B      | switch ID | Pollster | Bytes transmitt\|
| ansmit.bytes    | tive    |        |           |          | ed on port      |
+-----------------+---------+--------+-----------+----------+-----------------+
| switch.port.re\ | Cumula\ | packet | switch ID | Pollster | Drops received  |
| ceive.drops     | tive    |        |           |          | on port         |
+-----------------+---------+--------+-----------+----------+-----------------+
| switch.port.tr\ | Cumula\ | packet | switch ID | Pollster | Drops transmitt\|
| ansmit.drops    | tive    |        |           |          | ed on port      |
+-----------------+---------+--------+-----------+----------+-----------------+
| switch.port.re\ | Cumula\ | packet | switch ID | Pollster | Errors received |
| ceive.errors    | tive    |        |           |          | on port         |
+-----------------+---------+--------+-----------+----------+-----------------+
| switch.port.tr\ | Cumula\ | packet | switch ID | Pollster | Errors transmit\|
| ansmit.errors   | tive    |        |           |          | ted on port     |
+-----------------+---------+--------+-----------+----------+-----------------+
| switch.port.re\ | Cumula\ | packet | switch ID | Pollster | Frame alignment |
| ceive.frame\_er\| tive    |        |           |          | errors receive\ |
| ror             |         |        |           |          | d on port       |
+-----------------+---------+--------+-----------+----------+-----------------+
| switch.port.re\ | Cumula\ | packet | switch ID | Pollster | Overrun errors  |
| ceive.overrun\_\| tive    |        |           |          | received on port|
| error           |         |        |           |          |                 |
+-----------------+---------+--------+-----------+----------+-----------------+
| switch.port.re\ | Cumula\ | packet | switch ID | Pollster | CRC errors rece\|
| ceive.crc\_error| tive    |        |           |          | ived on port    |
+-----------------+---------+--------+-----------+----------+-----------------+
| switch.port.co\ | Cumula\ | count  | switch ID | Pollster | Collisions on p\|
| llision.count   | tive    |        |           |          | ort             |
+-----------------+---------+--------+-----------+----------+-----------------+
| switch.table    | Gauge   | table  | switch ID | Pollster | Duration of tab\|
|                 |         |        |           |          | le              |
+-----------------+---------+--------+-----------+----------+-----------------+
| switch.table.a\ | Gauge   | entry  | switch ID | Pollster | Active entries  |
| ctive.entries   |         |        |           |          | in table        |
+-----------------+---------+--------+-----------+----------+-----------------+
| switch.table.l\ | Gauge   | packet | switch ID | Pollster | Lookup packets  |
| ookup.packets   |         |        |           |          | for table       |
+-----------------+---------+--------+-----------+----------+-----------------+
| switch.table.m\ | Gauge   | packet | switch ID | Pollster | Packets matches |
| atched.packets  |         |        |           |          | for table       |
+-----------------+---------+--------+-----------+----------+-----------------+
| switch.flow     | Gauge   | flow   | switch ID | Pollster | Duration of flow|
+-----------------+---------+--------+-----------+----------+-----------------+
| switch.flow.du\ | Gauge   | s      | switch ID | Pollster | Duration of flow|
| ration.seconds  |         |        |           |          | in seconds      |
+-----------------+---------+--------+-----------+----------+-----------------+
| switch.flow.du\ | Gauge   | ns     | switch ID | Pollster | Duration of flow|
| ration.nanosec\ |         |        |           |          | in nanoseconds  |
| onds            |         |        |           |          |                 |
+-----------------+---------+--------+-----------+----------+-----------------+
| switch.flow.pa\ | Cumula\ | packet | switch ID | Pollster | Packets received|
| ckets           | tive    |        |           |          |                 |
+-----------------+---------+--------+-----------+----------+-----------------+
| switch.flow.by\ | Cumula\ | B      | switch ID | Pollster | Bytes received  |
| tes             | tive    |        |           |          |                 |
+-----------------+---------+--------+-----------+----------+-----------------+

|

These meters are available for OpenFlow based switches. In order to
enable these meters, each driver needs to be properly configured.

Load-Balancer-as-a-Service (LBaaS v1)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following meters are collected for LBaaS v1:

+---------------+---------+---------+-----------+-----------+-----------------+
| Name          | Type    | Unit    | Resource  | Origin    | Note            |
+===============+=========+=========+===========+===========+=================+
| **Meters added in the Juno release**                                        |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Gauge   | pool    | pool ID   | Notifica\ | Existence of a  |
| ices.lb.pool  |         |         |           | tion, Po\ | LB pool         |
|               |         |         |           | llster    |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Gauge   | vip     | vip ID    | Notifica\ | Existence of a  |
| ices.lb.vip   |         |         |           | tion, Po\ | LB VIP          |
|               |         |         |           | llster    |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Gauge   | member  | member ID | Notifica\ | Existence of a  |
| ices.lb.memb\ |         |         |           | tion, Po\ | LB member       |
| er            |         |         |           | llster    |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Gauge   | health\ | monitor ID| Notifica\ | Existence of a  |
| ices.lb.heal\ |         | _monit\ |           | tion, Po\ | LB health probe |
| th_monitor    |         | or      |           | llster    |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Cumula\ | connec\ | pool ID   | Pollster  | Total connectio\|
| ices.lb.tota\ | tive    | tion    |           |           | ns on a LB      |
| l.connections |         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Gauge   | connec\ | pool ID   | Pollster  | Active connecti\|
| ices.lb.acti\ |         | tion    |           |           | ons on a LB     |
| ve.connections|         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Gauge   | B       | pool ID   | Pollster  | Number of incom\|
| ices.lb.inco\ |         |         |           |           | ing Bytes       |
| ming.bytes    |         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Gauge   | B       | pool ID   | Pollster  | Number of outgo\|
| ices.lb.outg\ |         |         |           |           | ing Bytes       |
| oing.bytes    |         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| **Meters added in the Kilo release**                                        |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Delta   | pool    | pool ID   | Notifica\ | LB pool was cre\|
| ices.lb.pool\ |         |         |           | tion      | ated            |
| .create       |         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Delta   | pool    | pool ID   | Notifica\ | LB pool was upd\|
| ices.lb.pool\ |         |         |           | tion      | ated            |
| .update       |         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Delta   | vip     | vip ID    | Notifica\ | LB VIP was crea\|
| ices.lb.vip.\ |         |         |           | tion      | ted             |
| create        |         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Delta   | vip     | vip ID    | Notifica\ | LB VIP was upda\|
| ices.lb.vip.\ |         |         |           | tion      | ted             |
| update        |         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Delta   | member  | member ID | Notifica\ | LB member was c\|
| ices.lb.memb\ |         |         |           | tion      | reated          |
| er.create     |         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Delta   | member  | member ID | Notifica\ | LB member was u\|
| ices.lb.memb\ |         |         |           | tion      | pdated          |
| er.update     |         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Delta   | health\ | monitor ID| Notifica\ | LB health probe |
| ices.lb.heal\ |         | _monit\ |           | tion      | was created     |
| th_monitor.c\ |         | or      |           |           |                 |
| reate         |         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Delta   | health\ | monitor ID| Notifica\ | LB health probe |
| ices.lb.heal\ |         | _monit\ |           | tion      | was updated     |
| th_monitor.u\ |         | or      |           |           |                 |
| pdate         |         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+

Load-Balancer-as-a-Service (LBaaS v2)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following meters are collected for LBaaS v2. They are added in Mitaka
release:

+---------------+---------+---------+-----------+-----------+-----------------+
| Name          | Type    | Unit    | Resource  | Origin    | Note            |
+===============+=========+=========+===========+===========+=================+
| network.serv\ | Gauge   | pool    | pool ID   | Notifica\ | Existence of a  |
| ices.lb.pool  |         |         |           | tion, Po\ | LB pool         |
|               |         |         |           | llster    |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Gauge   | listen\ | listener  | Notifica\ | Existence of a  |
| ices.lb.list\ |         | er      | ID        | tion, Po\ | LB listener     |
| ener          |         |         |           | llster    |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Gauge   | member  | member ID | Notifica\ | Existence of a  |
| ices.lb.memb\ |         |         |           | tion, Po\ | LB member       |
| er            |         |         |           | llster    |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Gauge   | health\ | monitor ID| Notifica\ | Existence of a  |
| ices.lb.heal\ |         | _monit\ |           | tion, Po\ | LB health probe |
| th_monitor    |         | or      |           | llster    |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Gauge   | loadba\ | loadbala\ | Notifica\ | Existence of a  |
| ices.lb.load\ |         | lancer  | ncer ID   | tion, Po\ | LB loadbalancer |
| balancer      |         |         |           | llster    |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Cumula\ | connec\ | pool ID   | Pollster  | Total connectio\|
| ices.lb.tota\ | tive    | tion    |           |           | ns on a LB      |
| l.connections |         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Gauge   | connec\ | pool ID   | Pollster  | Active connecti\|
| ices.lb.acti\ |         | tion    |           |           | ons on a LB     |
| ve.connections|         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Gauge   | B       | pool ID   | Pollster  | Number of incom\|
| ices.lb.inco\ |         |         |           |           | ing Bytes       |
| ming.bytes    |         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Gauge   | B       | pool ID   | Pollster  | Number of outgo\|
| ices.lb.outg\ |         |         |           |           | ing Bytes       |
| oing.bytes    |         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Delta   | pool    | pool ID   | Notifica\ | LB pool was cre\|
| ices.lb.pool\ |         |         |           | tion      | ated            |
| .create       |         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Delta   | pool    | pool ID   | Notifica\ | LB pool was upd\|
| ices.lb.pool\ |         |         |           | tion      | ated            |
| .update       |         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Delta   | listen\ | listener  | Notifica\ | LB listener was |
| ices.lb.list\ |         | er      | ID        | tion      | created         |
| ener.create   |         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Delta   | listen\ | listener  | Notifica\ | LB listener was |
| ices.lb.list\ |         | er      | ID        | tion      | updated         |
| ener.update   |         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Delta   | member  | member ID | Notifica\ | LB member was c\|
| ices.lb.memb\ |         |         |           | tion      | reated          |
| er.create     |         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Delta   | member  | member ID | Notifica\ | LB member was u\|
| ices.lb.memb\ |         |         |           | tion      | pdated          |
| er.update     |         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Delta   | health\ | monitor ID| Notifica\ | LB health probe |
| ices.lb.heal\ |         | _monit\ |           | tion      | was created     |
| thmonitor.cr\ |         | or      |           |           |                 |
| eate          |         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Delta   | health\ | monitor ID| Notifica\ | LB health probe |
| ices.lb.heal\ |         | _monit\ |           | tion      | was updated     |
| thmonitor.up\ |         | or      |           |           |                 |
| date          |         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Delta   | loadba\ | loadbala\ | Notifica\ | LB loadbalancer |
| ices.lb.load\ |         | lancer\ | ncer ID   | tion      | was created     |
| balancer.cre\ |         |         |           |           |                 |
| ate           |         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+
| network.serv\ | Delta   | loadba\ | loadbala\ | Notifica\ | LB loadbalancer |
| ices.lb.load\ |         | lancer\ | ncer ID   | tion      | was updated     |
| balancer.upd\ |         |         |           |           |                 |
| ate           |         |         |           |           |                 |
+---------------+---------+---------+-----------+-----------+-----------------+

.. note::

   The above meters are experimental and may generate a large load against the
   Neutron APIs. The future enhancement will be implemented when Neutron
   supports the new APIs.

VPN-as-a-Service (VPNaaS)
~~~~~~~~~~~~~~~~~~~~~~~~~

The following meters are collected for VPNaaS:

+---------------+-------+---------+------------+-----------+------------------+
| Name          | Type  | Unit    | Resource   | Origin    | Note             |
+===============+=======+=========+============+===========+==================+
| **Meters added in the Juno release**                                        |
+---------------+-------+---------+------------+-----------+------------------+
| network.serv\ | Gauge | vpnser\ | vpn ID     | Notifica\ | Existence of a   |
| ices.vpn      |       | vice    |            | tion, Po\ | VPN              |
|               |       |         |            | llster    |                  |
+---------------+-------+---------+------------+-----------+------------------+
| network.serv\ | Gauge | ipsec\_\| connection | Notifica\ | Existence of an  |
| ices.vpn.con\ |       | site\_c\| ID         | tion, Po\ | IPSec connection |
| nections      |       | onnect\ |            | llster    |                  |
|               |       | ion     |            |           |                  |
+---------------+-------+---------+------------+-----------+------------------+
| **Meters added in the Kilo release**                                        |
+---------------+-------+---------+------------+-----------+------------------+
| network.serv\ | Delta | vpnser\ | vpn ID     | Notifica\ | VPN was created  |
| ices.vpn.cre\ |       | vice    |            | tion      |                  |
| ate           |       |         |            |           |                  |
+---------------+-------+---------+------------+-----------+------------------+
| network.serv\ | Delta | vpnser\ | vpn ID     | Notifica\ | VPN was updated  |
| ices.vpn.upd\ |       | vice    |            | tion      |                  |
| ate           |       |         |            |           |                  |
+---------------+-------+---------+------------+-----------+------------------+
| network.serv\ | Delta | ipsec\_\| connection | Notifica\ | IPSec connection |
| ices.vpn.con\ |       | site\_c\| ID         | tion      | was created      |
| nections.cre\ |       | onnect\ |            |           |                  |
| ate           |       | ion     |            |           |                  |
+---------------+-------+---------+------------+-----------+------------------+
| network.serv\ | Delta | ipsec\_\| connection | Notifica\ | IPSec connection |
| ices.vpn.con\ |       | site\_c\| ID         | tion      | was updated      |
| nections.upd\ |       | onnect\ |            |           |                  |
| ate           |       | ion     |            |           |                  |
+---------------+-------+---------+------------+-----------+------------------+
| network.serv\ | Gauge | ipsecp\ | ipsecpolicy| Notifica\ | Existence of an  |
| ices.vpn.ips\ |       | olicy   | ID         | tion, Po\ | IPSec policy     |
| ecpolicy      |       |         |            | llster    |                  |
+---------------+-------+---------+------------+-----------+------------------+
| network.serv\ | Delta | ipsecp\ | ipsecpolicy| Notifica\ | IPSec policy was |
| ices.vpn.ips\ |       | olicy   | ID         | tion      | created          |
| ecpolicy.cre\ |       |         |            |           |                  |
| ate           |       |         |            |           |                  |
+---------------+-------+---------+------------+-----------+------------------+
| network.serv\ | Delta | ipsecp\ | ipsecpolicy| Notifica\ | IPSec policy was |
| ices.vpn.ips\ |       | olicy   | ID         | tion      | updated          |
| ecpolicy.upd\ |       |         |            |           |                  |
| ate           |       |         |            |           |                  |
+---------------+-------+---------+------------+-----------+------------------+
| network.serv\ | Gauge | ikepol\ | ikepolicy  | Notifica\ | Existence of an  |
| ices.vpn.ike\ |       | icy     | ID         | tion, Po\ | Ike policy       |
| policy        |       |         |            | llster    |                  |
+---------------+-------+---------+------------+-----------+------------------+
| network.serv\ | Delta | ikepol\ | ikepolicy  | Notifica\ | Ike policy was   |
| ices.vpn.ike\ |       | icy     | ID         | tion      | created          |
| policy.create |       |         |            |           |                  |
+---------------+-------+---------+------------+-----------+------------------+
| network.serv\ | Delta | ikepol\ | ikepolicy  | Notifica\ | Ike policy was   |
| ices.vpn.ike\ |       | icy     | ID         | tion      | updated          |
| policy.update |       |         |            |           |                  |
+---------------+-------+---------+------------+-----------+------------------+

Firewall-as-a-Service (FWaaS)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following meters are collected for FWaaS:

+---------------+-------+---------+------------+-----------+------------------+
| Name          | Type  | Unit    | Resource   | Origin    | Note             |
+===============+=======+=========+============+===========+==================+
| **Meters added in the Juno release**                                        |
+---------------+-------+---------+------------+-----------+------------------+
| network.serv\ | Gauge | firewall| firewall ID| Notifica\ | Existence of a   |
| ices.firewall |       |         |            | tion, Po\ | firewall         |
|               |       |         |            | llster    |                  |
+---------------+-------+---------+------------+-----------+------------------+
| network.serv\ | Gauge | firewa\ | firewall ID| Notifica\ | Existence of a   |
| ices.firewal\ |       | ll_pol\ |            | tion, Po\ | firewall policy  |
| l.policy      |       | icy     |            | llster    |                  |
+---------------+-------+---------+------------+-----------+------------------+
| **Meters added in the Kilo release**                                        |
+---------------+-------+---------+------------+-----------+------------------+
| network.serv\ | Delta | firewall| firewall ID| Notifica\ | Firewall was cr\ |
| ices.firewal\ |       |         |            | tion      | eated            |
| l.create      |       |         |            |           |                  |
+---------------+-------+---------+------------+-----------+------------------+
| network.serv\ | Delta | firewall| firewall ID| Notifica\ | Firewall was up\ |
| ices.firewal\ |       |         |            | tion      | dated            |
| l.update      |       |         |            |           |                  |
+---------------+-------+---------+------------+-----------+------------------+
| network.serv\ | Delta | firewa\ | policy ID  | Notifica\ | Firewall policy  |
| ices.firewal\ |       | ll_pol\ |            | tion      | was created      |
| l.policy.cre\ |       | icy     |            |           |                  |
| ate           |       |         |            |           |                  |
+---------------+-------+---------+------------+-----------+------------------+
| network.serv\ | Delta | firewa\ | policy ID  | Notifica\ | Firewall policy  |
| ices.firewal\ |       | ll_pol\ |            | tion      | was updated      |
| l.policy.upd\ |       | icy     |            |           |                  |
| ate           |       |         |            |           |                  |
+---------------+-------+---------+------------+-----------+------------------+
| network.serv\ | Gauge | firewa\ | rule ID    | Notifica\ | Existence of a   |
| ices.firewal\ |       | ll_rule |            | tion      | firewall rule    |
| l.rule        |       |         |            |           |                  |
+---------------+-------+---------+------------+-----------+------------------+
| network.serv\ | Delta | firewa\ | rule ID    | Notifica\ | Firewall rule w\ |
| ices.firewal\ |       | ll_rule |            | tion      | as created       |
| l.rule.create |       |         |            |           |                  |
|               |       |         |            |           |                  |
+---------------+-------+---------+------------+-----------+------------------+
| network.serv\ | Delta | firewa\ | rule ID    | Notifica\ | Firewall rule w\ |
| ices.firewal\ |       | ll_rule |            | tion      | as updated       |
| l.rule.update |       |         |            |           |                  |
+---------------+-------+---------+------------+-----------+------------------+

Orchestration service
~~~~~~~~~~~~~~~~~~~~~

The following meters are collected for the Orchestration service:

+----------------+-------+------+----------+--------------+-------------------+
| Name           | Type  | Unit | Resource | Origin       | Note              |
+================+=======+======+==========+==============+===================+
| **Meters added in the Icehouse release or earlier**                         |
+----------------+-------+------+----------+--------------+-------------------+
| stack.create   | Delta | stack| stack ID | Notification | Stack was success\|
|                |       |      |          |              | fully created     |
+----------------+-------+------+----------+--------------+-------------------+
| stack.update   | Delta | stack| stack ID | Notification | Stack was success\|
|                |       |      |          |              | fully updated     |
+----------------+-------+------+----------+--------------+-------------------+
| stack.delete   | Delta | stack| stack ID | Notification | Stack was success\|
|                |       |      |          |              | fully deleted     |
+----------------+-------+------+----------+--------------+-------------------+
| stack.resume   | Delta | stack| stack ID | Notification | Stack was success\|
|                |       |      |          |              | fully resumed     |
+----------------+-------+------+----------+--------------+-------------------+
| stack.suspend  | Delta | stack| stack ID | Notification | Stack was success\|
|                |       |      |          |              | fully suspended   |
+----------------+-------+------+----------+--------------+-------------------+
| **All meters thoroughly deprecated in the Liberty release**                 |
+------------------+-------+------+----------+-------------+------------------+

Data processing service for OpenStack
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following meters are collected for the Data processing service for
OpenStack:

+----------------+-------+---------+-----------+-------------+----------------+
| Name           | Type  | Unit    | Resource  | Origin      | Note           |
+================+=======+=========+===========+=============+================+
| **Meters added in the Juno release**                                        |
+----------------+-------+---------+-----------+-------------+----------------+
| cluster.create | Delta | cluster | cluster ID| Notification| Cluster was    |
|                |       |         |           |             | successfully   |
|                |       |         |           |             | created        |
|                |       |         |           |             |                |
+----------------+-------+---------+-----------+-------------+----------------+
| cluster.update | Delta | cluster | cluster ID| Notification| Cluster was    |
|                |       |         |           |             | successfully   |
|                |       |         |           |             | updated        |
+----------------+-------+---------+-----------+-------------+----------------+
| cluster.delete | Delta | cluster | cluster ID| Notification| Cluster was    |
|                |       |         |           |             | successfully   |
|                |       |         |           |             | deleted        |
+----------------+-------+---------+-----------+-------------+----------------+
| **All meters thoroughly deprecated in the Liberty release**                 |
+------------------+-------+------+----------+-------------+------------------+

Key Value Store module
~~~~~~~~~~~~~~~~~~~~~~

The following meters are collected for the Key Value Store module:

+------------------+-------+------+----------+-------------+------------------+
| Name             | Type  | Unit | Resource | Origin      | Note             |
+==================+=======+======+==========+=============+==================+
| **Meters added in the Kilo release**                                        |
+------------------+-------+------+----------+-------------+------------------+
| magnetodb.table.\| Gauge | table| table ID | Notification| Table was succe\ |
| create           |       |      |          |             | ssfully created  |
+------------------+-------+------+----------+-------------+------------------+
| magnetodb.table\ | Gauge | table| table ID | Notification| Table was succe\ |
| .delete          |       |      |          |             | ssfully deleted  |
+------------------+-------+------+----------+-------------+------------------+
| magnetodb.table\ | Gauge | index| table ID | Notification| Number of indices|
| .index.count     |       |      |          |             | created in a     |
|                  |       |      |          |             | table            |
+------------------+-------+------+----------+-------------+------------------+

|

.. note::

   The Key Value Store meters are not supported in the Newton release and
   later.

Energy
~~~~~~

The following energy related meters are available:

+---------------+------------+------+----------+----------+-------------------+
| Name          | Type       | Unit | Resource | Origin   | Note              |
+===============+============+======+==========+==========+===================+
| **Meters added in the Icehouse release or earlier**                         |
+---------------+------------+------+----------+----------+-------------------+
| energy        | Cumulative | kWh  | probe ID | Pollster | Amount of energy  |
+---------------+------------+------+----------+----------+-------------------+
| power         | Gauge      | W    | probe ID | Pollster | Power consumption |
+---------------+------------+------+----------+----------+-------------------+
