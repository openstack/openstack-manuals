=======================================
Messaging service for high availability
=======================================

An AMQP (Advanced Message Queuing Protocol) compliant message bus is
required for most OpenStack components in order to coordinate the
execution of jobs entered into the system.

The most popular AMQP implementation used in OpenStack installations
is RabbitMQ.

RabbitMQ nodes fail over on the application and the infrastructure layers.

The application layer is controlled by the ``oslo.messaging``
configuration options for multiple AMQP hosts. If the AMQP node fails,
the application reconnects to the next one configured within the
specified reconnect interval. The specified reconnect interval
constitutes its SLA.

On the infrastructure layer, the SLA is the time for which RabbitMQ
cluster reassembles. Several cases are possible. The Mnesia keeper
node is the master of the corresponding Pacemaker resource for
RabbitMQ. When it fails, the result is a full AMQP cluster downtime
interval. Normally, its SLA is no more than several minutes. Failure
of another node that is a slave of the corresponding Pacemaker
resource for RabbitMQ results in no AMQP cluster downtime at all.

Making the RabbitMQ service highly available involves the following steps:

- :ref:`Install RabbitMQ<rabbitmq-install>`

- :ref:`Configure RabbitMQ for HA queues<rabbitmq-configure>`

- :ref:`Configure OpenStack services to use RabbitMQ HA queues
  <rabbitmq-services>`

.. note::

   Access to RabbitMQ is not normally handled by HAProxy. Instead,
   consumers must be supplied with the full list of hosts running
   RabbitMQ with ``rabbit_hosts`` and turn on the ``rabbit_ha_queues``
   option. For more information, read the `core issue
   <http://people.redhat.com/jeckersb/private/vip-failover-tcp-persist.html>`_.
   For more detail, read the `history and solution
   <http://john.eckersberg.com/improving-ha-failures-with-tcp-timeouts.html>`_.

.. _rabbitmq-install:

Install RabbitMQ
~~~~~~~~~~~~~~~~

The commands for installing RabbitMQ are specific to the Linux distribution
you are using.

For Ubuntu or Debian:

.. code-block: console

   # apt-get install rabbitmq-server

For RHEL, Fedora, or CentOS:

.. code-block: console

   # yum install rabbitmq-server

For openSUSE:

.. code-block: console

   # zypper install rabbitmq-server

For SLES 12:

.. code-block: console

   # zypper addrepo -f obs://Cloud:OpenStack:Kilo/SLE_12 Kilo
   [Verify the fingerprint of the imported GPG key. See below.]
   # zypper install rabbitmq-server

.. note::

   For SLES 12, the packages are signed by GPG key 893A90DAD85F9316.
   You should verify the fingerprint of the imported GPG key before using it.

   .. code-block:: none

      Key ID: 893A90DAD85F9316
      Key Name: Cloud:OpenStack OBS Project <Cloud:OpenStack@build.opensuse.org>
      Key Fingerprint: 35B34E18ABC1076D66D5A86B893A90DAD85F9316
      Key Created: Tue Oct  8 13:34:21 2013
      Key Expires: Thu Dec 17 13:34:21 2015

For more information, see the official installation manual for the
distribution:

- `Debian and Ubuntu <https://www.rabbitmq.com/install-debian.html>`_
- `RPM based <https://www.rabbitmq.com/install-rpm.html>`_
  (RHEL, Fedora, CentOS, openSUSE)

.. _rabbitmq-configure:

Configure RabbitMQ for HA queues
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. [TODO: This section should begin with a brief mention
.. about what HA queues are and why they are valuable, etc]

.. [TODO: replace "currently" with specific release names]

.. [TODO: Does this list need to be updated? Perhaps we need a table
.. that shows each component and the earliest release that allows it
.. to work with HA queues.]

The following components/services can work with HA queues:

- OpenStack Compute
- OpenStack Block Storage
- OpenStack Networking
- Telemetry

Consider that, while exchanges and bindings survive the loss of individual
nodes, queues and their messages do not because a queue and its contents
are located on one node. If we lose this node, we also lose the queue.

Mirrored queues in RabbitMQ improve the availability of service since
it is resilient to failures.

Production servers should run (at least) three RabbitMQ servers for testing
and demonstration purposes, however it is possible to run only two servers.
In this section, we configure two nodes, called ``rabbit1`` and ``rabbit2``.
To build a broker, ensure that all nodes have the same Erlang cookie file.

.. [TODO: Should the example instead use a minimum of three nodes?]

#. Stop RabbitMQ and copy the cookie from the first node to each of the
   other node(s):

   .. code-block:: console

      # scp /var/lib/rabbitmq/.erlang.cookie root@NODE:/var/lib/rabbitmq/.erlang.cookie

#. On each target node, verify the correct owner,
   group, and permissions of the file :file:`erlang.cookie`:

   .. code-block:: console

      # chown rabbitmq:rabbitmq /var/lib/rabbitmq/.erlang.cookie
      # chmod 400 /var/lib/rabbitmq/.erlang.cookie

#. Start the message queue service on all nodes and configure it to start
   when the system boots. On Ubuntu, it is configured by default.

   On CentOS, RHEL, openSUSE, and SLES:

   .. code-block:: console

      # systemctl enable rabbitmq-server.service
      # systemctl start rabbitmq-server.service

#. Verify that the nodes are running:

   .. code-block:: console

      # rabbitmqctl cluster_status
      Cluster status of node rabbit@NODE...
      [{nodes,[{disc,[rabbit@NODE]}]},
       {running_nodes,[rabbit@NODE]},
       {partitions,[]}]
      ...done.

#. Run the following commands on each node except the first one:

   .. code-block:: console

      # rabbitmqctl stop_app
      Stopping node rabbit@NODE...
      ...done.
      # rabbitmqctl join_cluster --ram rabbit@rabbit1
      # rabbitmqctl start_app
      Starting node rabbit@NODE ...
      ...done.

.. note::

   The default node type is a disc node. In this guide, nodes
   join the cluster as RAM nodes.

#. Verify the cluster status:

   .. code-block:: console

      # rabbitmqctl cluster_status
      Cluster status of node rabbit@NODE...
      [{nodes,[{disc,[rabbit@rabbit1]},{ram,[rabbit@NODE]}]}, \
          {running_nodes,[rabbit@NODE,rabbit@rabbit1]}]

   If the cluster is working, you can create usernames and passwords
   for the queues.

#. To ensure that all queues except those with auto-generated names
   are mirrored across all running nodes,
   set the ``ha-mode`` policy key to all
   by running the following command on one of the nodes:

   .. code-block:: console

      # rabbitmqctl set_policy ha-all '^(?!amq\.).*' '{"ha-mode": "all"}'

More information is available in the RabbitMQ documentation:

- `Highly Available Queues <https://www.rabbitmq.com/ha.html>`_
- `Clustering Guide <https://www.rabbitmq.com/clustering.html>`_

.. note::

   As another option to make RabbitMQ highly available, RabbitMQ contains the
   OCF scripts for the Pacemaker cluster resource agents since version 3.5.7.
   It provides the active/active RabbitMQ cluster with mirrored queues.
   For more information, see `Auto-configuration of a cluster with
   a Pacemaker <https://www.rabbitmq.com/pacemaker.html>`_.

.. _rabbitmq-services:

Configure OpenStack services to use Rabbit HA queues
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Configure the OpenStack components to use at least two RabbitMQ nodes.

Use these steps to configurate all services using RabbitMQ:

#. RabbitMQ HA cluster Transport URL using ``[user:pass@]host:port`` format:

   .. code-block:: ini

      transport_url = rabbit://RABBIT_USER:RABBIT_PASS@rabbit1:5672,
      RABBIT_USER:RABBIT_PASS@rabbit2:5672,RABBIT_USER:RABBIT_PASS@rabbit3:5672

   Replace ``RABBIT_USER`` with RabbitMQ username and ``RABBIT_PASS`` with
   password for respective RabbitMQ host. For more information, see
   `oslo messaging transport
   <https://docs.openstack.org/developer/oslo.messaging/transport.html>`_.

#. Retry connecting with RabbitMQ:

   .. code-block:: console

      rabbit_retry_interval=1

#. How long to back-off for between retries when connecting to RabbitMQ:

   .. code-block:: console

      rabbit_retry_backoff=2

#. Maximum retries with trying to connect to RabbitMQ (infinite by default):

   .. code-block:: console

      rabbit_max_retries=0

#. Use durable queues in RabbitMQ:

   .. code-block:: console

      rabbit_durable_queues=true

#. Use HA queues in RabbitMQ (``x-ha-policy: all``):

   .. code-block:: console

      rabbit_ha_queues=true

.. note::

   If you change the configuration from an old set-up
   that did not use HA queues, restart the service:

   .. code-block:: console

      # rabbitmqctl stop_app
      # rabbitmqctl reset
      # rabbitmqctl start_app
