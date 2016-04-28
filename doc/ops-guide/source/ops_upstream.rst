==================
Upstream OpenStack
==================

OpenStack is founded on a thriving community that is a source of help
and welcomes your contributions. This chapter details some of the ways
you can interact with the others involved.

Getting Help
~~~~~~~~~~~~

There are several avenues available for seeking assistance. The quickest
way is to help the community help you. Search the Q&A sites, mailing
list archives, and bug lists for issues similar to yours. If you can't
find anything, follow the directions for reporting bugs or use one of
the channels for support, which are listed below.

Your first port of call should be the official OpenStack documentation,
found on http://docs.openstack.org. You can get questions answered on
http://ask.openstack.org.

`Mailing lists <https://wiki.openstack.org/wiki/Mailing_Lists>`_ are
also a great place to get help. The wiki page has more information about
the various lists. As an operator, the main lists you should be aware of
are:

`General list <http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack>`_
    *openstack@lists.openstack.org*. The scope of this list is the
    current state of OpenStack. This is a very high-traffic mailing
    list, with many, many emails per day.

`Operators list <http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-operators>`_
    *openstack-operators@lists.openstack.org.* This list is intended for
    discussion among existing OpenStack cloud operators, such as
    yourself. Currently, this list is relatively low traffic, on the
    order of one email a day.

`Development list <http://lists.openstack.org/cgi-bin/mailman/listinfo/openstack-dev>`_
    *openstack-dev@lists.openstack.org*. The scope of this list is the
    future state of OpenStack. This is a high-traffic mailing list, with
    multiple emails per day.

We recommend that you subscribe to the general list and the operator
list, although you must set up filters to manage the volume for the
general list. You'll also find links to the mailing list archives on the
mailing list wiki page, where you can search through the discussions.

`Multiple IRC channels <https://wiki.openstack.org/wiki/IRC>`_ are
available for general questions and developer discussions. The general
discussion channel is #openstack on *irc.freenode.net*.

Reporting Bugs
~~~~~~~~~~~~~~

As an operator, you are in a very good position to report unexpected
behavior with your cloud. Since OpenStack is flexible, you may be the
only individual to report a particular issue. Every issue is important
to fix, so it is essential to learn how to easily submit a bug
report.

All OpenStack projects use `Launchpad <https://launchpad.net/>`_
for bug tracking. You'll need to create an account on Launchpad before you
can submit a bug report.

Once you have a Launchpad account, reporting a bug is as simple as
identifying the project or projects that are causing the issue.
Sometimes this is more difficult than expected, but those working on the
bug triage are happy to help relocate issues if they are not in the
right place initially:

-  Report a bug in
   `nova <https://bugs.launchpad.net/nova/+filebug/+login>`_.

-  Report a bug in
   `python-novaclient <https://bugs.launchpad.net/python-novaclient/+filebug/+login>`_.

-  Report a bug in
   `swift <https://bugs.launchpad.net/swift/+filebug/+login>`_.

-  Report a bug in
   `python-swiftclient <https://bugs.launchpad.net/python-swiftclient/+filebug/+login>`_.

-  Report a bug in
   `glance <https://bugs.launchpad.net/glance/+filebug/+login>`_.

-  Report a bug in
   `python-glanceclient <https://bugs.launchpad.net/python-glanceclient/+filebug/+login>`_.

-  Report a bug in
   `keystone <https://bugs.launchpad.net/keystone/+filebug/+login>`_.

-  Report a bug in
   `python-keystoneclient <https://bugs.launchpad.net/python-keystoneclient/+filebug/+login>`_.

-  Report a bug in
   `neutron <https://bugs.launchpad.net/neutron/+filebug/+login>`_.

-  Report a bug in
   `python-neutronclient <https://bugs.launchpad.net/python-neutronclient/+filebug/+login>`_.

-  Report a bug in
   `cinder <https://bugs.launchpad.net/cinder/+filebug/+login>`_.

-  Report a bug in
   `python-cinderclient <https://bugs.launchpad.net/python-cinderclient/+filebug/+login>`_.

-  Report a bug in
   `manila <https://bugs.launchpad.net/manila/+filebug/+login>`_.

-  Report a bug in
   `python-manilaclient <https://bugs.launchpad.net/python-manilaclient/+filebug/+login>`_.

-  Report a bug in
   `python-openstackclient <https://bugs.launchpad.net/python-openstackclient/+filebug/+login>`_.

-  Report a bug in
   `horizon <https://bugs.launchpad.net/horizon/+filebug/+login>`_.

-  Report a bug with the
   `documentation <https://bugs.launchpad.net/openstack-manuals/+filebug/+login>`_.

-  Report a bug with the `API
   documentation <https://bugs.launchpad.net/openstack-api-site/+filebug/+login>`_.

To write a good bug report, the following process is essential. First,
search for the bug to make sure there is no bug already filed for the
same issue. If you find one, be sure to click on "This bug affects X
people. Does this bug affect you?" If you can't find the issue, then
enter the details of your report. It should at least include:

-  The release, or milestone, or commit ID corresponding to the software
   that you are running

-  The operating system and version where you've identified the bug

-  Steps to reproduce the bug, including what went wrong

-  Description of the expected results instead of what you saw

-  Portions of your log files so that you include only relevant excerpts

When you do this, the bug is created with:

-  Status: *New*

In the bug comments, you can contribute instructions on how to fix a
given bug, and set it to *Triaged*. Or you can directly fix it: assign
the bug to yourself, set it to *In progress*, branch the code, implement
the fix, and propose your change for merging. But let's not get ahead of
ourselves; there are bug triaging tasks as well.

Confirming and Prioritizing
---------------------------

This stage is about checking that a bug is real and assessing its
impact. Some of these steps require bug supervisor rights (usually
limited to core teams). If the bug lacks information to properly
reproduce or assess the importance of the bug, the bug is set to:

-  Status: *Incomplete*

Once you have reproduced the issue (or are 100 percent confident that
this is indeed a valid bug) and have permissions to do so, set:

-  Status: *Confirmed*

Core developers also prioritize the bug, based on its impact:

-  Importance: <Bug impact>

The bug impacts are categorized as follows:

#. *Critical* if the bug prevents a key feature from working properly
   (regression) for all users (or without a simple workaround) or
   results in data loss

#. *High* if the bug prevents a key feature from working properly for
   some users (or with a workaround)

#. *Medium* if the bug prevents a secondary feature from working
   properly

#. *Low* if the bug is mostly cosmetic

#. *Wishlist* if the bug is not really a bug but rather a welcome change
   in behavior

If the bug contains the solution, or a patch, set the bug status to
*Triaged*.

Bug Fixing
----------

At this stage, a developer works on a fix. During that time, to avoid
duplicating the work, the developer should set:

-  Status: *In Progress*

-  Assignee: <yourself>

When the fix is ready, the developer proposes a change and gets the
change reviewed.

After the Change Is Accepted
----------------------------

After the change is reviewed, accepted, and lands in master, it
automatically moves to:

-  Status: *Fix Committed*

When the fix makes it into a milestone or release branch, it
automatically moves to:

-  Milestone: Milestone the bug was fixed in

-  Status: \ *Fix Released*

Join the OpenStack Community
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Since you've made it this far in the book, you should consider becoming
an official individual member of the community and `join the OpenStack
Foundation <https://www.openstack.org/join/>`_. The OpenStack
Foundation is an independent body providing shared resources to help
achieve the OpenStack mission by protecting, empowering, and promoting
OpenStack software and the community around it, including users,
developers, and the entire ecosystem. We all share the responsibility to
make this community the best it can possibly be, and signing up to be a
member is the first step to participating. Like the software, individual
membership within the OpenStack Foundation is free and accessible to
anyone.

How to Contribute to the Documentation
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack documentation efforts encompass operator and administrator
docs, API docs, and user docs.

The genesis of this book was an in-person event, but now that the book
is in your hands, we want you to contribute to it. OpenStack
documentation follows the coding principles of iterative work, with bug
logging, investigating, and fixing.

Just like the code, http://docs.openstack.org is updated constantly
using the Gerrit review system, with source stored in git.openstack.org
in the `openstack-manuals
repository <https://git.openstack.org/cgit/openstack/openstack-manuals/>`_
and the `api-site
repository <https://git.openstack.org/cgit/openstack/api-site/>`_.

To review the documentation before it's published, go to the OpenStack
Gerrit server at \ http://review.openstack.org and search for
`project:openstack/openstack-manuals <https://review.openstack.org/#/q/status:open+project:openstack/openstack-manuals,n,z>`_
or
`project:openstack/api-site <https://review.openstack.org/#/q/status:open+project:openstack/api-site,n,z>`_.

See the `How To Contribute page on the
wiki <https://wiki.openstack.org/wiki/How_To_Contribute>`_ for more
information on the steps you need to take to submit your first
documentation review or change.

Security Information
~~~~~~~~~~~~~~~~~~~~

As a community, we take security very seriously and follow a specific
process for reporting potential issues. We vigilantly pursue fixes and
regularly eliminate exposures. You can report security issues you
discover through this specific process. The OpenStack Vulnerability
Management Team is a very small group of experts in vulnerability
management drawn from the OpenStack community. The team's job is
facilitating the reporting of vulnerabilities, coordinating security
fixes and handling progressive disclosure of the vulnerability
information. Specifically, the team is responsible for the following
functions:

Vulnerability management
    All vulnerabilities discovered by community members (or users) can
    be reported to the team.

Vulnerability tracking
    The team will curate a set of vulnerability related issues in the
    issue tracker. Some of these issues are private to the team and the
    affected product leads, but once remediation is in place, all
    vulnerabilities are public.

Responsible disclosure
    As part of our commitment to work with the security community, the
    team ensures that proper credit is given to security researchers who
    responsibly report issues in OpenStack.

We provide two ways to report issues to the OpenStack Vulnerability
Management Team, depending on how sensitive the issue is:

-  Open a bug in Launchpad and mark it as a "security bug." This makes
   the bug private and accessible to only the Vulnerability Management
   Team.

-  If the issue is extremely sensitive, send an encrypted email to one
   of the team's members. Find their GPG keys at `OpenStack
   Security <http://www.openstack.org/projects/openstack-security/>`_.

You can find the full list of security-oriented teams you can join at
`Security Teams <https://wiki.openstack.org/wiki/SecurityTeams>`_. The
vulnerability management process is fully documented at `Vulnerability
Management <https://wiki.openstack.org/wiki/VulnerabilityManagement>`_.

Finding Additional Information
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In addition to this book, there are many other sources of information
about OpenStack. The
`OpenStack website <http://www.openstack.org/>`_
is a good starting point, with
`OpenStack Docs <http://docs.openstack.org/>`_ and `OpenStack API
Docs <http://developer.openstack.org/>`_ providing technical
documentation about OpenStack. The `OpenStack
wiki <https://wiki.openstack.org/wiki/Main_Page>`_ contains a lot of
general information that cuts across the OpenStack projects, including a
list of `recommended
tools <https://wiki.openstack.org/wiki/OperationsTools>`_. Finally,
there are a number of blogs aggregated at \ `Planet
OpenStack <http://planet.openstack.org/>`_.OpenStack community
additional information
