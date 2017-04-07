==========
Monitoring
==========

There are two types of monitoring: watching for problems and watching
usage trends. The former ensures that all services are up and running,
creating a functional cloud. The latter involves monitoring resource
usage over time in order to make informed decisions about potential
bottlenecks and upgrades.

Process Monitoring
~~~~~~~~~~~~~~~~~~

A basic type of alert monitoring is to simply check and see whether a
required process is running. For example, ensure that
the ``nova-api`` service is running on the cloud controller:

.. code-block:: console

   # ps aux | grep nova-api
   nova 12786 0.0 0.0 37952 1312 ? Ss Feb11 0:00 su -s /bin/sh -c exec nova-api
   --config-file=/etc/nova/nova.conf nova
   nova 12787 0.0 0.1 135764 57400 ? S Feb11 0:01 /usr/bin/python
    /usr/bin/nova-api --config-file=/etc/nova/nova.conf
   nova 12792 0.0 0.0 96052 22856 ? S Feb11 0:01 /usr/bin/python
   /usr/bin/nova-api --config-file=/etc/nova/nova.conf
   nova 12793 0.0 0.3 290688 115516 ? S Feb11 1:23 /usr/bin/python
   /usr/bin/nova-api --config-file=/etc/nova/nova.conf
   nova 12794 0.0 0.2 248636 77068 ? S Feb11 0:04 /usr/bin/python
   /usr/bin/nova-api --config-file=/etc/nova/nova.conf
   root 24121 0.0 0.0 11688 912 pts/5 S+ 13:07 0:00 grep nova-api


The OpenStack processes that should be monitored depend on the specific
configuration of the environment, but can include:

**Compute service (nova)**

* nova-api
* nova-scheduler
* nova-conductor
* nova-novncproxy
* nova-compute

**Block Storage service (cinder)**

* cinder-volume
* cinder-api
* cinder-scheduler

**Networking service (neutron)**

* neutron-api
* neutron-server
* neutron-openvswitch-agent
* neutron-dhcp-agent
* neutron-l3-agent
* neutron-metadata-agent

**Image service (glance)**

* glance-api
* glance-registry

**Identity service (keystone)**

The keystone processes are run within Apache as WSGI applications.

Resource Alerting
~~~~~~~~~~~~~~~~~

Resource alerting provides notifications when one or more resources are
critically low. While the monitoring thresholds should be tuned to your
specific OpenStack environment, monitoring resource usage is not
specific to OpenStack at all—any generic type of alert will work
fine.

Some of the resources that you want to monitor include:

* Disk usage
* Server load
* Memory usage
* Network I/O
* Available vCPUs

Telemetry Service
~~~~~~~~~~~~~~~~~

The Telemetry service (:term:`ceilometer`) collects
metering and event data relating to OpenStack services. Data collected
by the Telemetry service could be used for billing. Depending on
deployment configuration, collected data may be accessible to users
based on the deployment configuration. The Telemetry service provides a
REST API documented at `ceilometer V2 Web API
<https://docs.openstack.org/developer/ceilometer/webapi/v2.html>`_. You can
read more about the module in the `OpenStack Administrator
Guide <https://docs.openstack.org/admin-guide/telemetry.html>`_ or
in the `developer
documentation <https://docs.openstack.org/developer/ceilometer>`_.

OpenStack Specific Resources
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Resources such as memory, disk, and CPU are generic resources that all
servers (even non-OpenStack servers) have and are important to the
overall health of the server. When dealing with OpenStack specifically,
these resources are important for a second reason: ensuring that enough
are available to launch instances. There are a few ways you can see
OpenStack resource usage.
The first is through the :command:`nova` command:

.. code-block:: console

   # openstack usage list

This command displays a list of how many instances a tenant has running
and some light usage statistics about the combined instances. This
command is useful for a quick overview of your cloud, but it doesn't
really get into a lot of details.

Next, the ``nova`` database contains three tables that store usage
information.

The ``nova.quotas`` and ``nova.quota_usages`` tables store quota
information. If a tenant's quota is different from the default quota
settings, its quota is stored in the ``nova.quotas`` table. For example:

.. code-block:: mysql

   mysql> select project_id, resource, hard_limit from quotas;
   +----------------------------------+-----------------------------+------------+
   | project_id                       | resource                    | hard_limit |
   +----------------------------------+-----------------------------+------------+
   | 628df59f091142399e0689a2696f5baa | metadata_items              | 128        |
   | 628df59f091142399e0689a2696f5baa | injected_file_content_bytes | 10240      |
   | 628df59f091142399e0689a2696f5baa | injected_files              | 5          |
   | 628df59f091142399e0689a2696f5baa | gigabytes                   | 1000       |
   | 628df59f091142399e0689a2696f5baa | ram                         | 51200      |
   | 628df59f091142399e0689a2696f5baa | floating_ips                | 10         |
   | 628df59f091142399e0689a2696f5baa | instances                   | 10         |
   | 628df59f091142399e0689a2696f5baa | volumes                     | 10         |
   | 628df59f091142399e0689a2696f5baa | cores                       | 20         |
   +----------------------------------+-----------------------------+------------+

The ``nova.quota_usages`` table keeps track of how many resources the
tenant currently has in use:

.. code-block:: mysql

   mysql> select project_id, resource, in_use from quota_usages where project_id like '628%';
   +----------------------------------+--------------+--------+
   | project_id                       | resource     | in_use |
   +----------------------------------+--------------+--------+
   | 628df59f091142399e0689a2696f5baa | instances    | 1      |
   | 628df59f091142399e0689a2696f5baa | ram          | 512    |
   | 628df59f091142399e0689a2696f5baa | cores        | 1      |
   | 628df59f091142399e0689a2696f5baa | floating_ips | 1      |
   | 628df59f091142399e0689a2696f5baa | volumes      | 2      |
   | 628df59f091142399e0689a2696f5baa | gigabytes    | 12     |
   | 628df59f091142399e0689a2696f5baa | images       | 1      |
   +----------------------------------+--------------+--------+

By comparing a tenant's hard limit with their current resource usage,
you can see their usage percentage. For example, if this tenant is using
1 floating IP out of 10, then they are using 10 percent of their
floating IP quota. Rather than doing the calculation manually, you can
use SQL or the scripting language of your choice and create a formatted
report:

.. code-block:: mysql

   +----------------------------------+------------+-------------+---------------+
   | some_tenant                                                                 |
   +-----------------------------------+------------+------------+---------------+
   | Resource                          | Used       | Limit      |               |
   +-----------------------------------+------------+------------+---------------+
   | cores                             | 1          | 20         |           5 % |
   | floating_ips                      | 1          | 10         |          10 % |
   | gigabytes                         | 12         | 1000       |           1 % |
   | images                            | 1          | 4          |          25 % |
   | injected_file_content_bytes       | 0          | 10240      |           0 % |
   | injected_file_path_bytes          | 0          | 255        |           0 % |
   | injected_files                    | 0          | 5          |           0 % |
   | instances                         | 1          | 10         |          10 % |
   | key_pairs                         | 0          | 100        |           0 % |
   | metadata_items                    | 0          | 128        |           0 % |
   | ram                               | 512        | 51200      |           1 % |
   | reservation_expire                | 0          | 86400      |           0 % |
   | security_group_rules              | 0          | 20         |           0 % |
   | security_groups                   | 0          | 10         |           0 % |
   | volumes                           | 2          | 10         |          20 % |
   +-----------------------------------+------------+------------+---------------+

The preceding information was generated by using a custom script that
can be found on
`GitHub <https://github.com/cybera/novac/blob/dev/libexec/novac-quota-report>`_.

.. note::

   This script is specific to a certain OpenStack installation and must
   be modified to fit your environment. However, the logic should
   easily be transferable.

Intelligent Alerting
~~~~~~~~~~~~~~~~~~~~

Intelligent alerting can be thought of as a form of continuous
integration for operations. For example, you can easily check to see
whether the Image service is up and running by ensuring that
the ``glance-api`` and ``glance-registry`` processes are running or by
seeing whether ``glace-api`` is responding on port 9292.

But how can you tell whether images are being successfully uploaded to
the Image service? Maybe the disk that Image service is storing the
images on is full or the S3 back end is down. You could naturally check
this by doing a quick image upload:

.. code-block:: bash

   #!/bin/bash
   #
   # assumes that reasonable credentials have been stored at
   # /root/auth


   . /root/openrc
   wget http://download.cirros-cloud.net/0.3.5/cirros-0.3.5-x86_64-disk.img
   openstack image create --name='cirros image' --public \
   --container-format=bare --disk-format=qcow2 \
   --file cirros-0.3.5-x86_64-disk.img

By taking this script and rolling it into an alert for your monitoring
system (such as Nagios), you now have an automated way of ensuring that
image uploads to the Image Catalog are working.

.. note::

   You must remove the image after each test. Even better, test whether
   you can successfully delete an image from the Image service.

Intelligent alerting takes considerably more time to plan and implement
than the other alerts described in this chapter. A good outline to
implement intelligent alerting is:

-  Review common actions in your cloud.

-  Create ways to automatically test these actions.

-  Roll these tests into an alerting system.

Some other examples for Intelligent Alerting include:

-  Can instances launch and be destroyed?

-  Can users be created?

-  Can objects be stored and deleted?

-  Can volumes be created and destroyed?

Trending
~~~~~~~~

Trending can give you great insight into how your cloud is performing
day to day. You can learn, for example, if a busy day was simply a rare
occurrence or if you should start adding new compute nodes.

Trending takes a slightly different approach than alerting. While
alerting is interested in a binary result (whether a check succeeds or
fails), trending records the current state of something at a certain
point in time. Once enough points in time have been recorded, you can
see how the value has changed over time.

All of the alert types mentioned earlier can also be used for trend
reporting. Some other trend examples include:

* The number of instances on each compute node
* The types of flavors in use
* The number of volumes in use
* The number of Object Storage requests each hour
* The number of ``nova-api`` requests each hour
* The I/O statistics of your storage services

As an example, recording ``nova-api`` usage can allow you to track the
need to scale your cloud controller. By keeping an eye on ``nova-api``
requests, you can determine whether you need to spawn more ``nova-api``
processes or go as far as introducing an entirely new server to run
``nova-api``. To get an approximate count of the requests, look for
standard INFO messages in ``/var/log/nova/nova-api.log``:

.. code-block:: console

   # grep INFO /var/log/nova/nova-api.log | wc

You can obtain further statistics by looking for the number of
successful requests:

.. code-block:: console

   # grep " 200 " /var/log/nova/nova-api.log | wc

By running this command periodically and keeping a record of the result,
you can create a trending report over time that shows whether your
``nova-api`` usage is increasing, decreasing, or keeping steady.

A tool such as **collectd** can be used to store this information. While
collectd is out of the scope of this book, a good starting point would
be to use collectd to store the result as a COUNTER data type. More
information can be found in `collectd's
documentation <https://collectd.org/wiki/index.php/Data_source>`_.


Monitoring Tools
~~~~~~~~~~~~~~~~

Nagios
------


Nagios is an open source monitoring service. It is capable of executing
arbitrary commands to check the status of server and network services,
remotely executing arbitrary commands directly on servers, and allowing
servers to push notifications back in the form of passive monitoring.
Nagios has been around since 1999. Although newer monitoring services
are available, Nagios is a tried-and-true systems administration
staple.

You can create automated alerts for critical processes by using Nagios
and NRPE. For example, to ensure that the ``nova-compute`` process is
running on the compute nodes, create an alert on your Nagios server:

.. code-block:: none

   define service {
       host_name c01.example.com
       check_command check_nrpe_1arg!check_nova-compute
       use generic-service
       notification_period 24x7
       contact_groups sysadmins
       service_description nova-compute
   }

On the Compute node, create the following NRPE
configuration:

.. code-block:: ini

    command[check_nova-compute]=/usr/lib/nagios/plugins/check_procs -c 1: -a nova-compute

Nagios checks that at least one ``nova-compute`` service is running at
all times.

For resource alerting, for example, monitor disk capacity on a compute node
with Nagios, add the following to your Nagios configuration:

.. code-block:: none

   define service {
       host_name c01.example.com
       check_command check_nrpe!check_all_disks!20% 10%
       use generic-service
       contact_groups sysadmins
       service_description Disk
   }

On the compute node, add the following to your NRPE configuration:

.. code-block:: none

   command[check_all_disks]=/usr/lib/nagios/plugins/check_disk -w $ARG1$ -c $ARG2$ -e

Nagios alerts you with a `WARNING` when any disk on the compute node is 80
percent full and `CRITICAL` when 90 percent is full.

StackTach
---------

StackTach is a tool that collects and reports the notifications sent by
nova. Notifications are essentially the same as logs but can be much
more detailed. Nearly all OpenStack components are capable of generating
notifications when significant events occur. Notifications are messages
placed on the OpenStack queue (generally RabbitMQ) for consumption by
downstream systems. An overview of notifications can be found at `System
Usage
Data <https://wiki.openstack.org/wiki/SystemUsageData>`_.

To enable nova to send notifications, add the following to the
``nova.conf`` configuration file:

.. code-block:: ini

   notification_topics=monitor
   notification_driver=messagingv2

Once nova is sending notifications, install and configure StackTach.
StackTach works for queue consumption and pipeline processing are
configured to read these notifications from RabbitMQ servers and store
them in a database. Users can inquire on instances, requests, and servers
by using the browser interface or command-line tool,
`Stacky <https://github.com/rackerlabs/stacky>`_. Since StackTach is
relatively new and constantly changing, installation instructions
quickly become outdated. Refer to the `StackTach Git
repository <https://git.openstack.org/cgit/openstack/stacktach>`_ for
instructions as well as a demostration video. Additional details on the latest
developments can be discovered at the `official
page <http://stacktach.com/>`_

Logstash
~~~~~~~~

Logstash is a high performance indexing and search engine for logs. Logs
from Jenkins test runs are sent to logstash where they are indexed and
stored. Logstash facilitates reviewing logs from multiple sources in a
single test run, searching for errors or particular events within a test
run, and searching for log event trends across test runs.

There are four major layers in Logstash setup which are:

* Log Pusher
* Log Indexer
* ElasticSearch
* Kibana

Each layer scales horizontally. As the number of logs grows you can add
more log pushers, more Logstash indexers, and more ElasticSearch nodes.

Logpusher is a pair of Python scripts that first listens to Jenkins
build events, then converts them into Gearman jobs. Gearman provides a
generic application framework to farm out work to other machines or
processes that are better suited to do the work. It allows you to do
work in parallel, to load balance processing, and to call functions
between languages. Later, Logpusher performs Gearman jobs to push log
files into logstash. Logstash indexer reads these log events, filters
them to remove unwanted lines, collapse multiple events together, and
parses useful information before shipping them to ElasticSearch for
storage and indexing. Kibana is a logstash oriented web client for
ElasticSearch.
