=================================
How can I use an OpenStack cloud?
=================================

As an OpenStack cloud end user, you can provision your own resources
within the limits set by cloud administrators.

The examples in this guide show you how to perform tasks by using the
following methods:

* OpenStack dashboard: Use this web-based graphical interface, code named
  `horizon <https://git.openstack.org/cgit/openstack/horizon>`__, to view,
  create, and manage resources.

* OpenStack command-line clients: Each core OpenStack project has a
  command-line client that you can use to run simple commands to view,
  create, and manage resources in a cloud and automate tasks by using
  scripts.

You can modify these examples for your specific use cases.

In addition to these ways of interacting with a cloud, you can access
the OpenStack APIs directly or indirectly through `cURL <http://curl.haxx.se>`__
commands or open SDKs. You can automate access or build tools to manage
resources and services by using the OpenStack APIs.

To use the OpenStack APIs, it helps to be familiar with HTTP/1.1,
RESTful web services, the OpenStack services, and JSON or XML data
serialization formats.

Who should read this book?
~~~~~~~~~~~~~~~~~~~~~~~~~~

This book is written for anyone who uses virtual machines and cloud
resources to develop software or perform research. You should have
years of experience with Linux-based tool sets and be comfortable
using both GUI and CLI based tools. While this book includes some
information about using Python to create and manage cloud resources,
Python knowledge is not a pre-requisite for reading this book.
