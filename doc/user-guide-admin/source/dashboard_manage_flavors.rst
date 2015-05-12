==============
Manage flavors
==============

In OpenStack, a flavor defines the compute, memory, and storage
capacity of a virtual server, also known as an instance. As an
administrative user, you can create, edit, and delete flavors.

The following table lists the default flavors.

============  =========  ===============  =============
 Flavor         VCPUs      Disk (in GB)     RAM (in MB)
============  =========  ===============  =============
 m1.tiny        1          1                512
 m1.small       1          20               2048
 m1.medium      2          40               4096
 m1.large       4          80               8192
 m1.xlarge      8          160              16384
============  =========  ===============  =============

Create flavors
~~~~~~~~~~~~~~

#. Log in to the dashboard.

   Choose the :guilabel:`admin` project from the drop-down
   list at the top of the page.
#. In the :guilabel:`Admin` tab, open the :guilabel:`System
   Panel` and click the :guilabel:`Flavors` category.
#. Click :guilabel:`Create Flavor`.
#. In the :guilabel:`Create Flavor` window, enter or select
   the parameters for the flavor.

   **Flavor info tab**

   =======================  =========================================
    **Name**                   Enter the flavor name.
    **ID**                     OpenStack generates the flavor ID.
    **VCPUs**                  Enter the number of virtual CPUs to
                               use.
    **RAM MB**                 Enter the amount of RAM to use, in
                               megabytes.
    **Root Disk GB**           Enter the amount of disk space in
                               gigabytes to use for the root (/)
                               partition.
    **Ephemeral Disk GB**      Enter the amount of disk space in
                               gigabytes to use for the ephemeral
                               partition. If unspecified, the value
                               is 0 by default.

                               Ephemeral disks offer machine local
                               disk storage linked to the life cycle
                               of a VM instance. When a VM is
                               terminated, all data on the ephemeral
                               disk is lost. Ephemeral disks are not
                               included in any snapshots.
    **Swap Disk MB**           Enter the amount of swap space (in
                               megabytes) to use. If unspecified,
                               the default is 0.
   =======================  =========================================

#. In the :guilabel:`Flavor Access` tab, you can control access to
   the flavor by moving projects from the :guilabel:`All Projects`
   column to the :guilabel:`Selected Projects` column.

   Only projects in the :guilabel:`Selected Projects` column can
   use the flavor. If there are no projects in the right column,
   all projects can use the flavor.
#. Click :guilabel:`Create Flavor`.

Update flavors
~~~~~~~~~~~~~~

#. Log in to the dashboard.

   Choose the :guilabel:`admin` project from the drop-down list at
   the top of the page.
#. In the :guilabel:`Admin tab`, open the :guilabel:`System Panel`
   and click the :guilabel:`Flavors` category.
#. Select the flavor that you want to edit. Click :guilabel:`Edit
   Flavor`.
#. In the :guilabel:`Edit Flavor` window, you can change the flavor
   name, VCPUs, RAM, root disk, ephemeral disk, and swap disk values.
#. Click :guilabel:`Save`.

Delete flavors
~~~~~~~~~~~~~~

#. Log in to the dashboard.

   Choose the :guilabel:`admin` project from the drop-down list at
   the top of the page.
#. In the :guilabel:`Admin tab`, open the :guilabel:`System Panel`
   and click the :guilabel:`Flavors` category.
#. Select the flavors that you want to delete.
#. Click :guilabel:`Delete Flavors`.
#. In the :guilabel:`Confirm Delete Flavors` window, click
   :guilabel:`Delete Flavors` to confirm the deletion. You cannot
   undo this action.
