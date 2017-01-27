============
Introduction
============

The OpenStack Orchestration service, a tool for orchestrating clouds,
automatically configures and deploys resources in stacks. The deployments can
be simple, such as deploying WordPress on Ubuntu with an SQL back end, or
complex, such as starting a server group that auto scales by
starting and stopping using real-time CPU loading information from the
Telemetry service.

Orchestration stacks are defined with templates, which are non-procedural
documents. Templates describe tasks in terms of resources, parameters, inputs,
constraints, and dependencies. When the Orchestration service was originally
introduced, it worked with AWS CloudFormation templates, which are in the JSON
format.

The Orchestration service also runs Heat Orchestration Template (HOT)
templates that are written in YAML. YAML is a terse notation that loosely
follows structural conventions (colons, returns, indentation) that are similar
to Python or Ruby. Therefore, it is easier to write, parse, grep, generate
with tools, and maintain source-code management systems.

Orchestration can be accessed through a CLI and RESTful queries.
The Orchestration service provides both an OpenStack-native REST API and a
CloudFormation-compatible Query API. The Orchestration service is also
integrated with the OpenStack dashboard to perform stack functions through
a web interface.

For more information about using the Orchestration service through the
command line, see the `OpenStack Command-Line Interface Reference
<https://docs.openstack.org/cli-reference/heat.html>`_.
