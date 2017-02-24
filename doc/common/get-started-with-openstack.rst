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

The following table describes the OpenStack services that make up the
OpenStack architecture:

.. list-table:: OpenStack Services
   :header-rows: 1
   :widths: 10 10 40

   * - Service
     - Project name
     - Description
   * - `Dashboard <https://www.openstack.org/software/releases/ocata/components/horizon>`__
     - `Horizon <https://docs.openstack.org/developer/horizon/>`__
     - Provides a web-based self-service portal to interact with underlying
       OpenStack services, such as launching an instance, assigning IP
       addresses and configuring access controls.
   * - `Compute <https://www.openstack.org/software/releases/ocata/components/nova>`__
     - `Nova <https://docs.openstack.org/developer/nova/>`__
     - Manages the lifecycle of compute instances in an OpenStack environment.
       Responsibilities include spawning, scheduling and decommissioning of
       virtual machines on demand.
   * - `Networking <https://www.openstack.org/software/releases/ocata/components/neutron>`__
     - `Neutron <https://docs.openstack.org/developer/neutron/>`__
     - Enables Network-Connectivity-as-a-Service for other OpenStack services,
       such as OpenStack Compute. Provides an API for users to define networks
       and the attachments into them. Has a pluggable architecture that
       supports many popular networking vendors and technologies.
   * - `Object Storage <https://www.openstack.org/software/releases/ocata/components/swift>`__
     - `Swift <https://docs.openstack.org/developer/swift/>`__
     - Stores and retrieves arbitrary unstructured data objects via a RESTful,
       HTTP based API. It is highly fault tolerant with its data replication
       and scale-out architecture. Its implementation is not like a file server
       with mountable directories. In this case, it writes objects and files to
       multiple drives, ensuring the data is replicated across a server
       cluster.
   * - `Block Storage <https://www.openstack.org/software/releases/ocata/components/cinder>`__
     - `Cinder <https://docs.openstack.org/developer/cinder/>`__
     - Provides persistent block storage to running instances. Its pluggable
       driver architecture facilitates the creation and management of block
       storage devices.
   * - `Identity service <https://www.openstack.org/software/releases/ocata/components/keystone>`__
     - `Keystone <https://docs.openstack.org/developer/keystone/>`__
     - Provides an authentication and authorization service for other
       OpenStack services. Provides a catalog of endpoints for all
       OpenStack services.
   * - `Image service <https://www.openstack.org/software/releases/ocata/components/glance>`__
     - `Glance <https://docs.openstack.org/developer/glance/>`__
     - Stores and retrieves virtual machine disk images. OpenStack Compute
       makes use of this during instance provisioning.
   * - `Telemetry <https://www.openstack.org/software/releases/ocata/components/ceilometer>`__
     - `Ceilometer <https://docs.openstack.org/developer/ceilometer/>`__
     - Monitors and meters the OpenStack cloud for billing, benchmarking,
       scalability, and statistical purposes.
   * - `Orchestration <https://www.openstack.org/software/releases/ocata/components/heat>`__
     - `Heat <https://docs.openstack.org/developer/heat/>`__
     - Orchestrates multiple composite cloud applications by using either the
       native HOT template format or the AWS CloudFormation template format,
       through both an OpenStack-native REST API and a
       CloudFormation-compatible Query API.
   * - `Database service <https://www.openstack.org/software/releases/ocata/components/trove>`__
     - `Trove <https://docs.openstack.org/developer/trove/>`__
     - Provides scalable and reliable Cloud Database-as-a-Service functionality
       for both relational and non-relational database engines.
   * - `Data processing service <https://www.openstack.org/software/releases/ocata/components/sahara>`__
     - `Sahara <https://docs.openstack.org/developer/sahara/>`__
     - Provides capabilities to provision and scale Hadoop clusters in OpenStack
       by specifying parameters like Hadoop version, cluster topology and nodes
       hardware details.

.. toctree::
   :maxdepth: 2

   get-started-conceptual-architecture.rst
   get-started-logical-architecture.rst
   get-started-openstack-services.rst
