.. _compute-flavors:

=======
Flavors
=======

Admin users can use the :command:`nova flavor-` commands to customize and
manage flavors. To see the available flavor-related commands, run:

.. code-block:: console

   $ nova help | grep flavor-
     flavor-access-add     Add flavor access for the given tenant.
     flavor-access-list    Print access information about the given flavor.
     flavor-access-remove  Remove flavor access for the given tenant.
     flavor-create         Create a new flavor
     flavor-delete         Delete a specific flavor
     flavor-key            Set or unset extra_spec for a flavor.
     flavor-list           Print a list of available 'flavors' (sizes of
     flavor-show           Show details about the given flavor.

.. note::

   -  Configuration rights can be delegated to additional users by
      redefining the access controls for
      ``compute_extension:flavormanage`` in ``/etc/nova/policy.json``
      on the ``nova-api`` server.

   -  You can modify an existing flavor from the :guilabel:`Edit Flavor`
      button in the Dashboard.

Flavors define these elements:

+-------------+---------------------------------------------------------------+
| Element     | Description                                                   |
+=============+===============================================================+
| Name        | A descriptive name. XX.SIZE_NAME is typically not required,   |
|             | though some third party tools may rely on it.                 |
+-------------+---------------------------------------------------------------+
| Memory_MB   | Virtual machine memory in megabytes.                          |
+-------------+---------------------------------------------------------------+
| Disk        | Virtual root disk size in gigabytes. This is an ephemeral di\ |
|             | sk that the base image is copied into. When booting from a p\ |
|             | ersistent volume it is not used. The "0" size is a special c\ |
|             | ase which uses the native base image size as the size of the  |
|             | ephemeral root volume.                                        |
+-------------+---------------------------------------------------------------+
| Ephemeral   | Specifies the size of a secondary ephemeral data disk. This   |
|             | is an empty, unformatted disk and exists only for the life o\ |
|             | f the instance.                                               |
+-------------+---------------------------------------------------------------+
| Swap        | Optional swap space allocation for the instance.              |
+-------------+---------------------------------------------------------------+
| VCPUs       | Number of virtual CPUs presented to the instance.             |
+-------------+---------------------------------------------------------------+
| RXTX_Factor | Optional property allows created servers to have a different  |
|             | bandwidth cap than that defined in the network they are att\  |
|             | ached to. This factor is multiplied by the rxtx_base propert\ |
|             | y of the network. Default value is 1.0. That is, the same as  |
|             | attached network. This parameter is only available for Xen    |
|             | or NSX based systems.                                         |
+-------------+---------------------------------------------------------------+
| Is_Public   | Boolean value, whether flavor is available to all users or p\ |
|             | rivate to the tenant it was created in. Defaults to ``True``. |
+-------------+---------------------------------------------------------------+
| extra_specs | Key and value pairs that define on which compute nodes a fla\ |
|             | vor can run. These pairs must match corresponding pairs on t\ |
|             | he compute nodes. Use to implement special resources, such a\ |
|             | s flavors that run on only compute nodes with GPU hardware.   |
+-------------+---------------------------------------------------------------+

|

Flavor customization can be limited by the hypervisor in use. For
example the libvirt driver enables quotas on CPUs available to a VM,
disk tuning, bandwidth I/O, watchdog behavior, random number generator
device control, and instance VIF traffic control.

CPU limits
    You can configure the CPU limits with control parameters with the
    ``nova`` client. For example, to configure the I/O limit, use:

    .. code-block:: console

       $ nova flavor-key m1.small set quota:read_bytes_sec=10240000
       $ nova flavor-key m1.small set quota:write_bytes_sec=10240000

    Use these optional parameters to control weight shares, enforcement
    intervals for runtime quotas, and a quota for maximum allowed
    bandwidth:

    -  ``cpu_shares``. Specifies the proportional weighted share for the
       domain. If this element is omitted, the service defaults to the
       OS provided defaults. There is no unit for the value; it is a
       relative measure based on the setting of other VMs. For example,
       a VM configured with value 2048 gets twice as much CPU time as a
       VM configured with value 1024.

    -  ``cpu_shares_level``. On VMware, specifies the allocation level. Can
       be ``custom``, ``high``, ``normal``, or ``low``. If you choose
       ``custom``, set the number of shares using ``cpu_shares_share``.

    -  ``cpu_period``. Specifies the enforcement interval (unit:
       microseconds) for QEMU and LXC hypervisors. Within a period, each
       VCPU of the domain is not allowed to consume more than the quota
       worth of runtime. The value should be in range ``[1000, 1000000]``.
       A period with value 0 means no value.

    -  ``cpu_limit``. Specifies the upper limit for VMware machine CPU
       allocation in MHz. This parameter ensures that a machine never
       uses more than the defined amount of CPU time. It can be used to
       enforce a limit on the machine's CPU performance.

    -  ``cpu_reservation``. Specifies the guaranteed minimum CPU
       reservation in MHz for VMware. This means that if needed, the
       machine will definitely get allocated the reserved amount of CPU
       cycles.

    -  ``cpu_quota``. Specifies the maximum allowed bandwidth (unit:
       microseconds). A domain with a negative-value quota indicates
       that the domain has infinite bandwidth, which means that it is
       not bandwidth controlled. The value should be in range ``[1000,
       18446744073709551]`` or less than 0. A quota with value 0 means no
       value. You can use this feature to ensure that all vCPUs run at the
       same speed. For example:

       .. code-block:: console

          $ nova flavor-key m1.low_cpu set quota:cpu_quota=10000
          $ nova flavor-key m1.low_cpu set quota:cpu_period=20000

       In this example, the instance of ``m1.low_cpu`` can only consume
       a maximum of 50% CPU of a physical CPU computing capability.

Memory limits
    For VMware, you can configure the memory limits with control parameters.

    Use these optional parameters to limit the memory allocation,
    guarantee minimum memory reservation, and to specify shares
    used in case of resource contention:

    -  ``memory_limit``: Specifies the upper limit for VMware machine
       memory allocation in MB. The utilization of a virtual machine will
       not exceed this limit, even if there are available resources. This
       is typically used to ensure a consistent performance of
       virtual machines independent of available resources.

    -  ``memory_reservation``: Specifies the guaranteed minimum memory
       reservation in MB for VMware. This means the specified amount of
       memory will definitely be allocated to the machine.

    -  ``memory_shares_level``: On VMware, specifies the allocation level.
       This can be ``custom``, ``high``, ``normal`` or ``low``. If you choose
       ``custom``, set the number of shares using ``memory_shares_share``.

    -  ``memory_shares_share``: Specifies the number of shares allocated
       in the event that ``custom`` is used. There is no unit for this
       value. It is a relative measure based on the settings for other VMs.
       For example:

       .. code-block:: console

          $ nova flavor-key m1.medium set quota:memory_shares_level=custom
          $ nova flavor-key m1.medium set quota:memory_shares_share=15

Disk I/O limits
    For VMware, you can configure the resource limits for disk
    with control parameters.

    Use these optional parameters to limit the disk utilization,
    guarantee disk allocation, and to specify shares
    used in case of resource contention. This allows the VMware
    driver to enable disk allocations for the running instance.

    -  ``disk_io_limit``: Specifies the upper limit for disk
       utilization in I/O per second. The utilization of a
       virtual machine will not exceed this limit, even
       if there are available resources. The default value
       is -1 which indicates unlimited usage.

    -  ``disk_io_reservation``: Specifies the guaranteed minimum disk
       allocation in terms of :term:`IOPS`.

    -  ``disk_io_shares_level``: Specifies the allocation
       level. This can be ``custom``, ``high``, ``normal`` or ``low``.
       If you choose custom, set the number of shares
       using ``disk_io_shares_share``.

    -  ``disk_io_shares_share``: Specifies the number of shares
       allocated in the event that ``custom`` is used.
       When there is resource contention, this value is used
       to determine the resource allocation.

       The example below sets the ``disk_io_reservation`` to 2000 IOPS.

       .. code-block:: console

          $ nova flavor-key m1.medium set quota:disk_io_reservation=2000

Disk tuning
    Using disk I/O quotas, you can set maximum disk write to 10 MB per
    second for a VM user. For example:

    .. code-block:: console

       $ nova flavor-key m1.medium set quota:disk_write_bytes_sec=10485760

    The disk I/O options are:

    -  disk\_read\_bytes\_sec

    -  disk\_read\_iops\_sec

    -  disk\_write\_bytes\_sec

    -  disk\_write\_iops\_sec

    -  disk\_total\_bytes\_sec

    -  disk\_total\_iops\_sec

Bandwidth I/O
    The vif I/O options are:

    -  vif\_inbound\_ average

    -  vif\_inbound\_burst

    -  vif\_inbound\_peak

    -  vif\_outbound\_ average

    -  vif\_outbound\_burst

    -  vif\_outbound\_peak

    Incoming and outgoing traffic can be shaped independently. The
    bandwidth element can have at most, one inbound and at most, one
    outbound child element. If you leave any of these child elements
    out, no quality of service (QoS) is applied on that traffic
    direction. So, if you want to shape only the network's incoming
    traffic, use inbound only (and vice versa). Each element has one
    mandatory attribute average, which specifies the average bit rate on
    the interface being shaped.

    There are also two optional attributes (integer): ``peak``, which
    specifies the maximum rate at which a bridge can send data
    (kilobytes/second), and ``burst``, the amount of bytes that can be
    burst at peak speed (kilobytes). The rate is shared equally within
    domains connected to the network.

    The example below sets network traffic bandwidth limits for existing
    flavor as follows:

    -  Outbound traffic:

       -  average: 256 Mbps (32768 kilobytes/second)

       -  peak: 512 Mbps (65536 kilobytes/second)

       -  burst: 65536 kilobytes

    -  Inbound traffic:

       -  average: 256 Mbps (32768 kilobytes/second)

       -  peak: 512 Mbps (65536 kilobytes/second)

       -  burst: 65536 kilobytes

    .. code-block:: console

       $ nova flavor-key nlimit set quota:vif_outbound_average=32768
       $ nova flavor-key nlimit set quota:vif_outbound_peak=65536
       $ nova flavor-key nlimit set quota:vif_outbound_burst=65536
       $ nova flavor-key nlimit set quota:vif_inbound_average=32768
       $ nova flavor-key nlimit set quota:vif_inbound_peak=65536
       $ nova flavor-key nlimit set quota:vif_inbound_burst=65536


    .. note::

       All the speed limit values in above example are specified in
       kilobytes/second. And burst values are in kilobytes.

Watchdog behavior
    For the libvirt driver, you can enable and set the behavior of a
    virtual hardware watchdog device for each flavor. Watchdog devices
    keep an eye on the guest server, and carry out the configured
    action, if the server hangs. The watchdog uses the i6300esb device
    (emulating a PCI Intel 6300ESB). If ``hw:watchdog_action`` is not
    specified, the watchdog is disabled.

    To set the behavior, use:

    .. code-block:: console

       $ nova flavor-key FLAVOR-NAME set hw:watchdog_action=ACTION

    Valid ACTION values are:

    -  ``disabled``—(default) The device is not attached.

    -  ``reset``—Forcefully reset the guest.

    -  ``poweroff``—Forcefully power off the guest.

    -  ``pause``—Pause the guest.

    -  ``none``—Only enable the watchdog; do nothing if the server
       hangs.

    .. note::

       Watchdog behavior set using a specific image's properties will
       override behavior set using flavors.

Random-number generator
    If a random-number generator device has been added to the instance
    through its image properties, the device can be enabled and
    configured using:

    .. code-block:: console

       $ nova flavor-key FLAVOR-NAME set hw_rng:allowed=True
       $ nova flavor-key FLAVOR-NAME set hw_rng:rate_bytes=RATE-BYTES
       $ nova flavor-key FLAVOR-NAME set hw_rng:rate_period=RATE-PERIOD

    Where:

    -  RATE-BYTES—(Integer) Allowed amount of bytes that the guest can
       read from the host's entropy per period.

    -  RATE-PERIOD—(Integer) Duration of the read period in seconds.

CPU topology
    For the libvirt driver, you can define the topology of the processors
    in the virtual machine using properties. The properties with ``max``
    limit the number that can be selected by the user with image properties.

    .. code-block:: console

       $ nova flavor-key FLAVOR-NAME set hw:cpu_sockets=FLAVOR-SOCKETS
       $ nova flavor-key FLAVOR-NAME set hw:cpu_cores=FLAVOR-CORES
       $ nova flavor-key FLAVOR-NAME set hw:cpu_threads=FLAVOR-THREADS
       $ nova flavor-key FLAVOR-NAME set hw:cpu_max_sockets=FLAVOR-SOCKETS
       $ nova flavor-key FLAVOR-NAME set hw:cpu_max_cores=FLAVOR-CORES
       $ nova flavor-key FLAVOR-NAME set hw:cpu_max_threads=FLAVOR-THREADS

    Where:

    -  FLAVOR-SOCKETS—(Integer) The number of sockets for the guest VM. By
       this is set to the number of vCPUs requested.

    -  FLAVOR-CORES—(Integer) The number of cores per socket for the guest VM. By
       this is set to 1.

    -  FLAVOR-THREADS—(Integer) The number of threads per core for the guest VM. By
       this is set to 1.

Core pinning
    VMs can be pinned to specific physical cores in the hypervisor to improve
    performance. This should only be done where there is no CPU overcommit
    (``cpu_allocation_ratio`` is 1.0).

    .. code:: console

        $ nova flavor-key FLAVOR-NAME set hw:dedicated=PIN-POLICY

    Valid PIN-POLICY values are:

    -  ``shared``—(default) The guest vCPUs will be allowed to freely float
       across host pCPUs, albeit potentially constrained by NUMA policy.

    -  ``dedicated``—the guest vCPUs will be strictly pinned to a set of host
       pCPUs. In the absence of an explicit vCPU topology request, the drivers
       typically expose all vCPUs as sockets with 1 core and 1 thread. When strict
       CPU pinning is in effect the guest CPU topology will be setup to match the
       topology of the CPUs to which it is pinned. This option assumes the overcommit
       ratio is 1.0. For example, if a 2 vCPU guest is pinned to a single host core
       with 2 threads, then the guest will get a topology of 1 socket, 1 core, 2
       threads.

Project private flavors
    Flavors can also be assigned to particular projects. By default, a
    flavor is public and available to all projects. Private flavors are
    only accessible to those on the access list and are invisible to
    other projects. To create and assign a private flavor to a project,
    run these commands:

    .. code-block:: console

       $ nova flavor-create --is-public false p1.medium auto 512 40 4
       $ nova flavor-access-add 259d06a0-ba6d-4e60-b42d-ab3144411d58 86f94150ed744e08be565c2ff608eef9
