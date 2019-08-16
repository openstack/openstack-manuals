.. _docs_review:

=======================
Reviewing documentation
=======================

OpenStack documentation is treated in the same way as code, and follows the
standard code review process. To see what documentation changes are ready for
review, use the `Documentation Program Dashboard
<https://is.gd/openstackdocsdashboard>`_ or the appropriate list of
Gerrit reviews for repositories with documentation.

The Documentation Program Dashboard only lists changes to repositories that
are managed by the Documentation project or the project's subteams. The
Dashboard is organized in groups based on the audience for the documentation.

To see current proposed changes, make sure you register and log into
`review.openstack Code Review
<https://review.opendev.org>`_. For more details on the review process in
OpenStack, see `Code Review
<https://docs.openstack.org/infra/manual/developers.html#code-review>`_.

Review guidelines
~~~~~~~~~~~~~~~~~

.. toctree::
   :maxdepth: 1

   docs-review-guidelines.rst

Repositories and core team
~~~~~~~~~~~~~~~~~~~~~~~~~~

The Documentation team is core for a number of repositories managed by the
Documentation project subteams. A list of those subteams is available from
:doc:`team-structure`.

For the security-doc repository, the rule is that each patch needs an approval
by a Docs core and a Security core.

Reviewing a documentation patch
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Before you proceed with reviewing patches, make sure to read carefully
the :doc:`Review Guidelines <docs-review-guidelines>` for documentation
and `Code Review Guidelines
<https://docs.openstack.org/infra/manual/developers.html#code-review>`_.
Once done, follow the steps below to submit a patch review.

#. If you want to review patches for the repositories managed by the
   Documentation project or the project's subteams, go to the
   `Documentation Program Dashboard
   <https://is.gd/openstackdocsdashboard>`_.

   To review patches for project teams' repositories, use the list of Gerrit
   changes for the appropriate project.
#. Select a patch set.
#. Click a file that was uploaded to view the changes side by side.
#. If you see some inconsistencies or have questions to the patch owner,
   you can also highlight the line or word in question, and press 'c'
   on your keyboard, which enables commenting directly on that line or word.
   Click :guilabel:`Save` button once you write a draft of your comment.
#. In the :guilabel:`Zuul check` section, click the ``publishdocs``
   gate link (for the openstack-manuals, it is called
   ``build-tox-manuals-publishdocs``) and review the built manuals to see how
   the change will look on the web page. For a new patch, it takes some time
   before the OpenStack CI system checks appear on the Gerrit page.
   You can also :ref:`build the patch locally <docs_builds_locally>`
   if necessary.
#. Click :guilabel:`Reply` to vote and enter any comments about your review,
   then click :guilabel:`Post`.

.. note::

   A patch with WorkInProgress (WIP) status needs additional work
   before review and possible approval. Therefore, you may skip such a patch
   and review once it is ready. For more information, see `Work In Progress
   <https://docs.openstack.org/infra/manual/core.html#work-in-progress>`_.

.. seealso::

   `Peer Review
   <https://docs.openstack.org/infra/manual/developers.html#peer-review>`_

.. note::

   The following information only applies to repositories managed by the
   Documentation project.

Achieving core reviewer status
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Core reviewers are able to +2 and merge content into the projects they
have core status in. Core status is granted to those who have not
only done a sufficient quantity of reviews, but who also have shown care
and wisdom in those reviews.

The core reviewer's role is complex, and having a great core team is crucial
to the success of any OpenStack project. The documentation team aims to have
a suitably small team of core reviewers, with each core reviewer being active
and engaged. The process for appointing core reviewers aims to ensure there
is a good mix between a statistics-based and nomination-based approach. To
this end, the core team changes relatively quickly, with inactive core team
members being removed and new, active core team members being added on a
regular basis. This also allows the existing core team to act quickly on
recognizing valuable team members.

The process is:

* Every month (usually on the 1st), the documentation PTL draws the top
  committers and reviewers from the `Stackalytics <http://stackalytics.com/>`_
  report for openstack-manuals:

  * `openstack-manuals Stackalytics
    <http://stackalytics.com/?module=openstack-manuals&metric=commits>`_

* The PTL then consults the existing core team and the OpenStack
  community with a list of names to be removed from and added to the
  core list. This is done in public by using the
  openstack-discuss@lists.openstack.org mailing list as the primary
  communication channel. Cores who are being removed will be contacted
  personally before changes are made.

* Existing core team members can nominate a new core member at any
  time, with a justification sent to the
  openstack-discuss@lists.openstack.org mailing list. Three +1 votes
  from other existing core team members must be achieved for approval.

Core reviewer responsibilities
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Becoming a core reviewer carries with it a responsibility: you are now the
guardian of the gate, and it is up to the core team to ensure that nothing
unfavorable gets through, without discouraging contributions.

General instructions for being a core reviewer are located in the
`Core Reviewer's Guide
<https://docs.openstack.org/infra/manual/developers.html#code-review>`_.
This section is for openstack-manuals core reviewers.

In almost all cases, patches can be merged with at least one +1 vote, and
two +2 votes. The second +2 vote is usually the one that will also merge the
patch (often referred to as a +2A vote). There are very few exceptions to
this rule within documentation, the main one being extraordinary
circumstances where a patch has broken the build and a fix is required very
quickly. In this case, you should still seek out another core team member
if possible, and make some kind of contact with the PTL so that they are
aware of the problem.

If you are a core team member, but don't feel you understand the subject
matter of a patch well enough to confidently merge it, vote +1 and mention
your reasons. Being overly cautious is better than being overly confident.

Try not to merge a patch too quickly, even if it strictly has the correct
number of votes. Allowing a patch to sit for a couple of days is generally
helpful, in order to ensure enough people have seen the change. It can also
be valuable to add team leads or other subject matter experts to patches
where you feel more specialized knowledge is required to make a good
decision.

A note on review rigor: There are very few guidelines about what a good patch
looks like, but the general approach is that if it's technically accurate and
better than the existing content, then it should be approved. The main things
to look for:

* General spelling and grammar.
* Technical accuracy. Where possible, test commands on your own VM to make
  sure they're accurate. Check any related bugs and mailing list conversation
  to see if there's anything else you might need to take into account.
* The 'is it better than what we have already' test. Check the diff, or look
  at the current document on the doc site, and determine if the changes are
  an improvement. Provide corrections in-line for the author to fix if
  there's more than a couple of errors. If there's just one or two really
  minor changes (or in a situation where the writer has explicitly asked for
  editorial assistance), consider checking out the patch and editing it
  yourself.

And, as a final note: Be nice. Be helpful. It is your job as a core reviewer
to help people get patches merged, not block them.
