==========================
Using SR-IOV functionality
==========================

The purpose of this page is to describe how to enable SR-IOV
functionality available in OpenStack (using OpenStack Networking) as of
the Juno release. This page serves as a how-to guide on configuring
OpenStack Networking and OpenStack Compute to create neutron SR-IOV ports.

The basics
~~~~~~~~~~

PCI-SIG Single Root I/O Virtualization and Sharing (SR-IOV)
specification defines a standardized mechanism to virtualize PCIe devices.
The mechanism can virtualize a single PCIe Ethernet controller to appear as
multiple PCIe devices. You can directly assign each virtual PCIe device to
a VM, bypassing the hypervisor and virtual switch layer. As a result, users
are able to achieve low latency and near-line wire speed.

The following terms are used over the document:

.. list-table::
   :header-rows: 1
   :widths: 10 90

   * - Term
     - Definition
   * - PF
     - Physical Function. This is the physical Ethernet controller
       that supports SR-IOV.
   * - VF
     - Virtual Function. This is a virtual PCIe device created
       from a physical Ethernet controller.


In order to enable SR-IOV, the following steps are required:

#. Create Virtual Functions (Compute)
#. Whitelist PCI devices in nova-compute (Compute)
#. Configure neutron-server (Controller)
#. Configure nova-scheduler (Controller)
#. Enable neutron sriov-agent (Compute)

Neutron sriov-agent
--------------------
There are 2 ways of configuring SR-IOV:

#. With the sriov-agent running on each compute node
#. Without the sriov-agent running on each compute node

The sriov-agent allows you to set the admin state of ports and
starting from Liberty allows you to control
port security (enable and disable spoofchecking) and QoS rate limit settings.


.. note::

   With the sriov-agent mode is default in Liberty.
   Without the sriov-agent mode is deprecated in Liberty and
   removed in Mitaka.

Known limitations
~~~~~~~~~~~~~~~~~

* QoS is supported since Liberty, while it has limitations.
  max_burst_kbps (burst over max_kbps) is not supported.
  max_kbps is rounded to Mbps.
* Security Group is not supported. the agent is only working with
  ``firewall_driver = neutron.agent.firewall.NoopFirewallDriver``.
* No OpenStack Dashboard integration. Users need to use CLI or API to
  create neutron SR-IOV ports.
* Live migration is not supported for instances with SR-IOV ports.

  .. note::

     ARP spoofing filtering is supported since Liberty when using
     sriov-agent.

Environment example
~~~~~~~~~~~~~~~~~~~
We recommend using Open vSwitch with VLAN as segregation. This
way you can combine normal VMs without SR-IOV ports
and instances with SR-IOV ports on a single neutron
network.

.. note::

   Throughout this guide, eth3 is used as the PF and
   physnet2 is used as the provider network configured as a VLAN range.
   You are expected to change this according to your actual
   environment.


Create Virtual Functions (Compute)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In this step, create the VFs for the network
interface that will be used for SR-IOV.
Use eth3 as PF, which is also used
as the interface for Open vSwitch VLAN and has access
to the private networks of all machines.

The step to create VFs differ between SR-IOV card Ethernet controller
manufacturers. Currently the following manufacturers are known to work:

- Intel
- Mellanox
- QLogic

For **Mellanox SR-IOV Ethernet cards** see:
`Mellanox: HowTo Configure SR-IOV VFs
<https://community.mellanox.com/docs/DOC-1484>`_

To create the VFs on Ubuntu for **Intel SR-IOV Ethernet cards**,
do the following:

#. Make sure SR-IOV is enabled in BIOS, check for VT-d and
   make sure it is enabled.  After enabling VT-d, enable IOMMU on
   Linux by adding ``intel_iommu=on`` to kernel parameters. Edit the file
   ``/etc/default/grub``:

   .. code-block:: ini

      GRUB_CMDLINE_LINUX_DEFAULT="nomdmonddf nomdmonisw intel_iommu=on

#. Run the following if you have added new parameters:

   .. code-block:: console

      # update-grub
      # reboot

#. On each compute node, create the VFs via the PCI SYS interface:

   .. code-block:: console

      # echo '7' > /sys/class/net/eth3/device/sriov_numvfs

   Alternatively VFs can be created by passing the ``max_vfs`` to the kernel
   module of your network interface. The ``max_vfs`` parameter has been
   deprecated so the PCI SYS interface is the preferred method.

#. Now verify that the VFs have been created (Should see Virtual Function
   device):

   .. code-block:: console

      # lspci | grep Ethernet

#. Persist created VFs on reboot:

   .. code-block:: console

      # echo "echo '7' > /sys/class/net/eth3/device/sriov_numvfs" >> /etc/rc.local


   .. note::

      The suggested way of making PCI SYS settings persistent
      is through :file:`sysfs.conf` but for unknown reason
      changing :file:`sysfs.conf` does not have any effect on Ubuntu 14.04.

For **QLogic SR-IOV Ethernet cards** see:
`User's Guide OpenStack Deployment with SR-IOV Configuration
<http://www.qlogic.com/solutions/Documents/UsersGuide_OpenStack_SR-IOV.pdf>`_


Whitelist PCI devices nova-compute (Compute)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Tell nova-compute which pci devices are allowed to be passed
through. Edit the file ``/etc/nova/nova.conf``:

.. code-block:: ini

   [default]
   pci_passthrough_whitelist = { "devname": "eth3", "physical_network": "physnet2"}

This tells nova that all VFs belonging to eth3 are allowed to be passed
through to VMs and belong to the neutron provider network physnet2. Restart
nova compute with :command:`service nova-compute restart` to let the changes
have effect.

Alternatively the ``pci_passthrough_whitelist`` parameter also supports
whitelisting by:

- PCI address: The address uses the same syntax as in ``lspci`` and an
  asterisk (*) can be used to match anything.

  .. code-block:: ini

     pci_passthrough_whitelist = { "address": "[[[[<domain>]:]<bus>]:][<slot>][.[<function>]]", "physical_network": "physnet2" }

     # Example match any domain, bus 0a, slot 00, all function
     pci_passthrough_whitelist = { "address": "*:0a:00.*", "physical_network": "physnet2" }

- PCI ``vendor_id`` and ``product_id`` as displayed by the Linux utility
  ``lspci``.

  .. code-block:: ini

     pci_passthrough_whitelist = { "vendor_id": "<id>", "product_id": "<id>",
                                   "physical_network": "physnet2"}


If the device defined by the PCI address or devname corresponds to a SR-IOV PF,
all VFs under the PF will match the entry. Multiple pci_passthrough_whitelist
entries per host are supported.

.. _configure_sriov_neutron_server:

Configure neutron-server (Controller)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Add ``sriovnicswitch`` as mechanism driver. Edit the file
   ``/etc/neutron/plugins/ml2/ml2_conf.ini``:

   .. code-block:: ini

      mechanism_drivers = openvswitch,sriovnicswitch

#. Find out the ``vendor_id`` and ``product_id`` of your **VFs** by logging
   in to your compute node with VFs previously created:

   .. code-block:: console

      # lspci -nn | grep -i ethernet
      87:00.0 Ethernet controller [0200]: Intel Corporation 82599 10 Gigabit Dual Port Backplane Connection [8086:10f8] (rev 01)
      87:10.1 Ethernet controller [0200]: Intel Corporation 82599 Ethernet Controller Virtual Function [8086:10ed] (rev 01)
      87:10.3 Ethernet controller [0200]: Intel Corporation 82599 Ethernet Controller Virtual Function [8086:10ed] (rev 01)

#. Update the ``/etc/neutron/plugins/ml2/ml2_conf_sriov.ini`` on each
   controller. In our case the vendor_id is 8086 and the product_id is 10ed.
   Tell neutron the vendor_id and product_id of the VFs that are supported.

   .. code-block:: ini

      supported_pci_vendor_devs = 8086:10ed


#. Add the newly configured ``ml2_conf_sriov.ini`` as parameter to
   the neutron-server daemon.  Edit the file
   ``/etc/init/neutron-server.conf``:

   .. code-block:: ini

      --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugin.ini
      --config-file /etc/neutron/plugins/ml2/ml2_conf_sriov.ini

#. To make the changes have effect, restart the neutron-server service with
   the :command:`service neutron-server restart`.

Configure nova-scheduler (Controller)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. On every controller node running nova-scheduler add
   PCIDeviceScheduler to the scheduler_default_filters parameter
   and add a new line for scheduler_available_filters parameter
   under the ``[default]`` section in
   ``/etc/nova/nova.conf``:

   .. code-block:: ini

      [DEFAULT]
      scheduler_default_filters = RetryFilter, AvailabilityZoneFilter, RamFilter, ComputeFilter, ComputeCapabilitiesFilter, ImagePropertiesFilter, ServerGroupAntiAffinityFilter, ServerGroupAffinityFilter, PciPassthroughFilter
      scheduler_available_filters = nova.scheduler.filters.all_filters
      scheduler_available_filters = nova.scheduler.filters.pci_passthrough_filter.PciPassthroughFilter


#. Now restart the nova-scheduler service with
   :command:`service nova-scheduler restart`.


Enable neutron sriov-agent (Compute)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. note::

   You only need to enable the sriov-agent if you decided to keep
   ``agent_required=True`` in the step :ref:`configure_sriov_neutron_server`.
   If you set ``agent_required=False``, you can safely skip this step.

#. On each compute node edit the file
   ``/etc/neutron/plugins/ml2/sriov_agent.ini``:

   .. code-block:: ini

      [securitygroup]
      firewall_driver = neutron.agent.firewall.NoopFirewallDriver

      [sriov_nic]
      physical_device_mappings = physnet2:eth3
      exclude_devices =

   exclude_devices is empty so all the VFs associated with eth3 may be
   configured by the agent. If you want to exclude specific VFs, add
   them to the exclude_devices parameter as follows:

   .. code-block:: ini

      exclude_devices = eth1:0000:07:00.2; 0000:07:00.3, eth2:0000:05:00.1; 0000:05:00.2

#. Test whether the sriov-agent runs successfully:

   .. code-block:: console

      # neutron-sriov-nic-agent --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugins/ml2/sriov_agent.ini

#. Enable the neutron-sriov-agent to start automatically at system start.
   If your distribution does not come with a daemon file for your init
   system, create a daemon configuration file.
   For example on Ubuntu install the package:

   .. code-block:: console

      # apt-get install neutron-plugin-sriov-agent


Creating instances with SR-IOV ports
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
After the configuration is done, you can now launch Instances
with neutron SR-IOV ports.

#. Get the id of the neutron network where you want the SR-IOV port to be
   created:

   .. code-block:: console

      $ net_id=`neutron net-show net04 | grep "\ id\ " | awk '{ print $4 }'`

#. Create the SR-IOV port. We specify vnic_type direct, but other options
   include macvtap:

   .. code-block:: console

      $ port_id=`neutron port-create $net_id --name sriov_port --binding:vnic_type direct | grep "\ id\ " | awk '{ print $4 }'`

#. Create the VM. For the nic we specify the SR-IOV port created in step 2:

   .. code-block:: console

      $ nova boot --flavor m1.large --image ubuntu_14.04 --nic port-id=$port_id test-sriov

