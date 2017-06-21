Other nodes
~~~~~~~~~~~

Other nodes reference the controller node for clock synchronization.
Perform these steps on all other nodes.

Install and configure components
--------------------------------

1. Install the packages:



.. code-block:: console

   # yum install chrony

.. end





2. Edit the ``/etc/chrony.conf`` file and comment out or remove all but one
   ``server`` key. Change it to reference the controller node:

   .. path /etc/chrony.conf
   .. code-block:: shell

      server controller iburst

   .. end

3. Start the NTP service and configure it to start when the system boots:

   .. code-block:: console

      # systemctl enable chronyd.service
      # systemctl start chronyd.service

   .. end

