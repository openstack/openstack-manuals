==========
Get images
==========

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

CentOS
~~~~~~

The CentOS project maintains official images for direct download.

* `CentOS 6 images <http://cloud.centos.org/centos/6/images/>`_
* `CentOS 7 images <http://cloud.centos.org/centos/7/images/>`_

.. note::

   In a CentOS cloud image, the login account is ``centos``.

CirrOS (test)
~~~~~~~~~~~~~

CirrOS is a minimal Linux distribution that was designed for use
as a test image on clouds such as OpenStack Compute.
You can download a CirrOS image in various formats from the
`CirrOS download page <http://download.cirros-cloud.net>`_.

If your deployment uses QEMU or KVM, we recommend using the images
in qcow2 format. The most recent 64-bit qcow2 image as of this
writing is `cirros-0.4.0-x86_64-disk.img
<http://download.cirros-cloud.net/0.4.0/cirros-0.4.0-x86_64-disk.img>`_.

.. note::

   In a CirrOS image, the login account is ``cirros``.
   The password is ``gocubsgo``.

Debian
~~~~~~

`Debian provides images for direct download
<http://cdimage.debian.org/cdimage/openstack/>`_.
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

Ubuntu
~~~~~~

Canonical maintains an official set of `Ubuntu-based images
<http://cloud-images.ubuntu.com/>`_.

Images are arranged by Ubuntu release, and by image release date,
with ``current`` being the most recent.
For example, the page that contains the most recently built image for
Ubuntu 16.04 Xenial Xerus is `Ubuntu 16.04 LTS (Xenial Xerus) Daily Build
<https://cloud-images.ubuntu.com/xenial/current/>`_.
Scroll to the bottom of the page for links to the images that can be
downloaded directly.

If your deployment uses QEMU or KVM, we recommend using the images
in qcow2 format.
The most recent version of the 64-bit QCOW2 image for Ubuntu 16.04 is
`xenial-server-cloudimg-amd64-disk1.img
<http://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-disk1.img>`_.

.. note::

   In an Ubuntu cloud image, the login account is ``ubuntu``.

openSUSE and SUSE Linux Enterprise Server
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The openSUSE community provides images for `openSUSE
<https://software.opensuse.org/distributions/leap#jeos-ports>`_.

SUSE maintains official SUSE Linux Enterprise Server cloud images.
Go to `download.suse.com <https://download.suse.com>`_ and search
for ``SUSE Linux Enterprise Server 15 JeOS``.

.. note::

   In an openSUSE cloud image, the login account is ``opensuse``.

Red Hat Enterprise Linux
~~~~~~~~~~~~~~~~~~~~~~~~

Red Hat maintains official Red Hat Enterprise Linux cloud images. A valid Red
Hat Enterprise Linux subscription is required to download these images.

* `Red Hat Enterprise Linux 7 KVM Guest Image
  <https://access.redhat.com/downloads/content/69/ver=/rhel---7/x86_64/product-downloads>`_
* `Red Hat Enterprise Linux 6 KVM Guest Image
  <https://access.redhat.com/downloads/content/69/ver=/rhel---6/x86_64/product-downloads>`_

.. note::

   In a RHEL cloud image, the login account is ``cloud-user``.
