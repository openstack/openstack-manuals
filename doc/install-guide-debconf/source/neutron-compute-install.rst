Install and configure compute node
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The compute node handles connectivity and :term:`security groups <security
group>` for instances.

Install the components
----------------------

.. code-block:: console

   # apt-get install neutron-linuxbridge-agent

   Respond to prompts for
   :doc:`database management <debconf/debconf-dbconfig-common>`
   (leave it not-configured, as compute nodes do not need database access),
   :doc:`Identity service credentials <debconf/debconf-keystone-authtoken>`,
   :doc:`service endpoint registration <debconf/debconf-api-endpoints>`,
   and :doc:`message broker credentials <debconf/debconf-rabbitmq>`.

.. end

Configure the common component
------------------------------

The Networking common component configuration includes the
authentication mechanism, message queue, and plug-in.

.. include:: shared/note_configuration_vary_by_distribution.rst

* Edit the ``/etc/neutron/neutron.conf`` file and complete the following
  actions:

  * In the ``[database]`` section, comment out any ``connection`` options
    because compute nodes do not directly access the database.

Configure networking options
----------------------------

Choose the same networking option that you chose for the controller node to
configure services specific to it. Afterwards, return here and proceed to
:ref:`neutron-compute-compute`.

.. toctree::
   :maxdepth: 1

   neutron-compute-install-option1.rst
   neutron-compute-install-option2.rst

.. _neutron-compute-compute:

Finalize installation
---------------------

#. Restart the Linux bridge agent:

   .. code-block:: console

      # service neutron-linuxbridge-agent restart

   .. end
