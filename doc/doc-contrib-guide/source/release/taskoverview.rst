======================
Release tasks overview
======================

This section provides an overview of the tasks that need to be completed
for a documentation release, and a rough schedule of when to complete
each task. The schedule is expressed in terms of `time before release day`.
Release day is usually 1300UTC on the `initial release date` listed on the
`release schedule <https://releases.openstack.org>`_.

*Two to four weeks*
  Ping subteam leads to review and update release notes for openstack-manuals.

*At RC1*
  When projects create their branches and land the first patch, they will
  automatically have branch-specific documentation.

*Before or on release day*
  Create a project data file in the ``openstack-manuals`` repository for the
  new series. Update the series settings in the template generator and add the
  landing page for the next series by copying the templates from the
  current release to the new release directory.
