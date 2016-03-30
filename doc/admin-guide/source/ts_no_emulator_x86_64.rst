=========================================
Cannot find suitable emulator for x86_64
=========================================

Problem
~~~~~~~

When you attempt to create a VM, the error shows the VM is in the
``BUILD`` then ``ERROR`` state.

Solution
~~~~~~~~

On the KVM host, run :command:`cat /proc/cpuinfo`. Make sure the ``vmx`` or
``svm`` flags are set.

Follow the instructions in the `enabling KVM
section <http://docs.openstack.org/liberty/config-reference/content/kvm.html#section_kvm_enable>`__
of the Configuration Reference to enable hardware virtualization support
in your BIOS.
