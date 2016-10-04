====================
Next release: Newton
====================

User visible changes
~~~~~~~~~~~~~~~~~~~~

* Command-Line Interface Reference abandons the "openstack" command
  reference in favor of the reference in the OpenStackClient repository.

* Configuration Reference consolidates the common configurations
  such as database connections and RPC messaging.

* Configuration Reference supports the Application Catalog service.

Internal changes
~~~~~~~~~~~~~~~~

* The Operations Guide is now using RST as source format.

* The content of the separate repositories operations-guide and
  ha-guide has been moved into the openstack-manuals repository. The
  repositories operations-guide and ha-guide have been retired.

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

Architecture design guide
~~~~~~~~~~~~~~~~~~~~~~~~~

* A revised Architecture Design Guide is currently under development, no changes to
  the current guide.

Training guides
~~~~~~~~~~~~~~~

* Improved and restructured `Upstream Training <http://docs.openstack.org/upstream-training/>`_
* Added new chapters in the draft `Training guides <http://docs.openstack.org/draft/training-guides/>`_

Translations
~~~~~~~~~~~~

* Italian

  * Published the Upstream Training.