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
login account. See the `OpenStack End User Guide
<https://docs.openstack.org/user-guide/configure-access-and-security-for-instances.html>`_
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
writing is `cirros-0.3.4-x86_64-disk.img
<http://download.cirros-cloud.net/0.3.4/cirros-0.3.4-x86_64-disk.img>`_.

.. note::

   In a CirrOS image, the login account is ``cirros``.
   The password is ``cubswin:)``.

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
`Fedora download page <https://getfedora.org/cloud/download/>`_.

.. note::

   In a Fedora cloud image, the login account is ``fedora``.

Microsoft Windows
~~~~~~~~~~~~~~~~~

Cloudbase Solutions hosts `Windows Cloud Images
<https://cloudbase.it/windows-cloud-images/>`_
that runs on Hyper-V, KVM, and XenServer/XCP.

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
<http://download.opensuse.org/repositories/Cloud:/Images:/>`_.

SUSE maintains official SUSE Linux Enterprise Server cloud images.
A valid SUSE Linux Enterprise Server subscription is required to
download these images.

* `SUSE Linux Enterprise Server 12 SP1 JeOS
  <https://www.suse.com/products/server/jeos>`_

For openSUSE and SUSE Linux Enterprise Server (SLES), custom images can also
be built with a web-based tool called `SUSE Studio <https://susestudio.com>`_.

Red Hat Enterprise Linux
~~~~~~~~~~~~~~~~~~~~~~~~

Red Hat maintains official Red Hat Enterprise Linux cloud images.
A valid Red Hat Enterprise Linux subscription is required to
download these images.

* `Red Hat Enterprise Linux 7 KVM Guest Image
  <https://access.redhat.com/downloads/content/69/ver=/rhel---7/x86_64/product-downloads>`_
* `Red Hat Enterprise Linux 6 KVM Guest Image
  <https://rhn.redhat.com/rhn/software/channel/downloads/Download.do?cid=16952>`_

.. note::

   In a RHEL cloud image, the login account is ``cloud-user``.
