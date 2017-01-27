.. _telemetry-alarms:

======
Alarms
======

Alarms provide user-oriented Monitoring-as-a-Service for resources
running on OpenStack. This type of monitoring ensures you can
automatically scale in or out a group of instances through the
Orchestration service, but you can also use alarms for general-purpose
awareness of your cloud resources' health.

These alarms follow a tri-state model:

ok
  The rule governing the alarm has been evaluated as ``False``.

alarm
  The rule governing the alarm have been evaluated as ``True``.

insufficient data
  There are not enough datapoints available in the evaluation periods
  to meaningfully determine the alarm state.

Alarm definitions
~~~~~~~~~~~~~~~~~

The definition of an alarm provides the rules that govern when a state
transition should occur, and the actions to be taken thereon. The
nature of these rules depend on the alarm type.

Threshold rule alarms
---------------------

For conventional threshold-oriented alarms, state transitions are
governed by:

* A static threshold value with a comparison operator such as greater
  than or less than.

* A statistic selection to aggregate the data.

* A sliding time window to indicate how far back into the recent past
  you want to look.

Combination rule alarms
-----------------------

The Telemetry service also supports the concept of a meta-alarm, which
aggregates over the current state of a set of underlying basic alarms
combined via a logical operator (AND or OR).

Alarm dimensioning
~~~~~~~~~~~~~~~~~~

A key associated concept is the notion of *dimensioning* which
defines the set of matching meters that feed into an alarm
evaluation. Recall that meters are per-resource-instance, so in the
simplest case an alarm might be defined over a particular meter
applied to all resources visible to a particular user. More useful
however would be the option to explicitly select which specific
resources you are interested in alarming on.

At one extreme you might have narrowly dimensioned alarms where this
selection would have only a single target (identified by resource
ID). At the other extreme, you could have widely dimensioned alarms
where this selection identifies many resources over which the
statistic is aggregated. For example all instances booted from a
particular image or all instances with matching user metadata (the
latter is how the Orchestration service identifies autoscaling
groups).

Alarm evaluation
~~~~~~~~~~~~~~~~

Alarms are evaluated by the ``alarm-evaluator`` service on a periodic
basis, defaulting to once every minute.

Alarm actions
-------------

Any state transition of individual alarm (to ``ok``, ``alarm``, or
``insufficient data``) may have one or more actions associated with
it. These actions effectively send a signal to a consumer that the
state transition has occurred, and provide some additional context.
This includes the new and previous states, with some reason data
describing the disposition with respect to the threshold, the number
of datapoints involved and most recent of these. State transitions
are detected by the ``alarm-evaluator``, whereas the
``alarm-notifier`` effects the actual notification action.

**Webhooks**

These are the *de facto* notification type used by Telemetry alarming
and simply involve an HTTP POST request being sent to an endpoint,
with a request body containing a description of the state transition
encoded as a JSON fragment.

**Log actions**

These are a lightweight alternative to webhooks, whereby the state
transition is simply logged by the ``alarm-notifier``, and are
intended primarily for testing purposes.

Workload partitioning
---------------------

The alarm evaluation process uses the same mechanism for workload
partitioning as the central and compute agents. The
`Tooz <https://pypi.python.org/pypi/tooz>`_ library provides the
coordination within the groups of service instances. For further
information about this approach, see the section called
:ref:`Support for HA deployment of the central and compute agent services
<ha-deploy-services>`.

To use this workload partitioning solution set the
``evaluation_service`` option to ``default``. For more
information, see the alarm section in the
`OpenStack Configuration Reference <https://docs.openstack.org/newton/config-reference/telemetry.html>`_.

Using alarms
~~~~~~~~~~~~

Alarm creation
--------------

An example of creating a threshold-oriented alarm, based on an upper
bound on the CPU utilization for a particular instance:

.. code-block:: console

   $ ceilometer alarm-threshold-create --name cpu_hi \
     --description 'instance running hot' \
     --meter-name cpu_util --threshold 70.0 \
     --comparison-operator gt --statistic avg \
     --period 600 --evaluation-periods 3 \
     --alarm-action 'log://' \
     --query resource_id=INSTANCE_ID

This creates an alarm that will fire when the average CPU utilization
for an individual instance exceeds 70% for three consecutive 10
minute periods. The notification in this case is simply a log message,
though it could alternatively be a webhook URL.

.. note::

    Alarm names must be unique for the alarms associated with an
    individual project. Administrator can limit the maximum
    resulting actions for three different states, and the
    ability for a normal user to create ``log://`` and ``test://``
    notifiers is disabled. This prevents unintentional
    consumption of disk and memory resources by the
    Telemetry service.

The sliding time window over which the alarm is evaluated is 30
minutes in this example. This window is not clamped to wall-clock
time boundaries, rather it's anchored on the current time for each
evaluation cycle, and continually creeps forward as each evaluation
cycle rolls around (by default, this occurs every minute).

The period length is set to 600s in this case to reflect the
out-of-the-box default cadence for collection of the associated
meter. This period matching illustrates an important general
principal to keep in mind for alarms:

.. note::

   The alarm period should be a whole number multiple (1 or more)
   of the interval configured in the pipeline corresponding to the
   target meter.

Otherwise the alarm will tend to flit in and out of the
``insufficient data`` state due to the mismatch between the actual
frequency of datapoints in the metering store and the statistics
queries used to compare against the alarm threshold. If a shorter
alarm period is needed, then the corresponding interval should be
adjusted in the ``pipeline.yaml`` file.

Other notable alarm attributes that may be set on creation, or via a
subsequent update, include:

state
  The initial alarm state (defaults to ``insufficient data``).

description
  A free-text description of the alarm (defaults to a synopsis of the
  alarm rule).

enabled
  True if evaluation and actioning is to be enabled for this alarm
  (defaults to ``True``).

repeat-actions
  True if actions should be repeatedly notified while the alarm
  remains in the target state (defaults to ``False``).

ok-action
  An action to invoke when the alarm state transitions to ``ok``.

insufficient-data-action
  An action to invoke when the alarm state transitions to
  ``insufficient data``.

time-constraint
  Used to restrict evaluation of the alarm to certain times of the
  day or days of the week (expressed as ``cron`` expression with an
  optional timezone).

An example of creating a combination alarm, based on the combined
state of two underlying alarms:

.. code-block:: console

   $ ceilometer alarm-combination-create --name meta \
     --alarm_ids ALARM_ID1 \
     --alarm_ids ALARM_ID2 \
     --operator or \
     --alarm-action 'http://example.org/notify'

This creates an alarm that will fire when either one of two underlying
alarms transition into the alarm state. The notification in this case
is a webhook call. Any number of underlying alarms can be combined in
this way, using either ``and`` or ``or``.

Alarm retrieval
---------------

You can display all your alarms via (some attributes are omitted for
brevity):

.. code-block:: console

   $ ceilometer alarm-list
   +----------+--------+-------------------+---------------------------------+
   | Alarm ID | Name   | State             | Alarm condition                 |
   +----------+--------+-------------------+---------------------------------+
   | ALARM_ID | cpu_hi | insufficient data | cpu_util > 70.0 during 3 x 600s |
   +----------+--------+-------------------+---------------------------------+

In this case, the state is reported as ``insufficient data`` which
could indicate that:

* meters have not yet been gathered about this instance over the
  evaluation window into the recent past (for example a brand-new
  instance)

* *or*, that the identified instance is not visible to the
  user/project owning the alarm

* *or*, simply that an alarm evaluation cycle hasn't kicked off since
  the alarm was created (by default, alarms are evaluated once per
  minute).

.. note::

   The visibility of alarms depends on the role and project
   associated with the user issuing the query:

   * admin users see *all* alarms, regardless of the owner

   * non-admin users see only the alarms associated with their project
     (as per the normal project segregation in OpenStack)

Alarm update
------------

Once the state of the alarm has settled down, we might decide that we
set that bar too low with 70%, in which case the threshold (or most
any other alarm attribute) can be updated thusly:

.. code-block:: console

   $ ceilometer alarm-update --threshold 75 ALARM_ID

The change will take effect from the next evaluation cycle, which by
default occurs every minute.

Most alarm attributes can be changed in this way, but there is also
a convenient short-cut for getting and setting the alarm state:

.. code-block:: console

   $ ceilometer alarm-state-get ALARM_ID
   $ ceilometer alarm-state-set --state ok -a ALARM_ID

Over time the state of the alarm may change often, especially if the
threshold is chosen to be close to the trending value of the
statistic. You can follow the history of an alarm over its lifecycle
via the audit API:

.. code-block:: console

   $ ceilometer alarm-history ALARM_ID
   +------------------+-----------+---------------------------------------+
   | Type             | Timestamp | Detail                                |
   +------------------+-----------+---------------------------------------+
   | creation         | time0     | name: cpu_hi                          |
   |                  |           | description: instance running hot     |
   |                  |           | type: threshold                       |
   |                  |           | rule: cpu_util > 70.0 during 3 x 600s |
   | state transition | time1     | state: ok                             |
   | rule change      | time2     | rule: cpu_util > 75.0 during 3 x 600s |
   +------------------+-----------+---------------------------------------+

Alarm deletion
--------------

An alarm that is no longer required can be disabled so that it is no
longer actively evaluated:

.. code-block:: console

   $ ceilometer alarm-update --enabled False -a ALARM_ID

or even deleted permanently (an irreversible step):

.. code-block:: console

   $ ceilometer alarm-delete ALARM_ID

.. note::

    By default, alarm history is retained for deleted alarms.
