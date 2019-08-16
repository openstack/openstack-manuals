.. _template-generator:

==========================
Template generator details
==========================

The portion of the content on docs.openstack.org that is not managed
as document sets built by Sphinx is handled via a custom template
rendering tool in ``tools/www-generator.py`` within the
openstack-manuals git repository.

The script reads YAML data files in ``www/project-data`` to determine
which projects exist in a given series and how they should be
displayed on the list of installation, configuration, and other
guides.

After the script loads the data about the external projects, it scans
``www/`` for HTML template files. It uses `Jinja2 <https://jinja.pocoo.org>`_
to convert the templates to complete HTML pages, which it writes to the
``publish-docs`` output directory.

.. seealso::

   The `Jinja2 <https://jinja.pocoo.org>`_ documentation includes a guide
   for template designers that covers the syntax of templates, inheritance
   between templates, and the various filters and other features available
   when writing templates.

The template files
~~~~~~~~~~~~~~~~~~

The template files in the openstack-manuals repo are all under the
``www`` directory. They are organized in the same structure used to
publish to the site, so the path to a published URL corresponds
directly to a path to the template file that produces it.

Here are a few representative files under ``www/``:

* ``austin``

  * ``index.html`` -- landing page for $series docs (one per series)

* ``de``

  * ``index.html`` -- list of guides translated into $LANG

* ``errorpage.html``

* ``mitaka`` -- newer series have more complex page organizations; each
  directory is unique

  * ``admin``

    * ``index.html``

  * ``api``

    * ``index.html``

  * ``de``

    * ``index.html`` -- landing page for $series docs translated into $LANG

  * ``index.html``
  * ``language-bindings.html``
  * ``projects.html``
  * ``user``

    * ``index.html``

* ``pike``

  * ``admin``

    * ``index.html``

  * ``api``

    * ``index.html``

  * ``configuration``

    * ``index.html``

  * ``deploy``

    * ``index.html``

  * ``index.html``
  * ``install``

    * ``index.html``

  * ``language-bindings.html``
  * ``projects.html``
  * ``user``

    * ``index.html``

* ``project-data`` -- YAML files with data about projects in each $series

  * ``latest.yaml``
  * ``mitaka.yaml``
  * ``newton.yaml``
  * ``ocata.yaml``
  * ``pike.yaml``
  * ``README.rst``
  * ``schema.yaml``

* ``redirect-tests.txt`` -- input file for `whereto <https://docs.openstack.org/whereto/>`_
  to test ``.htaccess``;
  see http://files.openstack.org/docs-404s/ for a list of recent 404
  errors
* ``static`` -- contains files that are not templates (CSS, JS,
  sitemap, etc.)
* ``templates`` -- contains reused templates (base pages, partial
  pages, etc.)

  * ``api_guides.tmpl``
  * ``base.tmpl``
  * ``contributor_guides.tmpl``
  * ``css.tmpl``
  * ``default.tmpl``
  * ``dropdown_languages.tmpl``
  * ``footer.tmpl``
  * ``google_analytics.tmpl``
  * ``header.tmpl``
  * ``indexbase.tmpl``
  * ``navigation.tmpl``
  * ``ops_and_admin_guides.tmpl``
  * ``project_guides.tmpl``
  * ``script_footer.tmpl``
  * ``script_search.tmpl``
  * ``series_status.tmpl``
  * ``os_search_install.tmpl``
  * ``os_search_mobile.tmpl``
  * ``os_search.tmpl``
  * ``training_guides.tmpl``
  * ``user_guides.tmpl``

.. NOTE(dhellmann): The whereto link will move to docs.o.o as soon as
   the publishing jobs are updated.

Defining release series
~~~~~~~~~~~~~~~~~~~~~~~

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
~~~~~~~~~~~~~~~~~~~~~~~~

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

The ``deliverable-name`` should be the name of the deliverable as
defined in ``openstack/governance/reference/projects.yaml``. This
value only needs to be set if the deliverable name does not match the
project name (such as ``glance_store`` and ``glance-store``).

The ``service`` string should be taken from the governance repository
definition of the project.

The ``type`` must be one of the values listed below:

``service``
    A REST API service.

``cloud-client``
    A library for talking to a cloud.

``service-client``
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
<http://opendev.org/openstack/service-types-authority/>`_.

Entries with ``type`` set to ``client`` should include a ``description``
field with a short description, such as "keystone client".

Entries may optionally set flags to indicate that the repository
includes particular types of documentation in an expected location, to
include a link to that documentation on the templated landing pages.

``has_install_guide``
    produces a link to ``docs.o.o/{{name}}/latest/install/``

``has_api_guide``
    produces a link to ``developer.o.o/api-guide/{{service_type}}/``

``has_api_ref``
    produces a link to ``developer.o.o/api-ref/{{service_type}}/``

``has_config_ref``
    produces a link to ``docs.o.o/{{name}}/latest/configuration/``

``has_in_tree_api_docs``
    produces a link to ``docs.o.o/{{name}}/latest/api/``

``has_admin_guide``
    produces a link to ``docs.o.o/{{name}}/latest/admin/``

``has_in_tree_htaccess``
    enables full redirects to old paths, not just to the top of
    ``/{{name}}/latest/``

``has_deployment_guide``
    produces a link to ``docs.o.o/project-deploy-guide/{{name}}/{{series}}/``

.. note::

   The documentation associated with the flags must exist before the
   flags are set.

Template variables
~~~~~~~~~~~~~~~~~~

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
  The path to the top of the build output (relative path by default and
  absolute URL with ``--publish`` option). This is useful for
  building paths between output pages in a way that allows those pages
  to move around later.

``SCRIPTDIR``
  The path to the location of the JavaScript directory in the
  build output (relative path by default and absolute URL with
  ``--publish`` option).
  This is useful for building links to JavaScript files.

``CSSDIR``
  The path to the location of the directory containing the
  CSS files in the build output (relative path by default and absolute URL
  with ``--publish`` option). This is useful for building links to
  CSS files.

``IMAGEDIR``
  The path to the location of the directory containing image
  files in the build output (relative path by default and absolute URL
  with ``--publish`` option). This is useful for building links to
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

Common tasks
~~~~~~~~~~~~

How would I change a page?
--------------------------

1. Look for the ``TEMPLATE_FILE`` value in the page source to find which
   file produces the page.

   The source for https://docs.openstack.org/pike/ shows:

   .. code-block:: none

      <!-- TEMPLATE_FILE: openstack-manuals/www/pike/index.html -->

2. Modify the file or one of the other templates from which it
   inherits.

   ``www/pike/index.html`` has a base template of
   ``www/templates/indexbase.tmpl`` which contains:

   .. code-block:: none

      {% include "templates/series_status.tmpl" %}

   and that directive pulls in ``www/templates/series_status.tmpl``.

How would I add a new project?
------------------------------

Modify ``www/project-data/latest.yaml`` to add the new stanza.

Flags for having various types of docs default to off; only list the
ones that should be turned on.  Set the type for the project to ensure
it shows up in the correct list(s).

How would I add a new flag to the project metadata?
---------------------------------------------------

1. Update the schema to allow the flag by changing
   ``www/project-data/schema.yaml``.

2. Update the documentation team contributor guide to explain the
   flag's use by modifying
   ``doc/doc-contribu-guide/source/doc-tools/template-generator.rst``.

3. Update ``www/project-data/latest.yaml`` to set the flag for some project(s).

4. Update/create the template that will use the flag.

How would I add a new page?
---------------------------

Copy an existing template file to the new name under ``www/`` and then
modify it.

How does the final release process work?
----------------------------------------

See :doc:`../release/taskdetail`.

Testing the build
-----------------

There are two commands useful for testing the build locally:

.. code-block:: console

   $ tox -e publishdocs

and

.. code-block:: console

   $ tools/test.sh

The test script supports a few options to make it more effective.

``--skip-links``
  Skip link checks
``--series SERIES``
  series to update/test
``--check-all-links``
  Check for links with flags set false.

To test template rendering without waiting for link checks:

.. code-block:: console

   $ ./tools/test.sh --skip-links

To test project links only for items listed in latest.yaml:

.. code-block:: console

   $ ./tools/test.sh --series latest

To produce a list of the unset flags for latest.yaml that *could* be
set (the pages linked do exist):

.. code-block:: console

   $ ./tools/test.sh --check-all-links --series latest
