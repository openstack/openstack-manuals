======================
Release tasks overview
======================

This section provides an overview of the tasks that need to be completed
for a documentation release, and a rough schedule of when to complete
each task. The schedule is expressed in terms of `time before release day`.
Release day is usually 1300UTC on the `initial release date` listed on the
`release schedule <https://releases.openstack.org>`_.

*Four to six weeks before release*
  Ping packagers to locate pre-release packages to test the Installation
  Tutorial against, and start looking for willing volunteers to help test.

*Four weeks*
  Ping Cross Project Liaisons (CPLs) to check their chapters, and ping
  packagers to check on package availability. As soon as pre-release
  packages are available, ask people to start testing.

*Two to four weeks*
  Ping Speciality Team leads to review and update release notes for
  openstack-manuals.

*One to two weeks*
  Publish project-specific docs to new branch, publish index pages to docs
  (but leave unlinked).

*One week*
 Check and update all books to have correct version information, and update
 any links in each book to refer to the new release. Run scripts to pull the
 latest changes for the Configuration Reference and CLI Reference Guides.

*On release day*
  Add new release name to the dropdown menu on the docs page, regenerate the
  sitemap.xml, and change the front page so the new release is the default.

*After release day*
  Cut the branch for versioned guides. This usually happens about a month
  after release day, but the timing is informed mainly by the volume of
  changes going in to the guides. Update the sphinxmark configuration files
  for versioned guides with the latest release name.
