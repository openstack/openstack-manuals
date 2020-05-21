OpenStack packages for SUSE
~~~~~~~~~~~~~~~~~~~~~~~~~~~

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


Enable the OpenStack repository
-------------------------------

* Enable the Open Build Service repositories based on your openSUSE or
  SLES version, and on the version of OpenStack you want to install:

  **On openSUSE for OpenStack Ussuri:**

  .. code-block:: console

     # zypper addrepo -f obs://Cloud:OpenStack:Ussuri/openSUSE_Leap_15.1 Ussuri

  **On openSUSE for OpenStack Train:**

  .. code-block:: console

     # zypper addrepo -f obs://Cloud:OpenStack:Train/openSUSE_Leap_15.0 Train

  **On openSUSE for OpenStack Stein:**

  .. code-block:: console

     # zypper addrepo -f obs://Cloud:OpenStack:Stein/openSUSE_Leap_15.0 Stein

  **On openSUSE for OpenStack Rocky:**

  .. code-block:: console

     # zypper addrepo -f obs://Cloud:OpenStack:Rocky/openSUSE_Leap_15.0 Rocky

  **On openSUSE for OpenStack Queens:**

  .. code-block:: console

     # zypper addrepo -f obs://Cloud:OpenStack:Queens/openSUSE_Leap_42.3 Queens

  **On openSUSE for OpenStack Pike:**

  .. code-block:: console

     # zypper addrepo -f obs://Cloud:OpenStack:Pike/openSUSE_Leap_42.3 Pike

  .. note::

     The openSUSE distribution uses the concept of patterns to
     represent collections of packages. If you selected 'Minimal
     Server Selection (Text Mode)' during the initial installation,
     you may be presented with a dependency conflict when you
     attempt to install the OpenStack packages. To avoid this,
     remove the minimal\_base-conflicts package:

     .. code-block:: console

        # zypper rm patterns-openSUSE-minimal_base-conflicts

  **On SLES for OpenStack Ussuri:**

  .. code-block:: console

     # zypper addrepo -f obs://Cloud:OpenStack:Ussuri/SLE_15_SP2 Ussuri

  **On SLES for OpenStack Train:**

  .. code-block:: console

     # zypper addrepo -f obs://Cloud:OpenStack:Train/SLE_15_SP1 Train

  **On SLES for OpenStack Stein:**

  .. code-block:: console

     # zypper addrepo -f obs://Cloud:OpenStack:Stein/SLE_15 Stein

  **On SLES for OpenStack Rocky:**

  .. code-block:: console

     # zypper addrepo -f obs://Cloud:OpenStack:Rocky/SLE_12_SP4 Rocky

  **On SLES for OpenStack Queens:**

  .. code-block:: console

     # zypper addrepo -f obs://Cloud:OpenStack:Queens/SLE_12_SP3 Queens

  **On SLES for OpenStack Pike:**

  .. code-block:: console

     # zypper addrepo -f obs://Cloud:OpenStack:Pike/SLE_12_SP3 Pike

  .. note::

     The packages are signed by GPG key ``D85F9316``. You should
     verify the fingerprint of the imported GPG key before using it.

     .. code-block:: console

        Key Name:         Cloud:OpenStack OBS Project <Cloud:OpenStack@build.opensuse.org>
        Key Fingerprint:  35B34E18 ABC1076D 66D5A86B 893A90DA D85F9316
        Key Created:      2015-12-16T16:48:37 CET
        Key Expires:      2018-02-23T16:48:37 CET

Finalize the installation
-------------------------

#. Upgrade the packages on all nodes:

   .. code-block:: console

      # zypper refresh && zypper dist-upgrade

   .. note::

      If the upgrade process includes a new kernel, reboot your host
      to activate it.

#. Install the OpenStack client:

   .. code-block:: console

      # zypper install python-openstackclient
