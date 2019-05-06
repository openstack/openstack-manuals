=====================================
Disk and container formats for images
=====================================

When you add an image to the Image service, you can specify
its disk and container formats.

Disk formats
~~~~~~~~~~~~

The disk format of a virtual machine image is the format of the
underlying disk image.
Virtual appliance vendors have different formats for laying out
the information contained in a virtual machine disk image.

Set the disk format for your image to one of the following values:

aki
 An Amazon kernel image.
ami
 An Amazon machine image.
ari
 An Amazon ramdisk image.
iso
 An archive format for the data contents of an optical disc,
 such as CD-ROM.
ploop
 A kernel block device, similar to the traditional loop device but with
 more features added, such as dynamic disk space allocation, stackable
 images, online resize, snapshotting, and live migration helper.
qcow2
 Supported by the QEMU emulator that can expand dynamically
 and supports Copy on Write.
raw
 An unstructured disk image format; if you have a file
 without an extension it is possibly a raw format.
vdi
 Supported by VirtualBox virtual machine monitor and the QEMU emulator.
vhd
 The VHD disk format, a common disk format used by virtual
 machine monitors from VMware, Xen, Microsoft, VirtualBox, and others.
vhdx
 The VHDX disk format, an enhanced version of the VHD format, which
 supports larger disk sizes among other features.
vmdk
 Common disk format supported by many common virtual machine monitors.

Container formats
~~~~~~~~~~~~~~~~~

The container format indicates whether the virtual machine image is in
a file format that also contains metadata about the actual virtual machine.

.. note::

   The Image service and other OpenStack projects do not currently
   support the container format. It is safe to specify ``bare`` as
   the container format if you are unsure.

You can set the container format for your image to one of the following
values:

aki
 An Amazon kernel image.
ami
 An Amazon machine image.
ari
 An Amazon ramdisk image.
bare
 The image does not have a container or metadata envelope.
docker
 A docker container format.
ova
 An OVF package in a tarfile.
ovf
 The OVF container format.
