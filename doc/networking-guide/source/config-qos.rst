.. _config-qos:

========================
Quality of Service (QoS)
========================

QoS is defined as the ability to guarantee certain network requirements
like bandwidth, latency, jitter, and reliability in order to satisfy a
Service Level Agreement (SLA) between an application provider and end
users.

Network devices such as switches and routers can mark traffic so that it is
handled with a higher priority to fulfill the QoS conditions agreed under
the SLA. In other cases, certain network traffic such as Voice over IP (VoIP)
and video streaming needs to be transmitted with minimal bandwidth
constraints. On a system without network QoS management, all traffic will be
transmitted in a "best-effort" manner making it impossible to guarantee service
delivery to customers.

QoS is an advanced service plug-in. QoS is decoupled from the rest of the
OpenStack Networking code on multiple levels and it is available through the
ml2 extension driver.

Details about the DB models, API extension, and use cases are out of the scope
of this guide but can be found in the
`Neutron QoS specification <http://specs.openstack.org/openstack/neutron-specs/specs/liberty/qos-api-extension.html>`_.


Supported QoS rule types
~~~~~~~~~~~~~~~~~~~~~~~~

Any plug-in or ml2 mechanism driver can claim support for some QoS rule types
by providing a plug-in/driver class property called
``supported_qos_rule_types`` that returns a list of strings that correspond
to `QoS rule types
<https://git.openstack.org/cgit/openstack/neutron/tree/neutron/services/qos/qos_consts.py>`_.

.. note::

   For the Newton release onward DSCP marking will be supported.

In the most simple case, the property can be represented by a simple Python
list defined on the class.

For an ml2 plug-in, the list of supported QoS rule types is defined as a common
subset of rules supported by all active mechanism drivers.

.. note::

   The list of supported rule types reported by core plug-in is not
   enforced when accessing QoS rule resources. This is mostly because
   then we would not be able to create any rules while at least one ml2
   driver lacks support for QoS (at the moment of writing, only macvtap
   is such a driver).


Configuration
~~~~~~~~~~~~~

To enable the service, follow the steps below:

On network nodes:

#. Add the QoS service to the ``service_plugins`` setting in
   ``/etc/neutron/neutron.conf``. For example:

   .. code-block:: none

      service_plugins = \
      neutron.services.l3_router.l3_router_plugin.L3RouterPlugin,
      neutron.services.metering.metering_plugin.MeteringPlugin,
      neutron.services.qos.qos_plugin.QoSPlugin

#. Optionally, set the needed ``notification_drivers`` in the ``[qos]``
   section in ``/etc/neutron/neutron.conf`` (``message_queue`` is the
   default).

#. In ``/etc/neutron/plugins/ml2/ml2_conf.ini``, add ``qos`` to
   ``extension_drivers`` in the ``[ml2]`` section. For example:

   .. code-block:: ini

      [ml2]
      extension_drivers = port_security, qos

#. If the Open vSwitch agent is being used, set ``extensions`` to
   ``qos`` in the ``[agent]`` section of
   ``/etc/neutron/plugins/ml2/openvswitch_agent.ini``. For example:

   .. code-block:: ini

      [agent]
      extensions = qos

On compute nodes:

#. In ``/etc/neutron/plugins/ml2/openvswitch_agent.ini``, add ``qos`` to the
   ``extensions`` setting in the ``[agent]`` section. For example:

   .. code-block:: ini

      [agent]
      extensions = qos

.. note::

   QoS currently works with ml2 only (SR-IOV, Open vSwitch, and linuxbridge
   are drivers that are enabled for QoS in Mitaka release).

Trusted projects policy.json configuration
------------------------------------------

If projects are trusted to administrate their own QoS policies in
your cloud, neutron's file ``policy.json`` can be modified to allow this.

Modify ``/etc/neutron/policy.json`` policy entries as follows:

.. code-block:: none

   "get_policy": "rule:regular_user",
   "create_policy": "rule:regular_user",
   "update_policy": "rule:regular_user",
   "delete_policy": "rule:regular_user",

To enable bandwidth limit rule:

.. code-block:: none

   "get_policy_bandwidth_limit_rule": "rule:regular_user",
   "create_policy_bandwidth_limit_rule": "rule:admin_only",
   "delete_policy_bandwidth_limit_rule": "rule:admin_only",
   "update_policy_bandwidth_limit_rule": "rule:admin_only",
   "get_rule_type": "rule:regular_user",

To enable DSCP marking rule:

.. code-block:: none

   "get_policy_dscp_marking_rule": "rule:regular_user",
   "create_dscp_marking_rule": "rule:admin_only",
   "delete_dscp_marking_rule": "rule:admin_only",
   "update_dscp_marking_rule": "rule:admin_only",
   "get_rule_type": "rule:regular_user",

User workflow
~~~~~~~~~~~~~

QoS policies are only created by admins with the default ``policy.json``.
Therefore, you should have the cloud operator set them up on
behalf of the cloud projects.

If projects are trusted to create their own policies, check the trusted
projects ``policy.json`` configuration section.

First, create a QoS policy and its bandwidth limit rule:

.. code-block:: console

   $ neutron qos-policy-create bw-limiter

   Created a new policy:
   +-------------+--------------------------------------+
   | Field       | Value                                |
   +-------------+--------------------------------------+
   | description |                                      |
   | id          | 0ee1c673-5671-40ca-b55f-4cd4bbd999c7 |
   | name        | bw-limiter                           |
   | rules       |                                      |
   | shared      | False                                |
   | tenant_id   | 85b859134de2428d94f6ee910dc545d8     |
   +-------------+--------------------------------------+

   $ neutron qos-bandwidth-limit-rule-create bw-limiter --max-kbps 3000 \
     --max-burst-kbps 300

   Created a new bandwidth_limit_rule:
   +----------------+--------------------------------------+
   | Field          | Value                                |
   +----------------+--------------------------------------+
   | id             | 92ceb52f-170f-49d0-9528-976e2fee2d6f |
   | max_burst_kbps | 300                                  |
   | max_kbps       | 3000                                 |
   +----------------+--------------------------------------+

.. note::

   The burst value is given in kilobits, not in kilobits per second as the name
   of the parameter might suggest. This is an amount of data which can be sent
   before the bandwidth limit applies.

.. note::

   The QoS implementation requires a burst value to ensure proper behavior of
   bandwidth limit rules in the Open vSwitch and Linux bridge agents. If you
   do not provide a value, it defaults to 80% of the bandwidth limit which
   works for typical TCP traffic.

Second, associate the created policy with an existing neutron port.
In order to do this, user extracts the port id to be associated to
the already created policy. In the next example, we will assign the
``bw-limiter`` policy to the VM with IP address 10.0.0.3

.. code-block:: console

   $ neutron port-list

   +--------------------------------------+----------------------------------+
   | id                                   | fixed_ips                        |
   +--------------------------------------+----------------------------------+
   | 0271d1d9-1b16-4410-bd74-82cdf6dcb5b3 | { ... , "ip_address": "10.0.0.1"}|
   | 88101e57-76fa-4d12-b0e0-4fc7634b874a | { ... , "ip_address": "10.0.0.3"}|
   | e04aab6a-5c6c-4bd9-a600-33333551a668 | { ... , "ip_address": "10.0.0.2"}|
   +--------------------------------------+----------------------------------+

   $ neutron port-update 88101e57-76fa-4d12-b0e0-4fc7634b874a --qos-policy bw-limiter
   Updated port: 88101e57-76fa-4d12-b0e0-4fc7634b874a

In order to detach a port from the QoS policy, simply update again the
port configuration.

.. code-block:: console

   $ neutron port-update 88101e57-76fa-4d12-b0e0-4fc7634b874a --no-qos-policy
   Updated port: 88101e57-76fa-4d12-b0e0-4fc7634b874a


Ports can be created with a policy attached to them too.

.. code-block:: console

   $ neutron port-create private --qos-policy-id bw-limiter

   Created a new port:
   +-----------------------+--------------------------------------------------+
   | Field                 | Value                                            |
   +-----------------------+--------------------------------------------------+
   | admin_state_up        | True                                             |
   | allowed_address_pairs |                                                  |
   | binding:vnic_type     | normal                                           |
   | device_id             |                                                  |
   | device_owner          |                                                  |
   | dns_assignment        | {"hostname": "host-10-0-0-4", ...   }            |
   | dns_name              |                                                  |
   | fixed_ips             | {"subnet_id":                                    |
   |                       |         "fabaf9b6-7a84-43b6-9d23-543591b531b8",  |
   |                       |          "ip_address": "10.0.0.4"}               |
   | id                    | c3cb8faa-db36-429d-bd25-6003fafe63c5             |
   | mac_address           | fa:16:3e:02:65:15                                |
   | name                  |                                                  |
   | network_id            | 4920548d-1a6c-4d67-8de4-06501211587c             |
   | port_security_enabled | True                                             |
   | qos_policy_id         | 0ee1c673-5671-40ca-b55f-4cd4bbd999c7             |
   | security_groups       | b9cecbc5-a136-4032-b196-fb3eb091fff2             |
   | status                | DOWN                                             |
   | tenant_id             | 85b859134de2428d94f6ee910dc545d8                 |
   +-----------------------+--------------------------------------------------+

You can attach networks to a QoS policy. The meaning of this is that
any compute port connected to the network will use the network policy by
default unless the port has a specific policy attached to it. Network owned
ports like DHCP and router ports are excluded from network policy application.

In order to attach a QoS policy to a network, update an existing
network, or initially create the network attached to the policy.

.. code-block:: console

    $ neutron net-update private --qos-policy bw-limiter
    Updated network: private

.. note::

   Configuring the proper burst value is very important. If the burst value is
   set too low, bandwidth usage will be throttled even with a proper bandwidth
   limit setting. This issue is discussed in various documentation sources, for
   example in `Juniper's documentation
   <http://www.juniper.net/documentation/en_US/junos12.3/topics/concept/policer-mx-m120-m320-burstsize-determining.html>`_.
   Burst value for TCP traffic can be set as 80% of desired bandwidth limit
   value. For example, if the bandwidth limit is set to 1000kbps then enough
   burst value will be 800kbit. If the configured burst value is too low,
   achieved bandwidth limit will be lower than expected. If the configured burst
   value is too high, too few packets could be limited and achieved bandwidth
   limit would be higher than expected.

Administrator enforcement
-------------------------

Administrators are able to enforce policies on project ports or networks.
As long as the policy is not shared, the project is not be able to detach
any policy attached to a network or port.

If the policy is shared, the project is able to attach or detach such
policy from its own ports and networks.


Rule modification
-----------------
You can modify rules at runtime. Rule modifications will be propagated to any
attached port.

.. code-block:: console

    $ neutron qos-bandwidth-limit-rule-update \
        92ceb52f-170f-49d0-9528-976e2fee2d6f bw-limiter \
        --max-kbps 2000 --max-burst-kbps 200
    Updated bandwidth_limit_rule: 92ceb52f-170f-49d0-9528-976e2fee2d6f

    $ neutron qos-bandwidth-limit-rule-show \
        92ceb52f-170f-49d0-9528-976e2fee2d6f bw-limiter

    +----------------+--------------------------------------+
    | Field          | Value                                |
    +----------------+--------------------------------------+
    | id             | 92ceb52f-170f-49d0-9528-976e2fee2d6f |
    | max_burst_kbps | 200                                  |
    | max_kbps       | 2000                                 |
    +----------------+--------------------------------------+

Just like with bandwidth limiting, create a policy for DSCP marking rule:

.. code-block:: console

    $ neutron qos-policy-create dscp-marking

    Created a new policy:
    +-------------+--------------------------------------+
    | Field       | Value                                |
    +-------------+--------------------------------------+
    | description |                                      |
    | id          | 8569fb4d-3d63-483e-b49a-9f9290d794f4 |
    | name        | dscp-marking                         |
    | rules       |                                      |
    | shared      | False                                |
    | tenant_id   | 85b859134de2428d94f6ee910dc545d8     |
    +-------------+--------------------------------------+

You can create, update, list, delete, and show DSCP markings
with the neutron client:

.. code-block:: console

    $ neutron qos-dscp-marking-rule-create dscp-marking --dscp-mark 26

    Created a new dscp marking rule
    +----------------+--------------------------------------+
    | Field          | Value                                |
    +----------------+--------------------------------------+
    | id             | 115e4f70-8034-4176-8fe9-2c47f8878a7d |
    | dscp_mark      | 26                                   |
    +----------------+--------------------------------------+

.. code-block:: console

    $ neutron qos-dscp-marking-rule-update \
        115e4f70-8034-4176-8fe9-2c47f8878a7d dscp-marking --dscp-mark 22
    Updated dscp_rule: 115e4f70-8034-4176-8fe9-2c47f8878a7d

    $ neutron qos-dscp-marking-rule-list dscp-marking

    +--------------------------------------+----------------------------------+
    | id                                   | dscp_mark                        |
    +--------------------------------------+----------------------------------+
    | 115e4f70-8034-4176-8fe9-2c47f8878a7d | 22                               |
    +--------------------------------------+----------------------------------+

    $ neutron qos-dscp-marking-rule-show \
        115e4f70-8034-4176-8fe9-2c47f8878a7d dscp-marking

    +----------------+--------------------------------------+
    | Field          | Value                                |
    +----------------+--------------------------------------+
    | id             | 115e4f70-8034-4176-8fe9-2c47f8878a7d |
    | dscp_mark      | 22                                   |
    +----------------+--------------------------------------+

    $ neutron qos-dscp-marking-rule-delete \
        115e4f70-8034-4176-8fe9-2c47f8878a7d dscp-marking
      Deleted dscp_rule: 115e4f70-8034-4176-8fe9-2c47f8878a7d

