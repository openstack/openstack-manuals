==============
Mitaka release
==============

* Tracking of release notes in the ``releasenotes`` directory.

Configuration Reference
~~~~~~~~~~~~~~~~~~~~~~~

* Completed RST conversion.
* Documented Message service (zaqar).

High Availability Guide
~~~~~~~~~~~~~~~~~~~~~~~

* Added the `Highly available Shared File Systems API <http://docs.openstack.org/ha-guide/storage-ha-manila.html>`_
  section.

* Improved `Pacemaker/Corosync cluster <http://docs.openstack.org/ha-guide/controller-ha-pacemaker.html>`_
  installation and configuration details.

* Documented the `Pacemaker cluster manager <http://docs.openstack.org/ha-guide/intro-ha-arch-pacemaker.html>`_
  and `Keepalived architecture <http://docs.openstack.org/ha-guide/intro-ha-arch-keepalived.html>`_
  details and limitations.

* Added the `MariaDB Galera cluster <http://docs.openstack.org/ha-guide/controller-ha-galera.html>`_
  installation, configuration, and management details.

* Improved the `RabbitMQ section <http://docs.openstack.org/ha-guide/controller-ha-rabbitmq.html>`_.

Installation Guide
~~~~~~~~~~~~~~~~~~

* Updated configuration for all services.
* Added Shared File Systems (manila) content.
* Added Database service (trove) content.

Networking Guide
~~~~~~~~~~~~~~~~

* Documentation of some of the new features in Mitaka.
* New content including documentation for LBaaS, DNS integration,
  and macvtap ml2 driver.


Operations Guide
~~~~~~~~~~~~~~~~

* Added the Shared File Systems chapter.

User Guides
~~~~~~~~~~~

* Reorganised the **Admin User Guide** content together with the
  **Cloud Admin Guide** content to create a new
  **Administrator Guide**.

* Approximately one third of the **Administrator Guide** chapters
  received a thorough edit for style and consistency, following the
  contributor guide standard.

* Troubleshooting chapters now have consistent formatting, which is
  a step toward improved troubleshooting sections.

* The **Admin User Guide** content has been removed from
  `OpenStack Docs <http://docs.openstack.org>`_ since all files have been
  reorganised into the **Administrator Guide**.

Virtual Machine Image Guide
~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Completed RST conversion.

Command-Line Interface Reference
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Completed RST conversion.
* Documented that individual CLIs are deprecated in favor of
  the common OpenStack client.
* Marked Identity API v2 as deprecated.
* Added senlin, monasca, and cloudkitty clients.
* Removed tuskar client because of retirement.

Architecture Design Guide
~~~~~~~~~~~~~~~~~~~~~~~~~

* Completed RST conversion.

API Guides
~~~~~~~~~~

* New, cleaner `developer.openstack.org <http://developer.openstack.org>`_
  landing page.
* `API Quick Start <http://developer.openstack.org/api-guide/compute/>`_
  converted to RST with theme styling to match.
* `Compute API Guide <http://developer.openstack.org/api-guide/compute/>`_
  now built from nova source tree.
* Draft swagger files now built to http://developer.openstack.org/draft/swagger/
* Created templates for writing API guides for projects teams available
  in projects repositories.
* Released fairy-slipper, a migration tool for WADL to RST plus API reference
  information.

Training Guides
~~~~~~~~~~~~~~~

* Added the `Upstream Training Archives <http://docs.openstack.org/upstream-training/upstream-archives.html>`_
  (the list of past global and local Upstream Training events).
* Added the bug report links to each slide and the landing page.
* Enabled translation.

Translations
~~~~~~~~~~~~

* Japanese

  * Published the Networking Guide.
  * Published the Upstream Training.

* Korean

  * Published the Upstream Training.

* German

  * Published the Upstream Training.
