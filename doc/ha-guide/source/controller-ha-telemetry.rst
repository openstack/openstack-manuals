==========================
Highly available Telemetry
==========================

The `Telemetry service
<https://docs.openstack.org/admin-guide/common/get-started-telemetry.html>`_
provides a data collection service and an alarming service.

Telemetry polling agent
~~~~~~~~~~~~~~~~~~~~~~~

The Telemetry polling agent can be configured to partition its polling
workload between multiple agents. This enables high availability (HA).

Both the central and the compute agent can run in an HA deployment.
This means that multiple instances of these services can run in
parallel with workload partitioning among these running instances.

The `Tooz <https://pypi.org/project/tooz>`_ library provides
the coordination within the groups of service instances.
It provides an API above several back ends that can be used for building
distributed applications.

Tooz supports
`various drivers <https://docs.openstack.org/tooz/latest/user/drivers.html>`_
including the following back end solutions:

* `Zookeeper <https://zookeeper.apache.org/>`_:
    Recommended solution by the Tooz project.

* `Redis <https://redis.io/>`_:
    Recommended solution by the Tooz project.

* `Memcached <https://memcached.org/>`_:
    Recommended for testing.

You must configure a supported Tooz driver for the HA deployment of
the Telemetry services.

For information about the required configuration options
to set in the :file:`ceilometer.conf`, see the `coordination section
<https://docs.openstack.org/ocata/config-reference/telemetry.html>`_
in the OpenStack Configuration Reference.

.. note::

   Only one instance for the central and compute agent service(s) is able
   to run and function correctly if the ``backend_url`` option is not set.

The availability check of the instances is provided by heartbeat messages.
When the connection with an instance is lost, the workload will be
reassigned within the remaining instances in the next polling cycle.

.. note::

   Memcached uses a timeout value, which should always be set to
   a value that is higher than the heartbeat value set for Telemetry.

For backward compatibility and supporting existing deployments, the central
agent configuration supports using different configuration files. This is for
groups of service instances that are running in parallel.
For enabling this configuration, set a value for the
``partitioning_group_prefix`` option in the
`polling section <https://docs.openstack.org/ocata/config-reference/telemetry/telemetry-config-options.html>`_
in the OpenStack Configuration Reference.

.. warning::

   For each sub-group of the central agent pool with the same
   ``partitioning_group_prefix``, a disjoint subset of meters must be polled
   to avoid samples being missing or duplicated. The list of meters to poll
   can be set in the :file:`/etc/ceilometer/pipeline.yaml` configuration file.
   For more information about pipelines see the `Data processing and pipelines
   <https://docs.openstack.org/admin-guide/telemetry-data-pipelines.html>`_
   section.

To enable the compute agent to run multiple instances simultaneously with
workload partitioning, the ``workload_partitioning`` option must be set to
``True`` under the `compute section <https://docs.openstack.org/ocata/config-reference/telemetry.html>`_
in the :file:`ceilometer.conf` configuration file.
