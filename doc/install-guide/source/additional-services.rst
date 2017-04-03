.. _additional-services:

===================
Additional services
===================

Installation and configuration of additional OpenStack services is documented
in separate, project-specific installation guides.

Bare Metal service (ironic)
===========================

The Bare Metal service is a collection of components that provides
support to manage and provision physical machines.

Installation and configuration is documented in the
`Bare Metal installation guide
<http://docs.openstack.org/project-install-guide/baremetal/newton/>`_.

Container Infrastructure Management service (magnum)
====================================================

The Container Infrastructure Management service (magnum) is an OpenStack API
service making container orchestration engines (COE) such as Docker Swarm,
Kubernetes and Mesos available as first class resources in OpenStack.

Installation and configuration is documented in the
`Container Infrastructure Management installation guide
<http://docs.openstack.org/project-install-guide/container-infrastructure-management/newton/>`_.

Database service (trove)
========================

The Database service (trove) provides cloud provisioning functionality for
database engines.

Installation and configuration is documented in the
`Database installation guide
<http://docs.openstack.org/project-install-guide/database/newton/>`_.

Key Manager service (barbican)
==============================

The Key Manager service provides a RESTful API for the storage and provisioning
of secret data such as passphrases, encryption keys, and X.509 certificates.

Installation and configuration is documented in the
`Key Manager installation guide
<http://docs.openstack.org/project-install-guide/key-manager/newton/>`_.

Messaging service (zaqar)
=========================

The Messaging service allows developers to share data between distributed
application components performing different tasks, without losing messages or
requiring each component to be always available.

Installation and configuration is documented in the
`Messaging installation guide
<http://docs.openstack.org/project-install-guide/messaging/newton/>`_.

Object Storage services (swift)
===============================

The Object Storage services (swift) work together to provide object storage and
retrieval through a REST API.

Installation and configuration is documented in the
`Object Storage installation guide
<http://docs.openstack.org/project-install-guide/object-storage/newton/>`_.

Orchestration service (heat)
============================

The Orchestration service (heat) uses a
`Heat Orchestration Template (HOT)
<http://docs.openstack.org/developer/heat/template_guide/hot_guide.html>`_
to create and manage cloud resources.

Installation and configuration is documented in the
`Orchestration installation guide
<http://docs.openstack.org/project-install-guide/orchestration/newton/>`_.

Shared File Systems service (manila)
====================================

The Shared File Systems service (manila) provides coordinated access to shared
or distributed file systems.

Installation and configuration is documented in the
`Shared File Systems installation guide
<http://docs.openstack.org/project-install-guide/shared-file-systems/newton/>`_.

Telemetry Alarming services (aodh)
==================================

The Telemetry Alarming services trigger alarms when the collected metering or
event data break the defined rules.

Installation and configuration is documented in the
`Telemetry Alarming installation guide
<http://docs.openstack.org/project-install-guide/telemetry-alarming/newton/>`_.

Telemetry Data Collection service (ceilometer)
==============================================

The Telemetry Data Collection services provide the following functions:

* Efficiently polls metering data related to OpenStack services.
* Collects event and metering data by monitoring notifications sent from
  services.
* Publishes collected data to various targets including data stores and message
  queues.

Installation and configuration is documented in the
`Telemetry Data Collection installation guide
<http://docs.openstack.org/project-install-guide/telemetry/newton/>`_.
