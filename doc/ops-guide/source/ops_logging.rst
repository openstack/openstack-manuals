=======
Logging
=======

Where Are the Logs?
~~~~~~~~~~~~~~~~~~~

Most services use the convention of writing their log files to
subdirectories of the ``/var/log directory``, as listed in
:ref:`table_log_locations`.

.. _table_log_locations:

.. list-table:: Table OpenStack log locations
   :widths: 25 25 50
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

   2013-02-25 21:05:51 17409 CRITICAL cinder [-] Bad or unexpected response from the storage volume backend API:
   volume group cinder-volumes doesn't exist
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
use the RabbitMQ web management interface. Enable it on your cloud
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
