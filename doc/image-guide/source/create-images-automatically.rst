===============================
Tool support for image creation
===============================

There are several tools that are designed to automate image creation.

Diskimage-builder
~~~~~~~~~~~~~~~~~

`Diskimage-builder <https://docs.openstack.org/diskimage-builder/latest/>`_
is an automated disk image creation tool that supports a variety
of distributions and architectures.
Diskimage-builder (DIB) can build images for Fedora, Red Hat
Enterprise Linux, Ubuntu, Debian, CentOS, and openSUSE.
DIB is organized in a series of elements that build on top of
each other to create specific images.

To build an image, call the following script:

.. code-block:: console

   # disk-image-create ubuntu vm

This example creates a generic, bootable Ubuntu image of the latest release.

Further customization could be accomplished by setting environment
variables or adding elements to the command-line:

.. code-block:: console

   # disk-image-create -a armhf ubuntu vm

This example creates the image as before, but for arm architecture.
More elements are available in the `git source directory
<https://git.openstack.org/cgit/openstack/diskimage-builder/tree/elements>`_
and documented in the `diskimage-builder elements documentation
<https://docs.openstack.org/diskimage-builder/latest/elements.html>`_.

Oz
~~

`Oz <https://github.com/clalancette/oz/wiki>`_ is a command-line tool
that automates the process of creating a virtual machine image file.
Oz is a Python app that interacts with KVM to step through the process
of installing a virtual machine.

It uses a predefined set of kickstart (Red Hat-based systems) and
preseed files (Debian-based systems) for operating systems that it
supports, and it can also be used to create Microsoft Windows images.

A full treatment of Oz is beyond the scope of this document,
but we will provide an example. You can find additional examples of
Oz template files on GitHub at `rcbops/oz-image-build/tree/master/templates
<https://github.com/rcbops/oz-image-build/tree/master/templates>`_.
Here's how you would create a CentOS 6.4 image with Oz.

Create a template file called ``centos64.tdl`` with
the following contents. The only entry you will need to
change is the ``<rootpw>`` contents.

.. code-block:: xml

   <template>
     <name>centos64</name>
     <os>
       <name>CentOS-6</name>
       <version>4</version>
       <arch>x86_64</arch>
       <install type='iso'>
         <iso>http://mirror.rackspace.com/CentOS/6/isos/x86_64/CentOS-6.4-x86_64-bin-DVD1.iso</iso>
       </install>
       <rootpw>CHANGE THIS TO YOUR ROOT PASSWORD</rootpw>
     </os>
     <description>CentOS 6.4 x86_64</description>
     <repositories>
       <repository name='epel-6'>
         <url>http://download.fedoraproject.org/pub/epel/6/$basearch</url>
         <signed>no</signed>
       </repository>
     </repositories>
     <packages>
       <package name='epel-release'/>
       <package name='cloud-utils'/>
       <package name='cloud-init'/>
     </packages>
     <commands>
       <command name='update'>
   yum -y update
   yum clean all
   sed -i '/^HWADDR/d' /etc/sysconfig/network-scripts/ifcfg-eth0
   echo -n > /etc/udev/rules.d/70-persistent-net.rules
   echo -n > /lib/udev/rules.d/75-persistent-net-generator.rules
       </command>
     </commands>
   </template>

This Oz template specifies where to download the Centos 6.4 install ISO.
Oz will use the version information to identify which kickstart file to use.
In this case, it will be `RHEL6.auto
<https://github.com/clalancette/oz/blob/master/oz/auto/RHEL6.auto>`_.
It adds EPEL as a repository and install the ``epel-release``,
``cloud-utils``, and ``cloud-init`` packages, as specified in the
``packages`` section of the file.

After Oz completes the initial OS install using the kickstart file,
it customizes the image with an update. It also removes any reference
to the eth0 device that libvirt creates while Oz does the customizing,
as specified in the ``command`` section of the XML file.

To run this:

.. code-block:: console

   # oz-install -d3 -u centos64.tdl -x centos64-libvirt.xml

* The ``-d3`` flag tells Oz to show status information as it runs.
* The ``-u`` tells Oz to do the customization (install extra packages,
  run the commands) once it does the initial install.
* The ``-x`` flag tells Oz what filename to use to write out
  a libvirt XML file (otherwise it will default to something
  like ``centos64Apr_03_2013-12:39:42``).

If you leave out the ``-u`` flag, or you want to edit the file
to do additional customizations, you can use the :command:`oz-customize`
command, using the libvirt XML file that :command:`oz-install` creates.
For example:

.. code-block:: console

   # oz-customize -d3 centos64.tdl centos64-libvirt.xml

Oz will invoke libvirt to boot the image inside of KVM,
then Oz will ssh into the instance and perform the customizations.

VeeWee
~~~~~~

`VeeWee <https://github.com/jedi4ever/veewee>`_ is often used
to build `Vagrant <http://vagrantup.com>`_ boxes,
but it can also be used to build the KVM images.

Packer
~~~~~~

`Packer <https://packer.io>`_ is a tool for creating machine
images for multiple platforms from a single source configuration.

image-bootstrap
~~~~~~~~~~~~~~~

`image-bootstrap <https://github.com/hartwork/image-bootstrap>`_
is a command line tool that generates bootable virtual machine images
with support of Arch, Debian, Gentoo, Ubuntu, and is prepared for use
with OpenStack.

imagefactory
~~~~~~~~~~~~

`imagefactory <http://imgfac.org/>`_ is a newer tool designed
to automate the building, converting, and uploading images
to different cloud providers. It uses Oz as its back-end and
includes support for OpenStack-based clouds.

KIWI
~~~~

The `KIWI OS image builder <http://github.com/openSUSE/kiwi>`_
provides an operating system image builder for various Linux supported
hardware platforms as well as for virtualization and cloud systems. It
allows building of images based on openSUSE, SUSE Linux Enterprise,
and Red Hat Enterprise Linux. The `openSUSE Documentation
<https://doc.opensuse.org/#kiwi-doc>`_ explains how to use KIWI.

SUSE Studio
~~~~~~~~~~~

`SUSE Studio <http://susestudio.com>`_ is a web application
for building and testing software applications in a web browser.
It supports the creation of physical, virtual or cloud-based
applications and includes support for building images for OpenStack
based clouds using SUSE Linux Enterprise and openSUSE as distributions.

virt-builder
~~~~~~~~~~~~

`Virt-builder <http://libguestfs.org/virt-builder.1.html>`_ is a tool for
quickly building new virtual machines. You can build a variety of VMs for
local or cloud use, usually within a few minutes or less. Virt-builder also
has many ways to customize these VMs. Everything is run from the command line
and nothing requires root privileges, so automation and scripting is simple.

To build an image, call the following script:

.. code-block:: console

   # virt-builder fedora-23 -o image.qcow2 --format qcow2 \
     --update --selinux-relabel --size 20G

To list the operating systems available to install:

.. code-block:: console

   $ virt-builder --list

To import it into libvirt with :command:`virsh`:

.. code-block:: console

   # virt-install --name fedora --ram 2048 \
     --disk path=image.qcow2,format=qcow2 --import

openstack-debian-images
~~~~~~~~~~~~~~~~~~~~~~~

`openstack-debian-images <https://packages.debian.org/openstack-debian-images>`_
is the tool Debian uses to create its official OpenStack image. It is made of
a single very simple shell script that is easy to understand and modify.
It supports Grub and Syslinux, BIOS or EFI, amd64 and arm64 arch.

openstack-debian-images can also be used to create a bootable image directly
on a hard disk, instead of using the Debian installer.

To build an image, type this:

.. code-block:: console

   # build-openstack-debian-image --release stretch

More parameters can be added to further customize the image:

.. code-block:: console

   # build-openstack-debian-image --release stretch \
     --hook-script /root/my-hook-script.sh \
     --debootstrap-url http://ftp.fr.debian.org \
     --sources.list-mirror http://ftp.fr.debian.org \
     --login myusername \
     --extra-packages vim,emacs

The file ``/root/my-hook-script.sh`` will recieve 2 environment variable:
``BODI_CHROOT_PATH`` path where the image is mounted, and ``BODI_RELEASE``
which is the name of the Debian release that is being bootstraped. Here's
an example for customizing the motd:

.. code-block:: console

   # #!/bin/sh
     set -e
     echo "My message" >${BODI_CHROOT_PATH}/etc/motd

This hook script will conveniently be called at the correct moment of the
build process, when everything is installed, but before unmounting the
partition.
