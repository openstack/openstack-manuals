======================
event_definitions.yaml
======================

The ``event_definitions.yaml`` file defines how events received from
other OpenStack components should be translated to Telemetry events.

This file provides a standard set of events and corresponding traits
that may be of interest. This file can be modified to add and drop
traits that operators may find useful.

.. remote-code-block:: yaml

   https://git.openstack.org/cgit/openstack/ceilometer/plain/etc/ceilometer/event_definitions.yaml?h=stable/ocata
