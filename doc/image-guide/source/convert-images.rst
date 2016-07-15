================================
Converting between image formats
================================

Converting images from one format to another is generally straightforward.

qemu-img convert: raw, qcow2, qed, vdi, vmdk, vhd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The :command:`qemu-img convert` command can do conversion
between multiple formats, including ``qcow2``, ``qed``,
``raw``, ``vdi``, ``vhd``, and ``vmdk``.

.. list-table:: qemu-img format strings
   :header-rows: 1

   * - Image format
     - Argument to qemu-img
   * - QCOW2 (KVM, Xen)
     - ``qcow2``
   * - QED (KVM)
     - ``qed``
   * - raw
     - ``raw``
   * - VDI (VirtualBox)
     - ``vdi``
   * - VHD (Hyper-V)
     - ``vpc``
   * - VMDK (VMware)
     - ``vmdk``

This example will convert a raw image file named ``image.img``
to a qcow2 image file.

.. code-block:: console

   $ qemu-img convert -f raw -O qcow2 image.img image.qcow2

Run the following command to convert a vmdk image file to a raw image file.

.. code-block:: console

   $ qemu-img convert -f vmdk -O raw image.vmdk image.img

Run the following command to convert a vmdk image file to a qcow2 image file.

.. code-block:: console

   $ qemu-img convert -f vmdk -O qcow2 image.vmdk image.qcow2

.. note::

   The ``-f format`` flag is optional. If omitted, ``qemu-img``
   will try to infer the image format.

   When converting an image file with Windows, ensure the virtio
   driver is installed.
   Otherwise, you will get a blue screen when launching the image
   due to lack of the virtio driver.
   Another option is to set the image properties as below when you
   update the image in the Image service to avoid this issue,
   but it will reduce virtual machine performance significantly.

   .. code-block:: console

      $ openstack image set --property hw_disk_bus='ide' image_name_or_id

VBoxManage: VDI (VirtualBox) to raw
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you've created a VDI image using VirtualBox, you can convert
it to raw format using the ``VBoxManage`` command-line tool
that ships with VirtualBox. On Mac OS X, and Linux, VirtualBox
stores images by default in the ``~/VirtualBox VMs/`` directory.
The following example creates a raw image in the current directory
from a VirtualBox VDI image.

.. code-block:: console

   $ VBoxManage clonehd ~/VirtualBox\ VMs/image.vdi image.img --format raw
