========================================
How can I administer an OpenStack cloud?
========================================

As an OpenStack cloud administrative user, you can manage tenants,
known as projects, users, services, images, flavors, and quotas.

The examples in this guide show you how to perform tasks by using the
following methods:

* OpenStack dashboard. Use this web-based graphical interface, code
  named `horizon <https://git.openstack.org/cgit/openstack/horizon>`__,
  to view, create, and manage resources and services.

* OpenStack command-line clients. Each core OpenStack project has a
  command-line client that you can use to run simple commands to view,
  create, and manage resources and services in a cloud and automate
  tasks by using scripts.

You can modify these examples for your specific use cases.

In addition to these ways of interacting with a cloud, you can access
the OpenStack APIs directly or indirectly through `cURL <http://curl.haxx.se>`__ commands or
open SDKs. You can automate access or build tools to manage resources
and services by using the native OpenStack APIs or the EC2
compatibility API.

To use the OpenStack APIs, it helps to be familiar with HTTP/1.1,
RESTful web services, the OpenStack services, and JSON or XML data
serialization formats.

Who should read this book?
~~~~~~~~~~~~~~~~~~~~~~~~~~

This book is written for administrators who maintain and secure an
OpenStack cloud installation to serve end users' needs. You should
have years of experience with Linux-based tools for system
administration. You should also be familiar with OpenStack basics,
such as managing projects and users, troubleshooting, performing
backup and recovery, and monitoring. For more information, see the
`OpenStack Operations Guide <http://docs.openstack.org/ops>`__.
