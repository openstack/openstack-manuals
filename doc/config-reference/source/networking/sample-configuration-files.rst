=====================================
Networking sample configuration files
=====================================

The Networking service implements automatic generation of configuration
files. This guide contains a snapshot of common configuration files for
convenience. However, consider generating the latest configuration files
by cloning the neutron_ repository and running the
``tools/generate_config_file_samples.sh`` script. Distribution packages
should include sample configuration files for a particular release.
Generally, these files reside in the ``/etc/neutron`` directory structure.

.. _neutron: https://git.openstack.org/cgit/openstack/neutron/

neutron.conf
~~~~~~~~~~~~

The ``neutron.conf`` file contains the majority of Networking service
options common to all components.

.. literalinclude:: ../samples/neutron/neutron.conf.sample
   :language: ini

api-paste.ini
~~~~~~~~~~~~~

The ``api-paste.ini`` file contains configuration for the web services
gateway interface (WSGI).

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/neutron/plain/etc/api-paste.ini?h=mitaka-eol

policy.json
~~~~~~~~~~~

The ``policy.json`` defines API access policy.

.. remote-code-block:: json

   https://git.openstack.org/cgit/openstack/neutron/plain/etc/policy.json?h=mitaka-eol

rootwrap.conf
~~~~~~~~~~~~~

The ``rootwrap.conf`` file contains configuration for system utilities
that require privilege escalation to execute.

.. remote-code-block:: ini

   https://git.openstack.org/cgit/openstack/neutron/plain/etc/rootwrap.conf?h=mitaka-eol

Reference architecture plug-ins and agents
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Although the Networking service supports other plug-ins and agents, this
guide only contains configuration files for the following reference
architecture components:

* ML2 plug-in
* Layer-2 agents

  * Open vSwitch (OVS)
  * Linux bridge
  * Single-root I/O virtualization (SR-IOV)

* DHCP agent
* Layer-3 (routing) agent
* Metadata agent
* Metering agent

ml2_conf.ini
------------

The ``plugins/ml2/ml2_conf.ini`` file contains configuration for the ML2
plug-in.

.. literalinclude:: ../samples/neutron/ml2_conf.ini.sample
   :language: ini

ml2_conf_sriov.ini
------------------

The ``plugins/ml2/ml2_conf_sriov.ini`` file contains configuration for the
ML2 plug-in specific to SR-IOV.

.. literalinclude:: ../samples/neutron/ml2_conf_sriov.ini.sample
   :language: ini

linuxbridge_agent.ini
---------------------

The ``plugins/ml2/linuxbridge_agent.ini`` file contains configuration for the
Linux bridge layer-2 agent.

.. literalinclude:: ../samples/neutron/linuxbridge_agent.ini.sample
   :language: ini

openvswitch_agent.ini
---------------------

The ``plugins/ml2/openvswitch_agent.ini`` file contains configuration for the
Open vSwitch (OVS) layer-2 agent.

.. literalinclude:: ../samples/neutron/openvswitch_agent.ini.sample
   :language: ini

sriov_agent.ini
---------------

The ``plugins/ml2/sriov_agent.ini`` file contains configuration for the
SR-IOV layer-2 agent.

.. literalinclude:: ../samples/neutron/sriov_agent.ini.sample
   :language: ini

dhcp_agent.ini
--------------

The ``dhcp_agent.ini`` file contains configuration for the DHCP agent.

.. literalinclude:: ../samples/neutron/dhcp_agent.ini.sample
   :language: ini

l3_agent.ini
------------

The ``l3_agent.ini`` file contains configuration for the Layer-3 (routing)
agent.

.. literalinclude:: ../samples/neutron/l3_agent.ini.sample
   :language: ini

metadata_agent.ini
------------------

The ``metadata_agent.ini`` file contains configuration for the metadata
agent.

.. literalinclude:: ../samples/neutron/metadata_agent.ini.sample
   :language: ini

metering_agent.ini
------------------

The ``metering_agent.ini`` file contains configuration for the metering
agent.

.. literalinclude:: ../samples/neutron/metering_agent.ini.sample
   :language: ini
