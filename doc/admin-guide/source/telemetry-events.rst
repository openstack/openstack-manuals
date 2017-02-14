======
Events
======

In addition to meters, the Telemetry service collects events triggered
within an OpenStack environment. This section provides a brief summary
of the events format in the Telemetry service.

While a sample represents a single, numeric datapoint within a
time-series, an event is a broader concept that represents the state of
a resource at a point in time. The state may be described using various
data types including non-numeric data such as an instance's flavor. In
general, events represent any action made in the OpenStack system.

Event configuration
~~~~~~~~~~~~~~~~~~~

By default, ceilometer builds event data from the messages it receives from
other OpenStack services.

.. note::

    In releases older than Ocata, it is advisable to set
    ``disable_non_metric_meters`` to ``True`` when enabling events in the
    Telemetry service. The Telemetry service historically represented events as
    metering data, which may create duplication of data if both events and
    non-metric meters are enabled.

Event structure
~~~~~~~~~~~~~~~

Events captured by the Telemetry service are represented by five key
attributes:

event\_type
    A dotted string defining what event occurred such as
    ``"compute.instance.resize.start"``.

message\_id
    A UUID for the event.

generated
    A timestamp of when the event occurred in the system.

traits
    A flat mapping of key-value pairs which describe the event. The
    event's traits contain most of the details of the event. Traits are
    typed, and can be strings, integers, floats, or datetimes.

raw
    Mainly for auditing purpose, the full event message can be stored
    (unindexed) for future evaluation.

Event indexing
~~~~~~~~~~~~~~

The general philosophy of notifications in OpenStack is to emit any and
all data someone might need, and let the consumer filter out what they
are not interested in. In order to make processing simpler and more
efficient, the notifications are stored and processed within Ceilometer
as events. The notification payload, which can be an arbitrarily complex
JSON data structure, is converted to a flat set of key-value pairs. This
conversion is specified by a config file.

.. note::

    The event format is meant for efficient processing and querying.
    Storage of complete notifications for auditing purposes can be
    enabled by configuring ``store_raw`` option.

Event conversion
----------------

The conversion from notifications to events is driven by a configuration
file defined by the ``definitions_cfg_file`` in the ``ceilometer.conf``
configuration file.

This includes descriptions of how to map fields in the notification body
to Traits, and optional plug-ins for doing any programmatic translations
(splitting a string, forcing case).

The mapping of notifications to events is defined per event\_type, which
can be wildcarded. Traits are added to events if the corresponding
fields in the notification exist and are non-null.

.. note::

    The default definition file included with the Telemetry service
    contains a list of known notifications and useful traits. The
    mappings provided can be modified to include more or less data
    according to user requirements.

If the definitions file is not present, a warning will be logged, but an
empty set of definitions will be assumed. By default, any notifications
that do not have a corresponding event definition in the definitions
file will be converted to events with a set of minimal traits. This can
be changed by setting the option ``drop_unmatched_notifications`` in the
``ceilometer.conf`` file. If this is set to ``True``, any unmapped
notifications will be dropped.

The basic set of traits (all are TEXT type) that will be added to all
events if the notification has the relevant data are: service
(notification's publisher), tenant\_id, and request\_id. These do not
have to be specified in the event definition, they are automatically
added, but their definitions can be overridden for a given event\_type.

Event definitions format
------------------------

The event definitions file is in YAML format. It consists of a list of
event definitions, which are mappings. Order is significant, the list of
definitions is scanned in reverse order to find a definition which
matches the notification's event\_type. That definition will be used to
generate the event. The reverse ordering is done because it is common to
want to have a more general wildcarded definition (such as
``compute.instance.*``) with a set of traits common to all of those
events, with a few more specific event definitions afterwards that have
all of the above traits, plus a few more.

Each event definition is a mapping with two keys:

event\_type
    This is a list (or a string, which will be taken as a 1 element
    list) of event\_types this definition will handle. These can be
    wildcarded with unix shell glob syntax. An exclusion listing
    (starting with a ``!``) will exclude any types listed from matching.
    If only exclusions are listed, the definition will match anything
    not matching the exclusions.

traits
    This is a mapping, the keys are the trait names, and the values are
    trait definitions.

Each trait definition is a mapping with the following keys:

fields
    A path specification for the field(s) in the notification you wish
    to extract for this trait. Specifications can be written to match
    multiple possible fields. By default the value will be the first
    such field. The paths can be specified with a dot syntax
    (``payload.host``). Square bracket syntax (``payload[host]``) is
    also supported. In either case, if the key for the field you are
    looking for contains special characters, like ``.``, it will need to
    be quoted (with double or single quotes):
    ``payload.image_meta.’org.openstack__1__architecture’``. The syntax
    used for the field specification is a variant of
    `JSONPath <https://github.com/kennknowles/python-jsonpath-rw>`__

type
    (Optional) The data type for this trait. Valid options are:
    ``text``, ``int``, ``float``, and ``datetime``. Defaults to ``text``
    if not specified.

plugin
    (Optional) Used to execute simple programmatic conversions on the
    value in a notification field.

Event delivery to external sinks
--------------------------------

You can configure the Telemetry service to deliver the events
into external sinks. These sinks are configurable in the
``/etc/ceilometer/event_pipeline.yaml`` file.
