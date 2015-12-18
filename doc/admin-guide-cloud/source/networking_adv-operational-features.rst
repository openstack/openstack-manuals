=============================
Advanced operational features
=============================

Logging settings
~~~~~~~~~~~~~~~~

Networking components use Python logging module to do logging. Logging
configuration can be provided in ``neutron.conf`` or as command-line
options. Command options override ones in ``neutron.conf``.

To configure logging for Networking components, use one of these
methods:

-  Provide logging settings in a logging configuration file.

   See `Python logging
   how-to <http://docs.python.org/howto/logging.html>`__ to learn more
   about logging.

-  Provide logging setting in ``neutron.conf``.

   .. code-block:: ini

      [DEFAULT]
      # Default log level is WARNING
      # Show debugging output in logs (sets DEBUG log level output)
      # debug = False

      # Show more verbose log output (sets INFO log level output) if debug
        is False
      # verbose = False

      # log_format = %(asctime)s %(levelname)8s [%(name)s] %(message)s
      # log_date_format = %Y-%m-%d %H:%M:%S

      # use_syslog = False
      # syslog_log_facility = LOG_USER

      # if use_syslog is False, we can set log_file and log_dir.
      # if use_syslog is False and we do not set log_file,
      # the log will be printed to stdout.
      # log_file =
      # log_dir =

Notifications
~~~~~~~~~~~~~

Notifications can be sent when Networking resources such as network,
subnet and port are created, updated or deleted.

Notification options
--------------------

To support DHCP agent, rpc\_notifier driver must be set. To set up the
notification, edit notification options in ``neutron.conf``:

.. code-block:: ini

   # Driver or drivers to handle sending notifications. (multi
   # valued)
   #notification_driver=

   # AMQP topic used for OpenStack notifications. (list value)
   # Deprecated group/name - [rpc_notifier2]/topics
     notification_topics = notifications

Setting cases
-------------

Logging and RPC
^^^^^^^^^^^^^^^

These options configure the Networking server to send notifications
through logging and RPC. The logging options are described in OpenStack
Configuration Reference . RPC notifications go to ``notifications.info``
queue bound to a topic exchange defined by ``control_exchange`` in
``neutron.conf``.

.. code-block:: ini

   # ============ Notification System Options ====================

   # Notifications can be sent when network/subnet/port are create,
     updated or deleted.
   # There are three methods of sending notifications: logging
     (via the log_file directive), rpc (via a message queue) and
   # noop (no notifications sent, the default)

   # Notification_driver can be defined multiple times
   # Do nothing driver
   # notification_driver = neutron.openstack.common.notifier.
     no_op_notifier
   # Logging driver
     notification_driver = neutron.openstack.common.notifier.
     log_notifier
   # RPC driver
     notification_driver = neutron.openstack.common.notifier.
     rpc_notifier

   # default_notification_level is used to form actual topic
     names or to set logging level
     default_notification_level = INFO

   # default_publisher_id is a part of the notification payload
   # host = myhost.com
   # default_publisher_id = $host

   # Defined in rpc_notifier for rpc way, can be comma-separated values.
   # The actual topic names will be %s.%(default_notification_level)s
     notification_topics = notifications

   # Options defined in oslo.messaging

   # The default exchange under which topics are scoped. May be
   # overridden by an exchange name specified in the
   # transport_url option. (string value)
   #control_exchange=openstack

Multiple RPC topics
^^^^^^^^^^^^^^^^^^^

These options configure the Networking server to send notifications to
multiple RPC topics. RPC notifications go to ``notifications_one.info``
and ``notifications_two.info`` queues bound to a topic exchange defined
by ``control_exchange`` in ``neutron.conf``.

.. code-block:: ini

   # ============ Notification System Options =====================

   # Notifications can be sent when network/subnet/port are create,
     updated or deleted.
   # There are three methods of sending notifications: logging (via the
   # log_file directive), rpc (via a message queue) and
   # noop (no notifications sent, the default)

   # Notification_driver can be defined multiple times
   # Do nothing driver
   # notification_driver = neutron.openstack.common.notifier.no_op_notifier
   # Logging driver
   # notification_driver = neutron.openstack.common.notifier.log_notifier
   # RPC driver
     notification_driver = neutron.openstack.common.notifier.rpc_notifier

   # default_notification_level is used to form actual topic names or to set
     logging level
     default_notification_level = INFO

   # default_publisher_id is a part of the notification payload
   # host = myhost.com
   # default_publisher_id = $host

   # Defined in rpc_notifier for rpc way, can be comma-separated values.
   # The actual topic names will be %s.%(default_notification_level)s
     notification_topics = notifications_one,notifications_two
