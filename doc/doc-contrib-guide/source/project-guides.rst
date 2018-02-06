===================
Project guide setup
===================

OpenStack projects should follow the guidelines in this chapter for
setting up their documentation structure to make it easy to find their
documents and have consistency between OpenStack projects.

To make it easy to include links from the landing pages on
docs.openstack.org, we need to ensure a minimum level of consistency
in the organization of the docs directory. The sections are based on
high-level groupings that have evolved over the last years.

Within each top-level directory, project teams are free to organize
their content however seems most appropriate to them.

This is the proposed layout for phase 1 (pike):

* ``doc/source/``

  * ``install/`` -- anything having to do with installation of the
    project.
  * ``contributor/`` -- anything related to contributing to the
    project or how the team is managed. This applies to some of the previous
    content under ``/developer``, the name is changed to emphasize
    that not all contributors are developers and sometimes developers
    are users but not contributors. Service projects should place
    their automatically generated class documentation under this part
    of the tree, for example in ``contributor/api`` or
    ``contributor/internals``.
  * ``configuration/`` -- automatically generated configuration
    reference information based on oslo.config's sphinx integration
    (or manually written for projects not using
    oslo.config). Step-by-step guides for doing things like enabling
    cells or configuring a specific driver should be placed in the
    ``admin/`` section.
  * ``cli/`` -- command line tool reference docs, similar to man pages.
    These may be automatically generated with cliff's sphinx
    integration, or manually written when auto-generation is not
    possible. Tutorials or other step-by-step guides *using* these
    tools should go in either the ``user/`` or ``admin/`` sections,
    depending on their audience. Because the documentation for each
    project should live in the repository with the code, this
    directory may not be present for all service repositories but will
    be present for most of the client library repositories.
  * ``admin/`` -- any content from the old admin guide or anything
    else that discusses how to run or operate the software. This
    includes updating from one release to a newer version.
  * ``user/`` -- end-user content such as concept guides, advice,
    tutorials, step-by-step instructions for using the CLI to perform
    specific tasks, etc.
  * ``reference/`` -- any reference information associated with a
    project that is not covered by one of the above categories.
    Library projects should place their automatically generated class
    documentation here.

This layout is the *minimum* set. Projects are free and encouraged to
add whatever other docs they need beyond this list, but these items
are listed here explicitly because there are already links to most of
them from landing pages, and landing pages can be created for the
others.

During a later phase, we will merge the API reference and release notes builds
into the same job, along with the rest of the documentation for a project.
Both of those builds have custom considerations, though, and it is more
important to move the content that is no longer going to be maintained
by the documentation team.

* ``doc/source/``

  * ``api/`` -- the REST API reference and guide content, when it exists.
  * ``releasenotes/`` -- reno directions (the actual release notes
    inputs will stay in /releasenotes/notes, where they are now).

.. note::

   Further discussion of the layout of the ``api/`` and
   ``releasenotes/`` directories is deferred until we are further
   along with the initial migration work. If you create content, feel
   free to use these directories already as specified above.



.. toctree::
   :maxdepth: 2

   project-install-guide.rst
   project-deploy-guide.rst
