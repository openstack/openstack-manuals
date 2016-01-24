========
Overview
========

Each OpenStack project provides a command-line client, which enables
you to access the project API through easy-to-use commands. For
example, the Compute service provides a ``nova`` command-line client.

You can run the commands from the command line, or include the
commands within scripts to automate tasks. If you provide OpenStack
credentials, such as your user name and password, you can run these
commands on any computer.

Internally, each command uses cURL command-line tools, which embed API
requests. OpenStack APIs are RESTful APIs, and use the HTTP
protocol. They include methods, URIs, media types, and response codes.

OpenStack APIs are open-source Python clients, and can run on Linux or
Mac OS X systems. On some client commands, you can specify a debug
parameter to show the underlying API request for the command. This is
a good way to become familiar with the OpenStack API calls.

As a cloud end user, you can use the OpenStack dashboard to provision
your own resources within the limits set by administrators. You can
modify the examples provided in this section to create other types and
sizes of server instances.

The following table lists the command-line client for each OpenStack
service with its package name and description.

**OpenStack services and clients**

+----------------+----------+-----------------------+------------------------+
|Service         |Client    |Package                |Description             |
+================+==========+=======================+========================+
|Application     |murano    |python-muranoclient    |Creates and manages     |
|catalog         |          |                       |applications.           |
+----------------+----------+-----------------------+------------------------+
|Block Storage   |cinder    |python-cinderclient    |Creates and manages     |
|                |          |                       |volumes.                |
+----------------+----------+-----------------------+------------------------+
|Clustering      |senlin    |python-senlinclient    |Creates and manages     |
|service         |          |                       |clustering services.    |
+----------------+----------+-----------------------+------------------------+
|Compute         |nova      |python-novaclient      |Creates and manages     |
|                |          |                       |images, instances, and  |
|                |          |                       |flavors.                |
+----------------+----------+-----------------------+------------------------+
|Containers      |magnum    |python-magnumclient    |Creates and manages     |
|service         |          |                       |containers.             |
+----------------+----------+-----------------------+------------------------+
|Database service|trove     |python-troveclient     |Creates and manages     |
|                |          |                       |databases.              |
+----------------+----------+-----------------------+------------------------+
|Data processing |sahara    |python-saharaclient    |Creates and manages     |
|                |          |                       |Hadoop clusters on      |
|                |          |                       |OpenStack.              |
+----------------+----------+-----------------------+------------------------+
|Deployment      |fuel      |python-fuelclient      |Plans deployments.      |
|service         |          |                       |                        |
+----------------+----------+-----------------------+------------------------+
|Identity        |keystone  |python-keystoneclient  |Creates and manages     |
|                |          |                       |users, tenants, roles,  |
|                |          |                       |endpoints, and          |
|                |          |                       |credentials.            |
+----------------+----------+-----------------------+------------------------+
|Image service   |glance    |python-glanceclient    |Creates and manages     |
|                |          |                       |images.                 |
+----------------+----------+-----------------------+------------------------+
|Key Manager     |barbican  |python-barbicanclient  |Creates and manages     |
|service         |          |                       |keys.                   |
+----------------+----------+-----------------------+------------------------+
|Monitoring      |monasca   |python-monascaclient   |Monitoring solution.    |
|                |          |                       |                        |
+----------------+----------+-----------------------+------------------------+
|Networking      |neutron   |python-neutronclient   |Configures networks for |
|                |          |                       |guest servers.          |
+----------------+----------+-----------------------+------------------------+
|Object Storage  |swift     |python-swiftclient     |Gathers statistics,     |
|                |          |                       |lists items, updates    |
|                |          |                       |metadata, and uploads,  |
|                |          |                       |downloads, and deletes  |
|                |          |                       |files stored by the     |
|                |          |                       |Object Storage service. |
|                |          |                       |Gains access to         |
|                |          |                       |an Object Storage       |
|                |          |                       |installation for ad hoc |
|                |          |                       |processing.             |
+----------------+----------+-----------------------+------------------------+
|Orchestration   |heat      |python-heatclient      |Launches stacks from    |
|                |          |                       |templates, views details|
|                |          |                       |of running stacks       |
|                |          |                       |including events and    |
|                |          |                       |resources, and updates  |
|                |          |                       |and deletes stacks.     |
+----------------+----------+-----------------------+------------------------+
|Rating          |cloudkitty|python-cloudkittyclient|Rating service.         |
|service         |          |                       |                        |
+----------------+----------+-----------------------+------------------------+
|Shared file     |manila    |python-manilaclient    |Creates and manages     |
|systems         |          |                       |shared file systems.    |
+----------------+----------+-----------------------+------------------------+
|Telemetry       |ceilometer|python-ceilometerclient|Creates and collects    |
|                |          |                       |measurements across     |
|                |          |                       |OpenStack.              |
+----------------+----------+-----------------------+------------------------+
|Telemetry v3    |gnocchi   |python-gnocchiclient   |Creates and collects    |
|                |          |                       |measurements across     |
|                |          |                       |OpenStack.              |
+----------------+----------+-----------------------+------------------------+
|Workflow        |mistral   |python-mistralclient   |Workflow service        |
|service         |          |                       |for OpenStack cloud.    |
+----------------+----------+-----------------------+------------------------+
|Common client   |openstack |python-openstackclient |Common client for the   |
|                |          |                       |OpenStack project.      |
+----------------+----------+-----------------------+------------------------+
