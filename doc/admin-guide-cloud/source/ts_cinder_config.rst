============================================
Troubleshoot the Block Storage configuration
============================================

Most Block Storage errors are caused by incorrect volume configurations
that result in volume creation failures. To resolve these failures,
review these logs:

-  ``cinder-api`` log (``/var/log/cinder/api.log``)

-  ``cinder-volume`` log (``/var/log/cinder/volume.log``)

The ``cinder-api`` log is useful for determining if you have endpoint or
connectivity issues. If you send a request to create a volume and it
fails, review the ``cinder-api`` log to determine whether the request made
it to the Block Storage service. If the request is logged and you see no
errors or tracebacks, check the ``cinder-volume`` log for errors or
tracebacks.

.. note::

   Create commands are listed in the ``cinder-api`` log.

These entries in the ``cinder.openstack.common.log`` file can be used to
assist in troubleshooting your Block Storage configuration.

.. code-block:: console

   # Print debugging output (set logging level to DEBUG instead
   # of default WARNING level). (boolean value)
   # debug=false

   # Print more verbose output (set logging level to INFO instead
   # of default WARNING level). (boolean value)
   # verbose=false

   # Log output to standard error (boolean value)
   # use_stderr=true

   # Default file mode used when creating log files (string
   # value)
   # logfile_mode=0644

   # format string to use for log messages with context (string
   # value)
   # logging_context_format_string=%(asctime)s.%(msecs)03d %(levelname)s
   # %(name)s [%(request_id)s %(user)s %(tenant)s] %(instance)s%(message)s

   # format string to use for log mes #logging_default_format_string=%(asctime)s.
   # %(msecs)03d %(process)d %(levelname)s %(name)s [-] %(instance)s%(message)s

   # data to append to log format when level is DEBUG (string
   # value)
   # logging_debug_format_suffix=%(funcName)s %(pathname)s:%(lineno)d

   # prefix each line of exception output with this format
   # (string value)
   # logging_exception_prefix=%(asctime)s.%(msecs)03d %(process)d TRACE %(name)s
   # %(instance)s

   # list of logger=LEVEL pairs (list value)
   # default_log_levels=amqplib=WARN,sqlalchemy=WARN,boto=WARN,suds=INFO,
   # keystone=INFO,eventlet.wsgi.server=WARNsages without context
   # (string value)

   # If an instance is passed with the log message, format it
   # like this (string value)
   # instance_format="[instance: %(uuid)s]"

   # If an instance UUID is passed with the log message, format
   # it like this (string value)
   # A logging.Formatter log message format string which may use
   # any of the available logging.LogRecord attributes. Default:
   # %(default)s (string value)
   # log_format=%(asctime)s %(levelname)8s [%(name)s] %(message)s

   # Format string for %%(asctime)s in log records. Default:
   # %(default)s (string value)
   # log_date_format=%Y-%m-%d %H:%M:%S

   # (Optional) Name of log file to output to. If not set,
   # logging will go to stdout. (string value)
   # log_file=<None>

   # (Optional) The directory to keep log files in (will be
   # prepended to --log-file) (string value)
   # log_dir=<None>
   # instance_uuid_format="[instance: %(uuid)s]"

   # If this option is specified, the logging configuration file
   # specified is used and overrides any other logging options
   # specified. Please see the Python logging module
   # documentation for details on logging configuration files.
   # (string value)
   # Use syslog for logging. (boolean value)
   # use_syslog=false

   # syslog facility to receive log lines (string value)
   # syslog_log_facility=LOG_USER
   # log_config=<None>

These common issues might occur during configuration. To correct, use
these suggested solutions.

-  Issues with ``state_path`` and ``volumes_dir`` settings.

   The OpenStack Block Storage uses ``tgtd`` as the default iSCSI helper
   and implements persistent targets. This means that in the case of a
   ``tgt`` restart or even a node reboot your existing volumes on that node
   will be restored automatically with their original :term:`IQN`.

   In order to make this possible the iSCSI target information needs to
   be stored in a file on creation that can be queried in case of
   restart of the ``tgt daemon``. By default, Block Storage uses a
   ``state_path`` variable, which if installing with Yum or APT should
   be set to ``/var/lib/cinder/``. The next part is the ``volumes_dir``
   variable, by default this just simply appends a ``volumes``
   directory to the ``state_path``. The result is a file-tree
   ``/var/lib/cinder/volumes/``.

   While the installer should handle all this, it can go wrong. If you have
   trouble creating volumes and this directory does not exist you should
   see an error message in the ``cinder-volume`` log indicating that the
   ``volumes_dir`` does not exist, and it should provide information about
   which path it was looking for.

-  The persistent tgt include file.

   Along with the ``volumes_dir`` option, the iSCSI target driver also
   needs to be configured to look in the correct place for the persistent
   files. This is a simple entry in the ``/etc/tgt/conf.d`` file that you
   should have set when you installed OpenStack. If issues occur, verify
   that you have a ``/etc/tgt/conf.d/cinder.conf`` file.

   If the file is not present, create it with this command

   .. code-block:: console

      # echo 'include /var/lib/cinder/volumes/ *' >> /etc/tgt/conf.d/cinder.conf

-  No sign of attach call in the ``cinder-api`` log.

   This is most likely going to be a minor adjustment to your ``nova.conf``
   file. Make sure that your ``nova.conf`` has this entry:

   .. code-block:: ini

      volume_api_class=nova.volume.cinder.API

-  Failed to create iscsi target error in the ``cinder-volume.log`` file.

   .. code-block:: console

      2013-03-12 01:35:43 1248 TRACE cinder.openstack.common.rpc.amqp \
      ISCSITargetCreateFailed: \
      Failed to create iscsi target for volume \
      volume-137641b2-af72-4a2f-b243-65fdccd38780.

   You might see this error in ``cinder-volume.log`` after trying to
   create a volume that is 1 GB. To fix this issue:

   Change contents of the ``/etc/tgt/targets.conf`` from
   ``include /etc/tgt/conf.d/*.conf`` to ``include /etc/tgt/conf.d/cinder_tgt.conf``,
   as follows:

   .. code-block:: ini

      include /etc/tgt/conf.d/cinder_tgt.conf
      include /etc/tgt/conf.d/cinder.conf
      default-driver iscsi

   Restart ``tgt`` and ``cinder-*`` services so they pick up the new
   configuration.
