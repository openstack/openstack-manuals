==================
Auditing with CADF
==================

The Identity service uses the
`PyCADF <http://docs.openstack.org/developer/pycadf>`_ library to emit
CADF (Cloud Auditing Data Federation) notifications.
These events adhere to the DMTF (Distributed Management Task Force)
`CADF <http://www.dmtf.org/standards/cadf>`_ specification.
The DMTF standard provides auditing capabilities for compliance with
security, operational, and business processes and supports normalized
and categorized event data for federation and aggregation.

CADF notifications include additional context data around the ``resource``,
the ``action``, and the ``initiator``.

CADF notifications may be emitted by changing the ``notification_format`` to
``cadf`` in the configuration file.

The ``payload`` portion of a CADF notification is a CADF ``event``, which
is represented as a JSON dictionary. For example:

.. code-block:: javascript

    {
        "typeURI": "http://schemas.dmtf.org/cloud/audit/1.0/event",
        "initiator": {
            "typeURI": "service/security/account/user",
            "host": {
                "agent": "curl/7.22.0(x86_64-pc-linux-gnu)",
                "address": "127.0.0.1"
            },
            "id": "<initiator_id>"
        },
        "target": {
            "typeURI": "<target_uri>",
            "id": "openstack:1c2fc591-facb-4479-a327-520dade1ea15"
        },
        "observer": {
            "typeURI": "service/security",
            "id": "openstack:3d4a50a9-2b59-438b-bf19-c231f9c7625a"
        },
        "eventType": "activity",
        "eventTime": "2014-02-14T01:20:47.932842+00:00",
        "action": "<action>",
        "outcome": "success",
        "id": "openstack:f5352d7b-bee6-4c22-8213-450e7b646e9f",
    }

Where the following are defined:

* ``<initiator_id>``: ID of the user that performed the operation
* ``<target_uri>``: CADF specific target URI, (for example:
  data/security/project)
* ``<action>``: The action being performed, typically:
  ``<operation>``. ``<resource_type>``

Additionally there may be extra keys present depending on the operation being
performed, these will be discussed below.

.. note::

    The ``eventType`` property of the CADF payload is different from the
    ``event_type`` property of a notification. ``eventType`` is a CADF
    keyword which designates the type of event that is being measured:
    `activity`, `monitor` or `control`. Whereas ``event_type`` is described
    in previous sections as `identity.<resource_type>.<operation>`.
