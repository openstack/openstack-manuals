==============
Newton release
==============

User visible changes
~~~~~~~~~~~~~~~~~~~~

* The Installation Guide has been renamed to Installation Tutorial, and
  now includes Container Infrastructure Management service (magnum),
  Messaging service (zaqar), Key Manager service (barbican), and Bare Metal
  service (ironic).

* Command-Line Interface Reference abandons the `openstack` command
  reference in favor of the reference in the OpenStackClient repository.

* Configuration Reference consolidates the common configurations
  such as database connections and RPC messaging.

* Configuration Reference supports the Application Catalog service.

* Glossary reorganized to support ease of access for users.

* URL and file names changed to use only hyphens for consistency
  and search engine optimization.

Internal changes
~~~~~~~~~~~~~~~~

* The Installation Tutorial can now publish documentation from project
  specific repositories.

* The Operations Guide is now using RST as source format. This completes the
  transition to RST, and the old DocBook tools have been retired.

* The content of the separate repositories operations-guide and
  ha-guide has been moved into the openstack-manuals repository. The
  operations-guide and ha-guide repositories have been retired.

API guides
~~~~~~~~~~

* The API reference documentation has been moved from the api-site
  repository to project specific repositories. The collection of API docs
  is now available on the `OpenStack API Documentation <https://docs.openstack.org/api-quick-start/>`_.

* The `Compute API <https://docs.openstack.org/api-ref/compute/>`_ and
  `DNS API <https://docs.openstack.org/api-ref/dns/>`__ sites offer great
  examples of the new API reference, maintained by the project team rather
  than a central docs team.

* Updated the `Contributor Guide <https://docs.openstack.org/doc-contrib-guide/api-guides.html>`__
  to include specific API Guides information.

* Completed `API Documentation <https://specs.openstack.org/openstack/api-wg/guidelines/api-docs.html>`__
  guidelines with the API Working Group.

Architecture design guide
~~~~~~~~~~~~~~~~~~~~~~~~~

* A revised Architecture Design Guide is currently under development, no
  changes to the current guide.

Contributor guide
~~~~~~~~~~~~~~~~~

* Collected the user experience content in a single section.

* Added personas content to the user experience section.

* Updated the user interface text guidelines.

* Updated graphics advice.

* Added information about creating project-specific Installation Tutorials.

High availability guide
~~~~~~~~~~~~~~~~~~~~~~~

* Removed Keepalived architecture as it is no longer advocated.

* Replaced basic node and service installation instructions with links.

* Added section regarding automated instance recovery.

* Provide details for contacting the OpenStack HA community.

* Assorted updates and cleanups.

Installation guide
~~~~~~~~~~~~~~~~~~

* Renamed to Installation Tutorial.

* The Installation Tutorial can now publish documentation from project
  specific repositories.

* Published project specific guides for Container Infrastructure Management
  service (magnum), Messaging service (zaqar), Key Manager service (barbican),
  and Bare Metal service (ironic).

* Created `cookiecutter <https://opendev.org/openstack/installguide-cookiecutter/>`_
  tool to ensure project specific guides have a consistent structure.

Networking guide
~~~~~~~~~~~~~~~~

* Completely restructured the guide.

* Reorganized and rewrote the deployment examples using "building blocks" to
  improve usability and understanding. After choosing either the Linux bridge
  or Open vSwitch mechanism driver, the audience can deploy increasingly
  complex architectures that build on prior simpler examples. Also reduced
  duplication of content.

* Added service subnets.

* Added service function chaining.

* Added RBAC.

* Added subnet pools.

* Added address scopes.

* Added BGP dynamic routing.

* Added DPDK for Open vSwitch.

* Improved security groups.

* Improved address scopes.

* Improved SR-IOV.

* Improved DNS resolution.

* Improved high-availability for DHCP.

Operations guide
~~~~~~~~~~~~~~~~

* Completed RST conversion.

* Added enterprise operations documentation including RabbitMQ troubleshooting
  information, instructions to retrieve lost IP addresses, and procedures to
  manage floating IP addresses between instances.

* Removed instructions to install DevStack and information on contributing
  to OpenStack, which is documented on the DevStack project website and
  Infrastructure Manual respectively.

* Updated OpenStack command-line client commands to OpenStackClient commands.

Security Guide
~~~~~~~~~~~~~~

* Added OSSNs 0063, 0066, 0068, 0069, 0073.

* New section on rate-limiting and API endpoint traffic.

* Replaced Keystone CLI examples with OpenStack CLI examples.

* Readability changes for links, images, and document format.

* Updates to compliance section around audit phases and links.

* Migrated examples from deprecated Identity service (keystone)
  direct driver loading examples to stevedore.

* Updated command examples for accuracy and parity with latest versions.

* Added build tools so that the Security Guide can be built both separately
  and with the OSSN and TA sections.

* Updated glossary terms for Nginx, SPICE, Data Loss Prevention (DLP),
  Trusted Platform Module (TPM), Secure Boot, and other acronyms.

Training guides
~~~~~~~~~~~~~~~

* Improved and restructured `Upstream Training <https://docs.openstack.org/upstream-training/>`_
* Added new chapters in the draft Training Guides

Training labs
~~~~~~~~~~~~~

* Training labs landing page is published under `docs.openstack.org <https://docs.openstack.org/training_labs/>`_:

  * Users can download zip/tar files for Windows, Linux and Mac OS X platforms
    for supported releases.

* PXE feature for training-labs:

  * PXE booting functionality is available as a pluggable driver in parallel
    with KVM/VirtualBox.
  * PXE boot could also be used as a mechanism for provisioning KVM/VirtualBox
    based workloads.

* Stability improvements:

  * Various stability improvements have been added in this release.
  * Windows platform support has been updated and improved.
  * Training cluster should additionally have higher deployment rate.
  * Improvements in networking related challenges.

* Performance improvements:

  * Cluster setup speed is improving after addition of multiple features.
  * KVM/Libvirt backends now use shared storage. Hard disks for the cluster
    are diffs on top of the base disk. This uses less storage space.
  * Block storage (cinder) has a dedicated disk as opposed to being file
    mounted as a loop device. This should improve performance and provide
    persistence for cinder-volumes across reboots.
  * Performance improvements by fixing race conditions occurring due
    to virtualization overhead.
  * Improvements to the library scripts.

* Test coverage:

  * Added more tests to ``repeat_test`` scripts.
  * User interface test cases to check the availability of horizon have
    been implemented.

* Updates for supporting new operating systems. For example, Ubuntu 16.04.
* Adds support for x86/i386 architecture.
* Updates to the CLI along with many improvements to address new features.
* Newton support:

  * Newton support should be available shortly after the OpenStack release.
  * This delay is intentional, to let the distribution packages stabilize,
    and to ensure all test cases and reliability checks meet certain criteria.

User guides
~~~~~~~~~~~

* Added Redis replication information and Rootwrap Daemon configuration
  information to the Administrator Guide.

* Reorganized the Administrator Guide Telemetry chapter to improve
  information architecture.

* Migrated content on configuring and customizing the Dashboard, previously
  maintained in the Configuration Reference, to the Dashboard chapter
  of the Administrator Guide.

Translations
~~~~~~~~~~~~

Besides updating the existing translated manuals, the internationalization
team added the following new manuals:

* Indonesian

  * Published API Guide.
  * Published Installation Tutorials for Mitaka.
  * Published Networking Guide.

* Italian

  * Published Upstream Training.

* Japanese

  * Published Installation Tutorials for Mitaka.

* Korean

  * Published Installation Tutorials for Mitaka and Liberty.

* Simplified Chinese

  * Published API Guide.
