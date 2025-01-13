==========
Get images
==========

.. contents:: :depth: 3

The simplest way to obtain a virtual machine image that works with
OpenStack is to download one that someone else has already
created. Most of the images contain the ``cloud-init`` package to
support the SSH key pair and user data injection.
Because many of the images disable SSH password authentication
by default, boot the image with an injected key pair.
You can ``SSH`` into the instance with the private key and default
login account. See `Configure access and security for instances
<https://docs.openstack.org/horizon/latest/user/configure-access-and-security-for-instances.html>`_
for more information on how to create and inject key pairs with OpenStack.

AlmaLinux
~~~~~~~~~

AlmaLinux provides cloud images for download, more detail on the
`get AlmaLinux project page
<https://almalinux.org/get-almalinux/#Cloud_Images>`_

.. note::

   In an Almalinux cloud image, the login account is ``almalinux``.

Alpine Linux
~~~~~~~~~~~~

Alpine Linux provides cloud images for download, more detail on the
`Alpine Linux cloud page
<https://alpinelinux.org/cloud/>`_

.. note::

   In an Alpine Linux cloud image, the login account is ``alpine``.

Arch Linux
~~~~~~~~~~

Arch Linux provides a cloud image for download. More details can be found on
the `arch-boxes project page
<https://gitlab.archlinux.org/archlinux/arch-boxes/>`_.

.. note::

   In an Arch Linux image, the login account is ``arch``.

BSD: DragonFlyBSD, FreeBSD, NetBSD, OpenBSD
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Unofficial images for BSD are available on `BSD-Cloud-Image.org <https://bsd-cloud-image.org/>`_.

.. note::

   The login accounts are ``freebsd`` for FreeBSD, ``openbsd`` for OpenBSD,
   and ``netbsd`` for NetBSD.

CentOS
~~~~~~

The CentOS project maintains official images for direct download:

* `CentOS 9 Stream images <https://cloud.centos.org/centos/9-stream/>`_
* `CentOS 10 Stream images <https://cloud.centos.org/centos/10-stream/>`_

.. note::

   In a CentOS cloud image, the login account is ``cloud-user``.

CirrOS (test)
~~~~~~~~~~~~~

CirrOS is a minimal Linux distribution that was designed for use
as a test image on clouds such as OpenStack Compute.
You can download a CirrOS image in various formats from the
`CirrOS download page <https://download.cirros-cloud.net>`_.

If your deployment uses QEMU or KVM, we recommend using the images
in qcow2 format. The most recent 64-bit qcow2 image as of this
writing is `cirros-0.6.2-x86_64-disk.img
<https://download.cirros-cloud.net/0.6.2/cirros-0.6.2-x86_64-disk.img>`_.

.. note::

   In a CirrOS image, the login account is ``cirros``.
   The password is ``gocubsgo``. Since the fixed PW allows anyone to
   login, you should not run this image with a public IP attached.

Debian
~~~~~~

`Debian provides images for direct download
<https://cdimage.debian.org/images/cloud/>`_.
They are made at the same time as the CD and DVD images of Debian.
Therefore, images are available on each point release of Debian. Also,
weekly images of the testing distribution are available.

.. note::

   In a Debian image, the login account is ``debian``.

Fedora
~~~~~~

The Fedora project maintains a list of official cloud images at
`Fedora download page <https://alt.fedoraproject.org/cloud/>`_.

.. note::

   In a Fedora cloud image, the login account is ``fedora``.

Kali Linux
~~~~~~~~~~~~

Kali Linux provides cloud images for download at the
`Get Kali/Cloud page.
<https://www.kali.org/get-kali/#kali-cloud>`_
See also the page `Common Cloud Based Setup Information
<https://www.kali.org/docs/troubleshooting/common-cloud-setup/>`_
for cloud setup information.

.. note::

   In a Kali Linux cloud image, the login account is ``kali``.

Microsoft Windows
~~~~~~~~~~~~~~~~~

Cloudbase Solutions provides the last available trial version
of `Windows Server 2012 R2 <https://cloudbase.it/windows-cloud-images/>`_.
This image includes cloudbase-init plus VirtIO drivers on KVM.
You can build your own image based on Windows Server 2016, 2019,
Windows 10 etc) with `Cloudbase Imaging Tools <https://github.com/cloudbase/windows-openstack-imaging-tools/>`_.

ISO files for Windows 10 are available on `Microsoft Windows 10 Downloadpage <https://www.microsoft.com/en-us/software-download/windows10>`_
and `Microsoft Evaluation Center <https://www.microsoft.com/evalcenter/evaluate-windows-10-enterprise>`_.

`Fedora Virtio <https://docs.fedoraproject.org/en-US/quick-docs/creating-windows-virtual-machines-using-virtio-drivers/index.html#virtio-win-direct-downloads>`_
provides also Windows images.

openSUSE and SUSE Linux Enterprise Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The openSUSE community provides images for `openSUSE
<https://get.opensuse.org/leap>`_ under ``Alternative Downloads / Cloud image``

SUSE maintains official SUSE Linux Enterprise Server cloud images.
Go to the `SUSE Linux Enterprise Server download page
<https://www.suse.com/download/sles/>`_, select the ``AMD64 / Intel 64``
architecture and search for ``Cloud``.

.. note::

   In an openSUSE cloud image, the login account is ``opensuse``.

Red Hat Enterprise Linux
~~~~~~~~~~~~~~~~~~~~~~~~

Red Hat maintains official Red Hat Enterprise Linux cloud images. A valid Red
Hat Enterprise Linux subscription is required to download these images.

* `Red Hat Enterprise Linux 7 KVM Guest Image
  <https://access.redhat.com/downloads/content/69/ver=/rhel---7/x86_64/product-downloads>`_
* `Red Hat Enterprise Linux 8 KVM Guest Image
  <https://access.redhat.com/downloads/content/479/ver=/rhel---8/x86_64/product-downloads>`_
* `Red Hat Enterprise Linux 9 KVM Guest Image
  <https://access.redhat.com/downloads/content/479/ver=/rhel---9/x86_64/product-downloads>`_

.. note::

   In a RHEL cloud image, the login account is ``cloud-user``.

Rocky Linux
~~~~~~~~~~~

Rocky Linux provides cloud images for download, more detail on the
`Rocky Linux download page
<https://rockylinux.org/download>`_

.. note::

   In an Rocky Linux cloud image, the login account is ``rocky``.

Ubuntu
~~~~~~

Canonical maintains an official set of `Ubuntu-based images
<https://cloud-images.ubuntu.com/>`_.

Images are arranged by Ubuntu release, and by image release date,
with ``current`` being the most recent.
For example, the page that contains the most recently built image for
Ubuntu 24.04 Noble Numbat is `Ubuntu 24.04 LTS (Noble Numbat) Daily Build
<https://cloud-images.ubuntu.com/noble/current/>`_.
Scroll to the bottom of the page for links to the images that can be
downloaded directly.

If your deployment uses QEMU or KVM, we recommend using the images
in qcow2 format, with name ending in ``.img``.
The most recent version of the 64-bit amd64-arch QCOW2 image for
Ubuntu 24.04 is
`noble-server-cloudimg-amd64.img
<https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img>`_.

.. note::

   In an Ubuntu cloud image, the login account is ``ubuntu``.
