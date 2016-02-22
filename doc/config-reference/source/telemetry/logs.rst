===================
Telemetry log files
===================

The corresponding log file of each Telemetry service is stored in the
``/var/log/ceilometer/`` directory of the host on which each service runs.

.. list-table:: Log files used by Telemetry services
   :widths: 35 35
   :header-rows: 1

   * - Log filename
     - Service that logs to the file
   * - ``agent-notification.log``
     - Telemetry service notification agent
   * - ``alarm-evaluator.log``
     - Telemetry service alarm evaluation
   * - ``alarm-notifier.log``
     - Telemetry service alarm notification
   * - ``api.log``
     - Telemetry service API
   * - ``ceilometer-dbsync.log``
     - Informational messages
   * - ``central.log``
     - Telemetry service central agent
   * - ``collector.log``
     - Telemetry service collection
   * - ``compute.log``
     - Telemetry service compute agent
