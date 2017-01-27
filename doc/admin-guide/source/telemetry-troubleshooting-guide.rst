Troubleshoot Telemetry
~~~~~~~~~~~~~~~~~~~~~~

Logging in Telemetry
--------------------

The Telemetry service has similar log settings as the other OpenStack
services. Multiple options are available to change the target of
logging, the format of the log entries and the log levels.

The log settings can be changed in ``ceilometer.conf``. The list of
configuration options are listed in the logging configuration options
table in the `Telemetry
section <https://docs.openstack.org/newton/config-reference/telemetry.html>`__
in the OpenStack Configuration Reference.

By default ``stderr`` is used as standard output for the log messages.
It can be changed to either a log file or syslog. The ``debug`` and
``verbose`` options are also set to false in the default settings, the
default log levels of the corresponding modules can be found in the
table referred above.


Recommended order of starting services
--------------------------------------

As it can be seen in `Bug
1355809 <https://bugs.launchpad.net/devstack/+bug/1355809>`__, the wrong
ordering of service startup can result in data loss.

When the services are started for the first time or in line with the
message queue service restart, it takes time while the
``ceilometer-collector`` service establishes the connection and joins or
rejoins to the configured exchanges. Therefore, if the
``ceilometer-agent-compute``, ``ceilometer-agent-central``, and the
``ceilometer-agent-notification`` services are started before
the ``ceilometer-collector`` service, the ``ceilometer-collector`` service
may lose some messages while connecting to the message queue service.

The possibility of this issue to happen is higher, when the polling
interval is set to a relatively short period. In order to avoid this
situation, the recommended order of service startup is to start or
restart the ``ceilometer-collector`` service after the message queue. All
the other Telemetry services should be started or restarted after and
the ``ceilometer-agent-compute`` should be the last in the sequence, as this
component emits metering messages in order to send the samples to the
collector.


Notification agent
------------------

In the Icehouse release of OpenStack a new service was introduced to be
responsible for consuming notifications that are coming from other
OpenStack services.

If the ``ceilometer-agent-notification`` service is not installed and
started, samples originating from notifications will not be generated.
In case of the lack of notification based samples, the state of this
service and the log file of Telemetry should be checked first.

For the list of meters that are originated from notifications, see the
`Telemetry Measurements
Reference <https://docs.openstack.org/developer/ceilometer/measurements.html>`__.


Recommended auth_url to be used
-------------------------------

When using the Telemetry command-line client, the credentials and the
``os_auth_url`` have to be set in order for the client to authenticate
against OpenStack Identity. For further details
about the credentials that have to be provided see the `Telemetry Python
API <https://docs.openstack.org/developer/python-ceilometerclient/>`__.

The service catalog provided by OpenStack Identity contains the
URLs that are available for authentication. The URLs have
different ``port``\s, based on whether the type of the given URL is
``public``, ``internal`` or ``admin``.

OpenStack Identity is about to change API version from v2 to v3. The
``adminURL`` endpoint (which is available via the port: ``35357``)
supports only the v3 version, while the other two supports both.

The Telemetry command line client is not adapted to the v3 version of
the OpenStack Identity API. If the ``adminURL`` is used as
``os_auth_url``, the :command:`ceilometer` command results in the following
error message:

.. code-block:: console

   $ ceilometer meter-list
     Unable to determine the Keystone version to authenticate with \
     using the given auth_url: http://10.0.2.15:35357/v2.0

Therefore when specifying the ``os_auth_url`` parameter on the command
line or by using environment variable, use the ``internalURL`` or
``publicURL``.

For more details check the bug report `Bug
1351841 <https://bugs.launchpad.net/python-ceilometerclient/+bug/1351841>`__.


.. TODO (karenb) The content in this file needs updating.
