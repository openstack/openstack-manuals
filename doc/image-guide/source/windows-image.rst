================================
Example: Microsoft Windows image
================================

This example creates a Windows Server 2012 qcow2 image,
using the :command:`virt-install` command and the KVM hypervisor.

#. Follow these steps to prepare the installation:

   #. Download a Windows Server 2012 installation ISO.
      Evaluation images are available on the `Microsoft website
      <http://www.microsoft.com/en-us/evalcenter/
      evaluate-windows-server-2012>`_ (registration required).
   #. Download the signed VirtIO drivers ISO from the `Fedora website
      <https://docs.fedoraproject.org/en-US/quick-docs/creating-windows-virtual-machines-using-virtio-drivers/index.html>`_.
   #. Create a 15 GB qcow2 image:

      .. code-block:: console

         $ qemu-img create -f qcow2 ws2012.qcow2 15G

#. Start the Windows Server 2012 installation with the
   :command:`virt-install` command:

   .. code-block:: console

      # virt-install --connect qemu:///system \
        --name ws2012 --ram 2048 --vcpus 2 \
        --network network=default,model=virtio \
        --disk path=ws2012.qcow2,format=qcow2,device=disk,bus=virtio \
        --cdrom /path/to/en_windows_server_2012_x64_dvd.iso \
        --disk path=/path/to/virtio-win-0.1-XX.iso,device=cdrom \
        --vnc --os-type windows --os-variant win2k12 \
        --os-distro windows --os-version 2012

   Use :command:`virt-manager` or :command:`virt-viewer` to
   connect to the VM and start the Windows installation.

#. Enable the VirtIO drivers. By default, the Windows installer does not detect
   the disk.

#. Load VirtIO SCSI drivers and  network drivers by choosing an installation
   target when prompted. Click :guilabel:`Load driver` and browse the file
   system.

#. Select the ``E:\virtio-win-0.1XX\viostor\2k12\amd64`` folder. The Windows
   installer displays a list of drivers to install.

#. Select the VirtIO SCSI drivers.

#. Click :guilabel:`Load driver` and browse the file system, and
   select the ``E:\NETKVM\2k12\amd64`` folder.

#. Select the network drivers, and continue the installation. Once the
   installation is completed, the VM restarts.

#. Define a password for the administrator when prompted.

#. Log in as administrator and start a command window.

#. Complete the VirtIO drivers installation by running the
   following command:

   .. code-block:: console

      C:\pnputil -i -a E:\virtio-win-0.1XX\viostor\2k12\amd64\*.INF

#. To allow the :term:`Cloudbase-Init` to run scripts during an instance
   boot, set the PowerShell execution policy to be unrestricted:

   .. code-block:: console

      C:\powershell
      C:\Set-ExecutionPolicy Unrestricted

#. Download and install the ``Cloudbase-Init``:

   .. code-block:: console

      C:\Invoke-WebRequest -UseBasicParsing https://cloudbase.it/downloads/CloudbaseInitSetup_Stable_x64.msi -OutFile cloudbaseinit.msi
      C:\.\cloudbaseinit.msi

   In the :guilabel:`configuration options` window,
   change the following settings:

   * Username: ``Administrator``
   * Network adapter to configure: ``Red Hat VirtIO Ethernet Adapter``
   * Serial port for logging: ``COM1``

   When the installation is done, in the
   :guilabel:`Complete the Cloudbase-Init Setup Wizard` window,
   select the :guilabel:`Run Sysprep` and :guilabel:`Shutdown`
   check boxes and click :guilabel:`Finish`.

   Wait for the machine shutdown.

Your image is ready to upload to the Image service:

.. code-block:: console

   $ openstack image create --disk-format qcow2 --file ws2012.qcow2 WS2012
