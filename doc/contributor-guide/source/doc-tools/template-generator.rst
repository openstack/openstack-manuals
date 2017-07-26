.. _template-generator:

============================
 Template generator details
============================

The content on docs.openstack.org that is not managed as document sets
built by Sphinx is handled via a custom template rendering tool in
``tools/www-generator.py`` within the openstack-manuals git
repository.

The script reads YAML data files in ``www/project-data`` to determine
which projects exist in a given series and how they should be
displayed on the list of installation, configuration, and other
guides.

After the script loads the data about the external projects, it scans
``www/`` for HTML template files. It uses Jinja2_ to convert the
templates to complete HTML pages, which it writes to the
``publish-docs`` output directory.

.. seealso::

   The Jinja2_ documentation includes a guide for template designers
   that covers the syntax of templates, inheritance between templates,
   and the various filters and other features available when writing
   templates.

.. _Jinja2: http://jinja.pocoo.org

Defining release series
=======================

The set of release series and their individual status and other
metadata is embedded in the template generator script in the
``SERIES_INFO`` data structure. The structure is a dictionary mapping
the name of the release series to a ``SeriesInfo`` structure holding
the metadata.

For each release series, the generator needs to know:

``date``
  The date value should be a string containing the month name and 4
  digit year.

``status``
  The 'status' field should be one of:

  ``obsolete``
      the release existed, but we have no more artifacts for it

  ``EOL``
      the release is closed but we have docs for it

  ``maintained``
      the release still has an open branch

  ``development``
      the current release being developed

.. seealso::

   :ref:`release-www-page-updates` has some additional information
   about how the status values are updated at the end of a release
   cycle.

Project data file format
========================

The projects associated with each release series are listed in a
separate YAML file in the ``www/project-data`` directory. Each file is
named for the series (``austin.yaml``, ``bexar.yaml``, etc.) except
for the series currently under development which is always kept in
``latest.yaml``.

The schema for the project data files is defined in
``www/project-data/schema.yaml``.

Each file should contain an array or list of entries. Each entry must
define the name, service, and type properties.

The ``name`` should be the base name of a git repository.

The ``service`` string should be taken from the governance repository
definition of the project.

The ``type`` must be one of the values listed below:

``service``
    A REST API service.

``client``
    A library for talking to a service.

``library``
    Another type of library.

``tool``
    A command line tool or other project that is used with, or used to
    build, OpenStack.

``networking``
    A plugin for the networking service.

``baremetal``
    A subproject for the bare metal project, Ironic.

``deployment``
    A tool for deploying OpenStack.

``other``
    A project that does run in a cloud but does not provide
    a REST API.

An entry can also optionally define ``service_type``, which must match
the value associated with the name in the `service-types-authority
repository
<http://git.openstack.org/cgit/openstack/service-types-authority/>`_.

Entries with ``type`` set to ``client`` should include a ``description``
field with a short description, such as "keystone client".

Entries may optionally set flags to indicate that the repository
includes particular types of documentation in an expected location, to
include a link to that documentation on the templated landing pages.

``has_install_guide``
    produces a link to docs.o.o/name/latest/install/

``has_api_guide``
    produces a link to developer.o.o/api-guide/service_type/

``has_api_ref``
    produces a link to developer.o.o/api-ref/service_type/

``has_config_ref``
    produces a link to docs.o.o/name/latest/configuration/

``has_in_tree_api_docs``
    produces a link to docs.o.o/name/latest/api/

``has_admin_guide``
    produces a link to docs.o.o/name/latest/admin/

.. note::

   The documentation associated with the flags must exist before the
   flags are set.

Template variables
==================

The template generator uses the input data to set several variables
visible within the template. This allows us to reuse the same template
to generate content for multiple pages of the same style, filling in
different data.

By convention, all of the variables defined in the template generator
use all uppercase names. This makes it easy to differentiate the
generator variables from variables defined within templates (such as
loop contexts).

``TEMPLATE_FILE``
  The name of the template file being rendered, with the ``www``
  prefix removed. For example, ``pike/index.html``.

``PROJECT_DATA``
  All of the project data loaded from the data files in a dictionary
  mapping the series name to the parsed data file. Most template pages
  will assign a local variable using ``PROJECT_DATA[SERIES]`` to
  extract the correct subset of the data.

``TOPDIR``
  The relative path to the top of the build output. This is useful for
  building paths between output pages in a way that allows those pages
  to move around later.

``SCRIPTDIR``
  The relative path to the location of the JavaScript directory in the
  build output. This is useful for building links to JavaScript files.

``CSSDIR``
  The relative path to the location of the directory containing the
  CSS files in the build output. This is useful for building links to
  CSS files.

``IMAGEDIR``
  The relative path to the location of the directory containing image
  files in the build output. This is useful for building links to
  images.

``SERIES``
  A string containing the name of the series usable in URLs. For the
  series under development, this is ``"latest"``. For other series, it
  is the series name in lower case.

  This value is derived from the path to the template file. If the
  file is under a directory that matches one of the known series
  names, that value is used to set ``SERIES``.

``SERIES_TITLE``
  A string containing the name of the series usable in text visible to
  the reader. It is always the actual name of the series in "title
  case" (the first letter of each word is uppercase). For example,
  ``"Pike"``.

  This value is derived from the path to the template file. If the
  file is under a directory that matches one of the known series
  names, that value is used to set ``SERIES``.

``ALL_SERIES``
  A list of all of the series names for all OpenStack releases, in
  order of release.

  This list is derived from the keys of the ``SERIES_INFO`` dictionary
  defined in the template generator.

``PAST_SERIES``
  A list of the series names for OpenStack releases with a status
  other than ``"development"``.

  This list is derived from the values in the ``SERIES_INFO``
  dictionary defined in the template generator.

``RELEASED_SERIES``
  A string containing the lowercase name of the most recent series to
  be released. For example, during the Pike series this value was
  ``"ocata"``.

  This value is derived from the values in the ``SERIES_INFO``
  dictionary defined in the template generator.

``SERIES_IN_DEVELOPMENT``
  A string containing the lowercase name of the series under active
  development. For example, during the Pike series this value was
  ``"pike"``.

  This value is derived from the values in the ``SERIES_INFO``
  dictionary defined in the template generator.

``SERIES_INFO``
  The ``SeriesInfo`` object associated with the current series. This
  provides access to the ``date`` and ``status`` values for the
  series.

  This value is taken from the ``SERIES_INFO`` dictionary defined in
  the template generator.

``REGULAR_REPOS``
  A list of all of the names of regular repositories for official
  OpenStack projects. Here "regular" differentiates the repositories
  from infrastructure team repositories, which have their
  documentation published to a different location and therefore need
  some different URLs for redirects in the ``.htaccess`` template. See
  ``INFRA_REPOS``.

  This value is derived from data published from the governance
  repository.

``INFRA_REPOS``
  A list of all of the names of repositories for the infrastructure
  team. See ``REGULAR_REPOS``.

  This value is derived from data published from the governance
  repository.
