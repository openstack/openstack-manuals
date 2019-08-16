.. _release-task-detail:

===================
Release task detail
===================

This section provides detailed instructions for each release task.

Installation Guides testing
~~~~~~~~~~~~~~~~~~~~~~~~~~~

Testing Installation Guides for a release series is handled by each project
team's members or individual documentation contributors.

When testing installation documentation for a project, it is important to test
it together with other related projects by using their project-specific
installation docs. This is best achieved by following the instructions from
the common
`OpenStack Installation Guide <https://docs.openstack.org/install-guide/>`_.

Remember that all project installation documentation must be based on the
common OpenStack Installation Guide and must link back to that Guide.

A list of all project installation guides for the release series under
development is available from https://docs.openstack.org/latest/install/.

For convenience, an `Installation Guides Review Inbox`_ is provided. The Inbox
offers an overview of currently open changes that touch files under
``doc/source/install/`` in project team repositories.

.. _`Installation Guides Review Inbox`:
   https://review.opendev.org/#/dashboard/?foreach=file%3A%22%5Edoc%5C%2Fsou
   rce%5C%2Finstall%5C%2F.%2A%22%0Astatus%3Aopen%0ANOT+owner%3Aself%0ANOT+labe
   l%3AWorkflow%3C%3D%2D1%0Alabel%3AVerified%3E%3D1%2Czuul%0ANOT+reviewedby%3A
   self&title=Installation+Guides+Review+Inbox&Needs+final+%2B2=label%3ACode%2
   DReview%3E%3D2+limit%3A50+NOT+label%3ACode%2DReview%3C%3D%2D1%2Cself&Passed
   +Zuul%2C+No+Negative+Feedback+%28Small+Fixes%29=NOT+label%3ACode%2DReview%3
   E%3D2+NOT+label%3ACode%2DReview%3C%3D%2D1+delta%3A%3C%3D10&Passed+Zuul%2C+N
   o+Negative+Feedback=NOT+label%3ACode%2DReview%3E%3D2+NOT+label%3ACode%2DRev
   iew%3C%3D%2D1+delta%3A%3E10&Needs+Feedback+%28Changes+older+than+5+days+tha
   t+have+not+been+reviewed+by+anyone%29=NOT+label%3ACode%2DReview%3C%3D%2D1+N
   OT+label%3ACode%2DReview%3E%3D1+age%3A5d&You+are+a+reviewer%2C+but+haven%27
   t+voted+in+the+current+revision=NOT+label%3ACode%2DReview%3C%3D%2D1%2Cself+
   NOT+label%3ACode%2DReview%3E%3D1%2Cself+reviewer%3Aself&Wayward+Changes+%28
   Changes+with+no+code+review+in+the+last+2+days%29=NOT+is%3Areviewed+age%3
   A2d

As soon as pre-release packages are available, you can start testing. Testers
should look at the current latest version of the document, and attempt to run
each command on the pre-release package. If a command cannot be run, and it is
confirmed to be a bug in the documentation, file a bug against the appropriate
project in Launchpad.

Release Notes
~~~~~~~~~~~~~

OpenStack Manuals no longer handles release notes for the project teams.
However, we do need to write release notes for our documentation. Release
notes should be added as major changes occur throughout the release, however
this is often overlooked – both by authors and reviewers – and thus a final
review is needed to check that all major changes are in.

Contact each subteam lead, listed at :doc:`../team-structure`, and ask them
for the notes for the documentation they look after.

The source for release notes is
``openstack-manuals/releasenotes/source/RELEASENAME.rst`` and they are
published to
``https://docs.openstack.org/releasenotes/openstack-manuals/RELEASENAME.html``.

.. _release-www-page-updates:

Update www pages for end of release
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Make the following changes in the **openstack-manuals** repository:

#. Copy the "latest" project data file to one *named for the release
   being completed*:

   .. code-block:: console

      $ cp www/project-data/latest.yaml www/project-data/RELEASE.yaml

#. Create the docs.openstack.org pages for the *new* release, by
   copying the existing templates to the new directory:

   .. code-block:: console

      $ cp -a www/RELEASE www/NEXT_SERIES

#. Update the ``SERIES_INFO`` data structure at the top of the source
   file for the template generator (``tools/www-generator.py``). See
   :ref:`template-generator` for details about the structure.

   * Change the series with status ``'development'`` to have status
     ``'maintained'``.
   * Add a new entry for the new series, giving the estimated release
     date and setting the status to ``'development'``.

   For example, at the end of the Pike cycle, the variables will
   contain:

   .. code-block:: python

      SERIES_INFO = {
          'austin': SeriesInfo(date='October 2010', status='obsolete'),
          # ...
          'mitaka': SeriesInfo(date='April 2016', status='EOL'),
          'newton': SeriesInfo(date='October 2016', status='maintained'),
          'ocata': SeriesInfo(date='February 2017', status='maintained'),
          'pike': SeriesInfo(date='August 2017', status='development'),
      }

   To update the settings:

   * the status for pike is changed to ``'maintained'``
   * a new entry for queens is added

   .. code-block:: python

      SERIES_INFO = {
          'austin': SeriesInfo(date='October 2010', status='obsolete'),
          # ...
          'mitaka': SeriesInfo(date='April 2016', status='EOL'),
          'newton': SeriesInfo(date='October 2016', status='maintained'),
          'ocata': SeriesInfo(date='February 2017', status='maintained'),
          'pike': SeriesInfo(date='August 2017', status='maintained'),
          'queens': SeriesInfo(date='August 2017', status='development'),
      }

   This will cause docs.openstack.org to redirect to the
   series-specific landing page for the current release, and the
   templates for the release being completed will use the data from
   the file created in the previous step.

#. Test the build locally with ``tox -e publishdocs``.

   If any project links are missing and cause the template generator
   to fail, set the flags to disable linking to those docs. For
   example, if "foo" does not have a configuration reference guide,
   set ``has_config_ref: false`` for the "foo" project by modifying
   the file created in step 1.

   .. note::

      If any link flags are set to false or any projects are commented
      out, someone will need to periodically check for those documents
      to be published when the new branches are created in the
      affected projects. All branches should be created before the
      final release deadline, so it should be possible to update the
      project-data settings by then to have the site link to all of
      the latest documentation.

.. warning::

   When the patch to make these changes merges, docs.openstack.org
   will immediately update to redirect to the release. The previous
   release pages will still be present at their old locations.

.. note::

   Changes to the docs site can take an hour or more to populate,
   depending on the status of the gate and the number of changes being
   pushed at release time, so be prepared to have the release day
   patches ready well ahead of the official release time. You can
   check the current gate status at `Zuul status
   <http://zuul.openstack.org/>`_ to get an idea of the current
   merge times.

Generate the site map
~~~~~~~~~~~~~~~~~~~~~

After the release day patches have merged, generate a new site map for
docs.openstack.org using the ``sitemap`` script in the **openstack-doc-tools**
repository. Copy the `sitemap.xml` file into the `www/static` directory in
the **openstack-manuals** repository and commit the change.

End-of-life
~~~~~~~~~~~

Once a release is at end-of-life, you must stop producing new publications.
To indicate the end-of-life, add the below sentence at the index
for release-specific documentation:

.. code-block:: rst

   .. warning::

      This guide documents the OpenStack Liberty release and is frozen
      as OpenStack Liberty has reached its official end-of-life.
      This guide will not get any updates from the OpenStack project anymore.
      See the `OpenStack Documentation page
      <https://docs.openstack.org/>`_ for current documentation.

For continuously released documentation, exclude the release from target.

For example, from:

.. code-block:: rst

   This guide documents OpenStack Newton, Mitaka, and Liberty releases.

To:

.. code-block:: rst

   This guide documents OpenStack Newton and Mitaka releases.

.. seealso::

   See :ref:`docs_builds_eol` for instructions for building
   documentation for versions past their end-of-life.
