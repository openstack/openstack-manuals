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

.. toctree::

   neutron.conf.rst
   api-paste.ini.rst
   policy.json.rst
   rootwrap.conf.rst

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

.. toctree::

   ml2_conf.ini.rst
   ml2_conf_sriov.ini.rst
   linuxbridge_agent.ini.rst
   sriov_agent.ini.rst
   openvswitch_agent.ini.rst
   dhcp_agent.ini.rst
   l3_agent.ini.rst
   macvtap_agent.ini.rst
   metadata_agent.ini.rst
   metering_agent.ini.rst
