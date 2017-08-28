.. _environment-ntp:

Network Time Protocol (NTP)
~~~~~~~~~~~~~~~~~~~~~~~~~~~

To properly synchronize services among nodes, you can install Chrony, an
implementation of :term:`NTP <Network Time Protocol (NTP)>`. We recommend that
you configure the controller node to reference more accurate (lower stratum)
servers and other nodes to reference the controller node.

.. toctree::
   :maxdepth: 1

   environment-ntp-controller.rst
   environment-ntp-other.rst
   environment-ntp-verify.rst
