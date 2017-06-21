OpenStack packages
~~~~~~~~~~~~~~~~~~

Distributions release OpenStack packages as part of the distribution or
using other methods because of differing release schedules. Perform
these procedures on all nodes.

.. note::

   The set up of OpenStack packages described here needs to be done on
   all nodes: controller, compute, and Block Storage nodes.

.. warning::

   Your hosts must contain the latest versions of base installation
   packages available for your distribution before proceeding further.

.. note::

   Disable or remove any automatic update services because they can
   impact your OpenStack environment.

.. toctree::
   :glob:

   environment-packages-*
