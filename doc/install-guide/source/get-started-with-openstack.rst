==========================
Get started with OpenStack
==========================

The OpenStack project is an open source cloud computing platform for all
types of clouds, which aims to be simple to implement, massively
scalable, and feature rich. Developers and cloud computing technologists
from around the world create the OpenStack project.

OpenStack provides an :term:`Infrastructure-as-a-Service (IaaS)` solution
through a set of interrelated services. Each service offers an
:term:`application programming interface (API)` that facilitates this
integration. Depending on your needs, you can install some or all
services.

The OpenStack services
======================

The following table describes the OpenStack services that make up the
OpenStack architecture:

.. list-table:: OpenStack services
   :header-rows: 1
   :widths: 10 10 40

   * - Service
     - Project name
     - Description
   * - `Dashboard <https://www.openstack.org/software/releases/ocata/components/horizon>`__
     - `Horizon <https://docs.openstack.org/horizon/latest/>`__
     - Provides a web-based self-service portal to interact with underlying
       OpenStack services, such as launching an instance, assigning IP
       addresses and configuring access controls.
   * - `Compute service <https://www.openstack.org/software/releases/ocata/components/nova>`__
     - `Nova <https://docs.openstack.org/nova/latest/>`__
     - Manages the lifecycle of compute instances in an OpenStack environment.
       Responsibilities include spawning, scheduling and decommissioning of
       virtual machines on demand.
   * - `Networking service <https://www.openstack.org/software/releases/ocata/components/neutron>`__
     - `Neutron <https://docs.openstack.org/neutron/latest/>`__
     - Enables Network-Connectivity-as-a-Service for other OpenStack services,
       such as OpenStack Compute. Provides an API for users to define networks
       and the attachments into them. Has a pluggable architecture that
       supports many popular networking vendors and technologies.
   * - `Object Storage service <https://www.openstack.org/software/releases/ocata/components/swift>`__
     - `Swift <https://docs.openstack.org/swift/latest/>`__
     - Stores and retrieves arbitrary unstructured data objects via a RESTful,
       HTTP based API. It is highly fault tolerant with its data replication
       and scale-out architecture. Its implementation is not like a file server
       with mountable directories. In this case, it writes objects and files to
       multiple drives, ensuring the data is replicated across a server
       cluster.
   * - `Block Storage service <https://www.openstack.org/software/releases/ocata/components/cinder>`__
     - `Cinder <https://docs.openstack.org/cinder/latest/>`__
     - Provides persistent block storage to running instances. Its pluggable
       driver architecture facilitates the creation and management of block
       storage devices.
   * - `Identity service <https://www.openstack.org/software/releases/ocata/components/keystone>`__
     - `Keystone <https://docs.openstack.org/keystone/latest/>`__
     - Provides an authentication and authorization service for other
       OpenStack services. Provides a catalog of endpoints for all
       OpenStack services.
   * - `Image service <https://www.openstack.org/software/releases/ocata/components/glance>`__
     - `Glance <https://docs.openstack.org/glance/latest/>`__
     - Stores and retrieves virtual machine disk images. OpenStack Compute
       makes use of this during instance provisioning.
   * - `Telemetry service <https://www.openstack.org/software/releases/ocata/components/ceilometer>`__
     - `Ceilometer <https://docs.openstack.org/ceilometer/latest/>`__
     - Monitors and meters the OpenStack cloud for billing, benchmarking,
       scalability, and statistical purposes.
   * - `Orchestration service <https://www.openstack.org/software/releases/ocata/components/heat>`__
     - `Heat <https://docs.openstack.org/heat/latest/>`__
     - Orchestrates multiple composite cloud applications by using either the
       native HOT template format or the AWS CloudFormation template format,
       through both an OpenStack-native REST API and a
       CloudFormation-compatible Query API.
   * - `Database service <https://www.openstack.org/software/releases/ocata/components/trove>`__
     - `Trove <https://docs.openstack.org/trove/latest/>`__
     - Provides scalable and reliable Cloud Database-as-a-Service functionality
       for both relational and non-relational database engines.
   * - `Data Processing service <https://www.openstack.org/software/releases/ocata/components/sahara>`__
     - `Sahara <https://docs.openstack.org/sahara/latest/>`__
     - Provides capabilities to provision and scale Hadoop clusters in OpenStack
       by specifying parameters like Hadoop version, cluster topology and nodes
       hardware details.

The OpenStack architecture
==========================

The following sections describe the OpenStack architecture in more detail:

.. toctree::
   :maxdepth: 2

   get-started-conceptual-architecture.rst
   get-started-logical-architecture.rst
