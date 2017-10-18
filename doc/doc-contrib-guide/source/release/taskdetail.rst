.. _release-task-detail:

===================
Release task detail
===================

This section provides detailed instructions for each release task.

Installation Guide testing
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The process for Installation Guide testing begins about six weeks before
release day. First of all, create a new testing page on the wiki, based on
`the previous one
<https://wiki.openstack.org/wiki/Documentation/NewtonDocTesting>`_.

You will need to locate pre-release packages for each distribution, and
disseminate information about obtaining the packages for testing purposes.
The current list of packaging contacts:

* openSUSE/SLES: Pranav Salunke (dguitarbite)
* RDO/CentOS: Petr Kovar and Haïkel Guémar
* Ubuntu: James Page

As soon as pre-release packages are available, you can start testing. Testers
should look at the current draft version of the document, and attempt to
run each command on the pre-release package. If you are able to run the
instructions in the book successfully, then place a green tick in the
matrix, noting which version you tested against. If a command cannot be run,
and it is confirmed to be a bug in the documentation, add a note in the
`Issues` section, so that the book can be updated.

.. note::

   Testers should avoid raising bugs against the book at this stage, to ensure
   that the fix lands before release. Instead, list the details on the testing
   wiki page, so other testers are aware of it.

It is also important to ask Cross Project Liaisons (CPLs) to check the
chapters or project-specific guides that relate to their projects. It is
possible that changes might have happened within projects during the
release that have not been reflected in the documentation.

As release day draws near, and testing progresses, the PTL will make a
judgment call on whether or not the various Installation Guides are
tested sufficiently to be released. In some rare cases, the book either
has not been tested adequately, or has performed badly in tests, which can
justify not publishing that book. In this case, the PTL will contact
relevant parties to let them know of the decision, and work with them to
get the book to an adequate level to be published at some point after
release day.

Release Notes
~~~~~~~~~~~~~

OpenStack Manuals no longer handles release notes for the project teams.
However, we do need to write release notes for our documentation. Release
notes should be added as major changes occur throughout the release, however
this is often overlooked - both by authors and reviewers - and thus a final
review is needed to check that all major changes are in. Contact each
Specialty Team lead, listed at :doc:`../team-structure`, and ask them for
the notes for the books they look after. The source repository for release
notes is `openstack-manuals/releasenotes/source/RELEASENAME` and they are
published to
`https://docs.openstack.org/releasenotes/openstack-manuals/RELEASENAME.html`.

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

#. Test the build locally with ``tox -e checkbuild``.

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
   <http://status.openstack.org/zuul/>`_ to get an idea of the current
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

However, we will keep the documentation on the
`docs.openstack.org <https://docs.openstack.org/>`_
page for a while so that the users can refer the guides if necessary.

.. seealso::

   See :ref:`docs_builds_eol` for instructions for building
   documentation for versions past their end-of-life.

Removing series landing pages
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To remove the landing pages for a series that has passed its end of
life date, delete the series directory under ``www`` and remove the
associated project data file.

.. code-block:: console

   $ git rm -r www/SERIES
   $ git rm www/project-data/SERIES.yaml
