=============================
Appendix A. Reserved user IDs
=============================

OpenStack reserves certain user IDs to run specific services and own
specific files. These user IDs are set up according to the distribution
packages. The following table gives an overview.

.. note::

   Some OpenStack packages generate and assign user IDs automatically
   during package installation. In these cases, the user ID value is
   not important. The existence of the user ID is what matters.

.. list-table:: **Reserved user IDs**
   :header-rows: 1
   :widths: 10 20 15

   * - Name
     - Description
     - ID
   * - ceilometer
     - OpenStack ceilometer daemons
     - .. only:: ubuntu or obs

          Assigned during package installation

       .. only:: rdo

          166
   * - cinder
     - OpenStack cinder daemons
     - .. only:: ubuntu or obs

          Assigned during package installation

       .. only:: rdo

          165
   * - glance
     - OpenStack glance daemons
     - .. only:: ubuntu or obs

          Assigned during package installation

       .. only:: rdo

          161
   * - heat
     - OpenStack heat daemons
     - .. only:: ubuntu or obs

          Assigned during package installation

       .. only:: rdo

          187
   * - keystone
     - OpenStack keystone daemons
     - .. only:: ubuntu or obs

          Assigned during package installation

       .. only:: rdo

          163
   * - neutron
     - OpenStack neutron daemons
     - .. only:: ubuntu or obs

          Assigned during package installation

       .. only:: rdo

          164
   * - nova
     - OpenStack nova daemons
     - .. only:: ubuntu or obs

          Assigned during package installation

       .. only:: rdo

          162
   * - swift
     - OpenStack swift daemons
     - .. only:: ubuntu or obs

          Assigned during package installation

       .. only:: rdo

          160
   * - trove
     - OpenStack trove daemons
     - Assigned during package installation

Each user belongs to a user group with the same name as the user.
