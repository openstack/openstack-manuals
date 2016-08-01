=============
Image service
=============

.. toctree::

   common/get-started-image-service.rst
   glance-install.rst
   glance-verify.rst

The Image service (glance) enables users to discover,
register, and retrieve virtual machine images. It offers a
:term:`REST <RESTful>` API that enables you to query virtual
machine image metadata and retrieve an actual image.
You can store virtual machine images made available through
the Image service in a variety of locations, from simple file
systems to object-storage systems like OpenStack Object Storage.

.. important::

   For simplicity, this guide describes configuring the Image service to
   use the ``file`` back end, which uploads and stores in a
   directory on the controller node hosting the Image service. By
   default, this directory is ``/var/lib/glance/images/``.

   Before you proceed, ensure that the controller node has at least
   several gigabytes of space available in this directory.

   For information on requirements for other back ends, see
   `Configuration Reference <http://docs.openstack.org/mitaka/config-reference/image-service.html>`__.
