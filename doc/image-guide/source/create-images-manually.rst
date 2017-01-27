======================
Create images manually
======================

.. toctree::
   :maxdepth: 1

   net-running.rst
   virt-manager.rst
   virt-install.rst
   centos-image.rst
   ubuntu-image.rst
   fedora-image.rst
   windows-image.rst
   freebsd-image.rst

Creating a new image is a step done outside of your
OpenStack installation. You create the new image manually on
your own system and then upload the image to your cloud.

To create a new image, you will need the installation CD or
DVD ISO file for the guest operating system. You will also need
access to a virtualization tool. You can use KVM for this. Or,
if you have a GUI desktop virtualization tool (such as, VMware
Fusion or VirtualBox), you can use that instead.
Convert the file to raw once you are done.

When you create a new virtual machine image, you will need
to connect to the graphical console of the hypervisor, which
acts as the virtual machine's display and allows you to interact
with the guest operating system's installer using your keyboard
and mouse. KVM can expose the graphical console using the
`VNC <https://en.wikipedia.org/wiki/Virtual_Network_Computing>`_
(Virtual Network Computing) protocol or the newer
`SPICE <http://spice-space.org>`_ protocol.
We will use the VNC protocol here, since you are more likely
to find a VNC client that works on your local desktop.

To create an image for the Database service,
see `Building Guest Images for OpenStack Trove
<https://docs.openstack.org/developer/trove/dev/building_guest_images.html>`_.
