.. meta::
    :scope: admin_only

===========================
View cloud usage statistics
===========================

As an administrative user, you can view information for OpenStack services.

The Telemetry module provides user-level usage data for OpenStack-based clouds,
which can be used for customer billing, system monitoring, or alerts. Data can be
collected by notifications sent by existing OpenStack components (for example,
usage events emitted from Compute) or by polling the infrastructure (for example,
libvirt).

.. note::
   You can only view metering statistics on the dashboard (available only to administrators).
   The Telemetry service must be set up and administered through the
   :command:`ceilometer` command-line interface (CLI).

   For basic administration information, refer to the "Measure Cloud Resources"
   chapter in the `OpenStack End User Guide <http://docs.openstack.org/user-guide/content/>`_.

.. _dashboard-view-resource-statistics:

View resource statistics
~~~~~~~~~~~~~~~~~~~~~~~~

#. Log in to the OpenStack dashboard as a user with Admin privileges.

#. On the **Admin** tab, click the **Resource Usage** category.

#. Click the:

   * **Global Disk Usage** tab to view disk usage per tenant (project).

   * **Global Network Traffic Usage** tab to view ingress or egress usage
     per tenant (project).

   * **Global Object Storage Usage** tab to view incoming and outgoing
     storage bytes per tenant (project).

   * **Global Network Usage** tab to view duration and creation requests for
     networks, subnets, routers, ports, and floating IPs, per tenant (project).

   * **Stats** tab to view a multi-series line chart with user-defined
     metrics. You group by project, define the value type (min, max, avg, or sum),
     and specify the time period (or even use a calendar to define a date range).
