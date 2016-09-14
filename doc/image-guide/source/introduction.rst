============
Introduction
============

.. toctree::
   :maxdepth: 1

   image-formats.rst
   image-metadata.rst

An OpenStack Compute cloud is not very useful unless you have virtual
machine images (which some people call "virtual appliances").
This guide describes how to obtain, create, and modify virtual machine
images that are compatible with OpenStack.

To keep things brief, we will sometimes use the term ``image``
instead of virtual machine image.

**What is a virtual machine image?**

A virtual machine image is a single file which contains a virtual disk
that has a bootable operating system installed on it.

Virtual machine images come in different formats, some of which are
described below.

AKI/AMI/ARI
 The `AKI/AMI/ARI
 <http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html>`_
 format was the initial image format supported by Amazon EC2.
 The image consists of three files:

 AKI (Amazon Kernel Image)
  A kernel file that the hypervisor will load initially to boot the image.
  For a Linux machine, this would be a ``vmlinuz`` file.

 AMI (Amazon Machine Image)
  This is a virtual machine image in raw format, as described above.

 ARI (Amazon Ramdisk Image)
  An optional ramdisk file mounted at boot time.
  For a Linux machine, this would be an ``initrd`` file.

ISO
 The `ISO
 <http://www.ecma-international.org/publications/standards/Ecma-119.htm>`_
 format is a disk image formatted with the read-only ISO 9660 (also known
 as ECMA-119) filesystem commonly used for CDs and DVDs.
 While we do not normally think of ISO as a virtual machine image format,
 since ISOs contain bootable filesystems with an installed operating system,
 you can treat them the same as you treat other virtual machine image files.

OVF
 `OVF <http://dmtf.org/sites/default/files/OVF_Overview_Document_2010.pdf>`_
 (Open Virtualization Format) is a packaging format for virtual machines,
 defined by the Distributed Management Task Force (DMTF) standards group.
 An OVF package contains one or more image files, a ``.ovf`` XML metadata file
 that contains information about the virtual machine, and possibly other
 files as well.

 An OVF package can be distributed in different ways. For example,
 it could be distributed as a set of discrete files, or as a tar archive
 file with an ``.ova`` (open virtual appliance/application) extension.

 OpenStack Compute does not currently have support for OVF packages,
 so you will need to extract the image file(s) from an OVF package
 if you wish to use it with OpenStack.

QCOW2
 The `QCOW2 <http://en.wikibooks.org/wiki/QEMU/Images>`_
 (QEMU copy-on-write version 2) format is commonly used with the
 KVM hypervisor.
 It has some additional features over the raw format, such as:

 * Using sparse representation, so the image size is smaller.
 * Support for snapshots.

 Because qcow2 is sparse, qcow2 images are typically smaller than
 raw images. Smaller images mean faster uploads, so it is often
 faster to convert a raw image to qcow2 for uploading instead of
 uploading the raw file directly.

 .. note::

    Because raw images do not support snapshots, OpenStack Compute
    will automatically convert raw image files to qcow2 as needed.

Raw
 The ``raw`` image format is the simplest one, and is natively
 supported by both KVM and Xen hypervisors.
 You can think of a raw image as being the bit-equivalent of
 a block device file, created as if somebody had copied, say,
 ``/dev/sda`` to a file using the :command:`dd` command.

 .. note::

    We do not recommend creating raw images by dd'ing block device
    files, we discuss how to create raw images later.

UEC tarball
 A UEC (Ubuntu Enterprise Cloud) tarball is a gzipped tarfile that
 contains an AMI file, AKI file, and ARI file.

 .. note::

    Ubuntu Enterprise Cloud refers to a discontinued Eucalyptus-based
    Ubuntu cloud solution that has been replaced by the OpenStack-based
    Ubuntu Cloud Infrastructure.

VDI
 VirtualBox uses the
 `VDI <https://forums.virtualbox.org/viewtopic.php?t=8046>`_
 (Virtual Disk Image) format for image files. None of the OpenStack Compute
 hypervisors support VDI directly, so you will need to convert these files
 to a different format to use them with OpenStack.

VHD
 Microsoft Hyper-V uses the VHD (Virtual Hard Disk) format for images.

VHDX
 The version of Hyper-V that ships with Microsoft Server 2012 uses the newer
 `VHDX <http://technet.microsoft.com/en-us/library/hh831446.aspx>`_ format,
 which has some additional features over VHD such as support for larger disk
 sizes and protection against data corruption during power failures.

VMDK
 VMware ESXi hypervisor uses the
 `VMDK <https://developercenter.vmware.com/web/sdk/60/vddk>`_
 (Virtual Machine Disk) format for images.
