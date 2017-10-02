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
  Guide against, and start looking for willing volunteers to help test.

*Four weeks*
  Ping Cross Project Liaisons (CPLs) to check their chapters, and ping
  packagers to check on package availability. As soon as pre-release
  packages are available, ask people to start testing.

*Two to four weeks*
  Ping Speciality Team leads to review and update release notes for
  openstack-manuals.

*At RC1*
  When projects create their branches and land the first patch,
  they will automatically have branch-specific documentation. After
  the branches are created, create the project data file in the
  ``openstack-manuals`` repository for the new series.

*Before or on release day*
  Update the series settings in the template generator and add the
  landing page for the next series by copying the templates from the
  current release to the new release directory.
