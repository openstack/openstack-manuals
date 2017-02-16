===============
Message service
===============

.. toctree::
   :maxdepth: 1

   message/zaqar-conf.rst
   message/api.rst
   message/zaqar-drivers.rst
   message/zaqar-storage-drivers.rst
   message/zaqar-transport-drivers.rst
   message/zaqar-notifications.rst
   message/zaqar-authentication.rst
   message/zaqar-pooling.rst
   message/logs.rst
   tables/conf-changes/zaqar.rst

The Message service is multi-tenant, fast, reliable, and scalable. It allows
developers to share data between distributed application components performing
different tasks, without losing messages or requiring each component to be
always available.

The service features a RESTful API, which developers can use to send messages
between various components of their SaaS and mobile applications, by using a
variety of communication patterns.

The Message service provides the following key features:

* Choice between two communication transports. Both with Identity service
  support:

  * Firewall-friendly, **HTTP-based RESTful API**. Many of today's developers
    prefer a more web-friendly HTTP API. They value the simplicity and
    transparency of the protocol, its firewall-friendly nature, and its huge
    ecosystem of tools, load balancers and proxies. In addition, cloud
    operators appreciate the scalability aspects of the REST architectural
    style.
  * **Websocket-based API** for persistent connections. Websocket protocol
    provides communication over persistent connections. Unlike HTTP, where
    new connections are opened for each request/response pair, Websocket can
    transfer multiple requests/responses over single TCP connection. It saves
    much network traffic and minimizes delays.

* Multi-tenant queues based on Identity service IDs.
* Support for several common patterns including event broadcasting, task
  distribution, and point-to-point messaging.
* Component-based architecture with support for custom back ends and message
  filters.
* Efficient reference implementation with an eye toward low latency and high
  throughput (dependent on back end).
* Highly available and horizontally scalable.
* Support for subscriptions to queues. Several notification types are
  available:

  * Email notifications.
  * Webhook notifications.
  * Websocket notifications.

The Message service contains the following components:

* **Transport back end**. The Message service requires the selection of a
  transport specification responsible of the communication between the
  endpoints. In addition to the base driver implementation, the Message
  service also provides the means to add support for other transport
  mechanisms. The default option is WSGI.

* **Storage back end**. The Message service depends on a storage engine for
  message persistence. In addition to the base driver implementation, the
  Message service also provides the means to add support for other storage
  solutions. The default storage option is MongoDB.

To configure your Message service installation, you must define configuration
options in these files:

* ``zaqar.conf``. Contains most of the Message service configuration options.
  Resides in the ``/etc/zaqar`` directory. If there is a file ``zaqar.conf``
  in ``~/.zaqar`` directory, it is used instead of the one in ``/etc/zaqar``
  directory.
* ``policy.yaml``. Contains RBAC policy for all actions. Only applies to API
  v2. Resides in the ``/etc/zaqar`` directory. If there is a file
  ``policy.yaml`` in ``~/.zaqar`` directory, it is used instead of the one in
  ``/etc/zaqar`` directory. See :doc:`../policy-yaml-file`.

.. note::

   The common configurations for shared service and libraries,
   such as database connections and RPC messaging,
   are described at :doc:`common-configurations`.
