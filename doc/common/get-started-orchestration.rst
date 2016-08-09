==============================
Orchestration service overview
==============================

The Orchestration service provides a template-based orchestration for
describing a cloud application by running OpenStack API calls to
generate running cloud applications. The software integrates other core
components of OpenStack into a one-file template system. The templates
allow you to create most OpenStack resource types such as instances,
floating IPs, volumes, security groups, and users. It also provides
advanced functionality such as instance high availability, instance
auto-scaling, and nested stacks. This enables OpenStack core projects to
receive a larger user base.

The service enables deployers to integrate with the Orchestration service
directly or through custom plug-ins.

The Orchestration service consists of the following components:

``heat`` command-line client
  A CLI that communicates with the ``heat-api`` to run AWS
  CloudFormation APIs. End developers can directly use the Orchestration
  REST API.

``heat-api`` component
  An OpenStack-native REST API that processes API requests by sending
  them to the ``heat-engine`` over :term:`Remote Procedure Call (RPC)`.

``heat-api-cfn`` component
  An AWS Query API that is compatible with AWS CloudFormation. It
  processes API requests by sending them to the ``heat-engine`` over RPC.

``heat-engine``
  Orchestrates the launching of templates and provides events back to
  the API consumer.
