==================
Database log files
==================

The corresponding log file of each Database service is stored in the
``/var/log/trove/`` directory of the host on which each service runs.

.. list-table:: Log files used by Database services
   :widths: 35 35
   :header-rows: 1

   * - Log filename
     - Service that logs to the file
   * - ``trove-api.log``
     - Database service API Service
   * - ``trove-conductor.log``
     - Database service Conductor Service
   * - ``'logfile.txt'``
     - Database service guestagent Service
   * - ``trove-taskmanager.log``
     - Database service taskmanager Service
