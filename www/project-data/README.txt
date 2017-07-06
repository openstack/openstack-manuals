.. -*- mode: rst -*-

==============
 Project Data
==============

The projects associated with each release series are listed in a
separate YAML file, all following the same schema defined in
schema.yaml.

The file should contain an array or list of entries. Each entry must
define the name, service, and type properties.

The name should be the base name of a git repository.

The service string should be taken from the governance repository
definition of the project.

The type must be one of the values listed below:

  service -- A REST API service.

  client -- A library for talking to a service.

  library -- Another type of library.

  tool -- A command line tool or other project that is used with, or used to build, OpenStack.

  networking -- A plugin for the networking service.

  baremetal -- A subproject for the bare metal project, Ironic.

  other -- A project that does run in a cloud but does not provide a REST API.

An entry can also optionally define service_type, which must match the
value associated with the name in the service-types-authority
repository.

Entries with type client should include a description field with a
short description, such as "keystone client".

Entries may optionally set flags to indicate that the repository
includes particular types of documentation in an expected location, to
include a link to that documentation on the templated landing pages.

  has_install_guide -- produces a link to docs.o.o/name/latest/install/

  has_api_guide -- produces a link to developer.o.o/api-guide/service_type/

  has_api_ref -- produces a link to developer.o.o/api-ref/service_type/

  NOTE: The documentation associated with the flags must exist before
  the flags are set.
