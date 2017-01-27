========
Overview
========

OpenStack provides four different options for interacting with its
APIs from Python, each targeting a slightly different user:

- OpenStack SDK
- shade
- Per-project client libraries
- Direct REST calls via keystoneauth

You should also be familiar with:

- RESTful web services
- HTTP/1.1
- JSON and data serialization formats

OpenStack SDK
-------------

The `OpenStack Python Software Development Kit (SDK)
<https://pypi.python.org/pypi/openstacksdk>`_ is used to write Python
automation scripts that create and manage resources in your OpenStack
cloud. The SDK implements Python bindings to the OpenStack API, which
enables you to perform automation tasks in Python by making calls on
Python objects, rather than making REST calls directly.

New users should default to coding against the OpenStack SDK.

shade
-----

`shade <http://pypi.python.org/pypi/shade>`_ is an abstraction library
focused on hiding implementation differences between OpenStack clouds. While
the OpenStack SDK presents a clean object interface to the underlying REST
APIs, shade hides them if doing so is advantageous. If you plan on
running the same Python program against many OpenStack clouds, you may want to
use shade - but if you need to access any features of a cloud that do not have
a cloud-neutral abstraction mapping, you will be unable to do so with shade.

Per-project client libraries
----------------------------

Each OpenStack project produces a client library that wraps its own REST API.
Unless there is no other choice for some reason, the per-project libraries
should be avoided.

Direct REST calls via keystoneauth
----------------------------------

All of OpenStack's APIs are actually REST APIs. The
`keystoneauth <https://docs.openstack.org/developer/keystoneauth>`_ library
provides an object that looks very much like a
`Session <http://docs.python-requests.org/en/master/api/#request-sessions>`_
object from the Python
`requests <http://pypi.python.org/pypi/requests>`_ library that handles all
of the authentication for you. If you are more comfortable just dealing with
REST or if there is a feature implemented in your cloud that has not seen
support in any of the libraries yet, this option is for you.
