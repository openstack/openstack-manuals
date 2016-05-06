
=========
Telemetry
=========

[TODO (Add Telemetry overview)]

Telemetry central agent
~~~~~~~~~~~~~~~~~~~~~~~

The Telemetry central agent can be configured to partition its polling
workload between multiple agents, enabling high availability.

Both the central and the compute agent can run in an HA deployment,
which means that multiple instances of these services can run in
parallel with workload partitioning among these running instances.

The `Tooz <https://pypi.python.org/pypi/tooz>`__ library provides
the coordination within the groups of service instances.
It provides an API above several back ends that can be used for building
distributed applications.

Tooz supports
`various drivers <http://docs.openstack.org/developer/tooz/drivers.html>`__
including the following back end solutions:

* `Zookeeper <http://zookeeper.apache.org/>`__.
    Recommended solution by the Tooz project.

* `Redis <http://redis.io/>`__.
    Recommended solution by the Tooz project.

* `Memcached <http://memcached.org/>`__.
    Recommended for testing.

You must configure a supported Tooz driver for the HA deployment of
the Telemetry services.

For information about the required configuration options that have
to be set in the :file:`ceilometer.conf` configuration file for both
the central and compute agents, see the `coordination section
<http://docs.openstack.org/liberty/config-reference/content/
ch_configuring-openstack-telemetry.html>`__
in the OpenStack Configuration Reference.

.. note:: Without the ``backend_url`` option being set only one
   instance of both the central and compute agent service is able to run
   and function correctly.

The availability check of the instances is provided by heartbeat messages.
When the connection with an instance is lost, the workload will be
reassigned within the remained instances in the next polling cycle.

.. note:: Memcached uses a timeout value, which should always be set to
   a value that is higher than the heartbeat value set for Telemetry.

For backward compatibility and supporting existing deployments, the central
agent configuration also supports using different configuration files for
groups of service instances of this type that are running in parallel.
For enabling this configuration, set a value for the partitioning_group_prefix
option in the `central section <http://docs.openstack.org/liberty/
config-reference/content/ch_configuring-openstack-telemetry.html>`__
in the OpenStack Configuration Reference.

.. warning:: For each sub-group of the central agent pool with the same
   ``partitioning_group_prefix`` a disjoint subset of meters must be polled --
   otherwise samples may be missing or duplicated. The list of meters to poll
   can be set in the :file:`/etc/ceilometer/pipeline.yaml` configuration file.
   For more information about pipelines see the `Data collection and
   processing
   <http://docs.openstack.org/admin-guide/telemetry-data-collection.html#data-collection-and-processing>`__
   section.

To enable the compute agent to run multiple instances simultaneously with
workload partitioning, the workload_partitioning option has to be set to
``True`` under the `compute section <http://docs.openstack.org/liberty/
config-reference/content/ch_configuring-openstack-telemetry.html>`__
in the :file:`ceilometer.conf` configuration file.
