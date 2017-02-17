.. _doc_bugs:

============================
Reporting documentation bugs
============================

The Documentation team tracks all its work through bugs. This section includes
the detailed overview of documentation bugs specifics.

.. note::

   To work on documentation bugs, join the openstack-doc-bugs team on
   Launchpad. For more information, see :ref:`first_timers`.

Go through the triaging process and look for possible duplicate bugs
before working on a bug. Do not work on a documentation bug until it is set to
`Confirmed`. Ideally, another person has to confirm the bug for you. Once the
changes are made in a patch, they are reviewed and approved, just like other
OpenStack code.

To pick up a documentation bug or mark a bug as related to the documentation,
go to `the aggregated list of documentation bugs from all OpenStack projects
<https://bugs.launchpad.net/openstack/+bugs?field.tag=documentation>`_.

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

**DocImpact**

When adding code that affects documentation (for example, to add a new
parameter), the developer adds a DocImpact flag. This flag automatically
files a bug in the system explaining what needs to be done. For more
information, see `Documentation/DocImpact
<https://wiki.openstack.org/wiki/Documentation/DocImpact>`_.

Launchpad projects and repositories
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The Documentation team uses the following projects for tracking documentation
bugs across OpenStack:

* `openstack-manuals <https://bugs.launchpad.net/openstack-manuals>`_ is the
  default area for doc bugs in the openstack-manuals repository.

* `OpenStack Security Guide Documentation
  <https://launchpad.net/ossp-security-documentation>`_ is used for the
  security-doc repository.

* `openstack-api-site <https://bugs.launchpad.net/openstack-api-site>`_ is used
  for the api-site API repository.

* `openstack-doc-tools <https://bugs.launchpad.net/openstack-doc-tools>`_ is
  used for the doc-tools and openstackdocstheme repositories.


.. _doc_bugs_triaging:

Doc bug triaging guidelines
~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

* **sec guide**, **install guide**, **ops-guide**, and other for specific
  guides.

* **infra**, **theme** for documentation bugs that are in the documentation
  build tool chain.

Bugs for third-party drivers
----------------------------

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

Doc bug categories
------------------

To help with bug fixing, use these quick links to pick a certain subset of
bugs:

* `list of all documentation bugs
  <https://bugs.launchpad.net/openstack-manuals>`_
* `list of all API site bugs
  <https://bugs.launchpad.net/openstack-api-site>`_
* `low hanging fruit documentation bugs
  <https://bugs.launchpad.net/openstack-manuals/+bugs?field.tag=low-hanging-fruit>`_
