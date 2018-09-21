.. _doc_bugs:

==================
Documentation bugs
==================

The Documentation team tracks some of its work through bugs. This section
includes the detailed overview of documentation bugs specifics.

The Documentation team uses the following projects for tracking documentation
bugs for repositories managed by the Documentation project or the project's
subteams:

* `openstack-manuals <https://bugs.launchpad.net/openstack-manuals>`_ is the
  default area for doc bugs in the openstack-manuals repository.

* `openstack-api-site <https://bugs.launchpad.net/openstack-api-site>`_ is used
  for the api-site API repository.

* `openstack-contributor-guide <https://bugs.launchpad.net/openstack-contributor-guide>`_
  is used for the contributor-guide repository.

* `OpenStack Security Guide Documentation
  <https://bugs.launchpad.net/ossp-security-documentation>`_ is used for the
  security-doc repository.

* `openstack-doc-tools <https://bugs.launchpad.net/openstack-doc-tools>`_ is
  used for the openstack-doc-tools and openstackdocstheme repositories.

Documentation bugs for project-specific repositories are tracked in the
appropriate project's bug tracking area on Launchpad.

OpenStack projects may also use
`StoryBoard <https://storyboard.openstack.org/>`_ to track cross-project
tasks involving documentation. For more information, see :ref:`doc_stories`.

Finally, OpenStack developers can use a DocImpact flag to help identify bugs
that require documentation updates in the openstack-manuals repository.

.. toctree::
   :maxdepth: 2

   doc-impact.rst

Filing a bug
~~~~~~~~~~~~

Bugs differ depending on:

* The way they are filed:

  * Manually
  * Automatically (through the DocImpact flag)

* The required changes:

  * Fix spelling errors or formatting
  * Update existing content
  * Add new content

.. important::

   Do not file a bug with troubleshooting issues. If you are experiencing
   problems with your environment, and you are following the installation
   tutorials, seek assistance from the relevant team and operations
   specialists on IRC,
   `ask.openstack.org <https://ask.openstack.org/en/questions/>`_
   or the OpenStack mailing list.

   For more information about the relevant IRC channels, see the
   `OpenStack IRC wiki <https://wiki.openstack.org/wiki/IRC>`_.

   For more information about the OpenStack mailing list, see the
   `Mailing lists wiki <https://wiki.openstack.org/wiki/Mailing_Lists>`_.

   A bug should be filed only if the documentation itself is found to be
   incorrect.

Working on documentation bugs
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Do not work on a documentation bug until it is set to
'Confirmed'. Ideally, someone other than the reporter will confirm the bug
for you. Once the changes are made in a patch, they are reviewed and approved,
just like other OpenStack code.

To pick up a documentation bug or mark a bug as related to the
documentation, go to `the aggregated list of documentation bugs from all
OpenStack projects
<https://bugs.launchpad.net/openstack/+bugs?field.tag=documentation>`_.

.. _doc_stories:

Working on documentation stories
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack projects may use `StoryBoard <https://storyboard.openstack.org/>`_
to track cross-project tasks. When these tasks involve documentation, the
tasks should be tagged as such in StoryBoard, allowing you to view
`the aggregated list of documentation stories from all OpenStack projects
<https://storyboard.openstack.org/#!/story/list?status=active&q=documentation%20docs>`_.

Triaging bugs for openstack-manuals
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following sections detail the role of the bug triage liaison and the
process and guidelines of bug triaging for the openstack-manuals repository.

Project-specific repositories follow their respective team's processes and
guidelines for bug triaging.

Bug triage liaison
------------------

The documentation team assigns bug triage liaisons to ensure all bugs reported
against the openstack-manuals repository are triaged in a timely manner.

If you are interested in serving as a bug triage liaison, there are several
steps you will need to follow in order to be prepared.

.. note::

   Read this page in full. Keep this document in mind at all times as it
   describes the duties of the liaison and how to triage bugs. In particular,
   it describes how to set bug importance, and how to select bug tags.

#. Before you begin to work on documentation bugs, you must join the
   openstack-doc-bugs team on Launchpad. For more information,
   see :ref:`first_timers`.

#. Sign up for openstack-manuals emails from Launchpad if you have not already:

   #. Navigate to the `Launchpad openstack-manuals bug list
      <https://bugs.launchpad.net/openstack-manuals>`_.
   #. Click on the right hand side, :guilabel:`Subscribe to bug mail`.
   #. In the pop-up that is displayed, keep the recipient as
      :guilabel:`Yourself`, and name your subscription something useful
      like :guilabel:`Docs Bugs`. You can choose
      either option or how much mail you get, but keep in mind that getting
      mail for all changes - while informative - will result in several dozen
      emails per day at least.

#. Volunteer during the course of the Documentation team meeting, when
   volunteers to be bug deputy are requested.

   Alternatively, use the #openstack-doc IRC channel or the
   openstack-dev@lists.openstack.org mailing list to contact the documentation
   core team members.

#. Sign up as a volunteer by adding your name to the bug triaging schedule on the
   `Bug Triage Team
   <https://wiki.openstack.org/wiki/Documentation/SpecialityTeams#Bug_Triage_Team>`_
   page.

#. During your scheduled time as a liaison, if it is feasible for your
   timezone, plan on attending the Documentation team meeting. That way if you
   have any CRITICAL or HIGH bugs, you can address them with the team.

Bug triaging process
--------------------

The process of bug triaging consists of the following steps:

* Check if a bug was filed for a correct component (project). If not,
  either change the project or mark it as ``Invalid``.
  For example, if the bug impacts the project-specific dev-ref, then
  mark it as ``Invalid``. If a bug is reported against the nova installation
  guide, ensure openstack-manuals is removed, and the nova project is added.

* If the reported bug affects the ReST API, tools, openstackdocstheme, or
  the Security Guide, add the relevant project to the affected
  projects and remove ``openstack-manuals``.
  For example, if the bug affects the ReST API, file a bug in
  ``openstack-api-site`` and remove ``openstack-manuals``.

* Tag the bug for the appropriate guide. For example, for the
  ``image-guide`` remove ``glance`` from the affected projects if it
  only affects ``openstack-manuals`` and tag ``image-guide``.

* Set the bug to ``Invalid`` if it is a request for support or a
  troubleshooting request.

* Check if a similar bug was filed before. You may also check
  already verified bugs to see if the bug has been reported. If so, mark it as
  a duplicate of the previous bug.

* Verify if the bug meets the requirements of a good bug report by checking
  that the guidelines or checklist has been followed.

* Omitted information is still acceptable if the issue is clear. Use your good
  judgment and your experience and consult another core member or the PTL if in
  doubt. If the bug report requires more context, mark the bug as
  ``Incomplete``, point the submitter to this document.

.. _guidelines:

Doc bug triaging guidelines
---------------------------

Bug triaging is the process of reviewing new bugs, verifying whether a bug is
valid or not, and gathering more information about it. Before being triaged,
all the new bugs have the status New, and importance Undecided. Here are the
definitions for available options for Status and Importance columns of any bug.

**Status:**

* **New** - Recently logged by a non-triaging person.
* **Incomplete** - Needs additional information before it can be triaged.
* **Opinion** - Does not fit the project but can still be discussed.
* **Invalid** - Not an issue for docs.
* **Won't Fix** - Documentation fixes won't fix the issue.
* **Confirmed** - Acknowledged that it is a documentation bug.
* **Triaged** - Comments in the bug indicate its scope and amount of work to
  be done.
* **In Progress** - Someone is working on it.
* **Fix Committed** - A fix is in the repository; Gerrit sets this
  automatically. Do not set this manually.
* **Fix Released** - A fix is published to the site.

.. note::

   Since all documentation is released directly on docs.openstack.org, the
   "Fix Committed" status is deprecated. If a patch contains the line
   "Closes-Bug: #12345" (see git commit messages for details), our CI
   infrastructure automatically sets the bug to "Fix Released" once the patch
   is merged.

**Importance:**

* **Critical** - Data will be lost if this bug stays in; or it is so bad that
  we are better off fixing it than dealing with all the incoming questions
  about it. Also items on the website itself that prevent access are Critical
  doc bugs.
* **High** - Definitely need docs about this or a fix to current docs; docs are
  incomplete without this. Work on these first if possible.
* **Medium** - Need docs about this within a six-month release timeframe.
* **Low** - Docs are fine without this but could be enhanced by fixing this
  bug.
* **Wishlist** - Not really a bug but a welcome change. If something is wrong
  with the doc, mark the bug as Low rather than Wishlist.
* **Undecided** - Recently logged by a non-triaging person or requires more
  research before deciding its importance.

Tags for doc bugs
-----------------

Depending on the area a bug affects, it has one or more tags. For example:

* **low-hanging-fruit** for documentation bugs that are straightforward to fix.
  If you are a newcomer, this is a way to start.

* **install-guide**, **image-guide**, and other for specific guides.

* **infra**, **theme** for documentation bugs that are in the documentation
  build tool chain.

Tracking bugs by tag
--------------------

If you need to regularly track activity relating to particular tags,
you can set up email subscriptions by visiting
`the subscriptions page of the Launchpad project
<https://bugs.launchpad.net/openstack-manuals/+subscriptions>`_:

#. Select :guilabel:`Add a subscription`.
#. Select the option to receive mail for bugs affecting the project
   that :guilabel:`are added or changed in any way`.
#. Check the :guilabel:`Bugs must match this filter` checkbox.
#. Select the :guilabel:`Tags` subsection.
#. Populate the tag(s) you want to track.
#. Create the subscription.

Bugs for third-party drivers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. note::

   As of the Pike release, this documentation was moved into
   the project-specific repos and this option is no longer
   required.

Bugs to update tables for the configuration references use the tag
**autogenerate-config-docs**.

For updates of specific sections or adding of new drivers, follow the
specification `Proprietary driver docs in openstack-manuals
<https://specs.openstack.org/openstack/docs-specs/specs/kilo/move-driver-docs.html>`_
and assign the bug to the contact person that is mentioned on the
`Vendor driver page
<https://wiki.openstack.org/wiki/Documentation/VendorDrivers>`_. If
this is a new driver with no documentation yet, assign the bug to the
committer of the change that triggered the bug report, mark it as
**Wishlist** and ask the committer to read and follow the
specification and handle it since the documentation team will not
document third-party drivers.
