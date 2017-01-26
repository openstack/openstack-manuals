.. _environment-ntp-verify:

Verify operation
~~~~~~~~~~~~~~~~

We recommend that you verify NTP synchronization before proceeding
further. Some nodes, particularly those that reference the controller
node, can take several minutes to synchronize.

#. Run this command on the *controller* node:

   .. code-block:: console

    # chronyc sources

      210 Number of sources = 2
      MS Name/IP address         Stratum Poll Reach LastRx Last sample
      ===============================================================================
      ^- 192.0.2.11                    2   7    12   137  -2814us[-3000us] +/-   43ms
      ^* 192.0.2.12                    2   6   177    46    +17us[  -23us] +/-   68ms

   .. end

   Contents in the *Name/IP address* column should indicate the hostname or IP
   address of one or more NTP servers. Contents in the *MS* column should indicate
   *\** for the server to which the NTP service is currently synchronized.

#. Run the same command on *all other* nodes:

   .. code-block:: console

    # chronyc sources

      210 Number of sources = 1
      MS Name/IP address         Stratum Poll Reach LastRx Last sample
      ===============================================================================
      ^* controller                    3    9   377   421    +15us[  -87us] +/-   15ms

   .. end

   Contents in the *Name/IP address* column should indicate the hostname of the
   controller node.
