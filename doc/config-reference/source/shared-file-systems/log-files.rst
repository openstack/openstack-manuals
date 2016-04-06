=====================================
Log files used by Shared File Systems
=====================================

The corresponding log file of each Shared File Systems service is stored
in the ``/var/log/manila/`` directory of the host on which each service
runs.

.. list-table:: Log files used by Shared File Systems services
   :header-rows: 1

   * - Log file
     - Service/interface (for CentOS, Fedora, openSUSE, Red Hat Enterprise
       Linux, and SUSE Linux Enterprise)
     - Service/interface (for Ubuntu and Debian)
   * - ``api.log``
     - ``openstack-manila-api``
     - ``manila-api``
   * - ``manila-manage.log``
     - ``manila-manage``
     - ``manila-manage``
   * - ``scheduler.log``
     - ``openstack-manila-scheduler``
     - ``manila-scheduler``
   * - ``share.log``
     - ``openstack-manila-share``
     - ``manila-share``
   * - ``data.log``
     - ``openstack-manila-data``
     - ``manila-data``
