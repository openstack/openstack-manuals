:orphan:

==========================
Get started with OpenStack
==========================

The OpenStack project is an open source cloud computing platform for all
types of clouds, which aims to be simple to implement, massively
scalable, and feature rich. Developers and cloud computing technologists
from around the world create the OpenStack project.

OpenStack provides an Infrastructure-as-a-Service (IaaS) solution
through a set of interrelated services. Each service offers an
application programming interface (API) that facilitates this
integration. Depending on your needs, you can install some or all
services.

The following table describes the OpenStack services that make up the
OpenStack architecture:

.. list-table:: OpenStack Services
   :header-rows: 1
   :widths: 10 10 40

   * - Service
     - Project name
     - Description
   * - `Dashboard <http://www.openstack.org/software/openstack-dashboard/>`__
     - `Horizon <http://docs.openstack.org/developer/horizon/>`__
     - Provides a web-based self-service portal to interact with underlying
       OpenStack services, such as launching an instance, assigning IP
       addresses and configuring access controls.
   * - `Compute <http://www.openstack.org/software/openstack-compute/>`__
     - `Nova <http://docs.openstack.org/developer/nova/>`__
     - Manages the lifecycle of compute instances in an OpenStack environment.
       Responsibilities include spawning, scheduling and decommissioning of
       virtual machines on demand.
   * - `Networking <http://www.openstack.org/software/openstack-networking/>`__
     - `Neutron <http://docs.openstack.org/developer/neutron/>`__
     - Enables Network-Connectivity-as-a-Service for other OpenStack services,
       such as OpenStack Compute. Provides an API for users to define networks
       and the attachments into them. Has a pluggable architecture that
       supports many popular networking vendors and technologies.
   * - `Object Storage <http://www.openstack.org/software/openstack-storage/>`__
     - `Swift <http://docs.openstack.org/developer/swift/>`__
     - Stores and retrieves arbitrary unstructured data objects via a RESTful,
       HTTP based API. It is highly fault tolerant with its data replication
       and scale-out architecture. Its implementation is not like a file server
       with mountable directories. In this case, it writes objects and files to
       multiple drives, ensuring the data is replicated across a server
       cluster.
   * - `Block Storage <http://www.openstack.org/software/openstack-storage/>`__
     - `Cinder <http://docs.openstack.org/developer/cinder/>`__
     - Provides persistent block storage to running instances. Its pluggable
       driver architecture facilitates the creation and management of block
       storage devices.
   * - `Identity service <http://www.openstack.org/software/openstack-shared-services/>`__
     - `Keystone <http://docs.openstack.org/developer/keystone/>`__
     - Provides an authentication and authorization service for other
       OpenStack services. Provides a catalog of endpoints for all
       OpenStack services.
   * - `Image service <http://www.openstack.org/software/openstack-shared-services/>`__
     - `Glance <http://docs.openstack.org/developer/glance/>`__
     - Stores and retrieves virtual machine disk images. OpenStack Compute
       makes use of this during instance provisioning.
   * - `Telemetry <http://www.openstack.org/software/openstack-shared-services/>`__
     - `Ceilometer <http://docs.openstack.org/developer/ceilometer/>`__
     - Monitors and meters the OpenStack cloud for billing, benchmarking,
       scalability, and statistical purposes.
   * - `Orchestration <http://www.openstack.org/software/openstack-shared-services/>`__
     - `Heat <http://docs.openstack.org/developer/heat/>`__
     - Orchestrates multiple composite cloud applications by using either the
       native HOT template format or the AWS CloudFormation template format,
       through both an OpenStack-native REST API and a
       CloudFormation-compatible Query API.
   * - `Database service <http://www.openstack.org/software/openstack-shared-services/>`__
     - `Trove <http://docs.openstack.org/developer/trove/>`__
     - Provides scalable and reliable Cloud Database-as-a-Service functionality
       for both relational and non-relational database engines.
   * - `Data processing service <http://www.openstack.org/software/openstack-shared-services/>`__
     - `Sahara <http://docs.openstack.org/developer/sahara/>`__
     - Provides capabilties to provision and scale Hadoop clusters in OpenStack
       by specifying parameters like Hadoop version, cluster topology and nodes
       hardware details.

.. include:: get_started_conceptual_architecture.rst
.. include:: get_started_logical_architecture.rst

.. toctree::
   :hidden:

   get_started_conceptual_architecture.rst
   get_started_logical_architecture.rst

OpenStack services
~~~~~~~~~~~~~~~~~~

This section describes OpenStack services in detail.

.. include:: get_started_compute.rst

.. include:: get_started_storage_concepts.rst

.. include:: get_started_object_storage.rst

.. include:: get_started_block_storage.rst

.. include:: get_started_openstack_networking.rst

.. include:: get_started_dashboard.rst

.. include:: get_started_identity.rst

.. include:: get_started_image_service.rst

.. include:: get_started_telemetry.rst

.. include:: get_started_orchestration.rst

.. include:: get_started_database_service.rst

.. include:: get_started_sahara.rst

.. toctree::
   :hidden:

   get_started_compute.rst
   get_started_storage_concepts.rst
   get_started_object_storage.rst
   get_started_block_storage.rst
   get_started_openstack_networking.rst
   get_started_dashboard.rst
   get_started_identity.rst
   get_started_image_service.rst
   get_started_telemetry.rst
   get_started_orchestration.rst
   get_started_database_service.rst
   get_started_sahara.rst

Feedback
~~~~~~~~

To provide feedback on documentation, join and use the
openstack-docs@lists.openstack.org mailing list at `OpenStack
Documentation Mailing
List <http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-docs>`__,
or `report a
bug <https://bugs.launchpad.net/openstack-manuals/+filebug>`__.
