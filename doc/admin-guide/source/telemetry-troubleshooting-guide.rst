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
section <https://docs.openstack.org/ocata/config-reference/telemetry.html>`__
in the OpenStack Configuration Reference.

By default ``stderr`` is used as standard output for the log messages.
It can be changed to either a log file or syslog. The ``debug`` and
``verbose`` options are also set to false in the default settings, the
default log levels of the corresponding modules can be found in the
table referred above.
