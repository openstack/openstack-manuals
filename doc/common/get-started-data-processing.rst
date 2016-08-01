================================
Data Processing service overview
================================

The Data processing service for OpenStack (sahara) aims to provide users
with a simple means to provision data processing (Hadoop, Spark)
clusters by specifying several parameters like Hadoop version, cluster
topology, node hardware details and a few more. After a user fills in
all the parameters, the Data processing service deploys the cluster in a
few minutes. Sahara also provides a means to scale already provisioned
clusters by adding or removing worker nodes on demand.

The solution addresses the following use cases:

* Fast provisioning of Hadoop clusters on OpenStack for development and
  QA.

* Utilization of unused compute power from general purpose OpenStack
  IaaS cloud.

* Analytics-as-a-Service for ad-hoc or bursty analytic workloads.

Key features are:

* Designed as an OpenStack component.

* Managed through REST API with UI available as part of OpenStack
  dashboard.

* Support for different Hadoop distributions:

  * Pluggable system of Hadoop installation engines.

  * Integration with vendor specific management tools, such as Apache
    Ambari or Cloudera Management Console.

* Predefined templates of Hadoop configurations with the ability to
  modify parameters.

* User-friendly UI for ad-hoc analytics queries based on Hive or Pig.
