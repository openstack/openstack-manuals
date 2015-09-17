========
Overview
========

Each OpenStack project provides a command-line client, which enables
you to access the project API through easy-to-use commands. For
example, the Compute service provides a nova command-line client.

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

+----------------+----------+-----------------------+------------------------+
|Service         |Client    |Package                |Description             |
+================+==========+=======================+========================+
|Application     |murano    |python-muranoclient    |Create and manage       |
|catalog         |          |                       |applications.           |
+----------------+----------+-----------------------+------------------------+
|Block Storage   |cinder    |python-cinderclient    |Create and manage       |
|                |          |                       |volumes.                |
+----------------+----------+-----------------------+------------------------+
|Compute         |nova      |python-novaclient      |Create and manage       |
|                |          |                       |images, instances, and  |
|                |          |                       |flavors.                |
+----------------+----------+-----------------------+------------------------+
|Containers      |magnum    |python-magnumclient    |Create and manage       |
|service         |          |                       |containers.             |
+----------------+----------+-----------------------+------------------------+
|Database service|trove     |python-troveclient     |Create and manage       |
|                |          |                       |databases.              |
+----------------+----------+-----------------------+------------------------+
|Identity        |keystone  |python-keystoneclient  |Create and manage       |
|                |          |                       |users, tenants, roles,  |
|                |          |                       |endpoints, and          |
|                |          |                       |credentials.            |
+----------------+----------+-----------------------+------------------------+
|Image service   |glance    |python-glanceclient    |Create and manage       |
|                |          |                       |images.                 |
+----------------+----------+-----------------------+------------------------+
|Key Manager     |barbican  |python-barbicanclient  |Create and manage       |
|service         |          |                       |keys.                   |
+----------------+----------+-----------------------+------------------------+
|Networking      |neutron   |python-neutronclient   |Configure networks for  |
|                |          |                       |guest servers.          |
+----------------+----------+-----------------------+------------------------+
|Object Storage  |swift     |python-swiftclient     |Gather statistics, list |
|                |          |                       |items, update metadata, |
|                |          |                       |and upload, download,   |
|                |          |                       |and delete files stored |
|                |          |                       |by the Object Storage   |
|                |          |                       |service. Gain access to |
|                |          |                       |an Object Storage       |
|                |          |                       |installation for ad hoc |
|                |          |                       |processing.             |
+----------------+----------+-----------------------+------------------------+
|Orchestration   |heat      |python-heatclient      |Launch stacks from      |
|                |          |                       |templates, view details |
|                |          |                       |of running stacks       |
|                |          |                       |including events and    |
|                |          |                       |resources, and update   |
|                |          |                       |and delete stacks.      |
+----------------+----------+-----------------------+------------------------+
|Shared file     |manila    |python-manilaclient    |Create and manage       |
|systems         |          |                       |shared file systems.    |
+----------------+----------+-----------------------+------------------------+
|Telemetry       |ceilometer|python-ceilometerclient|Create and collect      |
|                |          |                       |measurements across     |
|                |          |                       |OpenStack.              |
+----------------+----------+-----------------------+------------------------+
|Data processing |sahara    |python-saharaclient    |Create and manage       |
|                |          |                       |Hadoop clusters on      |
|                |          |                       |OpenStack.              |
+----------------+----------+-----------------------+------------------------+
|Common client   |openstack |python-openstackclient |Common client for the   |
|                |          |                       |OpenStack project.      |
+----------------+----------+-----------------------+------------------------+
