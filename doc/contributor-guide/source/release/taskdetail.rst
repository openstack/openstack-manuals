===================
Release task detail
===================

This section provides detailed instructions for each release task.

Installation Tutorial testing
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The process for Installation Tutorial testing begins about six weeks before
release day. First of all, create a new testing page on the wiki, based on
`the previous one <https://wiki.openstack.org/wiki/Documentation/NewtonDocTesting>`_.

You will need to locate pre-release packages for each distribution, and
disseminate information about obtaining the packages for testing purposes.
The current list of packaging contacts:

* Debian: Thomas Goirand (zigo)
* openSUSE/SLES: Pranav Salunke (dguitarbite)
* RDO/CentOS: Petr Kovar and Haïkel Guémar
* Ubuntu: James Page

As soon as pre-release packages are available, you can start testing. Testers
should look at the current draft version of the document, and attempt to
run each command on the pre-release package. If you are able to run the
instructions in the book successfully, then place a green tick in the
matrix, noting which version you tested against. If a command can't be run,
and it's confirmed to be a bug in the documentation, add a note in the
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
judgement call on whether or not the various Installation Tutorials are
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
Speciality Team lead, listed at :doc:`../team-structure`., and ask them for
the notes for the books they look after. The source repository for release
notes is `openstack-manuals/releasenotes/source/RELEASENAME` and they are
published to
``https://docs.openstack.org/releasenotes/openstack-manuals/RELEASENAME.html``.

Publish index page
~~~~~~~~~~~~~~~~~~

Create a new index page for docs.openstack.org, at
`openstack-manuals/www/RELEASENAME/index.html`, copying the existing page
for the current release, with updated release name and date. Add the new page
to the list in `openstack-manuals/www/www-index.html`. This patch should have
a core -2 review on it until it is ready to be published. This should happen
about a week before release day, sending the page live, but should remain
unlinked until the last moment. This is to allow the release team to link
to the new page.

Update links in all books
~~~~~~~~~~~~~~~~~~~~~~~~~

Every book maintained by OpenStack Manuals will need to be checked for
links referencing the old release. Do one patch per book, record the review
number in the release etherpad so that release managers can review easily.
For versioned books, these patches should have a core -2 review on them until
they are ready to be published at release time. For continuously released
books, these patches can be merged immediately.


Run scripts for Configuration and CLI Reference Guides
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Run scripts to pull the latest changes for the Configuration Reference and
CLI Reference Guides. Instructions for using these scripts are in the
:ref:`doc-tools` chapter.

Update main docs page
~~~~~~~~~~~~~~~~~~~~~

Change the front page so the new release is the default, by synchronising
`openstack-manuals/www/RELEASENAME/index.html`, which you created earlier,
with `openstack/openstack-manuals/www/index.html`. These two files should
have the same content. You will also need to update the release version in the
dropdown header. This is the main patch that sends the release live, so it
must have a core -2 review on it until it is ready to be published. Changes to
the docs site can take an hour or more to populate, depending on the status of
the gate and the number of changes being pushed at release time, so be
prepared to have this ready well ahead of the official release time. You can
check the current gate status at
`Zuul status <http://status.openstack.org/zuul/>`_ to get an idea of the
current merge times.

Cut the branch
~~~~~~~~~~~~~~

Cut the branch for versioned guides. This usually happens about a month
after release day, but the timing is informed mainly by the volume of
changes going in to the guides. Cutting the branch is done by the
OpenStack Infrastructure team.

Once the branch ``stable/RELEASENAME`` is created, a few things need
to be set up before any other changes merge:

* Update the ``stable/RELEASENAME`` branch (`example stable branch change
  <https://review.openstack.org/#/c/396875/>`__):

  * Disable all non-translated and non-versioned guides for
    translation.
  * Only build backported guides (install-guide, config-reference,
    networking-guide).
  * Publish backported guides and their translations to
    ``/RELEASENAME/``.
  * Do not publish web pages.
  * Update ``.gitreview`` for the branch.

* Update the ``master`` branch (`example master branch change
  <https://review.openstack.org/#/c/396874/>`__):

  * Do not copy content anymore to ``/RELEASENAME``.
  * Update the sphinxmark configuration files for versioned guides
    with the latest release name.


Also, for translations the following needs to be done:

* The translation server needs be set up for this. A version
  ``stable-RELEASENAME`` needs to be set up as copy from ``master``.
* The OpenStack CI set up needs to be adjusted for the branch. Change
  in ``openstack-infra/project-config`` the gerritbot notifications and
  the import of translations (`example infra change
  <https://review.openstack.org/396876>`__).

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
