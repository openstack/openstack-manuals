.. _telemetry-data-pipelines:

=============================
Data processing and pipelines
=============================

The mechanism by which data is processed is called a pipeline. Pipelines,
at the configuration level, describe a coupling between sources of data and
the corresponding sinks for transformation and publication of data. This
functionality is handled by the notification agents.

A source is a producer of data: ``samples`` or ``events``. In effect, it is a
set of notification handlers emitting datapoints for a set of matching meters
and event types.

Each source configuration encapsulates name matching and mapping
to one or more sinks for publication.

A sink, on the other hand, is a consumer of data, providing logic for
the transformation and publication of data emitted from related sources.

In effect, a sink describes a chain of handlers. The chain starts with
zero or more transformers and ends with one or more publishers. The
first transformer in the chain is passed data from the corresponding
source, takes some action such as deriving rate of change, performing
unit conversion, or aggregating, before publishing_.

.. _telemetry-pipeline-configuration:

Pipeline configuration
~~~~~~~~~~~~~~~~~~~~~~

The pipeline configuration is, by default stored in separate configuration
files called ``pipeline.yaml`` and ``event_pipeline.yaml`` next to
the ``ceilometer.conf`` file. The meter pipeline and event pipeline
configuration files can be set by the ``pipeline_cfg_file`` and
``event_pipeline_cfg_file`` options listed in the `Description of
configuration options for api table
<https://docs.openstack.org/ocata/config-reference/telemetry/telemetry-config-options.html>`__
section in the OpenStack Configuration Reference respectively. Multiple
pipelines can be defined in one pipeline configuration file.

The meter pipeline definition looks like:

.. code-block:: yaml

   ---
   sources:
     - name: 'source name'
       meters:
         - 'meter filter'
       sinks
         - 'sink name'
   sinks:
     - name: 'sink name'
       transformers: 'definition of transformers'
       publishers:
         - 'list of publishers'

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

.. note::

   The OpenStack Telemetry service does not have any duplication check
   between pipelines, and if you add a meter to multiple pipelines then it is
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

The transformers section of a pipeline sink provides the possibility to
add a list of transformer definitions. The available transformers are:

.. list-table::
   :widths: 50 50
   :header-rows: 1

   * - Name of transformer
     - Reference name for configuration
   * - Accumulator
     - accumulator
   * - Aggregator
     - aggregator
   * - Arithmetic
     - arithmetic
   * - Rate of change
     - rate\_of\_change
   * - Unit conversion
     - unit\_conversion
   * - Delta
     - delta

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
------------

The definition of transformers can contain the following fields:

name
    Name of the transformer.

parameters
    Parameters of the transformer.

The parameters section can contain transformer specific fields, like
source and target fields with different subfields in case of the rate of
change, which depends on the implementation of the transformer.

The following are supported transformers:

Rate of change transformer
``````````````````````````
Transformer that computes the change in value between two data points in time.
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

The rate of change transformer generates the ``cpu_util`` meter
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

Unit conversion transformer
```````````````````````````

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

Aggregator transformer
``````````````````````

A transformer that sums up the incoming samples until enough samples
have come in or a timeout has been reached.

Timeout can be specified with the ``retention_time`` option. If you want
to flush the aggregation, after a set number of samples have been
aggregated, specify the size parameter.

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

Accumulator transformer
```````````````````````

This transformer simply caches the samples until enough samples have
arrived and then flushes them all down the pipeline at once:

.. code-block:: yaml

   transformers:
       - name: "accumulator"
         parameters:
             size: 15

Multi meter arithmetic transformer
``````````````````````````````````

This transformer enables us to perform arithmetic calculations over one
or more meters and/or their metadata, for example:

.. code-block:: none

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

To demonstrate the use of metadata, the following implementation of a
novel meter shows average CPU time per core:

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

Delta transformer
`````````````````

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

.. _publishing:

Publishers
----------

The Telemetry service provides several transport methods to transfer the
data collected to an external system. The consumers of this data are widely
different, like monitoring systems, for which data loss is acceptable and
billing systems, which require reliable data transportation. Telemetry provides
methods to fulfill the requirements of both kind of systems.

The publisher component makes it possible to save the data into persistent
storage through the message bus or to send it to one or more external
consumers. One chain can contain multiple publishers.

To solve this problem, the multi-publisher can
be configured for each data point within the Telemetry service, allowing
the same technical meter or event to be published multiple times to
multiple destinations, each potentially using a different transport.

Publishers are specified in the ``publishers`` section for each
pipeline that is defined in the `pipeline.yaml
<https://git.openstack.org/cgit/openstack/ceilometer/plain/ceilometer/pipeline/data/pipeline.yaml>`__
and the `event_pipeline.yaml
<https://git.openstack.org/cgit/openstack/ceilometer/plain/ceilometer/pipeline/data/event_pipeline.yaml>`__
files.

The following publisher types are supported:

gnocchi (default)
`````````````````

When the gnocchi publisher is enabled, measurement and resource information is
pushed to gnocchi for time-series optimized storage. Gnocchi must be registered
in the Identity service as Ceilometer discovers the exact path via the Identity
service.

More details on how to enable and configure gnocchi can be found on its
`official documentation page <http://gnocchi.xyz>`__.

panko
`````

Event data in Ceilometer can be stored in panko which provides an HTTP REST
interface to query system events in OpenStack. To push data to panko,
set the publisher to ``direct://?dispatcher=panko``. Beginning in panko's
Pike release, the publisher can be set as ``panko://``

notifier
````````

The notifier publisher can be specified in the form of
``notifier://?option1=value1&option2=value2``. It emits data over AMQP using
oslo.messaging. Any consumer can then subscribe to the published topic
for additional processing.

.. note::

   Prior to Ocata, the collector would consume this publisher but has since
   been deprecated and therefore not required.

The following customization options are available:

``per_meter_topic``
    The value of this parameter is 1. It is used for publishing the samples on
    additional ``metering_topic.sample_name`` topic queue besides the
    default ``metering_topic`` queue.

``policy``
    Used for configuring the behavior for the case, when the
    publisher fails to send the samples, where the possible predefined
    values are:

    default
        Used for waiting and blocking until the samples have been sent.

    drop
        Used for dropping the samples which are failed to be sent.

    queue
        Used for creating an in-memory queue and retrying to send the
        samples on the queue in the next samples publishing period (the
        queue length can be configured with ``max_queue_length``, where
        1024 is the default value).

``topic``
    The topic name of the queue to publish to. Setting this will override the
    default topic defined by ``metering_topic`` and ``event_topic`` options.
    This option can be used to support multiple consumers.

udp
```

This publisher can be specified in the form of ``udp://<host>:<port>/``. It
emits metering data over UDP.

file
````

The file publisher can be specified in the form of
``file://path?option1=value1&option2=value2``. This publisher
records metering data into a file.

.. note::

   If a file name and location is not specified, the ``file`` publisher
   does not log any meters, instead it logs a warning message in
   the configured log file for Telemetry.

The following options are available for the ``file`` publisher:

``max_bytes``
    When this option is greater than zero, it will cause a rollover.
    When the specified size is about to be exceeded, the file is closed and a
    new file is silently opened for output. If its value is zero, rollover
    never occurs.

``backup_count``
    If this value is non-zero, an extension will be appended to the
    filename of the old log, as '.1', '.2', and so forth until the
    specified value is reached. The file that is written and contains
    the newest data is always the one that is specified without any
    extensions.

http
````

The Telemetry service supports sending samples to an external HTTP
target. The samples are sent without any modification. To set this
option as the notification agents' target, set ``http://`` as a publisher
endpoint in the pipeline definition files. The HTTP target should be set along
with the publisher declaration. For example, addtional configuration options
can be passed in: ``http://localhost:80/?option1=value1&option2=value2``

The following options are availble:

``timeout``
    The number of seconds before HTTP request times out.

``max_retries``
    The number of times to retry a request before failing.

``batch``
    If false, the publisher will send each sample and event individually,
    whether or not the notification agent is configured to process in batches.

``poolsize``
    The maximum number of open connections the publisher will maintain.
    Increasing value may improve performance but will also increase memory and
    socket consumption requirements.

The default publisher is ``gnocchi``, without any additional options
specified. A sample ``publishers`` section in the
``/etc/ceilometer/pipeline.yaml`` looks like the following:

.. code-block:: yaml

   publishers:
       - gnocchi://
       - panko://
       - udp://10.0.0.2:1234
       - notifier://?policy=drop&max_queue_length=512&topic=custom_target
       - direct://?dispatcher=http


Deprecated publishers
---------------------

The following publishers are deprecated as of Ocata and may be removed in
subsequent releases.

direct
``````

This publisher can be specified in the form of ``direct://?dispatcher=http``.
The dispatcher's options include: ``database``, ``file``, ``http``, and
``gnocchi``. It emits data in the configured dispatcher directly, default
configuration (the form is ``direct://``) is database dispatcher.
In the Mitaka release, this method can only emit data to the database
dispatcher, and the form is ``direct://``.

kafka
`````

.. note::

   We recommened you use oslo.messaging if possible as it provides consistent
   OpenStack API.

The ``kafka`` publisher can be specified in the form of:
``kafka://kafka_broker_ip: kafka_broker_port?topic=kafka_topic
&option1=value1``.

This publisher sends metering data to a kafka broker. The kafka publisher
offers similar options as ``notifier`` publisher.

.. note::

   If the topic parameter is missing, this publisher brings out
   metering data under a topic name, ``ceilometer``. When the port
   number is not specified, this publisher uses 9092 as the
   broker's port.


.. _telemetry-expiry:

database
````````

.. note::

  This functionality was replaced by ``gnocchi`` and ``panko`` publishers.

When the database dispatcher is configured as a data store, you have the
option to set a ``time_to_live`` option (ttl) for samples. By default
the ttl value for samples is set to -1, which means that they
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

.. list-table::
   :widths: 33 33 33
   :header-rows: 1

   * - Database
     - TTL value support
     - Note
   * - MongoDB
     - Yes
     - MongoDB has native TTL support for deleting samples
       that are older than the configured ttl value.
   * - SQL-based back ends
     - Yes
     - ``ceilometer-expirer`` has to be used for deleting
       samples and its related data from the database.
   * - HBase
     - No
     - Telemetry's HBase support does not include native TTL
       nor ``ceilometer-expirer`` support.
   * - DB2 NoSQL
     - No
     - DB2 NoSQL does not have native TTL
       nor ``ceilometer-expirer`` support.
