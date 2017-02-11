.. _telemetry:

=========
Telemetry
=========

Even in the cloud industry, providers must use a multi-step process
for billing. The required steps to bill for usage in a cloud
environment are metering, rating, and billing. Because the provider's
requirements may be far too specific for a shared solution, rating
and billing solutions cannot be designed in a common module that
satisfies all. Providing users with measurements on cloud services is
required to meet the ``measured service`` definition of cloud computing.

The Telemetry service was originally designed to support billing
systems for OpenStack cloud resources. This project only covers the
metering portion of the required processing for billing. This service
collects information about the system and stores it in the form of
samples in order to provide data about anything that can be billed.

In addition to system measurements, the Telemetry service also
captures event notifications triggered when various actions are
executed in the OpenStack system. This data is captured as Events and
stored alongside metering data.

The list of meters is continuously growing, which makes it possible
to use the data collected by Telemetry for different purposes, other
than billing. For example, the autoscaling feature in the
Orchestration service can be triggered by alarms this module sets and
then gets notified within Telemetry.

The sections in this document contain information about the
architecture and usage of Telemetry. The first section contains a
brief summary about the system architecture used in a typical
OpenStack deployment. The second section describes the data
collection mechanisms. You can also read about alarming to understand
how alarm definitions can be posted to Telemetry and what actions can
happen if an alarm is raised. The last section contains a
troubleshooting guide, which mentions error situations and possible
solutions to the problems.

You can retrieve the collected data in two different ways: with
the REST API or with the command-line interface of the storage service.
Additionally, measurement data can be visualised through a graphical
service such as Grafana.


.. toctree::
   :maxdepth: 2

   telemetry-system-architecture.rst
   telemetry-data-collection.rst
   telemetry-data-pipelines.rst
   telemetry-data-retrieval.rst
   telemetry-alarms.rst
   telemetry-measurements.rst
   telemetry-events.rst
   telemetry-troubleshooting-guide.rst
   telemetry-best-practices.rst
