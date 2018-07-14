==========================
Control plane architecture
==========================

.. From Ops Guide chapter: Designing for Cloud Controllers and Cloud
   Management

OpenStack is designed to be massively horizontally scalable, which
allows all services to be distributed widely. However, to simplify this
guide, we have decided to discuss services of a more central nature,
using the concept of a *cloud controller*. A cloud controller is  a
conceptual simplification. In the real world, you design an architecture
for your cloud controller that enables high availability so that if any
node fails, another can take over the required tasks. In reality, cloud
controller tasks are spread out across more than a single node.

The cloud controller provides the central management system for
OpenStack deployments. Typically, the cloud controller manages
authentication and sends messaging to all the systems through a message
queue.

For many deployments, the cloud controller is a single node. However, to
have high availability, you have to take a few considerations into
account, which we'll cover in this chapter.

The cloud controller manages the following services for the cloud:

Databases
    Tracks current information about users and instances, for example,
    in a database, typically one database instance managed per service

Message queue services
    All :term:`Advanced Message Queuing Protocol (AMQP)` messages for
    services are received and sent according to the queue broker

Conductor services
    Proxy requests to a database

Authentication and authorization for identity management
    Indicates which users can do what actions on certain cloud
    resources; quota management is spread out among services,
    howeverauthentication

Image-management services
    Stores and serves images with metadata on each, for launching in the
    cloud

Scheduling services
    Indicates which resources to use first; for example, spreading out
    where instances are launched based on an algorithm

User dashboard
    Provides a web-based front end for users to consume OpenStack cloud
    services

API endpoints
    Offers each service's REST API access, where the API endpoint
    catalog is managed by the Identity service

For our example, the cloud controller has a collection of ``nova-*``
components that represent the global state of the cloud; talks to
services such as authentication; maintains information about the cloud
in a database; communicates to all compute nodes and storage
:term:`workers <worker>` through a queue; and provides API access.
Each service running on a designated cloud controller may be broken out
into separate nodes for scalability or availability.

As another example, you could use pairs of servers for a collective
cloud controller—one active, one standby—for redundant nodes providing a
given set of related services, such as:

-  Front end web for API requests, the scheduler for choosing which
   compute node to boot an instance on, Identity services, and the
   dashboard

-  Database and message queue server (such as MySQL, RabbitMQ)

-  Image service for the image management

Now that you see the myriad designs for controlling your cloud, read
more about the further considerations to help with your design
decisions.

Hardware Considerations
~~~~~~~~~~~~~~~~~~~~~~~

A cloud controller's hardware can be the same as a compute node, though
you may want to further specify based on the size and type of cloud that
you run.

It's also possible to use virtual machines for all or some of the
services that the cloud controller manages, such as the message queuing.
In this guide, we assume that all services are running directly on the
cloud controller.

:ref:`table_controller_hardware` contains common considerations to
review when sizing hardware for the cloud controller design.

.. _table_controller_hardware:

.. list-table:: Table. Cloud controller hardware sizing considerations
   :widths: 25 75
   :header-rows: 1

   * - Consideration
     - Ramification
   * - How many instances will run at once?
     - Size your database server accordingly, and scale out beyond one cloud
       controller if many instances will report status at the same time and
       scheduling where a new instance starts up needs computing power.
   * - How many compute nodes will run at once?
     - Ensure that your messaging queue handles requests successfully and size
       accordingly.
   * - How many users will access the API?
     - If many users will make multiple requests, make sure that the CPU load
       for the cloud controller can handle it.
   * - How many users will access the dashboard versus the REST API directly?
     - The dashboard makes many requests, even more than the API access, so
       add even more CPU if your dashboard is the main interface for your users.
   * - How many ``nova-api`` services do you run at once for your cloud?
     - You need to size the controller with a core per service.
   * - How long does a single instance run?
     - Starting instances and deleting instances is demanding on the compute
       node but also demanding on the controller node because of all the API
       queries and scheduling needs.
   * - Does your authentication system also verify externally?
     - External systems such as :term:`LDAP <Lightweight Directory Access
       Protocol (LDAP)>` or :term:`Active Directory` require network
       connectivity between the cloud controller and an external authentication
       system. Also ensure that the cloud controller has the CPU power to keep
       up with requests.


Separation of Services
~~~~~~~~~~~~~~~~~~~~~~

While our example contains all central services in a single location, it
is possible and indeed often a good idea to separate services onto
different physical servers. :ref:`table_deployment_scenarios` is a list
of deployment scenarios we've seen and their justifications.

.. _table_deployment_scenarios:

.. list-table:: Table. Deployment scenarios
   :widths: 25 75
   :header-rows: 1

   * - Scenario
     - Justification
   * - Run ``glance-*`` servers on the ``swift-proxy`` server.
     - This deployment felt that the spare I/O on the Object Storage proxy
       server was sufficient and that the Image Delivery portion of glance
       benefited from being on physical hardware and having good connectivity
       to the Object Storage back end it was using.
   * - Run a central dedicated database server.
     - This deployment used a central dedicated server to provide the databases
       for all services. This approach simplified operations by isolating
       database server updates and allowed for the simple creation of slave
       database servers for failover.
   * - Run one VM per service.
     - This deployment ran central services on a set of servers running KVM.
       A dedicated VM was created for each service (``nova-scheduler``,
       rabbitmq, database, etc). This assisted the deployment with scaling
       because administrators could tune the resources given to each virtual
       machine based on the load it received (something that was not well
       understood during installation).
   * - Use an external load balancer.
     - This deployment had an expensive hardware load balancer in its
       organization. It ran multiple ``nova-api`` and ``swift-proxy``
       servers on different physical servers and used the load balancer
       to switch between them.

One choice that always comes up is whether to virtualize. Some services,
such as ``nova-compute``, ``swift-proxy`` and ``swift-object`` servers,
should not be virtualized. However, control servers can often be happily
virtualized—the performance penalty can usually be offset by simply
running more of the service.

Database
~~~~~~~~

OpenStack Compute uses an SQL database to store and retrieve stateful
information. MySQL is the popular database choice in the OpenStack
community.

Loss of the database leads to errors. As a result, we recommend that you
cluster your database to make it failure tolerant. Configuring and
maintaining a database cluster is done outside OpenStack and is
determined by the database software you choose to use in your cloud
environment. MySQL/Galera is a popular option for MySQL-based databases.

Message Queue
~~~~~~~~~~~~~

Most OpenStack services communicate with each other using the *message
queue*. For example, Compute communicates to block storage services and
networking services through the message queue. Also, you can optionally
enable notifications for any service. RabbitMQ, Qpid, and Zeromq are all
popular choices for a message-queue service. In general, if the message
queue fails or becomes inaccessible, the cluster grinds to a halt and
ends up in a read-only state, with information stuck at the point where
the last message was sent. Accordingly, we recommend that you cluster
the message queue. Be aware that clustered message queues can be a pain
point for many OpenStack deployments. While RabbitMQ has native
clustering support, there have been reports of issues when running it at
a large scale. While other queuing solutions are available, such as Zeromq
and Qpid, Zeromq does not offer stateful queues. Qpid is the messaging
system of choice for Red Hat and its derivatives. Qpid does not have
native clustering capabilities and requires a supplemental service, such
as Pacemaker or Corsync. For your message queue, you need to determine
what level of data loss you are comfortable with and whether to use an
OpenStack project's ability to retry multiple MQ hosts in the event of a
failure, such as using Compute's ability to do so.

Conductor Services
~~~~~~~~~~~~~~~~~~

In the previous version of OpenStack, all ``nova-compute`` services
required direct access to the database hosted on the cloud controller.
This was problematic for two reasons: security and performance. With
regard to security, if a compute node is compromised, the attacker
inherently has access to the database. With regard to performance,
``nova-compute`` calls to the database are single-threaded and blocking.
This creates a performance bottleneck because database requests are
fulfilled serially rather than in parallel.

The conductor service resolves both of these issues by acting as a proxy
for the ``nova-compute`` service. Now, instead of ``nova-compute``
directly accessing the database, it contacts the ``nova-conductor``
service, and ``nova-conductor`` accesses the database on
``nova-compute``'s behalf. Since ``nova-compute`` no longer has direct
access to the database, the security issue is resolved. Additionally,
``nova-conductor`` is a nonblocking service, so requests from all
compute nodes are fulfilled in parallel.

.. note::

   If you are using ``nova-network`` and multi-host networking in your
   cloud environment, ``nova-compute`` still requires direct access to
   the database.

The ``nova-conductor`` service is horizontally scalable. To make
``nova-conductor`` highly available and fault tolerant, just launch more
instances of the ``nova-conductor`` process, either on the same server
or across multiple servers.

Application Programming Interface (API)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

All public access, whether direct, through a command-line client, or
through the web-based dashboard, uses the API service. Find the API
reference at `Development resources for OpenStack clouds
<https://developer.openstack.org/>`_.

You must choose whether you want to support the Amazon EC2 compatibility
APIs, or just the OpenStack APIs. One issue you might encounter when
running both APIs is an inconsistent experience when referring to images
and instances.

For example, the EC2 API refers to instances using IDs that contain
hexadecimal, whereas the OpenStack API uses names and digits. Similarly,
the EC2 API tends to rely on DNS aliases for contacting virtual
machines, as opposed to OpenStack, which typically lists IP
addresses.

If OpenStack is not set up in the right way, it is simple to have
scenarios in which users are unable to contact their instances due to
having only an incorrect DNS alias. Despite this, EC2 compatibility can
assist users migrating to your cloud.

As with databases and message queues, having more than one :term:`API server`
is a good thing. Traditional HTTP load-balancing techniques can be used to
achieve a highly available ``nova-api`` service.

Extensions
~~~~~~~~~~

The `API
Specifications <https://developer.openstack.org/api-guide/quick-start/index.html>`_ define
the core actions, capabilities, and mediatypes of the OpenStack API. A
client can always depend on the availability of this core API, and
implementers are always required to support it in its entirety.
Requiring strict adherence to the core API allows clients to rely upon a
minimal level of functionality when interacting with multiple
implementations of the same API.

The OpenStack Compute API is extensible. An extension adds capabilities
to an API beyond those defined in the core. The introduction of new
features, MIME types, actions, states, headers, parameters, and
resources can all be accomplished by means of extensions to the core
API. This allows the introduction of new features in the API without
requiring a version change and allows the introduction of
vendor-specific niche functionality.

Scheduling
~~~~~~~~~~

The scheduling services are responsible for determining the compute or
storage node where a virtual machine or block storage volume should be
created. The scheduling services receive creation requests for these
resources from the message queue and then begin the process of
determining the appropriate node where the resource should reside. This
process is done by applying a series of user-configurable filters
against the available collection of nodes.

There are currently two schedulers: ``nova-scheduler`` for virtual
machines and ``cinder-scheduler`` for block storage volumes. Both
schedulers are able to scale horizontally, so for high-availability
purposes, or for very large or high-schedule-frequency installations,
you should consider running multiple instances of each scheduler. The
schedulers all listen to the shared message queue, so no special load
balancing is required.

Images
~~~~~~

The OpenStack Image service consists of two parts: ``glance-api`` and
``glance-registry``. The former is responsible for the delivery of
images; the compute node uses it to download images from the back end.
The latter maintains the metadata information associated with virtual
machine images and requires a database.

The ``glance-api`` part is an abstraction layer that allows a choice of
back end. Currently, it supports:

OpenStack Object Storage
    Allows you to store images as objects.

File system
    Uses any traditional file system to store the images as files.

S3
    Allows you to fetch images from Amazon S3.

HTTP
    Allows you to fetch images from a web server. You cannot write
    images by using this mode.

If you have an OpenStack Object Storage service, we recommend using this
as a scalable place to store your images. You can also use a file system
with sufficient performance or Amazon S3—unless you do not need the
ability to upload new images through OpenStack.

Dashboard
~~~~~~~~~

The OpenStack dashboard (horizon) provides a web-based user interface to
the various OpenStack components. The dashboard includes an end-user
area for users to manage their virtual infrastructure and an admin area
for cloud operators to manage the OpenStack environment as a
whole.

The dashboard is implemented as a Python web application that normally
runs in :term:`Apache` ``httpd``. Therefore, you may treat it the same as any
other web application, provided it can reach the API servers (including
their admin endpoints) over the network.

Authentication and Authorization
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The concepts supporting OpenStack's authentication and authorization are
derived from well-understood and widely used systems of a similar
nature. Users have credentials they can use to authenticate, and they
can be a member of one or more groups (known as projects or tenants,
interchangeably).

For example, a cloud administrator might be able to list all instances
in the cloud, whereas a user can see only those in his current group.
Resources quotas, such as the number of cores that can be used, disk
space, and so on, are associated with a project.

OpenStack Identity provides authentication decisions and user attribute
information, which is then used by the other OpenStack services to
perform authorization. The policy is set in the ``policy.json`` file.
For information on how to configure these, see `Managing Projects and Users
<https://docs.openstack.org/operations-guide/ops-projects-users.html>`_ in the
OpenStack Operations Guide.

OpenStack Identity supports different plug-ins for authentication
decisions and identity storage. Examples of these plug-ins include:

-  In-memory key-value Store (a simplified internal storage structure)

-  SQL database (such as MySQL or PostgreSQL)

-  Memcached (a distributed memory object caching system)

-  LDAP (such as OpenLDAP or Microsoft's Active Directory)

Many deployments use the SQL database; however, LDAP is also a popular
choice for those with existing authentication infrastructure that needs
to be integrated.

Network Considerations
~~~~~~~~~~~~~~~~~~~~~~

Because the cloud controller handles so many different services, it must
be able to handle the amount of traffic that hits it. For example, if
you choose to host the OpenStack Image service on the cloud controller,
the cloud controller should be able to support the transferring of the
images at an acceptable speed.

As another example, if you choose to use single-host networking where
the cloud controller is the network gateway for all instances, then the
cloud controller must support the total amount of traffic that travels
between your cloud and the public Internet.

We recommend that you use a fast NIC, such as 10 GB. You can also choose
to use two 10 GB NICs and bond them together. While you might not be
able to get a full bonded 20 GB speed, different transmission streams
use different NICs. For example, if the cloud controller transfers two
images, each image uses a different NIC and gets a full 10 GB of
bandwidth.
