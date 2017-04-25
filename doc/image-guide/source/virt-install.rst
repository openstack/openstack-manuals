========================================================
Use virt-install and connect by using a local VNC client
========================================================

If you do not wish to use :command:`virt-manager` (for example,
you do not want to install the dependencies on your server, you do
not have an X server running locally, the X11 forwarding over SSH
is not working), you can use the :command:`virt-install` tool to boot
the virtual machine through libvirt and connect to the graphical
console from a VNC client installed on your local machine.

Because VNC is a standard protocol, there are multiple clients
available that implement the VNC spec, including
`TigerVNC <http://sourceforge.net/apps/mediawiki/tigervnc/
index.php?title=Welcome_to_TigerVNC>`_ (multiple platforms),
`TightVNC <http://tightvnc.com/>`_ (multiple platforms),
`RealVNC <http://realvnc.com/>`_ (multiple platforms),
`Chicken <http://sourceforge.net/projects/chicken/>`_ (Mac OS X),
`Krde <http://userbase.kde.org/Krdc>`_ (KDE),
`Vinagre <https://wiki.gnome.org/Apps/Vinagre>`_ (GNOME).

The following example shows how to use the :command:`qemu-img`
command to create an empty image file, and :command:`virt-install`
command to start up a virtual machine using that image file. As root:

.. code-block:: console

   # qemu-img create -f qcow2 /tmp/centos.qcow2 10G
   # virt-install --virt-type kvm --name centos --ram 1024 \
     --disk /tmp/centos.qcow2,format=qcow2 \
     --network network=default \
     --graphics vnc,listen=0.0.0.0 --noautoconsole \
     --os-type=linux --os-variant=centos7.0 \
     --location=/data/isos/CentOS-7-x86_64-NetInstall-1611.iso

   Starting install...
   Creating domain...                     |    0 B     00:00
   Domain installation still in progress. You can reconnect to
   the console to complete the installation process.

The KVM hypervisor starts the virtual machine with the
libvirt name, ``centos``, with 1024 MB of RAM.
The virtual machine also has a virtual CD-ROM drive associated
with the ``/data/isos/CentOS-7-x86_64-NetInstall-1611.iso`` file and
a local 10 GB hard disk in qcow2 format that is stored
in the host at ``/tmp/centos.qcow2``.
It configures networking to use libvirt default network.
There is a VNC server that is listening on all interfaces,
and libvirt will not attempt to launch a VNC client automatically
nor try to display the text console (``--no-autoconsole``).
Finally, libvirt will attempt to optimize the configuration
for a Linux guest running a CentOS 7 distribution.

.. note::

   When using the libvirt ``default`` network, libvirt will
   connect the virtual machine's interface to a bridge
   called ``virbr0``. There is a dnsmasq process managed
   by libvirt that will hand out an IP address on the
   192.168.122.0/24 subnet, and libvirt has iptables rules
   for doing NAT for IP addresses on this subnet.

Run the :command:`osinfo-query os` command
to see a range of allowed ``--os-variant`` options.

Use the :command:`virsh vncdisplay vm-name` command
to get the VNC port number.

.. code-block:: console

   # virsh vncdisplay centos
   :1

In the example above, the guest ``centos`` uses VNC
display ``:1``, which corresponds to TCP port ``5901``.
You should be able to connect a VNC client running on
your local machine to display ``:1`` on the remote
machine and step through the installation process.
