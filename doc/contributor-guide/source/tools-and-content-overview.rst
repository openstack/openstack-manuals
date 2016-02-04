.. _tools_and_content:

==========================
Tools and content overview
==========================

While in the past the documentation team used DocBook format, the guides are
now being converted from DocBook to ReStructured Text (RST). For more
information on the conversion, see `Doc Migration from DocBook to RST`_.

To work on the RST source files, find the :file:`/doc/guide/source/` directory
in a given OpenStack project. These files are built to
*docs.openstack.org/<guide-name>*, for example,
http://docs.openstack.org/user-guide-admin.

Many cross-project manuals are in the
http://git.openstack.org/cgit/openstack/openstack-manuals/tree/ project.

To work on the DocBook and WADL source files for http://developer.openstack.org,
look for the http://git.openstack.org/cgit/openstack/api-site project
and use the same `development workflow`_.

The builds are listed on the :ref:`docs_builds` page, showing what
source files are built from.

OpenStack projects
~~~~~~~~~~~~~~~~~~

The OpenStack Documentation program focuses on documentation for the
following primary projects:

* Compute service (nova)
* Identity service (keystone)
* Image service (glance)
* Networking service (neutron)
* Block Storage service (cinder)
* Object Storage service (swift)

The Documentation program has cross-project liaisons (CPLs) who assist with
subject matter questions, reviews, doc bug triaging, and patching docs. Refer
to `documentation cross-project liaisons`_ for a list, and if you are
interested in becoming a CPL for docs, contact the Docs PTL.

These projects have two basic audiences: developers and sysadmins (think
operations or dev-ops). The RST-based documentation, because it automatically
generates doc from docstrings in the code, is much more for a developer
audience.

The developer documentation serves both Python developers who want to work on
OpenStack code and web developers who work with the OpenStack API.

What docs go where?
~~~~~~~~~~~~~~~~~~~

Refer to :ref:`content-specs` for a description of many documents. A long
listing of which repos house which documents is at :ref:`docs_builds`.
Generally this table describes the patterns for what goes where.

Specialty teams meet weekly to work on specific documents. For more
information about Speciality Teams, including how to get involved, see:
`Speciality Teams`_.

.. TODO (MZ) Change the link above as soon as the page is converted.

.. important::

   Some content is completely generated using openstack-doc-tools,
   such as the configuration option tables and the CLI reference information.
   You will see the following warning in the source file: **<!-- This file is
   automatically generated, do not edit -->**. When you see this, you can still
   update the file using the `openstack-doc-tools`_ tool kit.

.. list-table::
   :header-rows: 1
   :widths: 10 20 20
   :stub-columns: 0
   :class: borderless

   * - Wiki
     - RST
     - WADL/Swagger

   * - Use for project docs.
     - Use for nearly all guides (migrated to RST), for Python contributor
       developer documentation, and quick starts.
     - Use for API reference information built to developer.openstack.org/api-ref.html.

   * - The audience is any project team member of OpenStack.
     - The audience is Python developers who want to work on the project. For
       the migrating content, it is for both end users and admin users.
     - The audience is typically app developers consuming OpenStack services
       through REST APIs.

   * - Output is per-page at wiki.openstack.org.
     - Output goes to *docs.openstack.org/<guide-name>* or
       *docs.openstack.org/developer/<projectname>*.
     - Output goes to developer.openstack.org/api-ref.html.

wiki.openstack.org (wikitext or RST)
------------------------------------

The OpenStack wiki contains project docs, legacy specs for blueprints, meeting
information, and meeting minutes. If there is a page you want to keep an eye
on, add it to your Watchlist (use :menuselection:`Actions > Watch` and see all
entries under :menuselection:`YourLogin > Watchlist` on the wiki).

If you add documentation specific pages, mark them as documentation-related
by adding ``[[Category:Documentation]]`` at the end of the page.

docs.openstack.org/developer/<projectname> (RST)
------------------------------------------------

The RST pages stored with the project code should be written with a developer
audience in mind, although you can find there is overlap in what an admin
needs to know and what a developer needs to know. High priorities for those
sites are wider coverage of doc strings, API doc, i18N methodology, and
architecture concepts that can help developers.

RST stands for ReStructured Text, a simple markup syntax that can be built
with Sphinx. Read more at `Sphinx documentation`_.

Operations Guide (DocBook 5)
----------------------------

doc/$BOOK contains the DocBook XML source files and images. When editing
DocBook documentation, please adhere to the DocBook 5 syntax. If you have used
DocBook version 4 or earlier before, and you are not familiar with the changes
of DocBook in V5.0, see the `Transition Guide`_.

Maven plugin
------------

The Cloud Doc Tools Maven plug-in provides a build tool that Jenkins can use
to build PDF and HTML from DocBook and WADL source files. It is maintained at http://git.openstack.org/cgit/openstack/clouddocs-maven-plugin/tree/. We
track bugs against the output in the openstack-manuals Launchpad project.

The release notes are available in the Git repository.

.. Links:

.. _`Doc Migration from DocBook to RST`: https://wiki.openstack.org/wiki/Documentation/Migrate
.. _`development workflow`: http://docs.openstack.org/infra/manual/developers.html#development-workflow
.. _`Speciality Teams`: https://wiki.openstack.org/wiki/Documentation/SpecialityTeams
.. _`documentation cross-project liaisons`: https://wiki.openstack.org/wiki/CrossProjectLiaisons#Documentation
.. _`openstack-doc-tools`: http://git.openstack.org/cgit/openstack/openstack-doc-tools/tree/README.rst
.. _`Sphinx documentation`: http://sphinx-doc.org/rest.html
.. _`Transition Guide`: http://docbook.org/docs/howto/
