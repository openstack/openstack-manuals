=======================
Measure cloud resources
=======================

Telemetry measures cloud resources in OpenStack. It collects data
related to billing. Currently, this metering service is available
through only the :command:`ceilometer` command-line client.

To model data, Telemetry uses the following abstractions:

Meter
  Measures a specific aspect of resource usage,
  such as the existence of a running instance, or
  ongoing performance, such as the CPU utilization
  for an instance. Meters exist for each type of
  resource. For example, a separate ``cpu_util``
  meter exists for each instance. The life cycle
  of a meter is decoupled from the existence of
  its related resource. The meter persists after
  the resource goes away.

  A meter has the following attributes:

  * String name

  * A unit of measurement

  * A type, which indicates whether values increase
    monotonically (cumulative), are interpreted as
    a change from the previous value (delta), or are
    stand-alone and relate only to the current duration (gauge)

Sample
  An individual data point that is associated with a specific meter.
  A sample has the same attributes as the associated meter, with
  the addition of time stamp and value attributes. The value attribute
  is also known as the sample ``volume``.

Statistic
  A set of data point aggregates over a time duration. (In contrast,
  a sample represents a single data point.) The Telemetry service
  employs the following aggregation functions:

  * **count**. The number of samples in each period.
  * **max**. The maximum number of sample volumes in each period.
  * **min**. The minimum number of sample volumes in each period.
  * **avg**. The average of sample volumes over each period.
  * **sum**. The sum of sample volumes over each period.

Alarm
  A set of rules that define a monitor and a current state, with
  edge-triggered actions associated with target states.
  Alarms provide user-oriented Monitoring-as-a-Service and a
  general purpose utility for OpenStack. Orchestration auto
  scaling is a typical use case. Alarms follow a tristate
  model of ``ok``, ``alarm``, and ``insufficient data``.
  For conventional threshold-oriented alarms, a static
  threshold value and comparison operator govern state transitions.
  The comparison operator compares a selected meter statistic against
  an evaluation window of configurable length into the recent past.

This example uses the :command:`heat` client to create an auto-scaling
stack and the :command:`ceilometer` client to measure resources.

#. Create an auto-scaling stack by running the following command.
   The `-f` option specifies the name of the stack template
   file, and the `-P` option specifies the ``KeyName``
   parameter as ``heat_key``:

   .. code-block:: console

      $ heat stack-create -f cfn/F17/AutoScalingCeilometer.yaml -P "KeyName=heat_key"

#. List the heat resources that were created:

   .. code-block:: console

      $ heat resource-list

      +--------------------------+-----------------------------------------+----------------+----------------------+
      | resource_name            | resource_type                           |resource_status | updated_time         |
      +--------------------------+-----------------------------------------+----------------+----------------------+
      | CfnUser                  | AWS::IAM::User                          |CREATE_COMPLETE | 2013-10-02T05:53:41Z |
      | WebServerKeys            | AWS::IAM::AccessKey                     |CREATE_COMPLETE | 2013-10-02T05:53:42Z |
      | LaunchConfig             | AWS::AutoScaling::LaunchConfiguration   |CREATE_COMPLETE | 2013-10-02T05:53:43Z |
      | ElasticLoadBalancer      | AWS::ElasticLoadBalancing::LoadBalancer |UPDATE_COMPLETE | 2013-10-02T05:55:58Z |
      | WebServerGroup           | AWS::AutoScaling::AutoScalingGroup      |CREATE_COMPLETE | 2013-10-02T05:55:58Z |
      | WebServerScaleDownPolicy | AWS::AutoScaling::ScalingPolicy         |CREATE_COMPLETE | 2013-10-02T05:56:00Z |
      | WebServerScaleUpPolicy   | AWS::AutoScaling::ScalingPolicy         |CREATE_COMPLETE | 2013-10-02T05:56:00Z |
      | CPUAlarmHigh             | OS::Ceilometer::Alarm                   |CREATE_COMPLETE | 2013-10-02T05:56:02Z |
      | CPUAlarmLow              | OS::Ceilometer::Alarm                   |CREATE_COMPLETE | 2013-10-02T05:56:02Z |
      +--------------------------+-----------------------------------------+-----------------+---------------------+

#. List the alarms that are set:

   .. code-block:: console

      $ ceilometer alarm-list
      +--------------------------------------+------------------------------+-------------------+---------+------------+----------------------------------+
      | Alarm ID                             | Name                         | State             | Enabled | Continuous | Alarm condition                  |
      +--------------------------------------+------------------------------+-------------------+---------+------------+----------------------------------+
      | 4f896b40-0859-460b-9c6a-b0d329814496 | as-CPUAlarmLow-i6qqgkf2fubs  | insufficient data | True    | False      | cpu_util &lt; 15.0 during 1x 60s |
      | 75d8ecf7-afc5-4bdc-95ff-19ed9ba22920 | as-CPUAlarmHigh-sf4muyfruy5m | insufficient data | True    | False      | cpu_util &gt; 50.0 during 1x 60s |
      +--------------------------------------+------------------------------+-------------------+---------+------------+----------------------------------+

#. List the meters that are set:

   .. code-block:: console

      $ ceilometer meter-list
      +-------------+------------+----------+--------------------------------------+----------------------------------+----------------------------------+
      | Name        | Type       | Unit     | Resource ID                          | User ID                          | Project ID                       |
      +-------------+------------+----------+--------------------------------------+----------------------------------+----------------------------------+
      | cpu         | cumulative | ns       | 3965b41b-81b0-4386-bea5-6ec37c8841c1 | d1a2996d3b1f4e0e8645ba9650308011 | bf03bf32e3884d489004ac995ff7a61c |
      | cpu         | cumulative | ns       | 62520a83-73c7-4084-be54-275fe770ef2c | d1a2996d3b1f4e0e8645ba9650308011 | bf03bf32e3884d489004ac995ff7a61c |
      | cpu_util    | gauge      | %        | 3965b41b-81b0-4386-bea5-6ec37c8841c1 | d1a2996d3b1f4e0e8645ba9650308011 | bf03bf32e3884d489004ac995ff7a61c |
      +-------------+------------+----------+--------------------------------------+----------------------------------+----------------------------------+

#. List samples:

   .. code-block:: console

      $ ceilometer sample-list -m cpu_util
      +--------------------------------------+----------+-------+---------------+------+---------------------+
      | Resource ID                          | Name     | Type  | Volume        | Unit | Timestamp           |
      +--------------------------------------+----------+-------+---------------+------+---------------------+
      | 3965b41b-81b0-4386-bea5-6ec37c8841c1 | cpu_util | gauge | 3.98333333333 | %    | 2013-10-02T10:50:12 |
      +--------------------------------------+----------+-------+---------------+------+---------------------+

#. View statistics:

   .. code-block:: console

      $ ceilometer statistics -m cpu_util
      +--------+---------------------+---------------------+-------+---------------+---------------+---------------+---------------+----------+---------------------+---------------------+
      | Period | Period Start        | Period End          | Count | Min           | Max           | Sum           | Avg           | Duration | Duration Start      | Duration End        |
      +--------+---------------------+---------------------+-------+---------------+---------------+---------------+---------------+----------+---------------------+---------------------+
      | 0      | 2013-10-02T10:50:12 | 2013-10-02T10:50:12 | 1     | 3.98333333333 | 3.98333333333 | 3.98333333333 | 3.98333333333 | 0.0      | 2013-10-02T10:50:12 | 2013-10-02T10:50:12 |
      +--------+---------------------+---------------------+-------+---------------+---------------+---------------+---------------+----------+---------------------+---------------------+
