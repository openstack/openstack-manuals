============================
Use the virt-manager X11 GUI
============================

If you plan to create a virtual machine image on a machine that
can run X11 applications, the simplest way to do so is to use
the :command:`virt-manager` GUI, which is installable as the
``virt-manager`` package on both Fedora-based and Debian-based systems.
This GUI has an embedded VNC client that will let you view and
interact with the guest's graphical console.

If you are building the image on a headless server, and
you have an X server on your local machine, you can launch
:command:`virt-manager` using ssh X11 forwarding to access the GUI.
Since virt-manager interacts directly with libvirt, you typically
need to be root to access it. If you can ssh directly in as root
(or with a user that has permissions to interact with libvirt), do:

.. code-block:: console

   $ ssh -X root@server virt-manager

If the account you use to ssh into your server does not have
permissions to run libvirt, but has sudo privileges, do:

.. code-block:: console

   $ ssh -X user@server
   $ sudo virt-manager

.. note::

   The ``-X`` flag passed to ssh will enable X11 forwarding over ssh.
   If this does not work, try replacing it with the ``-Y`` flag.

Click the :guilabel:`Create a new virtual machine` button at the top-left,
or go to :menuselection:`File --> New Virtual Machine`. Then, follow the
instructions.

.. figure:: figures/virt-manager.png
   :width: 100%

You will be shown a series of dialog boxes that will allow you
to specify information about the virtual machine.

.. note::

   When using qcow2 format images, you should check the option
   ``Customize configuration before install``, go to disk properties and
   explicitly select the :guilabel:`qcow2` format.
   This ensures the virtual machine disk size will be correct.
