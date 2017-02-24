==============
Data retrieval
==============

The Telemetry service offers several mechanisms from which the persisted
data can be accessed. As described in :ref:`telemetry-system-architecture` and
in :ref:`telemetry-data-collection`, the collected information can be stored in
one or more database back ends, which are hidden by the Telemetry RESTful API.

.. note::

   It is highly recommended not to access the database directly and
   read or modify any data in it. The API layer hides all the changes
   in the actual database schema and provides a standard interface to
   expose the samples, alarms and so forth.

Telemetry v2 API
~~~~~~~~~~~~~~~~

The Telemetry service provides a RESTful API, from which the collected
samples and all the related information can be retrieved, like the list
of meters, alarm definitions and so forth.

The Telemetry API URL can be retrieved from the service catalog provided
by OpenStack Identity, which is populated during the installation
process. The API access needs a valid token and proper permission to
retrieve data, as described in :ref:`telemetry-users-roles-projects`.

Further information about the available API endpoints can be found in
the `Telemetry API Reference
<https://developer.openstack.org/api-ref-telemetry-v2.html>`__.

Query
-----

The API provides some additional functionalities, like querying the
collected data set. For the samples and alarms API endpoints, both
simple and complex query styles are available, whereas for the other
endpoints only simple queries are supported.

After validating the query parameters, the processing is done on the
database side in the case of most database back ends in order to achieve
better performance.

**Simple query**

Many of the API endpoints accept a query filter argument, which should
be a list of data structures that consist of the following items:

-  ``field``

-  ``op``

-  ``value``

-  ``type``

Regardless of the endpoint on which the filter is applied on, it will
always target the fields of the `Sample type
<https://docs.openstack.org/developer/ceilometer/webapi/v2.html#Sample>`__.

Several fields of the API endpoints accept shorter names than the ones
defined in the reference. The API will do the transformation internally
and return the output with the fields that are listed in the `API reference
<https://docs.openstack.org/developer/ceilometer/webapi/v2.html>`__.
The fields are the following:

-  ``project_id``: project

-  ``resource_id``: resource

-  ``user_id``: user

When a filter argument contains multiple constraints of the above form,
a logical ``AND`` relation between them is implied.

.. _complex-query:

**Complex query**

The filter expressions of the complex query feature operate on the
fields of ``Sample``, ``Alarm`` and ``AlarmChange`` types. The following
comparison operators are supported:

-  ``=``

-  ``!=``

-  ``<``

-  ``<=``

-  ``>``

-  ``>=``

The following logical operators can be used:

-  ``and``

-  ``or``

-  ``not``

.. note::

   The ``not`` operator has different behavior in MongoDB and in the
   SQLAlchemy-based database engines. If the ``not`` operator is
   applied on a non existent metadata field then the result depends on
   the database engine. In case of MongoDB, it will return every sample
   as the ``not`` operator is evaluated true for every sample where the
   given field does not exist. On the other hand the SQL-based database
   engine will return an empty result because of the underlying
   ``join`` operation.

Complex query supports specifying a list of ``orderby`` expressions.
This means that the result of the query can be ordered based on the
field names provided in this list. When multiple keys are defined for
the ordering, these will be applied sequentially in the order of the
specification. The second expression will be applied on the groups for
which the values of the first expression are the same. The ordering can
be ascending or descending.

The number of returned items can be bounded using the ``limit`` option.

The ``filter``, ``orderby`` and ``limit`` fields are optional.

.. note::

   As opposed to the simple query, complex query is available via a
   separate API endpoint. For more information see the `Telemetry v2 Web API
   Reference <https://docs.openstack.org/developer/ceilometer/webapi/v2.html#v2-web-api>`__.

Statistics
----------

The sample data can be used in various ways for several purposes, like
billing or profiling. In external systems the data is often used in the
form of aggregated statistics. The Telemetry API provides several
built-in functions to make some basic calculations available without any
additional coding.

Telemetry supports the following statistics and aggregation functions:

``avg``
    Average of the sample volumes over each period.

``cardinality``
    Count of distinct values in each period identified by a key
    specified as the parameter of this aggregate function. The supported
    parameter values are:

    -  ``project_id``

    -  ``resource_id``

    -  ``user_id``

.. note::

   The ``aggregate.param`` option is required.

``count``
    Number of samples in each period.

``max``
    Maximum of the sample volumes in each period.

``min``
    Minimum of the sample volumes in each period.

``stddev``
    Standard deviation of the sample volumes in each period.

``sum``
    Sum of the sample volumes over each period.

The simple query and the statistics functionality can be used together
in a single API request.

Telemetry command-line client and SDK
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Telemetry service provides a command-line client, with which the
collected data is available just as the alarm definition and retrieval
options. The client uses the Telemetry RESTful API in order to execute
the requested operations.

To be able to use the :command:`ceilometer` command, the
python-ceilometerclient package needs to be installed and configured
properly. For details about the installation process, see the `Telemetry
chapter <https://docs.openstack.org/project-install-guide/telemetry/ocata/>`__
in the Installation Tutorials and Guides.

.. note::

   The Telemetry service captures the user-visible resource usage data.
   Therefore the database will not contain any data without the
   existence of these resources, like VM images in the OpenStack Image
   service.

Similarly to other OpenStack command-line clients, the ``ceilometer``
client uses OpenStack Identity for authentication. The proper
credentials and ``--auth_url`` parameter have to be defined via command
line parameters or environment variables.

This section provides some examples without the aim of completeness.
These commands can be used for instance for validating an installation
of Telemetry.

To retrieve the list of collected meters, the following command should
be used:

.. code-block:: console

    $ ceilometer meter-list
    +------------------------+------------+------+------------------------------------------+----------------------------------+----------------------------------+
    | Name                   | Type       | Unit | Resource ID                              | User ID                          | Project ID                       |
    +------------------------+------------+------+------------------------------------------+----------------------------------+----------------------------------+
    | cpu                    | cumulative | ns   | bb52e52b-1e42-4751-b3ac-45c52d83ba07     | b6e62aad26174382bc3781c12fe413c8 | cbfa8e3dfab64a27a87c8e24ecd5c60f |
    | cpu                    | cumulative | ns   | c8d2e153-a48f-4cec-9e93-86e7ac6d4b0b     | b6e62aad26174382bc3781c12fe413c8 | cbfa8e3dfab64a27a87c8e24ecd5c60f |
    | cpu_util               | gauge      | %    | bb52e52b-1e42-4751-b3ac-45c52d83ba07     | b6e62aad26174382bc3781c12fe413c8 | cbfa8e3dfab64a27a87c8e24ecd5c60f |
    | cpu_util               | gauge      | %    | c8d2e153-a48f-4cec-9e93-86e7ac6d4b0b     | b6e62aad26174382bc3781c12fe413c8 | cbfa8e3dfab64a27a87c8e24ecd5c60f |
    | disk.device.read.bytes | cumulative | B    | bb52e52b-1e42-4751-b3ac-45c52d83ba07-hdd | b6e62aad26174382bc3781c12fe413c8 | cbfa8e3dfab64a27a87c8e24ecd5c60f |
    | disk.device.read.bytes | cumulative | B    | bb52e52b-1e42-4751-b3ac-45c52d83ba07-vda | b6e62aad26174382bc3781c12fe413c8 | cbfa8e3dfab64a27a87c8e24ecd5c60f |
    | disk.device.read.bytes | cumulative | B    | c8d2e153-a48f-4cec-9e93-86e7ac6d4b0b-hdd | b6e62aad26174382bc3781c12fe413c8 | cbfa8e3dfab64a27a87c8e24ecd5c60f |
    | disk.device.read.bytes | cumulative | B    | c8d2e153-a48f-4cec-9e93-86e7ac6d4b0b-vda | b6e62aad26174382bc3781c12fe413c8 | cbfa8e3dfab64a27a87c8e24ecd5c60f |
    | ...                                                                                                                                                         |
    +------------------------+------------+------+------------------------------------------+----------------------------------+----------------------------------+

The :command:`ceilometer` command was run with ``admin`` rights, which means
that all the data is accessible in the database. For more information
about access right see :ref:`telemetry-users-roles-projects`. As it can be seen
in the above example, there are two VM instances existing in the system, as
there are VM instance related meters on the top of the result list. The
existence of these meters does not indicate that these instances are running at
the time of the request. The result contains the currently collected meters per
resource, in an ascending order based on the name of the meter.

Samples are collected for each meter that is present in the list of
meters, except in case of instances that are not running or deleted from
the OpenStack Compute database. If an instance no longer exists and
there is a ``time_to_live`` value set in the ``ceilometer.conf``
configuration file, then a group of samples are deleted in each
expiration cycle. When the last sample is deleted for a meter, the
database can be cleaned up by running ceilometer-expirer and the meter
will not be present in the list above anymore. For more information
about the expiration procedure see :ref:`telemetry-storing-samples`.

The Telemetry API supports simple query on the meter endpoint. The query
functionality has the following syntax:

.. code-block:: console

   --query <field1><operator1><value1>;...;<field_n><operator_n><value_n>

The following command needs to be invoked to request the meters of one
VM instance:

.. code-block:: console

    $ ceilometer meter-list --query resource=bb52e52b-1e42-4751-b3ac-45c52d83ba07
    +-------------------------+------------+-----------+--------------------------------------+----------------------------------+----------------------------------+
    | Name                    | Type       | Unit      | Resource ID                          | User ID                          | Project ID                       |
    +-------------------------+------------+-----------+--------------------------------------+----------------------------------+----------------------------------+
    | cpu                     | cumulative | ns        | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | b6e62aad26174382bc3781c12fe413c8 | cbfa8e3dfab64a27a87c8e24ecd5c60f |
    | cpu_util                | gauge      | %         | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | b6e62aad26174382bc3781c12fe413c8 | cbfa8e3dfab64a27a87c8e24ecd5c60f |
    | cpu_l3_cache            | gauge      | B         | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | b6e62aad26174382bc3781c12fe413c8 | cbfa8e3dfab64a27a87c8e24ecd5c60f |
    | disk.ephemeral.size     | gauge      | GB        | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | b6e62aad26174382bc3781c12fe413c8 | cbfa8e3dfab64a27a87c8e24ecd5c60f |
    | disk.read.bytes         | cumulative | B         | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | b6e62aad26174382bc3781c12fe413c8 | cbfa8e3dfab64a27a87c8e24ecd5c60f |
    | disk.read.bytes.rate    | gauge      | B/s       | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | b6e62aad26174382bc3781c12fe413c8 | cbfa8e3dfab64a27a87c8e24ecd5c60f |
    | disk.read.requests      | cumulative | request   | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | b6e62aad26174382bc3781c12fe413c8 | cbfa8e3dfab64a27a87c8e24ecd5c60f |
    | disk.read.requests.rate | gauge      | request/s | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | b6e62aad26174382bc3781c12fe413c8 | cbfa8e3dfab64a27a87c8e24ecd5c60f |
    | disk.root.size          | gauge      | GB        | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | b6e62aad26174382bc3781c12fe413c8 | cbfa8e3dfab64a27a87c8e24ecd5c60f |
    | disk.write.bytes        | cumulative | B         | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | b6e62aad26174382bc3781c12fe413c8 | cbfa8e3dfab64a27a87c8e24ecd5c60f |
    | disk.write.bytes.rate   | gauge      | B/s       | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | b6e62aad26174382bc3781c12fe413c8 | cbfa8e3dfab64a27a87c8e24ecd5c60f |
    | disk.write.requests     | cumulative | request   | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | b6e62aad26174382bc3781c12fe413c8 | cbfa8e3dfab64a27a87c8e24ecd5c60f |
    | disk.write.requests.rate| gauge      | request/s | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | b6e62aad26174382bc3781c12fe413c8 | cbfa8e3dfab64a27a87c8e24ecd5c60f |
    | instance                | gauge      | instance  | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | b6e62aad26174382bc3781c12fe413c8 | cbfa8e3dfab64a27a87c8e24ecd5c60f |
    | instance:m1.tiny        | gauge      | instance  | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | b6e62aad26174382bc3781c12fe413c8 | cbfa8e3dfab64a27a87c8e24ecd5c60f |
    | memory                  | gauge      | MB        | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | b6e62aad26174382bc3781c12fe413c8 | cbfa8e3dfab64a27a87c8e24ecd5c60f |
    | vcpus                   | gauge      | vcpu      | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | b6e62aad26174382bc3781c12fe413c8 | cbfa8e3dfab64a27a87c8e24ecd5c60f |
    +-------------------------+------------+-----------+--------------------------------------+----------------------------------+----------------------------------+

As it was described above, the whole set of samples can be retrieved
that are stored for a meter or filtering the result set by using one of
the available query types. The request for all the samples of the
``cpu`` meter without any additional filtering looks like the following:

.. code-block:: console

   $ ceilometer sample-list --meter cpu
   +--------------------------------------+-------+------------+------------+------+---------------------+
   | Resource ID                          | Meter | Type       | Volume     | Unit | Timestamp           |
   +--------------------------------------+-------+------------+------------+------+---------------------+
   | c8d2e153-a48f-4cec-9e93-86e7ac6d4b0b | cpu   | cumulative | 5.4863e+11 | ns   | 2014-08-31T11:17:03 |
   | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | cpu   | cumulative | 5.7848e+11 | ns   | 2014-08-31T11:17:03 |
   | c8d2e153-a48f-4cec-9e93-86e7ac6d4b0b | cpu   | cumulative | 5.4811e+11 | ns   | 2014-08-31T11:07:05 |
   | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | cpu   | cumulative | 5.7797e+11 | ns   | 2014-08-31T11:07:05 |
   | c8d2e153-a48f-4cec-9e93-86e7ac6d4b0b | cpu   | cumulative | 5.3589e+11 | ns   | 2014-08-31T10:27:19 |
   | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | cpu   | cumulative | 5.6397e+11 | ns   | 2014-08-31T10:27:19 |
   | ...                                                                                                 |
   +--------------------------------------+-------+------------+------------+------+---------------------+

The result set of the request contains the samples for both instances
ordered by the timestamp field in the default descending order.

The simple query makes it possible to retrieve only a subset of the
collected samples. The following command can be executed to request the
``cpu`` samples of only one of the VM instances:

.. code-block:: console

   $ ceilometer sample-list --meter cpu --query resource=bb52e52b-1e42-4751-
     b3ac-45c52d83ba07
   +--------------------------------------+------+------------+------------+------+---------------------+
   | Resource ID                          | Name | Type       | Volume     | Unit | Timestamp           |
   +--------------------------------------+------+------------+------------+------+---------------------+
   | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | cpu  | cumulative | 5.7906e+11 | ns   | 2014-08-31T11:27:08 |
   | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | cpu  | cumulative | 5.7848e+11 | ns   | 2014-08-31T11:17:03 |
   | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | cpu  | cumulative | 5.7797e+11 | ns   | 2014-08-31T11:07:05 |
   | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | cpu  | cumulative | 5.6397e+11 | ns   | 2014-08-31T10:27:19 |
   | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | cpu  | cumulative | 5.6207e+11 | ns   | 2014-08-31T10:17:03 |
   | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | cpu  | cumulative | 5.3831e+11 | ns   | 2014-08-31T08:41:57 |
   | ...                                                                                                |
   +--------------------------------------+------+------------+------------+------+---------------------+

As it can be seen on the output above, the result set contains samples
for only one instance of the two.

The :command:`ceilometer query-samples` command is used to execute rich
queries. This command accepts the following parameters:

``--filter``
    Contains the filter expression for the query in the form of:
    ``{complex_op: [{simple_op: {field_name: value}}]}``.

``--orderby``
    Contains the list of ``orderby`` expressions in the form of:
    ``[{field_name: direction}, {field_name: direction}]``.

``--limit``
    Specifies the maximum number of samples to return.

For more information about complex queries see
:ref:`Complex query <complex-query>`.

As the complex query functionality provides the possibility of using
complex operators, it is possible to retrieve a subset of samples for a
given VM instance. To request for the first six samples for the ``cpu``
and ``disk.read.bytes`` meters, the following command should be invoked:

.. code-block:: none

   $ ceilometer query-samples --filter '{"and": \
     [{"=":{"resource":"bb52e52b-1e42-4751-b3ac-45c52d83ba07"}},{"or":[{"=":{"counter_name":"cpu"}}, \
     {"=":{"counter_name":"disk.read.bytes"}}]}]}' --orderby '[{"timestamp":"asc"}]' --limit 6
   +--------------------------------------+-----------------+------------+------------+------+---------------------+
   | Resource ID                          | Meter           | Type       | Volume     | Unit | Timestamp           |
   +--------------------------------------+-----------------+------------+------------+------+---------------------+
   | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | disk.read.bytes | cumulative | 385334.0   | B    | 2014-08-30T13:00:46 |
   | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | cpu             | cumulative | 1.2132e+11 | ns   | 2014-08-30T13:00:47 |
   | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | cpu             | cumulative | 1.4295e+11 | ns   | 2014-08-30T13:10:51 |
   | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | disk.read.bytes | cumulative | 601438.0   | B    | 2014-08-30T13:10:51 |
   | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | disk.read.bytes | cumulative | 601438.0   | B    | 2014-08-30T13:20:33 |
   | bb52e52b-1e42-4751-b3ac-45c52d83ba07 | cpu             | cumulative | 1.4795e+11 | ns   | 2014-08-30T13:20:34 |
   +--------------------------------------+-----------------+------------+------------+------+---------------------+

Ceilometer also captures data as events, which represents the state of a
resource. Refer to ``/telemetry-events`` for more information regarding
Events.

To retrieve a list of recent events that occurred in the system, the
following command can be executed:

.. code-block:: console

    $ ceilometer event-list
    +--------------------------------------+---------------+----------------------------+-----------------------------------------------------------------+
    | Message ID                           | Event Type    | Generated                  | Traits                                                          |
    +--------------------------------------+---------------+----------------------------+-----------------------------------------------------------------+
    | dfdb87b6-92c6-4d40-b9b5-ba308f304c13 | image.create  | 2015-09-24T22:17:39.498888 | +---------+--------+-----------------+                          |
    |                                      |               |                            | |   name  |  type  |      value      |                          |
    |                                      |               |                            | +---------+--------+-----------------+                          |
    |                                      |               |                            | | service | string | image.localhost |                          |
    |                                      |               |                            | +---------+--------+-----------------+                          |
    | 84054bc6-2ae6-4b93-b5e7-06964f151cef | image.prepare | 2015-09-24T22:17:39.594192 | +---------+--------+-----------------+                          |
    |                                      |               |                            | |   name  |  type  |      value      |                          |
    |                                      |               |                            | +---------+--------+-----------------+                          |
    |                                      |               |                            | | service | string | image.localhost |                          |
    |                                      |               |                            | +---------+--------+-----------------+                          |
    | 2ec99c2c-08ee-4079-bf80-27d4a073ded6 | image.update  | 2015-09-24T22:17:39.578336 | +-------------+--------+--------------------------------------+ |
    |                                      |               |                            | |     name    |  type  |                value                 | |
    |                                      |               |                            | +-------------+--------+--------------------------------------+ |
    |                                      |               |                            | |  created_at | string |         2015-09-24T22:17:39Z         | |
    |                                      |               |                            | |     name    | string |    cirros-0.3.5-x86_64-uec-kernel    | |
    |                                      |               |                            | |  project_id | string |   56ffddea5b4f423496444ea36c31be23   | |
    |                                      |               |                            | | resource_id | string | 86eb8273-edd7-4483-a07c-002ff1c5657d | |
    |                                      |               |                            | |   service   | string |           image.localhost            | |
    |                                      |               |                            | |    status   | string |                saving                | |
    |                                      |               |                            | |   user_id   | string |   56ffddea5b4f423496444ea36c31be23   | |
    |                                      |               |                            | +-------------+--------+--------------------------------------+ |
    +--------------------------------------+---------------+----------------------------+-----------------------------------------------------------------+

.. note::

   In Liberty, the data returned corresponds to the role and user. Non-admin
   users will only return events that are scoped to them. Admin users will
   return all events related to the project they administer as well as
   all unscoped events.

Similar to querying meters, additional filter parameters can be given to
retrieve specific events:

.. code-block:: console

    $ ceilometer event-list -q 'event_type=compute.instance.exists;instance_type=m1.tiny'
    +--------------------------------------+-------------------------+----------------------------+----------------------------------------------------------------------------------+
    | Message ID                           | Event Type              | Generated                  | Traits                                                                           |
    +--------------------------------------+-------------------------+----------------------------+----------------------------------------------------------------------------------+
    | 134a2ab3-6051-496c-b82f-10a3c367439a | compute.instance.exists | 2015-09-25T03:00:02.152041 | +------------------------+----------+------------------------------------------+ |
    |                                      |                         |                            | |          name          |   type   |                  value                   | |
    |                                      |                         |                            | +------------------------+----------+------------------------------------------+ |
    |                                      |                         |                            | | audit_period_beginning | datetime |           2015-09-25T02:00:00            | |
    |                                      |                         |                            | |  audit_period_ending   | datetime |           2015-09-25T03:00:00            | |
    |                                      |                         |                            | |        disk_gb         | integer  |                    1                     | |
    |                                      |                         |                            | |      ephemeral_gb      | integer  |                    0                     | |
    |                                      |                         |                            | |          host          |  string  |          localhost.localdomain           | |
    |                                      |                         |                            | |      instance_id       |  string  |   2115f189-c7f1-4228-97bc-d742600839f2   | |
    |                                      |                         |                            | |     instance_type      |  string  |                 m1.tiny                  | |
    |                                      |                         |                            | |    instance_type_id    | integer  |                    2                     | |
    |                                      |                         |                            | |      launched_at       | datetime |           2015-09-24T22:24:56            | |
    |                                      |                         |                            | |       memory_mb        | integer  |                   512                    | |
    |                                      |                         |                            | |       project_id       |  string  |     56ffddea5b4f423496444ea36c31be23     | |
    |                                      |                         |                            | |       request_id       |  string  | req-c6292b21-bf98-4a1d-b40c-cebba4d09a67 | |
    |                                      |                         |                            | |        root_gb         | integer  |                    1                     | |
    |                                      |                         |                            | |        service         |  string  |                 compute                  | |
    |                                      |                         |                            | |         state          |  string  |                  active                  | |
    |                                      |                         |                            | |       tenant_id        |  string  |     56ffddea5b4f423496444ea36c31be23     | |
    |                                      |                         |                            | |        user_id         |  string  |     0b3d725756f94923b9d0c4db864d06a9     | |
    |                                      |                         |                            | |         vcpus          | integer  |                    1                     | |
    |                                      |                         |                            | +------------------------+----------+------------------------------------------+ |
    +--------------------------------------+-------------------------+----------------------------+----------------------------------------------------------------------------------+

.. note::

   As of the Liberty release, the number of items returned will be
   restricted to the value defined by ``default_api_return_limit`` in the
   ``ceilometer.conf`` configuration file. Alternatively, the value can
   be set per query by passing the ``limit`` option in the request.


Telemetry Python bindings
-------------------------

The command-line client library provides python bindings in order to use
the Telemetry Python API directly from python programs.

The first step in setting up the client is to create a client instance
with the proper credentials:

.. code-block:: python

   >>> import ceilometerclient.client
   >>> cclient = ceilometerclient.client.get_client(VERSION, username=USERNAME, password=PASSWORD, tenant_name=PROJECT_NAME, auth_url=AUTH_URL)

The ``VERSION`` parameter can be ``1`` or ``2``, specifying the API
version to be used.

The method calls look like the following:

.. code-block:: python

   >>> cclient.meters.list()
    [<Meter ...>, ...]

   >>> cclient.samples.list()
    [<Sample ...>, ...]

For further details about the python-ceilometerclient package, see the
`Python bindings to the OpenStack Ceilometer
API <https://docs.openstack.org/developer/python-ceilometerclient/>`__
reference.

.. _telemetry-publishers:

Publishers
~~~~~~~~~~

The Telemetry service provides several transport methods to forward the
data collected to the ``ceilometer-collector`` service or to an external
system. The consumers of this data are widely different, like monitoring
systems, for which data loss is acceptable and billing systems, which
require reliable data transportation. Telemetry provides methods to
fulfill the requirements of both kind of systems, as it is described
below.

The publisher component makes it possible to persist the data into
storage through the message bus or to send it to one or more external
consumers. One chain can contain multiple publishers.

To solve the above mentioned problem, the notion of multi-publisher can
be configured for each datapoint within the Telemetry service, allowing
the same technical meter or event to be published multiple times to
multiple destinations, each potentially using a different transport.

Publishers can be specified in the ``publishers`` section for each
pipeline (for further details about pipelines see
:ref:`data-collection-and-processing`) that is defined in
the `pipeline.yaml
<https://git.openstack.org/cgit/openstack/ceilometer/plain/etc/ceilometer/pipeline.yaml>`__
file.

The following publisher types are supported:

direct
    It can be specified in the form of ``direct://?dispatcher=http``. The
    dispatcher's options include database, file, http, and gnocchi. For
    more details on dispatcher, see :ref:`telemetry-storing-samples`.
    It emits data in the configured dispatcher directly, default configuration
    (the form is ``direct://``) is database dispatcher.
    In the Mitaka release, this method can only emit data to the database
    dispatcher, and the form is ``direct://``.

notifier
    It can be specified in the form of
    ``notifier://?option1=value1&option2=value2``. It emits data over
    AMQP using oslo.messaging. This is the recommended method of
    publishing.

rpc
    It can be specified in the form of
    ``rpc://?option1=value1&option2=value2``. It emits metering data
    over lossy AMQP. This method is synchronous and may experience
    performance issues. This publisher is deprecated in Liberty in favor of
    the notifier publisher.

udp
    It can be specified in the form of ``udp://<host>:<port>/``. It emits
    metering data for over UDP.

file
    It can be specified in the form of
    ``file://path?option1=value1&option2=value2``. This publisher
    records metering data into a file.

.. note::

   If a file name and location is not specified, this publisher
   does not log any meters, instead it logs a warning message in
   the configured log file for Telemetry.

kafka
    It can be specified in the form of:
    ``kafka://kafka_broker_ip: kafka_broker_port?topic=kafka_topic
    &option1=value1``.

    This publisher sends metering data to a kafka broker.

.. note::

   If the topic parameter is missing, this publisher brings out
   metering data under a topic name, ``ceilometer``. When the port
   number is not specified, this publisher uses 9092 as the
   broker's port.

The following options are available for ``rpc`` and ``notifier``. The
policy option can be used by ``kafka`` publisher:

``per_meter_topic``
    The value of it is 1. It is used for publishing the samples on
    additional ``metering_topic.sample_name`` topic queue besides the
    default ``metering_topic`` queue.

``policy``
    It is used for configuring the behavior for the case, when the
    publisher fails to send the samples, where the possible predefined
    values are the following:

    default
        Used for waiting and blocking until the samples have been sent.

    drop
        Used for dropping the samples which are failed to be sent.

    queue
        Used for creating an in-memory queue and retrying to send the
        samples on the queue on the next samples publishing period (the
        queue length can be configured with ``max_queue_length``, where
        1024 is the default value).

The following option is additionally available for the ``notifier`` publisher:

``topic``
    The topic name of queue to publish to. Setting this will override the
    default topic defined by ``metering_topic`` and ``event_topic`` options.
    This option can be used to support multiple consumers. Support for this
    feature was added in Kilo.

The following options are available for the ``file`` publisher:

``max_bytes``
    When this option is greater than zero, it will cause a rollover.
    When the size is about to be exceeded, the file is closed and a new
    file is silently opened for output. If its value is zero, rollover
    never occurs.

``backup_count``
    If this value is non-zero, an extension will be appended to the
    filename of the old log, as '.1', '.2', and so forth until the
    specified value is reached. The file that is written and contains
    the newest data is always the one that is specified without any
    extensions.

The default publisher is ``notifier``, without any additional options
specified. A sample ``publishers`` section in the
``/etc/ceilometer/pipeline.yaml`` looks like the following:

.. code-block:: yaml

   publishers:
       - udp://10.0.0.2:1234
       - rpc://?per_meter_topic=1 (deprecated in Liberty)
       - notifier://?policy=drop&max_queue_length=512&topic=custom_target
       - direct://?dispatcher=http
