=======================
Orchestration log files
=======================

The corresponding log file of each Orchestration service is stored in the
``/var/log/heat/`` directory of the host on which each service runs.

.. list-table:: Log files used by Orchestration services
   :widths: 35 35
   :header-rows: 1

   * - Log filename
     - Service that logs to the file
   * - ``heat-api.log``
     - Orchestration service API Service
   * - ``heat-engine.log``
     - Orchestration service Engine Service
   * - ``heat-manage.log``
     - Orchestration service events
