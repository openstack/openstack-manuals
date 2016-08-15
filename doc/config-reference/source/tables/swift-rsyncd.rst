.. This table is manually created.

.. list-table:: Description of configuration options in ``rsyncd.conf``
   :header-rows: 1
   :class: config-ref-table

   * - Configuration option = Default value
     - Description
   * - ``gid`` = ``swift``
     - Group ID for rsyncd.
   * - ``log file`` = ``/var/log/rsyncd.log``
     - Log file for rsyncd.
   * - ``pid file`` = ``/var/run/rsyncd.pid``
     - PID file for rsyncd.
   * - ``uid`` = ``swift``
     - User ID for rsyncd.
   * - ``max connections`` =
     - Maximum number of connections for rsyncd. This option should be set for each account, container, or object.
   * - ``path`` = ``/srv/node``
     - Working directory for rsyncd to use. This option should be set for each account, container, or object.
   * - ``read only`` = ``false``
     - Set read only. This option should be set for each account, container, or object.
   * - ``lock file`` =
     - Lock file for rsyncd. This option should be set for each account, container, or object.
