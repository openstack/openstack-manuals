========================
RabbitMQ troubleshooting
========================

This section provides tips on resolving common RabbitMQ issues.

RabbitMQ service hangs
~~~~~~~~~~~~~~~~~~~~~~

It is quite common for the RabbitMQ service to hang when it is
restarted or stopped. Therefore, it is highly recommended that
you manually restart RabbitMQ on each controller node.

.. note::

   The RabbitMQ service name may vary depending on your operating
   system or vendor who supplies your RabbitMQ service.

#. Restart the RabbitMQ service on the first controller node. The
   :command:`service rabbitmq-server restart` command may not work
   in certain situations, so it is best to use:

   .. code-block:: console

      # service rabbitmq-server stop
      # service rabbitmq-server start


#. If the service refuses to stop, then run the :command:`pkill` command
   to stop the service, then restart the service:

   .. code-block:: console

      # pkill -KILL -u rabbitmq
      # service rabbitmq-server start

#. Verify RabbitMQ processes are running:

   .. code-block:: console

      # ps -ef | grep rabbitmq
      # rabbitmqctl list_queues
      # rabbitmqctl list_queues 2>&1 | grep -i error

#. If there are errors, run the :command:`cluster_status` command to make sure
   there are no partitions:

   .. code-block:: console

      # rabbitmqctl cluster_status

   For more information, see `RabbitMQ documentation
   <https://www.rabbitmq.com/partitions.html>`_.

#. Go back to the first step and try restarting the RabbitMQ service again. If
   you still have errors, remove the contents in the
   ``/var/lib/rabbitmq/mnesia/`` directory between stopping and starting the
   RabbitMQ service.

#. If there are no errors, restart the RabbitMQ service on the next controller
   node.

Since the Liberty release, OpenStack services will automatically recover from
a RabbitMQ outage. You should only consider restarting OpenStack services
after checking if RabbitMQ heartbeat functionality is enabled, and if
OpenStack services are not picking up messages from RabbitMQ queues.

RabbitMQ alerts
~~~~~~~~~~~~~~~

If you receive alerts for RabbitMQ, take the following steps to troubleshoot
and resolve the issue:

#. Determine which servers the RabbitMQ alarms are coming from.
#. Attempt to boot a nova instance in the affected environment.
#. If you cannot launch an instance, continue to troubleshoot the issue.
#. Log in to each of the controller nodes for the affected environment, and
   check the ``/var/log/rabbitmq`` log files for any reported issues.
#. Look for connection issues identified in the log files.
#. For each controller node in your environment, view the ``/etc/init.d``
   directory to check it contains nova*, cinder*, neutron*, or
   glance*. Also check RabbitMQ message queues that are growing without being
   consumed which will indicate which OpenStack service is affected. Restart
   the affected OpenStack service.
#. For each compute node your environment, view the ``/etc/init.d`` directory
   and check if it contains nova*, cinder*, neutron*, or glance*,  Also check
   RabbitMQ message queues that are growing without being consumed which will
   indicate which OpenStack services are affected. Restart the affected
   OpenStack services.
#. Open OpenStack Dashboard and launch an instance. If the instance launches,
   the issue is resolved.
#. If you cannot launch an instance, check the ``/var/log/rabbitmq`` log
   files for reported connection issues.
#. Restart the RabbitMQ service on all of the controller nodes:

   .. code-block:: console

      # service rabbitmq-server stop
      # service rabbitmq-server start

   .. note::

      This step applies if you have already restarted only the OpenStack components, and
      cannot connect to the RabbitMQ service.

#. Repeat steps 7-8.

Excessive database management memory consumption
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Since the Liberty release, OpenStack with RabbitMQ 3.4.x or 3.6.x has an issue
with the management database consuming the memory allocated to RabbitMQ.
This is caused by statistics collection and processing. When a single node
with RabbitMQ reaches its memory threshold, all exchange and queue processing
is halted until the memory alarm recovers.

To address this issue:

#. Check memory consumption:

   .. code-block:: console

      # rabbitmqctl status

#. Edit the ``/etc/rabbitmq/rabbitmq.config`` configuration file, and change
   the ``collect_statistics_interval`` parameter between 30000-60000
   milliseconds. Alternatively you can turn off statistics collection by
   setting ``collect_statistics`` parameter to "none".

File descriptor limits when scaling a cloud environment
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A cloud environment that is scaled to a certain size will require the file
descriptor limits to be adjusted.

Run the :command:`rabbitmqctl status` to view the current file descriptor
limits:

.. code-block:: console

   "{file_descriptors,
        [{total_limit,3996},
         {total_used,135},
         {sockets_limit,3594},
         {sockets_used,133}]},"

Adjust the appropriate limits in the
``/etc/security/limits.conf`` configuration file.
