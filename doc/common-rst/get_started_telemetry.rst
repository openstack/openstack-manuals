===========================
OpenStack Telemetry service
===========================

The Telemetry service performs the following functions:

* Efficiently polls metering data related to OpenStack services.

* Collects event and metering data by monitoring notifications sent
  from services.

* Publishes collected data to various targets including data stores and
  message queues.

* Creates alarms when collected data breaks defined rules.

The Telemetry service consists of the following components:

A compute agent (``ceilometer-agent-compute``)
  Runs on each compute node and polls for resource utilization
  statistics. There may be other types of agents in the future, but
  for now our focus is creating the compute agent.

A central agent (``ceilometer-agent-central``)
  Runs on a central management server to poll for resource utilization
  statistics for resources not tied to instances or compute nodes.
  Multiple agents can be started to scale service horizontally.

A notification agent (``ceilometer-agent-notification``)
  Runs on a central management server(s) and consumes messages from
  the message queue(s) to build event and metering data.

A collector (``ceilometer-collector``)
  Runs on central management server(s) and dispatches collected
  telemetry data to a data store or external consumer without
  modification.

An alarm evaluator (``ceilometer-alarm-evaluator``)
  Runs on one or more central management servers to determine when
  alarms fire due to the associated statistic trend crossing a
  threshold over a sliding time window.

An alarm notifier (``ceilometer-alarm-notifier``)
  Runs on one or more central management servers to allow alarms to be
  set based on the threshold evaluation for a collection of samples.

An API server (``ceilometer-api``)
  Runs on one or more central management servers to provide data
  access from the data store.

These services communicate by using the OpenStack messaging bus. Only
the collector and API server have access to the data store.
