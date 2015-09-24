.. _baremetal:

.. highlight: ini
   :linenothreshold:

==========
Bare Metal
==========

The Bare Metal service provides physical hardware management features.

Introduction
~~~~~~~~~~~~

The Bare Metal service provides physical hardware as opposed to
virtual machines and provides several reference drivers which
leverage common technologies like PXE and IPMI, to cover a wide range
of hardware. The pluggable driver architecture also allows
vendor-specific drivers to be added for improved performance or
functionality not provided by reference drivers. The Bare Metal
service makes physical servers as easy to provision as virtual
machines in a cloud, which in turn will open up new avenues for
enterprises and service providers.

System architecture
~~~~~~~~~~~~~~~~~~~

The Bare Metal module is composed of the following components:

#. A RESTful API service

#. A conductor service

#. Various drivers that support heterogeneous hardware

#. A message queue

#. A database for storing information about the resources

.. TODO Add the detail about each component.

Bare Metal deployment
~~~~~~~~~~~~~~~~~~~~~

#. PXE deploy process

#. Agent deploy process

.. TODO Add the detail about the process of Bare Metal deployment.
