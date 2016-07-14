===============================
Profiling (conditional content)
===============================

Installation Guides has content that depends upon the operating systems.

Use the ``only`` directive to specify the content that is operating-system
specific. Define one or several tags depending on the operating system
the content belongs to.

The valid tags for the ``only`` directive are:

* ``ubuntu`` for Ubuntu
* ``debian`` for Debian
* ``rdo`` for Red Hat Enterprise Linux and CentOS
* ``obs`` for openSUSE and SUSE Linux Enterprise

**Input**

.. code-block:: none

   Install the NTP service
   -----------------------

   .. only:: ubuntu or debian

      .. code-block:: console

         # apt-get install chrony

   .. only:: rdo

      .. code-block:: console

         # yum install chrony

   .. only:: obs

      On openSUSE:

      .. code-block:: console

         # zypper addrepo http://download.opensuse.org/repositories/network:time/openSUSE_13.2/network:time.repo
         ...

      On SLES:

      .. code-block:: console

         # zypper addrepo http://download.opensuse.org/repositories/network:time/SLE_12/network:time.repo
         ...

For more details refer to `Including content based on tags
<http://sphinx.readthedocs.org/en/latest/markup/misc.html?highlight=only%20directive#including-content-based-on-tags>`_.
