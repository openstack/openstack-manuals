============
Introduction
============

Orchestration is a tool for orchestrating clouds that automatically
configures and deploys resources in stacks. Such deployments can be
simple — like deploying WordPress on Ubuntu with an SQL back end.
And they can be quite complex, like launching a group of servers that
autoscale: starting and stopping based on realtime CPU loading
information from the Telemetry module.

Orchestration stacks are defined with templates, which are
non-procedural documents describing tasks in terms of resources,
parameters, inputs, constraints and dependencies. When Orchestration
module was originally introduced, it worked with AWS CloudFormation
templates, which are in JSON format.

Now, Orchestration also executes HOT (Heat Orchestration Template)
templates written in YAML: a terse notation that loosely follows
Python/Ruby-type structural conventions (colons, returns,
indentation), so it is more easy to write, parse, grep, generate with
tools, and maintain source-code management systems.

Orchestration can be accessed via the CLI, and using RESTful queries.
Orchestration module provides both an OpenStack-native REST API and a
CloudFormation-compatible Query API. Orchestration is also integrated
with OpenStack dashboard in order to launch stacks from templates
through a web interface.

For more details on how to use Orchestration module through a command
line, see `OpenStack Command-Line Interface Reference`_.

.. Links
.. _`OpenStack Command-Line Interface Reference`: http://docs.openstack.org/
   cli-reference/content/heatclient_commands.html
