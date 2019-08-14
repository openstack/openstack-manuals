===================
event_pipeline.yaml
===================

Event pipelines describe a coupling between notification event_types
and the corresponding sinks for publication of the event data. They are
defined in the ``event_pipeline.yaml`` file.

This file can be modified to adjust which notifications to capture and
where to publish the events.

.. remote-code-block:: ini

   https://opendev.org/openstack/ceilometer/raw/tag/newton-eol/etc/ceilometer/event_pipeline.yaml
