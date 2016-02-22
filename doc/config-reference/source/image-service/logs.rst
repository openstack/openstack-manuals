===============
Image log files
===============

The corresponding log file of each Image service is stored in the
``/var/log/glance/`` directory of the host on which each service runs.

.. list-table:: Log files used by Image services
   :widths: 35 35
   :header-rows: 1

   * - Log filename
     - Service that logs to the file
   * - ``api.log``
     - Image service API server
   * - ``registry.log``
     - Image service Registry server
