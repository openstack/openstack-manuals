.. _get_capabilities:


================
Get capabilities
================

When an administrator configures *volume type* and *extra specs* of storage
on the back end, the administrator has to read the right documentation that
corresponds to the version of the storage back end. Deep knowledge of
storage is also required.

OpenStack Block Storage enables administrators to configure *volume type*
and *extra specs* without specific knowledge of the storage back end.

.. note::
    * *Volume Type:* A group of volume policies.
    * *Extra Specs:* The definition of a volume type. This is a group of
      policies. For example, provision type, QOS that will be used to
      define a volume at creation time.
    * *Capabilities:* What the current deployed back end in Cinder is able
      to do. These correspond to extra specs.

Usage of cinder client
~~~~~~~~~~~~~~~~~~~~~~

When an administrator wants to define new volume types for their
OpenStack cloud, the administrator would fetch a list of ``capabilities``
for a particular back end using the cinder client.

First, get a list of the services::

 $ cinder service-list
 +------------------+-------------------+------+---------+-------+------+
 |      Binary      |        Host       | Zone |  Status | State | ...  |
 +------------------+-------------------+------+---------+-------+------+
 | cinder-scheduler | controller        | nova | enabled |   up  | ...  |
 | cinder-volume    | block1@ABC-driver | nova | enabled |   up  | ...  |
 +------------------+-------------------+------+---------+-------+------+

With one of the listed hosts, pass that to ``get-capabilities``, then
the administrator can obtain volume stats and also back end ``capabilities``
as listed below.

::

 $ cinder get-capabilities block1@ABC-driver
 +---------------------+----------------------------------------------+
 |     Volume stats    |                    Value                     |
 +---------------------+----------------------------------------------+
 |     description     |                     None                     |
 |     display_name    |   Capabilities of Cinder Vendor ABC driver   |
 |    driver_version   |                    2.0.0                     |
 |      namespace      | OS::Storage::Capabilities::block1@ABC-driver |
 |      pool_name      |                     None                     |
 |   storage_protocol  |                    iSCSI                     |
 |     vendor_name     |                  Vendor ABC                  |
 |      visibility     |                     pool                     |
 | volume_backend_name |                  ABC-driver                  |
 +---------------------+----------------------------------------------+
 +----------------------+-----------------------------------------------------+
 |  Backend properties  |                     Value                           |
 +----------------------+-----------------------------------------------------+
 |      compression     | {u'type':u'boolean', u'title':u'Compression',  ...} |
 | ABC:compression_type | {u'enum':u'['lossy', 'lossless', 'special']',  ...} |
 |         qos          | {u'type':u'boolean', u'title':u'QoS',          ...} |
 |     replication      | {u'type':u'boolean', u'title':u'Replication',  ...} |
 |  thin_provisioning   | {u'type':u'boolean', u'title':u'Thin Provisioning'} |
 |     ABC:minIOPS      | {u'type':u'integer', u'title':u'Minimum IOPS QoS',} |
 |     ABC:maxIOPS      | {u'type':u'integer', u'title':u'Maximum IOPS QoS',} |
 |    ABC:burstIOPS     | {u'type':u'integer', u'title':u'Burst IOPS QoS',..} |
 +----------------------+-----------------------------------------------------+

Usage of REST API
~~~~~~~~~~~~~~~~~
New endpoint to ``get capabilities`` list for specific storage back end
is also available. For more details, refer to the Block Storage API reference.

API request::

 GET /v2/{tenant_id}/capabilities/{hostname}

Example of return value::

 {
   "namespace": "OS::Storage::Capabilities::block1@ABC-driver",
   "volume_backend_name": "ABC-driver",
   "pool_name": "pool",
   "driver_version": "2.0.0",
   "storage_protocol": "iSCSI",
   "display_name": "Capabilities of Cinder Vendor ABC driver",
   "description": "None",
   "visibility": "public",
   "properties": {
    "thin_provisioning": {
       "title": "Thin Provisioning",
       "description": "Sets thin provisioning.",
       "type": "boolean"
     },
     "compression": {
       "title": "Compression",
       "description": "Enables compression.",
       "type": "boolean"
     },
     "ABC:compression_type": {
       "title": "Compression type",
       "description": "Specifies compression type.",
       "type": "string",
       "enum": [
         "lossy", "lossless", "special"
       ]
     },
     "replication": {
       "title": "Replication",
       "description": "Enables replication.",
       "type": "boolean"
     },
     "qos": {
       "title": "QoS",
       "description": "Enables QoS.",
       "type": "boolean"
     },
     "ABC:minIOPS": {
       "title": "Minimum IOPS QoS",
       "description": "Sets minimum IOPS if QoS is enabled.",
       "type": "integer"
     },
     "ABC:maxIOPS": {
       "title": "Maximum IOPS QoS",
       "description": "Sets maximum IOPS if QoS is enabled.",
       "type": "integer"
     },
     "ABC:burstIOPS": {
       "title": "Burst IOPS QoS",
       "description": "Sets burst IOPS if QoS is enabled.",
       "type": "integer"
     },
   }
 }
