====================
Next release: Newton
====================

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
  is now available on the `API Quick Start page <http://developer.openstack.org/api-guide/quick-start/>`_.

* The `Compute API <http://developer.openstack.org/api-ref/compute/>`_ and
  `DNS API <http://developer.openstack.org/api-ref/dns/>`__ sites offer great
  examples of the new API reference, maintained by the project team rather
  than a central docs team.

* Updated the `Contributor Guide <http://docs.openstack.org/contributor-guide/api-guides.html>`__
  to include specific API Guides information.

* Completed `API Documentation <http://specs.openstack.org/openstack/api-wg/guidelines/api-docs.html>`__
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

* Created `cookiecutter <http://git.openstack.org/cgit/openstack/installguide-cookiecutter/>`_
  tool to ensure project specific guides have a consistent structure.

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

Training guides
~~~~~~~~~~~~~~~

* Improved and restructured `Upstream Training <http://docs.openstack.org/upstream-training/>`_
* Added new chapters in the draft `Training guides <http://docs.openstack.org/draft/training-guides/>`_

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
