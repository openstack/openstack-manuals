===================
Dashboard log files
===================

The dashboard is served to users through the Apache HTTP Server(httpd).

As a result, dashboard-related logs appear in files in the
``/var/log/httpd`` or ``/var/log/apache2`` directory on the system
where the dashboard is hosted. The following table describes these files:

.. list-table:: Dashboard and httpd log files
   :header-rows: 1

   * - Log file
     - Description
   * - ``access_log``
     - Logs all attempts to access the web server.
   * - ``error_log``
     - Logs all unsuccessful attempts to access the web server,
       along with the reason that each attempt failed.
   * - ``/var/log/horizon/horizon.log``
     - Log of certain user interactions
