================================
Networking configuration options
================================

The options and descriptions listed in this introduction are auto
generated from the code in the Networking service project, which
provides software-defined networking between VMs run in Compute. The
list contains common options, while the subsections list the options
for the various networking plug-ins.

.. include:: ../tables/neutron-common.rst

Networking plug-ins
~~~~~~~~~~~~~~~~~~~

OpenStack Networking introduces the concept of a plug-in,
which is a back-end implementation of the OpenStack Networking API.
A plug-in can use a variety of technologies to implement the logical
API requests. Some OpenStack Networking plug-ins might use basic
Linux VLANs and IP tables, while others might use more advanced
technologies, such as L2-in-L3 tunneling or OpenFlow. These sections
detail the configuration options for the various plug-ins.

Modular Layer 2 (ml2) plug-in configuration options
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Modular Layer 2 (ml2) plug-in has two components:
network types and mechanisms. You can configure these
components separately. The ml2 plugin also allows administrators to
perform a partial specification, where some options are specified
explicitly in the configuration, and the remainder is allowed to be chosen
automatically by the Compute service.

This section describes the available configuration options.

.. include:: ../tables/neutron-ml2.rst

Modular Layer 2 (ml2) Flat Type configuration options
-----------------------------------------------------

.. include:: ../tables/neutron-ml2_flat.rst

Modular Layer 2 (ml2) Geneve Type configuration options
-------------------------------------------------------------

.. include:: ../tables/neutron-ml2_geneve.rst

Modular Layer 2 (ml2) GRE Type configuration options
----------------------------------------------------

.. include:: ../tables/neutron-ml2_gre.rst

Modular Layer 2 (ml2) VLAN Type configuration options
-----------------------------------------------------

.. include:: ../tables/neutron-ml2_vlan.rst

Modular Layer 2 (ml2) VXLAN Type configuration options
------------------------------------------------------

.. include:: ../tables/neutron-ml2_vxlan.rst

Modular Layer 2 (ml2) L2 Population Mechanism configuration options
-------------------------------------------------------------------

.. include:: ../tables/neutron-ml2_l2pop.rst

Modular Layer 2 (ml2) SR-IOV Mechanism configuration options
------------------------------------------------------------

.. include:: ../tables/neutron-ml2_sriov.rst

Agent
~~~~~

Use the following options to alter agent-related settings.

.. include:: ../tables/neutron-agent.rst

Layer 2 agent configuration options
-----------------------------------

.. include:: ../tables/neutron-l2_agent.rst

Linux Bridge agent configuration options
----------------------------------------

.. include:: ../tables/neutron-linuxbridge_agent.rst

Open vSwitch agent configuration options
----------------------------------------

.. include:: ../tables/neutron-openvswitch_agent.rst

SR-IOV agent configuration options
----------------------------------

.. include:: ../tables/neutron-sriov_agent.rst

MacVTap Agent configuration options
-----------------------------------

.. include:: ../tables/neutron-macvtap_agent.rst

IPv6 Prefix Delegation configuration options
--------------------------------------------

.. include:: ../tables/neutron-pd_linux_agent.rst

API
~~~

Use the following options to alter API-related settings.

.. include:: ../tables/neutron-api.rst

Compute
~~~~~~~

Use the following options to alter Compute-related settings.

.. include:: ../tables/neutron-compute.rst

DHCP agent
~~~~~~~~~~

Use the following options to alter Database-related settings.

.. include:: ../tables/neutron-dhcp_agent.rst

Distributed virtual router
~~~~~~~~~~~~~~~~~~~~~~~~~~

Use the following options to alter DVR-related settings.

.. include:: ../tables/neutron-dvr.rst

IPv6 router advertisement
~~~~~~~~~~~~~~~~~~~~~~~~~

Use the following options to alter IPv6 RA settings.

.. include:: ../tables/neutron-ipv6_ra.rst

L3 agent
~~~~~~~~

Use the following options in the ``l3_agent.ini`` file for the L3
agent.

.. include:: ../tables/neutron-l3_agent.rst

Metadata Agent
~~~~~~~~~~~~~~

Use the following options in the
``metadata_agent.ini`` file for the Metadata agent.

.. include:: ../tables/neutron-metadata.rst

.. note::

   Previously, the neutron metadata agent connected to a neutron
   server via REST API using a neutron client. This is ineffective
   because keystone is then fully involved into the authentication
   process and gets overloaded.

   The neutron metadata agent has been reworked to use RPC by default
   to connect to a server since Kilo release. This is a typical way of
   interacting between neutron server and its agents. If neutron
   server does not support metadata RPC then neutron client will be
   used.

.. warning::

   Do not run the ``neutron-ns-metadata-proxy`` proxy namespace as
   root on a node with the L3 agent running. In OpenStack Kilo and
   newer, you can change the permissions of
   ``neutron-ns-metadata-proxy`` after the proxy installation using
   the ``metadata_proxy_user`` and ``metadata_proxy_group`` options.

Metering Agent
~~~~~~~~~~~~~~

Use the following options in the ``metering_agent.ini`` file for the
Metering agent.

.. include:: ../tables/neutron-metering_agent.rst

Nova
~~~~

Use the following options in the
``neutron.conf`` file to change nova-related settings.

.. include:: ../tables/neutron-nova.rst

Policy
~~~~~~

Use the following options in the ``neutron.conf`` file to change
policy settings.

.. include:: ../tables/neutron-policy.rst

Quotas
~~~~~~

Use the following options in the ``neutron.conf`` file for the quota
system.

.. include:: ../tables/neutron-quotas.rst

Scheduler
~~~~~~~~~

Use the following options in the ``neutron.conf`` file to change
scheduler settings.

.. include:: ../tables/neutron-scheduler.rst

Security Groups
~~~~~~~~~~~~~~~

Use the following options in the configuration file for your driver to
change security group settings.

.. include:: ../tables/neutron-securitygroups.rst

.. note::

   Now Networking uses iptables to achieve security group functions.
   In L2 agent with ``enable_ipset`` option enabled, it makes use of
   IPset to improve security group's performance, as it represents a
   hash set which is insensitive to the number of elements.

   When a port is created, L2 agent will add an additional IPset chain
   to it's iptables chain, if the security group that this port
   belongs to has rules between other security group, the member of
   that security group will be added to the ipset chain.

   If a member of a security group is changed, it used to reload
   iptables rules which is expensive. However, when IPset option is
   enabled on L2 agent, it does not need to reload iptables if only
   members of security group were changed, it should just update an
   IPset.

.. note::

   A single default security group has been introduced in order to
   avoid race conditions when creating a tenant's default security
   group. The race conditions are caused by the uniqueness check of a
   new security group name. A table ``default_security_group``
   implements such a group. It has ``tenant_id`` field as a primary
   key and ``security_group_id``, which is an identifier of a default
   security group. The migration that introduces this table has a
   sanity check that verifies if a default security group is not
   duplicated in any tenant.

Misc
~~~~

.. include:: ../tables/neutron-fdb_agent.rst
.. include:: ../tables/neutron-qos.rst
