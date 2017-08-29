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

  **On openSUSE for OpenStack Pike:**

  .. code-block:: console

     # zypper addrepo -f obs://Cloud:OpenStack:Pike/openSUSE_Leap_42.3 Pike

  .. end

  .. note::

     The openSUSE distribution uses the concept of patterns to
     represent collections of packages. If you selected 'Minimal
     Server Selection (Text Mode)' during the initial installation,
     you may be presented with a dependency conflict when you
     attempt to install the OpenStack packages. To avoid this,
     remove the minimal\_base-conflicts package:

     .. code-block:: console

        # zypper rm patterns-openSUSE-minimal_base-conflicts

     .. end

  **On SLES for OpenStack Pike:**

  .. code-block:: console

     # zypper addrepo -f obs://Cloud:OpenStack:Pike/SLE_12_SP3 Pike

  .. end

  .. note::

     The packages are signed by GPG key ``D85F9316``. You should
     verify the fingerprint of the imported GPG key before using it.

     .. code-block:: console

        Key Name:         Cloud:OpenStack OBS Project <Cloud:OpenStack@build.opensuse.org>
        Key Fingerprint:  35B34E18 ABC1076D 66D5A86B 893A90DA D85F9316
        Key Created:      2015-12-16T16:48:37 CET
        Key Expires:      2018-02-23T16:48:37 CET

     .. end

Finalize the installation
-------------------------

#. Upgrade the packages on all nodes:

   .. code-block:: console

      # zypper refresh && zypper dist-upgrade

   .. end

   .. note::

      If the upgrade process includes a new kernel, reboot your host
      to activate it.

#. Install the OpenStack client:

   .. code-block:: console

      # zypper install python-openstackclient

   .. end
