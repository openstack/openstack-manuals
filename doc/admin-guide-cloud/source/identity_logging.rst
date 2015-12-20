=======
Logging
=======

You configure logging externally to the rest of Identity. The name of
the file specifying the logging configuration is set using the
``log_config`` option in the ``[DEFAULT]`` section of the
``keystone.conf`` file. To route logging through syslog, set
``use_syslog=true`` in the ``[DEFAULT]`` section.

A sample logging configuration file is available with the project in
``etc/logging.conf.sample``. Like other OpenStack projects, Identity
uses the Python logging module, which provides extensive configuration
options that let you define the output levels and formats.
