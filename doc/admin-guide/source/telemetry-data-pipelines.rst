.. _data-collection-and-processing:

==========================================
Data collection, processing, and pipelines
==========================================

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
   end. We strongly recommend you do not use small granularity
   values like 10 seconds.

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

The optional resources section of a pipeline source allows a static list
of resource URLs to be configured for polling.

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

Unit conversion transformer
---------------------------

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
----------------------

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
-----------------------

This transformer simply caches the samples until enough samples have
arrived and then flushes them all down the pipeline at once:

.. code-block:: yaml

   transformers:
       - name: "accumulator"
         parameters:
             size: 15

Multi meter arithmetic transformer
----------------------------------

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
-----------------

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
