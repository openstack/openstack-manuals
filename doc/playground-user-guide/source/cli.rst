==============================
OpenStack command-line clients
==============================

Each OpenStack project provides a command-line client, which enables
you to access the project API through easy-to-use commands. For
example, the Compute service provides a nova command-line client.

You can run the commands from the command line, or include the
commands within scripts to automate tasks. If you provide OpenStack
credentials, such as your user name and password, you can run these
commands on any computer.

Internally, each command uses cURL command-line tools, which embed API
requests. OpenStack APIs are RESTful APIs, and use the HTTP
protocol. They include methods, URIs, media types, and response codes.

OpenStack APIs are open-source Python clients, and can run on Linux or
Mac OS X systems. On some client commands, you can specify a debug
parameter to show the underlying API request for the command. This is
a good way to become familiar with the OpenStack API calls.

As a cloud end user, you can use the OpenStack dashboard to provision
your own resources within the limits set by administrators. You can
modify the examples provided in this section to create other types and
sizes of server instances.

The following table lists the command-line client for each OpenStack
service with its package name and description.

TODO(ajaeger): Add table with command-line clients.

.. toctree::
   :maxdepth: 2

   cli_launch_instances.rst
   cli_cheat_sheet.rst

.. TODO(ajaeger): Add further sections

