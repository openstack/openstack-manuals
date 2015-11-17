==========
Get images
==========

The simplest way to obtain a virtual machine image that works with
OpenStack is to download one that someone else has already created.
Most of the images contain the ``cloud-init`` package to support
SSH key pair and user data injection.
Because many of the images disable SSH password authentication
by default, boot the image with an injected key pair.
You can SSH into the instance with the private key and default
login account. See the `OpenStack End User Guide
<http://docs.openstack.org/user-guide>`_ for more information
on how to create and inject key pairs with OpenStack.

CentOS images
~~~~~~~~~~~~~

The CentOS project maintains official images for direct download.

* `CentOS 6 images <http://cloud.centos.org/centos/6/images/>`_
* `CentOS 7 images <http://cloud.centos.org/centos/7/images/>`_

.. note::

   In a CentOS cloud image, the login account is ``centos``.

CirrOS (test) images
~~~~~~~~~~~~~~~~~~~~

CirrOS is a minimal Linux distribution that was designed for use
as a test image on clouds such as OpenStack Compute.
You can download a CirrOS image in various formats from the
`CirrOS download page <https://download.cirros-cloud.net>`_.

If your deployment uses QEMU or KVM, we recommend using the images
in qcow2 format. The most recent 64-bit qcow2 image as of this
writing is `cirros-0.3.4-x86_64-disk.img
<http://download.cirros-cloud.net/0.3.4/cirros-0.3.4-x86_64-disk.img>`_.

.. note::

   In a CirrOS image, the login account is ``cirros``.
   The password is ``cubswin:)``.

Official Ubuntu images
~~~~~~~~~~~~~~~~~~~~~~

Canonical maintains an `official set of Ubuntu-based images
<http://cloud-images.ubuntu.com/>`_.

Images are arranged by Ubuntu release, and by image release date,
with ``current`` being the most recent.
For example, the page that contains the most recently built image for
Ubuntu 14.04 Trusty Tahr is http://cloud-images.ubuntu.com/trusty/current/.
Scroll to the bottom of the page for links to images that can be
downloaded directly.

If your deployment uses QEMU or KVM, we recommend using the images
in qcow2 format.
The most recent version of the 64-bit QCOW2 image for Ubuntu 14.04 is
`trusty-server-cloudimg-amd64-disk1.img <http://uec-images.ubuntu.com/
trusty/current/trusty-server-cloudimg-amd64-disk1.img>`_.

.. note::

   In an Ubuntu cloud image, the login account is ``ubuntu``.

Official Red Hat Enterprise Linux images
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Red Hat maintains official Red Hat Enterprise Linux cloud images.
A valid Red Hat Enterprise Linux subscription is required to
download these images.

* `Red Hat Enterprise Linux 7 KVM Guest Image <https://access.redhat.com/
  downloads/content/69/ver=/rhel---7/7.0/x86_64/product-downloads>`_
* `Red Hat Enterprise Linux 6 KVM Guest Image <https://rhn.redhat.com/
  rhn/software/channel/downloads/Download.do?cid=16952>`_

.. note::

   In a RHEL cloud image, the login account is ``cloud-user``.

Official Fedora images
~~~~~~~~~~~~~~~~~~~~~~

The Fedora project maintains a list of official cloud images at
https://getfedora.org/en/cloud/download/.

.. note::

   In a Fedora cloud image, the login account is ``fedora``.

Official openSUSE and SLES images
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SUSE provides images for `openSUSE
<http://download.opensuse.org/repositories/Cloud:/Images:/>`_.
For SUSE Linux Enterprise Server (SLES), custom images can be built with
a web-based tool called `SUSE Studio <http://susestudio.com>`_.
SUSE Studio can also be used to build custom openSUSE images.

Official Debian images
~~~~~~~~~~~~~~~~~~~~~~

Since January 2015, `Debian provides images for direct download
<http://cdimage.debian.org/cdimage/openstack/>`_.
They are now made at the same time as the CD and DVD images of Debian.
However, until Debian 8.0 (aka Jessie) is out, these images are the
weekly built images of the testing distribution.

If you wish to build your own images of Debian 7.0 (aka Wheezy, the
current stable release of Debian), you can use the package which is
used to build the official Debian images.
It is named ``openstack-debian-images``, and it provides a simple
script for building them.
This package is available in Debian Unstable, Debian Jessie,
and through the wheezy-backports repositories.
To produce a Wheezy image, simply run:

.. code-block:: console

   # build-openstack-debian-image -r wheezy

If building the image for Wheezy, packages like ``cloud-init``,
``cloud-utils`` or ``cloud-initramfs-growroot`` will be pulled
from wheezy-backports.
Also, the current version of ``bootlogd`` in Wheezy does not support
logging to multiple consoles, which is needed so that both the
OpenStack Dashboard console and the ``nova console-log`` console works.
However, a `fixed version is available from the non-official GPLHost
repository <http://archive.gplhost.com/debian/pool/juno-backports/
main/s/sysvinit/bootlogd_2.88dsf-41+deb7u2_amd64.deb>`_.
To install it on top of the image, it is possible to use the
``--hook-script`` option of the ``build-openstack-debian-image`` script,
with this kind of script as parameter:

.. code-block:: bash

   #!/bin/sh

   cp bootlogd_2.88dsf-41+deb7u2_amd64.deb ${BODI_CHROOT_PATH}
   chroot ${BODI_CHROOT_PATH} dpkg -i bootlogd_2.88dsf-41+deb7u2_amd64.deb
   rm ${BODI_CHROOT_PATH}/bootlogd_2.88dsf-41+deb7u2_amd64.deb

.. note::

   In a Debian image, the login account is ``admin``.

Official images from other Linux distributions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As of this writing, we are not aware of other distributions that
provide images for download.

Rackspace Cloud Builders (multiple distros) images
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Rackspace Cloud Builders maintains a list of pre-built images from
various distributions (Red Hat, CentOS, Fedora, Ubuntu).
Links to these images can be found at `rackerjoe/oz-image-build
on GitHub <https://github.com/rackerjoe/oz-image-build>`_.

Microsoft Windows images
~~~~~~~~~~~~~~~~~~~~~~~~

Cloudbase Solutions hosts an `OpenStack Windows Server 2012
Standard Evaluation image <http://www.cloudbase.it/ws2012r2/>`_
that runs on Hyper-V, KVM, and XenServer/XCP.
