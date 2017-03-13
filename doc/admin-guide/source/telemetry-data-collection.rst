.. _telemetry-data-collection:

===============
Data collection
===============

The main responsibility of Telemetry in OpenStack is to collect
information about the system that can be used by billing systems or
interpreted by analytic tooling.

Collected data can be stored in the form of samples or events in the
supported databases, which are listed
in :ref:`telemetry-supported-databases`.

Samples capture a numerical measurement of a resource. The Telemetry service
leverages multiple methods to collect data samples.

The available data collection mechanisms are:

Notifications
    Processing notifications from other OpenStack services, by consuming
    messages from the configured message queue system.

Polling
    Retrieve information directly from the hypervisor or from the host
    machine using SNMP, or by using the APIs of other OpenStack
    services.

RESTful API (deprecated in Ocata)
    Pushing samples via the RESTful API of Telemetry.

.. note::

   Rather than pushing data through Ceilometer's API, it is advised to push
   directly into gnocchi. Ceilometer's API is officially deprecated as of
   Ocata.


Notifications
~~~~~~~~~~~~~

All OpenStack services send notifications about the executed operations
or system state. Several notifications carry information that can be
metered. For example, CPU time of a VM instance created by OpenStack
Compute service.

The notification agent is responsible for consuming notifications. This
component is responsible for consuming from the message bus and transforming
notifications into events and measurement samples.

Additionally, the notification agent is responsible for all data processing
such as transformations and publishing. After processing, the data is sent
to any supported publisher target such as gnocchi or panko. These services
persist the data in configured databases.

.. note::

   Prior to Ocata, the data was sent via AMQP to the collector service or any
   external service.

The different OpenStack services emit several notifications about the
various types of events that happen in the system during normal
operation. Not all these notifications are consumed by the Telemetry
service, as the intention is only to capture the billable events and
notifications that can be used for monitoring or profiling purposes. The
notification agent filters by the event type. Each notification
message contains the event type. The following table contains the event
types by each OpenStack service that Telemetry transforms into samples.

.. list-table::
   :widths: 10 15 30
   :header-rows: 1

   * - OpenStack service
     - Event types
     - Note
   * - OpenStack Compute
     - scheduler.run\_instance.scheduled

       scheduler.select\_\
       destinations

       compute.instance.\*
     - For a more detailed list of Compute notifications please
       check the `System Usage Data wiki page <https://wiki.openstack.org/wiki/
       SystemUsageData>`__.
   * - Bare metal service
     - hardware.ipmi.\*
     -
   * - OpenStack Image
     - image.update

       image.upload

       image.delete

       image.send

     - The required configuration for Image service can be found in the
       `Configure the Image service for Telemetry <https://docs.openstack.org/project-install-guide/telemetry/ocata>`__
       section in the Installation Tutorials and Guides.
   * - OpenStack Networking
     - floatingip.create.end

       floatingip.update.\*

       floatingip.exists

       network.create.end

       network.update.\*

       network.exists

       port.create.end

       port.update.\*

       port.exists

       router.create.end

       router.update.\*

       router.exists

       subnet.create.end

       subnet.update.\*

       subnet.exists

       l3.meter
     -
   * - Orchestration service
     - orchestration.stack\
       .create.end

       orchestration.stack\
       .update.end

       orchestration.stack\
       .delete.end

       orchestration.stack\
       .resume.end

       orchestration.stack\
       .suspend.end
     -
   * - OpenStack Block Storage
     - volume.exists

       volume.create.\*

       volume.delete.\*

       volume.update.\*

       volume.resize.\*

       volume.attach.\*

       volume.detach.\*

       snapshot.exists

       snapshot.create.\*

       snapshot.delete.\*

       snapshot.update.\*

       volume.backup.create.\
       \*

       volume.backup.delete.\
       \*

       volume.backup.restore.\
       \*
     - The required configuration for Block Storage service can be found in the
       `Add the Block Storage service agent for Telemetry
       <https://docs.openstack.org/project-install-guide/telemetry/ocata/cinder/install-cinder-ubuntu.html>`__
       section in the Installation Tutorials and Guides.

.. note::

   Some services require additional configuration to emit the
   notifications using the correct control exchange on the message
   queue and so forth. These configuration needs are referred in the
   above table for each OpenStack service that needs it.

Specific notifications from the Compute service are important for
administrators and users. Configuring ``nova_notifications`` in the
``nova.conf`` file allows administrators to respond to events
rapidly. For more information on configuring notifications for the
compute service, see `Telemetry services
<https://docs.openstack.org/project-install-guide/telemetry/ocata/install-compute-ubuntu.html>`__ in the
Installation Tutorials and Guides.

Meter definitions
-----------------

The Telemetry service collects a subset of the meters by filtering
notifications emitted by other OpenStack services. You can find the meter
definitions in a separate configuration file, called
``ceilometer/meter/data/meters.yaml``. This enables
operators/administrators to add new meters to Telemetry project by updating
the ``meters.yaml`` file without any need for additional code changes.

.. note::

   The ``meters.yaml`` file should be modified with care. Unless intended,
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
       metadata: 'addiitonal key-value data describing resource'

The definition above shows a simple meter definition with some fields,
from which ``name``, ``event_type``, ``type``, ``unit``, and ``volume``
are required. If there is a match on the event type, samples are generated
for the meter.

The ``meters.yaml`` file contains the sample
definitions for all the meters that Telemetry is collecting from
notifications. The value of each field is specified by using JSON path in
order to find the right value from the notification message. In order to be
able to specify the right field you need to be aware of the format of the
consumed notification. The values that need to be searched in the notification
message are set with a JSON path starting with ``$.`` For instance, if you need
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

In the above example, the ``name`` field is a JSON path with matching
a list of meter names defined in the notification message.

You can use complex operations on JSON paths. In the following example,
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

Compute agent
-------------

This agent is responsible for collecting resource usage data of VM
instances on individual compute nodes within an OpenStack deployment.
This mechanism requires a closer interaction with the hypervisor,
therefore a separate agent type fulfills the collection of the related
meters, which is placed on the host machines to retrieve this
information locally.

A Compute agent instance has to be installed on each and every compute
node, installation instructions can be found in the `Install the Compute
agent for Telemetry
<https://docs.openstack.org/project-install-guide/telemetry/ocata/install-compute-ubuntu.html>`__
section in the Installation Tutorials and Guides.

The compute agent does not need direct database connection. The samples
collected by this agent are sent via AMQP to the notification agent to be
processed.

The list of supported hypervisors can be found in
:ref:`telemetry-supported-hypervisors`. The Compute agent uses the API of the
hypervisor installed on the compute hosts. Therefore, the supported meters may
be different in case of each virtualization back end, as each inspection tool
provides a different set of meters.

The list of collected meters can be found in :ref:`telemetry-compute-meters`.
The support column provides the information about which meter is available for
each hypervisor supported by the Telemetry service.

.. note::

    Telemetry supports Libvirt, which hides the hypervisor under it.

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
   framework (deprecated in Newton)

To install and configure this service use the `Add the Telemetry service
<https://docs.openstack.org/project-install-guide/telemetry/ocata/install-base-ubuntu.html>`__
section in the Installation Tutorials and Guides.

Just like the compute agent, this component also does not need a direct
database connection. The samples are sent via AMQP to the notification agent.

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

Send samples to Telemetry
~~~~~~~~~~~~~~~~~~~~~~~~~

.. note::

   Sample pushing via the API is deprecated in Ocata. Measurement data should
   be pushed directly into `gnocchi's API <http://gnocchi.xyz/rest.html>`__.

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

-  ID of the corresponding resource. (``--resource-id``)

-  Name of meter. (``--meter-name``)

-  Type of meter. (``--meter-type``)

   Predefined meter types:

   -  Gauge

   -  Delta

   -  Cumulative

-  Unit of meter. (``--meter-unit``)

-  Volume of sample. (``--sample-volume``)

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
