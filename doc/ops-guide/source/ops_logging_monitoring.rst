======================
Logging and Monitoring
======================

As an OpenStack cloud is composed of so many different services, there
are a large number of log files. This chapter aims to assist you in
locating and working with them and describes other ways to track the
status of your deployment.

Where Are the Logs?
~~~~~~~~~~~~~~~~~~~

Most services use the convention of writing their log files to
subdirectories of the ``/var/log directory``, as listed in the
below table.

.. list-table:: OpenStack log locations
   :widths: 33 33 33
   :header-rows: 1

   * - Node type
     - Service
     - Log location
   * - Cloud controller
     - ``nova-*``
     - ``/var/log/nova``
   * - Cloud controller
     - ``glance-*``
     - ``/var/log/glance``
   * - Cloud controller
     - ``cinder-*``
     - ``/var/log/cinder``
   * - Cloud controller
     - ``keystone-*``
     - ``/var/log/keystone``
   * - Cloud controller
     - ``neutron-*``
     - ``/var/log/neutron``
   * - Cloud controller
     - horizon
     - ``/var/log/apache2/``
   * - All nodes
     - misc (swift, dnsmasq)
     - ``/var/log/syslog``
   * - Compute nodes
     - libvirt
     - ``/var/log/libvirt/libvirtd.log``
   * - Compute nodes
     - Console (boot up messages) for VM instances:
     - ``/var/lib/nova/instances/instance-<instance id>/console.log``
   * - Block Storage nodes
     - cinder-volume
     - ``/var/log/cinder/cinder-volume.log``


Reading the Logs
~~~~~~~~~~~~~~~~

OpenStack services use the standard logging levels, at increasing
severity: DEBUG, INFO, AUDIT, WARNING, ERROR, CRITICAL, and TRACE. That
is, messages only appear in the logs if they are more "severe" than the
particular log level, with DEBUG allowing all log statements through.
For example, TRACE is logged only if the software has a stack trace,
while INFO is logged for every message including those that are only for
information.

To disable DEBUG-level logging, edit ``/etc/nova/nova.conf`` file as follows:

.. code-block:: ini

   debug=false

Keystone is handled a little differently. To modify the logging level,
edit the ``/etc/keystone/logging.conf`` file and look at the
``logger_root`` and ``handler_file`` sections.

Logging for horizon is configured in
``/etc/openstack_dashboard/local_settings.py``. Because horizon is
a Django web application, it follows the `Django Logging framework
conventions <https://docs.djangoproject.com/en/dev/topics/logging/>`_.

The first step in finding the source of an error is typically to search
for a CRITICAL, TRACE, or ERROR message in the log starting at the
bottom of the log file.

Here is an example of a CRITICAL log message, with the corresponding
TRACE (Python traceback) immediately following:

.. code-block:: console

   2013-02-25 21:05:51 17409 CRITICAL cinder [-] Bad or unexpected response from the storage volume backend API: volume group
    cinder-volumes doesn't exist
   2013-02-25 21:05:51 17409 TRACE cinder Traceback (most recent call last):
   2013-02-25 21:05:51 17409 TRACE cinder File "/usr/bin/cinder-volume", line 48, in <module>
   2013-02-25 21:05:51 17409 TRACE cinder service.wait()
   2013-02-25 21:05:51 17409 TRACE cinder File "/usr/lib/python2.7/dist-packages/cinder/service.py", line 422, in wait
   2013-02-25 21:05:51 17409 TRACE cinder _launcher.wait()
   2013-02-25 21:05:51 17409 TRACE cinder File "/usr/lib/python2.7/dist-packages/cinder/service.py", line 127, in wait
   2013-02-25 21:05:51 17409 TRACE cinder service.wait()
   2013-02-25 21:05:51 17409 TRACE cinder File "/usr/lib/python2.7/dist-packages/eventlet/greenthread.py", line 166, in wait
   2013-02-25 21:05:51 17409 TRACE cinder return self._exit_event.wait()
   2013-02-25 21:05:51 17409 TRACE cinder File "/usr/lib/python2.7/dist-packages/eventlet/event.py", line 116, in wait
   2013-02-25 21:05:51 17409 TRACE cinder return hubs.get_hub().switch()
   2013-02-25 21:05:51 17409 TRACE cinder File "/usr/lib/python2.7/dist-packages/eventlet/hubs/hub.py", line 177, in switch
   2013-02-25 21:05:51 17409 TRACE cinder return self.greenlet.switch()
   2013-02-25 21:05:51 17409 TRACE cinder File "/usr/lib/python2.7/dist-packages/eventlet/greenthread.py", line 192, in main
   2013-02-25 21:05:51 17409 TRACE cinder result = function(*args, **kwargs)
   2013-02-25 21:05:51 17409 TRACE cinder File "/usr/lib/python2.7/dist-packages/cinder/service.py", line 88, in run_server
   2013-02-25 21:05:51 17409 TRACE cinder server.start()
   2013-02-25 21:05:51 17409 TRACE cinder File "/usr/lib/python2.7/dist-packages/cinder/service.py", line 159, in start
   2013-02-25 21:05:51 17409 TRACE cinder self.manager.init_host()
   2013-02-25 21:05:51 17409 TRACE cinder File "/usr/lib/python2.7/dist-packages/cinder/volume/manager.py", line 95,
    in init_host
   2013-02-25 21:05:51 17409 TRACE cinder self.driver.check_for_setup_error()
   2013-02-25 21:05:51 17409 TRACE cinder File "/usr/lib/python2.7/dist-packages/cinder/volume/driver.py", line 116,
    in check_for_setup_error
   2013-02-25 21:05:51 17409 TRACE cinder raise exception.VolumeBackendAPIException(data=exception_message)
   2013-02-25 21:05:51 17409 TRACE cinder VolumeBackendAPIException: Bad or unexpected response from the storage volume
    backend API: volume group cinder-volumes doesn't exist
   2013-02-25 21:05:51 17409 TRACE cinder

In this example, ``cinder-volumes`` failed to start and has provided a
stack trace, since its volume back end has been unable to set up the
storage volume—probably because the LVM volume that is expected from the
configuration does not exist.

Here is an example error log:

.. code-block:: console

   2013-02-25 20:26:33 6619 ERROR nova.openstack.common.rpc.common [-] AMQP server on localhost:5672 is unreachable:
    [Errno 111] ECONNREFUSED. Trying again in 23 seconds.

In this error, a nova service has failed to connect to the RabbitMQ
server because it got a connection refused error.

Tracing Instance Requests
~~~~~~~~~~~~~~~~~~~~~~~~~

When an instance fails to behave properly, you will often have to trace
activity associated with that instance across the log files of various
``nova-*`` services and across both the cloud controller and compute
nodes.

The typical way is to trace the UUID associated with an instance across
the service logs.

Consider the following example:

.. code-block:: console

   $ nova list
   +--------------------------------+--------+--------+--------------------------+
   | ID                             | Name   | Status | Networks                 |
   +--------------------------------+--------+--------+--------------------------+
   | fafed8-4a46-413b-b113-f1959ffe | cirros | ACTIVE | novanetwork=192.168.100.3|
   +--------------------------------------+--------+--------+--------------------+

Here, the ID associated with the instance is
``faf7ded8-4a46-413b-b113-f19590746ffe``. If you search for this string
on the cloud controller in the ``/var/log/nova-*.log`` files, it appears
in ``nova-api.log`` and ``nova-scheduler.log``. If you search for this
on the compute nodes in ``/var/log/nova-*.log``, it appears in
``nova-network.log`` and ``nova-compute.log``. If no ERROR or CRITICAL
messages appear, the most recent log entry that reports this may provide
a hint about what has gone wrong.

Adding Custom Logging Statements
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If there is not enough information in the existing logs, you may need to
add your own custom logging statements to the ``nova-*``
services.

The source files are located in
``/usr/lib/python2.7/dist-packages/nova``.

To add logging statements, the following line should be near the top of
the file. For most files, these should already be there:

.. code-block:: python

   from nova.openstack.common import log as logging
   LOG = logging.getLogger(__name__)

To add a DEBUG logging statement, you would do:

.. code-block:: python

   LOG.debug("This is a custom debugging statement")

You may notice that all the existing logging messages are preceded by an
underscore and surrounded by parentheses, for example:

.. code-block:: python

   LOG.debug(_("Logging statement appears here"))

This formatting is used to support translation of logging messages into
different languages using the
`gettext <https://docs.python.org/2/library/gettext.html>`_
internationalization library. You don't need to do this for your own
custom log messages. However, if you want to contribute the code back to
the OpenStack project that includes logging statements, you must
surround your log messages with underscores and parentheses.

RabbitMQ Web Management Interface or rabbitmqctl
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Aside from connection failures, RabbitMQ log files are generally not
useful for debugging OpenStack related issues. Instead, we recommend you
use the RabbitMQ web management interface.RabbitMQlogging/monitoring
RabbitMQ web management interface Enable it on your cloud
controller:

.. code-block:: console

   # /usr/lib/rabbitmq/bin/rabbitmq-plugins enable rabbitmq_management

.. code-block:: console

   # service rabbitmq-server restart

The RabbitMQ web management interface is accessible on your cloud
controller at *http://localhost:55672*.

.. note::

   Ubuntu 12.04 installs RabbitMQ version 2.7.1, which uses port 55672.
   RabbitMQ versions 3.0 and above use port 15672 instead. You can
   check which version of RabbitMQ you have running on your local
   Ubuntu machine by doing:

   .. code-block:: console

      $ dpkg -s rabbitmq-server | grep "Version:"
      Version: 2.7.1-0ubuntu4

An alternative to enabling the RabbitMQ web management interface is to
use the ``rabbitmqctl`` commands. For example,
:command:`rabbitmqctl list_queues| grep cinder` displays any messages left in
the queue. If there are messages, it's a possible sign that cinder
services didn't connect properly to rabbitmq and might have to be
restarted.

Items to monitor for RabbitMQ include the number of items in each of the
queues and the processing time statistics for the server.

Centrally Managing Logs
~~~~~~~~~~~~~~~~~~~~~~~

Because your cloud is most likely composed of many servers, you must
check logs on each of those servers to properly piece an event together.
A better solution is to send the logs of all servers to a central
location so that they can all be accessed from the same
area.

Ubuntu uses rsyslog as the default logging service. Since it is natively
able to send logs to a remote location, you don't have to install
anything extra to enable this feature, just modify the configuration
file. In doing this, consider running your logging over a management
network or using an encrypted VPN to avoid interception.

rsyslog Client Configuration
----------------------------

To begin, configure all OpenStack components to log to syslog in
addition to their standard log file location. Also configure each
component to log to a different syslog facility. This makes it easier to
split the logs into individual components on the central server:

``nova.conf``:

.. code-block:: ini

   use_syslog=True
   syslog_log_facility=LOG_LOCAL0

``glance-api.conf`` and ``glance-registry.conf``:

.. code-block:: ini

   use_syslog=True
   syslog_log_facility=LOG_LOCAL1

``cinder.conf``:

.. code-block:: ini

   use_syslog=True
   syslog_log_facility=LOG_LOCAL2

``keystone.conf``:

.. code-block:: ini

   use_syslog=True
   syslog_log_facility=LOG_LOCAL3

By default, Object Storage logs to syslog.

Next, create ``/etc/rsyslog.d/client.conf`` with the following line:

.. code-block:: ini

   *.* @192.168.1.10

This instructs rsyslog to send all logs to the IP listed. In this
example, the IP points to the cloud controller.

rsyslog Server Configuration
----------------------------

Designate a server as the central logging server. The best practice is
to choose a server that is solely dedicated to this purpose. Create a
file called ``/etc/rsyslog.d/server.conf`` with the following contents:

.. code-block:: ini

   # Enable UDP
   $ModLoad imudp
   # Listen on 192.168.1.10 only
   $UDPServerAddress 192.168.1.10
   # Port 514
   $UDPServerRun 514

   # Create logging templates for nova
   $template NovaFile,"/var/log/rsyslog/%HOSTNAME%/nova.log"
   $template NovaAll,"/var/log/rsyslog/nova.log"

   # Log everything else to syslog.log
   $template DynFile,"/var/log/rsyslog/%HOSTNAME%/syslog.log"
   *.* ?DynFile

   # Log various openstack components to their own individual file
   local0.* ?NovaFile
   local0.* ?NovaAll
   & ~

This example configuration handles the nova service only. It first
configures rsyslog to act as a server that runs on port 514. Next, it
creates a series of logging templates. Logging templates control where
received logs are stored. Using the last example, a nova log from
c01.example.com goes to the following locations:

-  ``/var/log/rsyslog/c01.example.com/nova.log``

-  ``/var/log/rsyslog/nova.log``

This is useful, as logs from c02.example.com go to:

-  ``/var/log/rsyslog/c02.example.com/nova.log``

-  ``/var/log/rsyslog/nova.log``

You have an individual log file for each compute node as well as an
aggregated log that contains nova logs from all nodes.

Monitoring
~~~~~~~~~~

There are two types of monitoring: watching for problems and watching
usage trends. The former ensures that all services are up and running,
creating a functional cloud. The latter involves monitoring resource
usage over time in order to make informed decisions about potential
bottlenecks and upgrades.

**Nagios** is an open source monitoring service. It's capable of executing
arbitrary commands to check the status of server and network services,
remotely executing arbitrary commands directly on servers, and allowing
servers to push notifications back in the form of passive monitoring.
Nagios has been around since 1999. Although newer monitoring services
are available, Nagios is a tried-and-true systems administration
staple.

Process Monitoring
------------------

A basic type of alert monitoring is to simply check and see whether a
required process is running.monitoring process monitoringprocess
monitoringlogging/monitoring process monitoring For example, ensure that
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

You can create automated alerts for critical processes by using Nagios
and NRPE. For example, to ensure that the ``nova-compute`` process is
running on compute nodes, create an alert on your Nagios server that
looks like this:

.. code-block:: none

   define service {
       host_name c01.example.com
       check_command check_nrpe_1arg!check_nova-compute
       use generic-service
       notification_period 24x7
       contact_groups sysadmins
       service_description nova-compute
   }

Then on the actual compute node, create the following NRPE
configuration:

.. code-block:: none

    \command[check_nova-compute]=/usr/lib/nagios/plugins/check_procs -c 1: \
    -a nova-compute

Nagios checks that at least one ``nova-compute`` service is running at
all times.

Resource Alerting
-----------------

Resource alerting provides notifications when one or more resources are
critically low. While the monitoring thresholds should be tuned to your
specific OpenStack environment, monitoring resource usage is not
specific to OpenStack at all—any generic type of alert will work
fine.

Some of the resources that you want to monitor include:

-  Disk usage

-  Server load

-  Memory usage

-  Network I/O

-  Available vCPUs

For example, to monitor disk capacity on a compute node with Nagios, add
the following to your Nagios configuration:

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

   command[check_all_disks]=/usr/lib/nagios/plugins/check_disk -w $ARG1$ -c \
   $ARG2$ -e

Nagios alerts you with a WARNING when any disk on the compute node is 80
percent full and CRITICAL when 90 percent is full.

StackTach
---------

StackTach is a tool that collects and reports the notifications sent by
``nova``. Notifications are essentially the same as logs but can be much
more detailed. Nearly all OpenStack components are capable of generating
notifications when significant events occur. Notifications are messages
placed on the OpenStack queue (generally RabbitMQ) for consumption by
downstream systems. An overview of notifications can be found at `System
Usage
Data <https://wiki.openstack.org/wiki/SystemUsageData>`_.

To enable ``nova`` to send notifications, add the following to
``nova.conf``:

.. code-block:: ini

   notification_topics=monitor
   notification_driver=messagingv2

Once ``nova`` is sending notifications, install and configure StackTach.
StackTach workers for Queue consumption and pipeling processing are
configured to read these notifications from RabbitMQ servers and store
them in a database. Users can inquire on instances, requests and servers
by using the browser interface or command line tool,
`Stacky <https://github.com/rackerlabs/stacky>`_. Since StackTach is
relatively new and constantly changing, installation instructions
quickly become outdated. Please refer to the `StackTach Git
repo <https://git.openstack.org/cgit//openstack/stacktach>`_ for
instructions as well as a demo video. Additional details on the latest
developments can be discovered at the `official
page <http://stacktach.com/>`_

Logstash
--------

Logstash is a high performance indexing and search engine for logs. Logs
from Jenkins test runs are sent to logstash where they are indexed and
stored. Logstash facilitates reviewing logs from multiple sources in a
single test run, searching for errors or particular events within a test
run, and searching for log event trends across test runs.

There are four major layers in Logstash setup which are

-  Log Pusher

-  Log Indexer

-  ElasticSearch

-  Kibana

Each layer scales horizontally. As the number of logs grows you can add
more log pushers, more Logstash indexers, and more ElasticSearch nodes.

Logpusher is a pair of Python scripts which first listens to Jenkins
build events and converts them into Gearman jobs. Gearman provides a
generic application framework to farm out work to other machines or
processes that are better suited to do the work. It allows you to do
work in parallel, to load balance processing, and to call functions
between languages.Later Logpusher performs Gearman jobs to push log
files into logstash. Logstash indexer reads these log events, filters
them to remove unwanted lines, collapse multiple events together, and
parses useful information before shipping them to ElasticSearch for
storage and indexing. Kibana is a logstash oriented web client for
ElasticSearch.

OpenStack Telemetry
-------------------

An integrated OpenStack project (code-named :term:`ceilometer`) collects
metering and event data relating to OpenStack services. Data collected
by the Telemetry service could be used for billing. Depending on
deployment configuration, collected data may be accessible to users
based on the deployment configuration. The Telemetry service provides a
REST API documented at
http://developer.openstack.org/api-ref-telemetry-v2.html. You can read
more about the module in the `OpenStack Administrator
Guide <http://docs.openstack.org/admin-guide/telemetry.html>`_ or
in the `developer
documentation <http://docs.openstack.org/developer/ceilometer>`_.

OpenStack-Specific Resources
----------------------------

Resources such as memory, disk, and CPU are generic resources that all
servers (even non-OpenStack servers) have and are important to the
overall health of the server. When dealing with OpenStack specifically,
these resources are important for a second reason: ensuring that enough
are available to launch instances. There are a few ways you can see
OpenStack resource usage.monitoring OpenStack-specific
resourcesresources generic vs. OpenStack-specificlogging/monitoring
OpenStack-specific resources The first is through the :command:`nova` command:

.. code-block:: console

   # nova usage-list

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
--------------------

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
   wget http://download.cirros-cloud.net/0.3.4/cirros-0.3.4-x86_64-disk.img
   glance image-create --name='cirros image' --is-public=true
   --container-format=bare --disk-format=qcow2 < cirros-0.3.4-x8
   6_64-disk.img

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
--------

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

-  The number of instances on each compute node

-  The types of flavors in use

-  The number of volumes in use

-  The number of Object Storage requests each hour

-  The number of ``nova-api`` requests each hour

-  The I/O statistics of your storage services

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

Summary
~~~~~~~

For stable operations, you want to detect failure promptly and determine
causes efficiently. With a distributed system, it's even more important
to track the right items to meet a service-level target. Learning where
these logs are located in the file system or API gives you an advantage.
This chapter also showed how to read, interpret, and manipulate
information from OpenStack services so that you can monitor effectively.
