===============================================
Migrate single instance to another compute host
===============================================

When you want to move an instance from one compute host to another,
you can use the :command:`nova migrate` command. The scheduler chooses the
destination compute host based on its settings. This process does
not assume that the instance has shared storage available on the
target host.

#. To list the VMs you want to migrate, run:

   .. code-block:: console

      $ nova list

#. After selecting a VM from the list, run this command where :guilabel:`VM_ID`
   is set to the ID in the list returned in the previous step:

   .. code-block:: console

      $ nova show VM_ID

#. Now, use the :command:`nova migrate` command.

   .. code-block:: console

      $ nova migrate VM_ID

#. To migrate an instance and watch the status, use this example script:

   .. code-block:: bash

      #!/bin/bash

      # Provide usage
      usage() {
      echo "Usage: $0 VM_ID"
      exit 1
      }

      [[ $# -eq 0 ]] && usage

      # Migrate the VM to an alternate hypervisor
      echo -n "Migrating instance to alternate host"
      VM_ID=$1
      nova migrate $VM_ID
      VM_OUTPUT=`nova show $VM_ID`
      VM_STATUS=`echo "$VM_OUTPUT" | grep status | awk '{print $4}'`
      while [[ "$VM_STATUS" != "VERIFY_RESIZE" ]]; do
      echo -n "."
      sleep 2
      VM_OUTPUT=`nova show $VM_ID`
      VM_STATUS=`echo "$VM_OUTPUT" | grep status | awk '{print $4}'`
      done
      nova resize-confirm $VM_ID
      echo " instance migrated and resized."
      echo;

      # Show the details for the VM
      echo "Updated instance details:"
      nova show $VM_ID

      # Pause to allow users to examine VM details
      read -p "Pausing, press <enter> to exit."

.. note::

   If you see this error, it means you are either
   trying the command with the wrong credentials,
   such as a non-admin user, or the ``policy.json``
   file prevents migration for your user:

   ``ERROR (Forbidden): Policy doesn't allow compute_extension:admin_actions:migrate
   to be performed. (HTTP 403)``

The instance is booted from a new host, but preserves its configuration
including its ID, name, any metadata, IP address, and other properties.
