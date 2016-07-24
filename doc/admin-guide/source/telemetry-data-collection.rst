.. _telemetry-data-collection:

===============
Data collection
===============

The main responsibility of Telemetry in OpenStack is to collect
information about the system that can be used by billing systems or
interpreted by analytic tooling. The original focus, regarding to the
collected data, was on the counters that can be used for billing, but
the range is getting wider continuously.

Collected data can be stored in the form of samples or events in the
supported databases, listed in :ref:`telemetry-supported-databases`.

Samples can have various sources regarding to the needs and
configuration of Telemetry, which requires multiple methods to collect
data.

The available data collection mechanisms are:

Notifications
    Processing notifications from other OpenStack services, by consuming
    messages from the configured message queue system.

Polling
    Retrieve information directly from the hypervisor or from the host
    machine using SNMP, or by using the APIs of other OpenStack
    services.

RESTful API
    Pushing samples via the RESTful API of Telemetry.

Notifications
~~~~~~~~~~~~~
All the services send notifications about the executed operations or
system state in OpenStack. Several notifications carry information that
can be metered, like the CPU time of a VM instance created by OpenStack
Compute service.

The Telemetry service has a separate agent that is responsible for
consuming notifications, namely the notification agent. This component
is responsible for consuming from the message bus and transforming
notifications into events and measurement samples. Beginning in the Liberty
release, the notification agent is responsible for all data processing such as
transformations and publishing. After processing, the data is sent via AMQP to
the collector service or any external service, which is responsible for
persisting the data into the configured database back end.


The different OpenStack services emit several notifications about the
various types of events that happen in the system during normal
operation. Not all these notifications are consumed by the Telemetry
service, as the intention is only to capture the billable events and
notifications that can be used for monitoring or profiling purposes. The
notification agent filters by the event type, that is contained by each
notification message. The following table contains the event types by
each OpenStack service that are transformed to samples by Telemetry.

+--------------------+------------------------+-------------------------------+
| OpenStack service  | Event types            | Note                          |
+====================+========================+===============================+
| OpenStack Compute  | scheduler.run\_insta\  | For a more detailed list of   |
|                    | nce.scheduled          | Compute notifications please  |
|                    |                        | check the `System Usage Data  |
|                    | scheduler.select\_\    | Data wiki page <https://wiki  |
|                    | destinations           | .openstack.org/wiki/          |
|                    |                        | SystemUsageData>`__.          |
|                    | compute.instance.\*    |                               |
+--------------------+------------------------+-------------------------------+
| Bare metal service | hardware.ipmi.\*       |                               |
+--------------------+------------------------+-------------------------------+
| OpenStack Image    | image.update           | The required configuration    |
| service            |                        | for Image service can be      |
|                    | image.upload           | found in `Configure the Image |
|                    |                        | service for Telemetry section |
|                    | image.delete           | <http://docs.openstack.org    |
|                    |                        | /mitaka/install-guide-ubuntu  |
|                    | image.send             | /ceilometer-glance.html>`__   |
|                    |                        | section in the OpenStack      |
|                    |                        | Installation Guide            |
+--------------------+------------------------+-------------------------------+
| OpenStack          | floatingip.create.end  |                               |
| Networking         |                        |                               |
|                    | floatingip.update.\*   |                               |
|                    |                        |                               |
|                    | floatingip.exists      |                               |
|                    |                        |                               |
|                    | network.create.end     |                               |
|                    |                        |                               |
|                    | network.update.\*      |                               |
|                    |                        |                               |
|                    | network.exists         |                               |
|                    |                        |                               |
|                    | port.create.end        |                               |
|                    |                        |                               |
|                    | port.update.\*         |                               |
|                    |                        |                               |
|                    | port.exists            |                               |
|                    |                        |                               |
|                    | router.create.end      |                               |
|                    |                        |                               |
|                    | router.update.\*       |                               |
|                    |                        |                               |
|                    | router.exists          |                               |
|                    |                        |                               |
|                    | subnet.create.end      |                               |
|                    |                        |                               |
|                    | subnet.update.\*       |                               |
|                    |                        |                               |
|                    | subnet.exists          |                               |
|                    |                        |                               |
|                    | l3.meter               |                               |
+--------------------+------------------------+-------------------------------+
| Orchestration      | orchestration.stack\   |                               |
| service            | .create.end            |                               |
|                    |                        |                               |
|                    | orchestration.stack\   |                               |
|                    | .update.end            |                               |
|                    |                        |                               |
|                    | orchestration.stack\   |                               |
|                    | .delete.end            |                               |
|                    |                        |                               |
|                    | orchestration.stack\   |                               |
|                    | .resume.end            |                               |
|                    |                        |                               |
|                    | orchestration.stack\   |                               |
|                    | .suspend.end           |                               |
+--------------------+------------------------+-------------------------------+
| OpenStack Block    | volume.exists          | The required configuration    |
| Storage            |                        | for Block Storage service can |
|                    | volume.create.\*       | be found in the `Add the      |
|                    |                        | Block Storage service agent   |
|                    | volume.delete.\*       | for Telemetry section <http:  |
|                    |                        | //docs.openstack.org/mitaka/  |
|                    | volume.update.\*       | install-guide-ubuntu/         |
|                    |                        | /ceilometer-cinder.html>`__   |
|                    | volume.resize.\*       | section in the                |
|                    |                        | OpenStack Installation Guide. |
|                    | volume.attach.\*       |                               |
|                    |                        |                               |
|                    | volume.detach.\*       |                               |
|                    |                        |                               |
|                    | snapshot.exists        |                               |
|                    |                        |                               |
|                    | snapshot.create.\*     |                               |
|                    |                        |                               |
|                    | snapshot.delete.\*     |                               |
|                    |                        |                               |
|                    | snapshot.update.\*     |                               |
|                    |                        |                               |
|                    | volume.backup.create.\ |                               |
|                    | \*                     |                               |
|                    |                        |                               |
|                    | volume.backup.delete.\ |                               |
|                    | \*                     |                               |
|                    |                        |                               |
|                    | volume.backup.restore.\|                               |
|                    | \*                     |                               |
+--------------------+------------------------+-------------------------------+

.. note::

   Some services require additional configuration to emit the
   notifications using the correct control exchange on the message
   queue and so forth. These configuration needs are referred in the
   above table for each OpenStack service that needs it.

Specific notifications from the Compute service are important for
administrators and users. Configuring ``nova_notifications`` in the
``nova.conf`` file allows administrators to respond to events
rapidly. For more information on configuring notifications for the
compute service, see
`Telemetry services <http://docs.openstack.org/
mitaka/install-guide-ubuntu/ceilometer-nova.html>`__ in the
OpenStack Installation Guide.

.. note::

   When the ``store_events`` option is set to ``True`` in
   ``ceilometer.conf``, Prior to the Kilo release, the notification agent
   needed database access in order to work properly.

Middleware for the OpenStack Object Storage service
---------------------------------------------------

A subset of Object Store statistics requires additional middleware to
be installed behind the proxy of Object Store. This additional component
emits notifications containing data-flow-oriented meters, namely the
``storage.objects.(incoming|outgoing).bytes values``. The list of these
meters are listed in :ref:`telemetry-object-storage-meter`, marked with
``notification`` as origin.

The instructions on how to install this middleware can be found in
`Configure the Object Storage service for Telemetry
<http://docs.openstack.org/mitaka/install-guide-ubuntu/ceilometer-swift.html>`__
section in the OpenStack Installation Guide.

Telemetry middleware
--------------------

Telemetry provides the capability of counting the HTTP requests and
responses for each API endpoint in OpenStack. This is achieved by
storing a sample for each event marked as ``audit.http.request``,
``audit.http.response``, ``http.request`` or ``http.response``.

It is recommended that these notifications be consumed as events rather
than samples to better index the appropriate values and avoid massive
load on the Metering database. If preferred, Telemetry can consume these
events as samples if the services are configured to emit ``http.*``
notifications.

Polling
~~~~~~~

The Telemetry service is intended to store a complex picture of the
infrastructure. This goal requires additional information than what is
provided by the events and notifications published by each service. Some
information is not emitted directly, like resource usage of the VM
instances.

Therefore Telemetry uses another method to gather this data by polling
the infrastructure including the APIs of the different OpenStack
services and other assets, like hypervisors. The latter case requires
closer interaction with the compute hosts. To solve this issue,
Telemetry uses an agent based architecture to fulfill the requirements
against the data collection.

There are three types of agents supporting the polling mechanism, the
``compute agent``, the ``central agent``, and the ``IPMI agent``. Under
the hood, all the types of polling agents are the same
``ceilometer-polling`` agent, except that they load different polling
plug-ins (pollsters) from different namespaces to gather data. The following
subsections give further information regarding the architectural and
configuration details of these components.

Running :command:`ceilometer-agent-compute` is exactly the same as:

.. code-block:: console

   $ ceilometer-polling --polling-namespaces compute

Running :command:`ceilometer-agent-central` is exactly the same as:

.. code-block:: console

   $ ceilometer-polling --polling-namespaces central

Running :command:`ceilometer-agent-ipmi` is exactly the same as:

.. code-block:: console

   $ ceilometer-polling --polling-namespaces ipmi

In addition to loading all the polling plug-ins registered in the
specified namespaces, the ``ceilometer-polling`` agent can also specify the
polling plug-ins to be loaded by using the ``pollster-list`` option:

.. code-block:: console

   $ ceilometer-polling --polling-namespaces central \
           --pollster-list image image.size storage.*

.. note::

   HA deployment is NOT supported if the ``pollster-list`` option is
   used.

.. note::

   The ``ceilometer-polling`` service is available since Kilo release.

Central agent
-------------

This agent is responsible for polling public REST APIs to retrieve additional
information on OpenStack resources not already surfaced via notifications,
and also for polling hardware resources over SNMP.

The following services can be polled with this agent:

-  OpenStack Networking

-  OpenStack Object Storage

-  OpenStack Block Storage

-  Hardware resources via SNMP

-  Energy consumption meters via `Kwapi <https://launchpad.net/kwapi>`__
   framework

To install and configure this service use the `Add the Telemetry service
<http://docs.openstack.org/mitaka/install-guide-ubuntu/ceilometer.html>`__
section in the OpenStack Installation Guide.

The central agent does not need direct database connection. The samples
collected by this agent are sent via AMQP to the notification agent to be
processed.

.. note::

   Prior to the Liberty release, data from the polling agents was processed
   locally and published accordingly rather than by the notification agent.

Compute agent
-------------

This agent is responsible for collecting resource usage data of VM
instances on individual compute nodes within an OpenStack deployment.
This mechanism requires a closer interaction with the hypervisor,
therefore a separate agent type fulfills the collection of the related
meters, which is placed on the host machines to locally retrieve this
information.

A compute agent instance has to be installed on each and every compute
node, installation instructions can be found in the `Install the Compute
agent for Telemetry
<http://docs.openstack.org/mitaka/install-guide-ubuntu/ceilometer-nova.html>`__
section in the OpenStack Installation Guide.

Just like the central agent, this component also does not need a direct
database connection. The samples are sent via AMQP to the notification agent.

The list of supported hypervisors can be found in
:ref:`telemetry-supported-hypervisors`. The compute agent uses the API of the
hypervisor installed on the compute hosts. Therefore the supported meters may
be different in case of each virtualization back end, as each inspection tool
provides a different set of meters.

The list of collected meters can be found in :ref:`telemetry-compute-meters`.
The support column provides the information that which meter is available for
each hypervisor supported by the Telemetry service.

.. note::

    Telemetry supports Libvirt, which hides the hypervisor under it.

.. _telemetry-ipmi-agent:

IPMI agent
----------

This agent is responsible for collecting IPMI sensor data and Intel Node
Manager data on individual compute nodes within an OpenStack deployment.
This agent requires an IPMI capable node with the ipmitool utility installed,
which is commonly used for IPMI control on various Linux distributions.

An IPMI agent instance could be installed on each and every compute node
with IPMI support, except when the node is managed by the Bare metal
service and the ``conductor.send_sensor_data`` option is set to ``true``
in the Bare metal service. It is no harm to install this agent on a
compute node without IPMI or Intel Node Manager support, as the agent
checks for the hardware and if none is available, returns empty data. It
is suggested that you install the IPMI agent only on an IPMI capable
node for performance reasons.

Just like the central agent, this component also does not need direct
database access. The samples are sent via AMQP to the notification agent.

The list of collected meters can be found in
:ref:`telemetry-bare-metal-service`.

.. note::

   Do not deploy both the IPMI agent and the Bare metal service on one
   compute node. If ``conductor.send_sensor_data`` is set, this
   misconfiguration causes duplicated IPMI sensor samples.


.. _ha-deploy-services:

Support for HA deployment
~~~~~~~~~~~~~~~~~~~~~~~~~
Both the polling agents and notification agents can run in an HA deployment,
which means that multiple instances of these services can run in
parallel with workload partitioning among these running instances.

The `Tooz <https://pypi.python.org/pypi/tooz>`__ library provides the
coordination within the groups of service instances. It provides an API
above several back ends that can be used for building distributed
applications.

Tooz supports `various
drivers <http://docs.openstack.org/developer/tooz/drivers.html>`__
including the following back end solutions:

-  `Zookeeper <http://zookeeper.apache.org/>`__. Recommended solution by
   the Tooz project.

-  `Redis <http://redis.io/>`__. Recommended solution by the Tooz
   project.

-  `Memcached <http://memcached.org/>`__. Recommended for testing.

You must configure a supported Tooz driver for the HA deployment of the
Telemetry services.

For information about the required configuration options that have to be
set in the ``ceilometer.conf`` configuration file for both the central
and compute agents, see the `Coordination section
<http://docs.openstack.org/mitaka/config-reference/telemetry/telemetry_service_config_opts.html>`__
in the OpenStack Configuration Reference.

Notification agent HA deployment
--------------------------------

In the Kilo release, workload partitioning support was added to the
notification agent. This is particularly useful as the pipeline processing
is handled exclusively by the notification agent now which may result
in a larger amount of load.

To enable workload partitioning by notification agent, the ``backend_url``
option must be set in the ``ceilometer.conf`` configuration file.
Additionally, ``workload_partitioning`` should be enabled in the
`Notification section <http://docs.openstack.org/mitaka/config-reference/telemetry/telemetry_service_config_opts.html>`__ in the OpenStack Configuration Reference.

.. note::

   In Liberty, the notification agent creates multiple queues to divide the
   workload across all active agents. The number of queues can be controlled by
   the ``pipeline_processing_queues`` option in the ``ceilometer.conf``
   configuration file. A larger value will result in better distribution of
   tasks but will also require more memory and longer startup time. It is
   recommended to have a value approximately three times the number of active
   notification agents. At a minimum, the value should be equal to the number
   of active agents.

Polling agent HA deployment
---------------------------

.. note::

    Without the ``backend_url`` option being set only one instance of
    both the central and compute agent service is able to run and
    function correctly.

The availability check of the instances is provided by heartbeat
messages. When the connection with an instance is lost, the workload
will be reassigned within the remained instances in the next polling
cycle.

.. note::

    ``Memcached`` uses a ``timeout`` value, which should always be set
    to a value that is higher than the ``heartbeat`` value set for
    Telemetry.

For backward compatibility and supporting existing deployments, the
central agent configuration also supports using different configuration
files for groups of service instances of this type that are running in
parallel. For enabling this configuration set a value for the
``partitioning_group_prefix`` option in the `Central section
<http://docs.openstack.org/mitaka/config-reference/telemetry/telemetry_service_config_opts.html>`__
in the OpenStack Configuration Reference.

.. warning::

    For each sub-group of the central agent pool with the same
    ``partitioning_group_prefix`` a disjoint subset of meters must be
    polled, otherwise samples may be missing or duplicated. The list of
    meters to poll can be set in the ``/etc/ceilometer/pipeline.yaml``
    configuration file. For more information about pipelines see
    :ref:`data-collection-and-processing`.

To enable the compute agent to run multiple instances simultaneously
with workload partitioning, the ``workload_partitioning`` option has to
be set to ``True`` under the `Compute section
<http://docs.openstack.org/mitaka/config-reference/telemetry/telemetry_service_config_opts.html>`__
in the ``ceilometer.conf`` configuration file.


Send samples to Telemetry
~~~~~~~~~~~~~~~~~~~~~~~~~

While most parts of the data collection in the Telemetry service are
automated, Telemetry provides the possibility to submit samples via the
REST API to allow users to send custom samples into this service.

This option makes it possible to send any kind of samples without the
need of writing extra code lines or making configuration changes.

The samples that can be sent to Telemetry are not limited to the actual
existing meters. There is a possibility to provide data for any new,
customer defined counter by filling out all the required fields of the
POST request.

If the sample corresponds to an existing meter, then the fields like
``meter-type`` and meter name should be matched accordingly.

The required fields for sending a sample using the command-line client
are:

-  ID of the corresponding resource. (:option:`--resource-id`)

-  Name of meter. (:option:`--meter-name`)

-  Type of meter. (:option:`--meter-type`)

   Predefined meter types:

   -  Gauge

   -  Delta

   -  Cumulative

-  Unit of meter. (:option:`--meter-unit`)

-  Volume of sample. (:option:`--sample-volume`)

To send samples to Telemetry using the command-line client, the
following command should be invoked:

.. code-block:: console

   $ ceilometer sample-create -r 37128ad6-daaa-4d22-9509-b7e1c6b08697 \
     -m memory.usage --meter-type gauge --meter-unit MB --sample-volume 48
   +-------------------+--------------------------------------------+
   | Property          | Value                                      |
   +-------------------+--------------------------------------------+
   | message_id        | 6118820c-2137-11e4-a429-08002715c7fb       |
   | name              | memory.usage                               |
   | project_id        | e34eaa91d52a4402b4cb8bc9bbd308c1           |
   | resource_id       | 37128ad6-daaa-4d22-9509-b7e1c6b08697       |
   | resource_metadata | {}                                         |
   | source            | e34eaa91d52a4402b4cb8bc9bbd308c1:openstack |
   | timestamp         | 2014-08-11T09:10:46.358926                 |
   | type              | gauge                                      |
   | unit              | MB                                         |
   | user_id           | 679b0499e7a34ccb9d90b64208401f8e           |
   | volume            | 48.0                                       |
   +-------------------+--------------------------------------------+

.. _data-collection-and-processing:

Data collection and processing
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The mechanism by which data is collected and processed is called a
pipeline. Pipelines, at the configuration level, describe a coupling
between sources of data and the corresponding sinks for transformation
and publication of data.

A source is a producer of data: ``samples`` or ``events``. In effect, it is a
set of pollsters or notification handlers emitting datapoints for a set
of matching meters and event types.

Each source configuration encapsulates name matching, polling interval
determination, optional resource enumeration or discovery, and mapping
to one or more sinks for publication.

Data gathered can be used for different purposes, which can impact how
frequently it needs to be published. Typically, a meter published for
billing purposes needs to be updated every 30 minutes while the same
meter may be needed for performance tuning every minute.

.. warning::

   Rapid polling cadences should be avoided, as it results in a huge
   amount of data in a short time frame, which may negatively affect
   the performance of both Telemetry and the underlying database back
   end. We therefore strongly recommend you do not use small
   granularity values like 10 seconds.

A sink, on the other hand, is a consumer of data, providing logic for
the transformation and publication of data emitted from related sources.

In effect, a sink describes a chain of handlers. The chain starts with
zero or more transformers and ends with one or more publishers. The
first transformer in the chain is passed data from the corresponding
source, takes some action such as deriving rate of change, performing
unit conversion, or aggregating, before passing the modified data to the
next step that is described in :ref:`telemetry-publishers`.

.. _telemetry-pipeline-configuration:

Pipeline configuration
----------------------
Pipeline configuration by default, is stored in separate configuration
files, called ``pipeline.yaml`` and ``event_pipeline.yaml``, next to
the ``ceilometer.conf`` file. The meter pipeline and event pipeline
configuration files can be set by the ``pipeline_cfg_file`` and
``event_pipeline_cfg_file`` options listed in the `Description of
configuration options for api table
<http://docs.openstack.org/mitaka/config-reference/telemetry/telemetry_service_config_opts.html>`__
section in the OpenStack Configuration Reference respectively. Multiple
pipelines can be defined in one pipeline configuration file.

The meter pipeline definition looks like:

.. code-block:: yaml

   ---
   sources:
     - name: 'source name'
       interval: 'how often should the samples be injected into the pipeline'
       meters:
         - 'meter filter'
       resources:
         - 'list of resource URLs'
       sinks
         - 'sink name'
   sinks:
     - name: 'sink name'
       transformers: 'definition of transformers'
       publishers:
         - 'list of publishers'

The interval parameter in the sources section should be defined in
seconds. It determines the polling cadence of sample injection into the
pipeline, where samples are produced under the direct control of an
agent.

There are several ways to define the list of meters for a pipeline
source. The list of valid meters can be found in :ref:`telemetry-measurements`.
There is a possibility to define all the meters, or just included or excluded
meters, with which a source should operate:

-  To include all meters, use the ``*`` wildcard symbol. It is highly
   advisable to select only the meters that you intend on using to avoid
   flooding the metering database with unused data.

-  To define the list of meters, use either of the following:

   -  To define the list of included meters, use the ``meter_name``
      syntax.

   -  To define the list of excluded meters, use the ``!meter_name``
      syntax.

   -  For meters, which have variants identified by a complex name
      field, use the wildcard symbol to select all, for example,
      for ``instance:m1.tiny``, use ``instance:\*``.

.. note::

   Please be aware that we do not have any duplication check between
   pipelines and if you add a meter to multiple pipelines then it is
   assumed the duplication is intentional and may be stored multiple
   times according to the specified sinks.

The above definition methods can be used in the following combinations:

-  Use only the wildcard symbol.

-  Use the list of included meters.

-  Use the list of excluded meters.

-  Use wildcard symbol with the list of excluded meters.

.. note::

   At least one of the above variations should be included in the
   meters section. Included and excluded meters cannot co-exist in the
   same pipeline. Wildcard and included meters cannot co-exist in the
   same pipeline definition section.

The optional resources section of a pipeline source allows a static list
of resource URLs to be configured for polling.

The transformers section of a pipeline sink provides the possibility to
add a list of transformer definitions. The available transformers are:

+-----------------------+------------------------------------+
| Name of transformer   | Reference name for configuration   |
+=======================+====================================+
| Accumulator           | accumulator                        |
+-----------------------+------------------------------------+
| Aggregator            | aggregator                         |
+-----------------------+------------------------------------+
| Arithmetic            | arithmetic                         |
+-----------------------+------------------------------------+
| Rate of change        | rate\_of\_change                   |
+-----------------------+------------------------------------+
| Unit conversion       | unit\_conversion                   |
+-----------------------+------------------------------------+
| Delta                 | delta                              |
+-----------------------+------------------------------------+

The publishers section contains the list of publishers, where the
samples data should be sent after the possible transformations.

Similarly, the event pipeline definition looks like:

.. code-block:: yaml

   ---
   sources:
     - name: 'source name'
       events:
         - 'event filter'
       sinks
         - 'sink name'
   sinks:
     - name: 'sink name'
       publishers:
         - 'list of publishers'

The event filter uses the same filtering logic as the meter pipeline.

.. _telemetry-transformers:

Transformers
^^^^^^^^^^^^

The definition of transformers can contain the following fields:

name
    Name of the transformer.

parameters
    Parameters of the transformer.

The parameters section can contain transformer specific fields, like
source and target fields with different subfields in case of the rate of
change, which depends on the implementation of the transformer.

In the case of the transformer that creates the ``cpu_util`` meter, the
definition looks like:

.. code-block:: yaml

   transformers:
       - name: "rate_of_change"
         parameters:
             target:
                 name: "cpu_util"
                 unit: "%"
                 type: "gauge"
                 scale: "100.0 / (10**9 * (resource_metadata.cpu_number or 1))"

The rate of change the transformer generates is the ``cpu_util`` meter
from the sample values of the ``cpu`` counter, which represents
cumulative CPU time in nanoseconds. The transformer definition above
defines a scale factor (for nanoseconds and multiple CPUs), which is
applied before the transformation derives a sequence of gauge samples
with unit ``%``, from sequential values of the ``cpu`` meter.

The definition for the disk I/O rate, which is also generated by the
rate of change transformer:

.. code-block:: yaml

   transformers:
       - name: "rate_of_change"
         parameters:
             source:
                 map_from:
                     name: "disk\\.(read|write)\\.(bytes|requests)"
                     unit: "(B|request)"
             target:
                 map_to:
                     name: "disk.\\1.\\2.rate"
                     unit: "\\1/s"
                 type: "gauge"

**Unit conversion transformer**

Transformer to apply a unit conversion. It takes the volume of the meter
and multiplies it with the given ``scale`` expression. Also supports
``map_from`` and ``map_to`` like the rate of change transformer.

Sample configuration:

.. code-block:: yaml

   transformers:
       - name: "unit_conversion"
         parameters:
             target:
                 name: "disk.kilobytes"
                 unit: "KB"
                 scale: "volume * 1.0 / 1024.0"

With ``map_from`` and ``map_to``:

.. code-block:: yaml

   transformers:
       - name: "unit_conversion"
         parameters:
             source:
                 map_from:
                     name: "disk\\.(read|write)\\.bytes"
             target:
                 map_to:
                     name: "disk.\\1.kilobytes"
                 scale: "volume * 1.0 / 1024.0"
                 unit: "KB"

**Aggregator transformer**

A transformer that sums up the incoming samples until enough samples
have come in or a timeout has been reached.

Timeout can be specified with the ``retention_time`` option. If we want
to flush the aggregation after a set number of samples have been
aggregated, we can specify the size parameter.

The volume of the created sample is the sum of the volumes of samples
that came into the transformer. Samples can be aggregated by the
attributes ``project_id``, ``user_id`` and ``resource_metadata``. To aggregate
by the chosen attributes, specify them in the configuration and set which
value of the attribute to take for the new sample (first to take the
first sample's attribute, last to take the last sample's attribute, and
drop to discard the attribute).

To aggregate 60s worth of samples by ``resource_metadata`` and keep the
``resource_metadata`` of the latest received sample:

.. code-block:: yaml

   transformers:
       - name: "aggregator"
         parameters:
             retention_time: 60
             resource_metadata: last

To aggregate each 15 samples by ``user_id`` and ``resource_metadata`` and keep
the ``user_id`` of the first received sample and drop the
``resource_metadata``:

.. code-block:: yaml

   transformers:
       - name: "aggregator"
         parameters:
             size: 15
             user_id: first
             resource_metadata: drop

**Accumulator transformer**

This transformer simply caches the samples until enough samples have
arrived and then flushes them all down the pipeline at once:

.. code-block:: yaml

   transformers:
       - name: "accumulator"
         parameters:
             size: 15

**Multi meter arithmetic transformer**

This transformer enables us to perform arithmetic calculations over one
or more meters and/or their metadata, for example:

.. code-block:: json

   memory_util = 100 * memory.usage / memory

A new sample is created with the properties described in the ``target``
section of the transformer's configuration. The sample's
volume is the result of the provided expression. The calculation is
performed on samples from the same resource.

.. note::

   The calculation is limited to meters with the same interval.

Example configuration:

.. code-block:: yaml

   transformers:
       - name: "arithmetic"
         parameters:
           target:
             name: "memory_util"
             unit: "%"
             type: "gauge"
             expr: "100 * $(memory.usage) / $(memory)"

To demonstrate the use of metadata, here is the implementation of a
silly meter that shows average CPU time per core:

.. code-block:: yaml

   transformers:
       - name: "arithmetic"
         parameters:
           target:
             name: "avg_cpu_per_core"
             unit: "ns"
             type: "cumulative"
             expr: "$(cpu) / ($(cpu).resource_metadata.cpu_number or 1)"

.. note::

   Expression evaluation gracefully handles NaNs and exceptions. In
   such a case it does not create a new sample but only logs a warning.

**Delta transformer**

This transformer calculates the change between two sample datapoints of a
resource. It can be configured to capture only the positive growth deltas.

Example configuration:

.. code-block:: yaml

   transformers:
       - name: "delta"
         parameters:
           target:
               name: "cpu.delta"
           growth_only: True

.. _telemetry-meter-definitions:

Meter definitions
-----------------
The Telemetry service collects a subset of the meters by filtering
notifications emitted by other OpenStack services. Starting with the Liberty
release, you can find the meter definitions in a separate configuration file,
called ``ceilometer/meter/data/meter.yaml``. This enables
operators/administrators to add new meters to Telemetry project by updating
the ``meter.yaml`` file without any need for additional code changes.

.. note::

   The ``meter.yaml`` file should be modified with care. Unless intended
   do not remove any existing meter definitions from the file. Also, the
   collected meters can differ in some cases from what is referenced in the
   documentation.

A standard meter definition looks like:

.. code-block:: yaml

   ---
   metric:
     - name: 'meter name'
       event_type: 'event name'
       type: 'type of meter eg: gauge, cumulative or delta'
       unit: 'name of unit eg: MB'
       volume: 'path to a measurable value eg: $.payload.size'
       resource_id: 'path to resource id eg: $.payload.id'
       project_id: 'path to project id eg: $.payload.owner'

The definition above shows a simple meter definition with some fields,
from which ``name``, ``event_type``, ``type``, ``unit``, and ``volume``
are required. If there is a match on the event type, samples are generated
for the meter.

If you take a look at the ``meter.yaml`` file, it contains the sample
definitions for all the meters that Telemetry is collecting from
notifications. The value of each field is specified by using json path in
order to find the right value from the notification message. In order to be
able to specify the right field you need to be aware of the format of the
consumed notification. The values that need to be searched in the notification
message are set with a json path starting with ``$.`` For instance, if you need
the ``size`` information from the payload you can define it like
``$.payload.size``.

A notification message may contain multiple meters. You can use ``*`` in
the meter definition to capture all the meters and generate samples
respectively. You can use wild cards as shown in the following example:

.. code-block:: yaml

   ---
   metric:
     - name: $.payload.measurements.[*].metric.[*].name
       event_type: 'event_name.*'
       type: 'delta'
       unit: $.payload.measurements.[*].metric.[*].unit
       volume: payload.measurements.[*].result
       resource_id: $.payload.target
       user_id: $.payload.initiator.id
       project_id: $.payload.initiator.project_id

In the above example, the ``name`` field is a json path with matching
a list of meter names defined in the notification message.

You can even use complex operations on json paths. In the following example,
``volume`` and ``resource_id`` fields perform an arithmetic
and string concatenation:

.. code-block:: yaml

   ---
   metric:
   - name: 'compute.node.cpu.idle.percent'
     event_type: 'compute.metrics.update'
     type: 'gauge'
     unit: 'percent'
     volume: payload.metrics[?(@.name='cpu.idle.percent')].value * 100
     resource_id: $.payload.host + "_" + $.payload.nodename

You can use the ``timedelta`` plug-in to evaluate the difference in seconds
between two ``datetime`` fields from one notification.

.. code-block:: yaml

   ---
   metric:
   - name: 'compute.instance.booting.time'
     event_type: 'compute.instance.create.end'
    type: 'gauge'
    unit: 'sec'
    volume:
      fields: [$.payload.created_at, $.payload.launched_at]
      plugin: 'timedelta'
    project_id: $.payload.tenant_id
    resource_id: $.payload.instance_id

You will find some existence meters in the ``meter.yaml``. These
meters have a ``volume`` as ``1`` and are at the bottom of the yaml file
with a note suggesting that these will be removed in Mitaka release.

For example, the meter definition for existence meters is as follows:

.. code-block:: yaml

   ---
   metric:
     - name: 'meter name'
       type: 'delta'
       unit: 'volume'
       volume: 1
       event_type:
           - 'event type'
       resource_id: $.payload.volume_id
       user_id: $.payload.user_id
       project_id: $.payload.tenant_id

These meters are not loaded by default. To load these meters, flip
the `disable_non_metric_meters` option in the ``ceilometer.conf``
file.

Block Storage audit script setup to get notifications
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you want to collect OpenStack Block Storage notification on demand,
you can use :command:`cinder-volume-usage-audit` from OpenStack Block Storage.
This script becomes available when you install OpenStack Block Storage,
so you can use it without any specific settings and you don't need to
authenticate to access the data. To use it, you must run this command in
the following format:

.. code-block:: console

   $ cinder-volume-usage-audit \
     --start_time='YYYY-MM-DD HH:MM:SS' --end_time='YYYY-MM-DD HH:MM:SS' --send_actions

This script outputs what volumes or snapshots were created, deleted, or
exists in a given period of time and some information about these
volumes or snapshots. Information about the existence and size of
volumes and snapshots is store in the Telemetry service. This data is
also stored as an event which is the recommended usage as it provides
better indexing of data.

Using this script via cron you can get notifications periodically, for
example, every 5 minutes::

    */5 * * * * /path/to/cinder-volume-usage-audit --send_actions

.. _telemetry-storing-samples:

Storing samples
~~~~~~~~~~~~~~~

The Telemetry service has a separate service that is responsible for
persisting the data that comes from the pollsters or is received as
notifications. The data can be stored in a file or a database back end,
for which the list of supported databases can be found in
:ref:`telemetry-supported-databases`. The data can also be sent to an external
data store by using an HTTP dispatcher.

The ``ceilometer-collector`` service receives the data as messages from the
message bus of the configured AMQP service. It sends these datapoints
without any modification to the configured target. The service has to
run on a host machine from which it has access to the configured
dispatcher.

.. note::

   Multiple dispatchers can be configured for Telemetry at one time.

Multiple ``ceilometer-collector`` processes can be run at a time. It is also
supported to start multiple worker threads per collector process. The
``collector_workers`` configuration option has to be modified in the
`Collector section
<http://docs.openstack.org/mitaka/config-reference/telemetry/telemetry_service_config_opts.html>`__
of the ``ceilometer.conf`` configuration file.

Database dispatcher
-------------------

When the database dispatcher is configured as data store, you have the
option to set a ``time_to_live`` option (ttl) for samples. By default
the time to live value for samples is set to -1, which means that they
are kept in the database forever.

The time to live value is specified in seconds. Each sample has a time
stamp, and the ``ttl`` value indicates that a sample will be deleted
from the database when the number of seconds has elapsed since that
sample reading was stamped. For example, if the time to live is set to
600, all samples older than 600 seconds will be purged from the
database.

Certain databases support native TTL expiration. In cases where this is
not possible, a command-line script, which you can use for this purpose
is ``ceilometer-expirer``. You can run it in a cron job, which helps to keep
your database in a consistent state.

The level of support differs in case of the configured back end:

+--------------------+-------------------+------------------------------------+
| Database           | TTL value support | Note                               |
+====================+===================+====================================+
| MongoDB            | Yes               | MongoDB has native TTL support for |
|                    |                   | deleting samples that are older    |
|                    |                   | than the configured ttl value.     |
+--------------------+-------------------+------------------------------------+
| SQL-based back     | Yes               | ``ceilometer-expirer`` has to be   |
| ends               |                   | used for deleting samples and its  |
|                    |                   | related data from the database.    |
+--------------------+-------------------+------------------------------------+
| HBase              | No                | Telemetry's HBase support does not |
|                    |                   | include native TTL nor             |
|                    |                   | ``ceilometer-expirer`` support.    |
+--------------------+-------------------+------------------------------------+
| DB2 NoSQL          | No                | DB2 NoSQL does not have native TTL |
|                    |                   | nor ``ceilometer-expirer``         |
|                    |                   | support.                           |
+--------------------+-------------------+------------------------------------+

HTTP dispatcher
---------------

The Telemetry service supports sending samples to an external HTTP
target. The samples are sent without any modification. To set this
option as the collector's target, the ``dispatcher`` has to be changed
to ``http`` in the ``ceilometer.conf`` configuration file. For the list
of options that you need to set, see the see the `dispatcher_http
section <http://docs.openstack.org/mitaka/config-reference/telemetry/telemetry_service_config_opts.html>`__
in the OpenStack Configuration Reference.

File dispatcher
---------------

You can store samples in a file by setting the ``dispatcher`` option in the
``ceilometer.conf`` file. For the list of configuration options,
see the `dispatcher_file section
<http://docs.openstack.org/mitaka/config-reference/telemetry/telemetry_service_config_opts.html>`__
in the OpenStack Configuration Reference.

Gnocchi dispatcher
------------------

The Telemetry service supports sending the metering data to Gnocchi back end
through the gnocchi dispatcher. To set this option as the target, change the
``dispatcher`` to ``gnocchi`` in the ``ceilometer.conf``
configuration file.

For the list of options that you need to set, see the
`dispatcher_gnocchi section
<http://docs.openstack.org/mitaka/config-reference/telemetry/telemetry_service_config_opts.html>`__
in the OpenStack Configuration Reference.
