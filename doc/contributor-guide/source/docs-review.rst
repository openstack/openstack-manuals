.. _docs_review:

=======================
Reviewing documentation
=======================

To see what documentation changes are ready for review, use the
`Documentation Program Dashboard`_. It is organized in groupings based on
the audience for the documentation. To see current proposed changes, make
sure you register and log into https://review.openstack.org. For more
details on the review process, see `Code Review`_.

Repositories and core team
~~~~~~~~~~~~~~~~~~~~~~~~~~

The OpenStack Docs team is core for api-site, openstack-manuals,
operations-guide, openstackdocstheme, and openstack-doc-tools projects.

For the following repositories that are part of the Documentation program,
special rules apply:

* docs-specs: has a separate core team,
  see :doc:`docs-specs <blueprints-and-specs>` section.
* security-doc: has a separate core team consisting of Docs team members and
  Security team members. The rule here is that each patch needs an approval
  by a Docs core and a Security core.
* training-guides: has a separate core team.
* training-labs: has a separate core team.

The current list of docs cores for openstack-manuals can be found at
https://review.openstack.org/#/admin/groups/30,members.

Achieving a core reviewer status
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Core reviewers are able to +2 and merge content into the projects they have
the core status in. Core status is granted to those who have not only done a
lot of reviews, but who also have shown care and wisdom in those reviews.
Becoming a core reviewer also carries with it a responsibility: you are now
the *guardian of the gate*, and it is up to the core team to ensure that
nothing untoward gets through, without discouraging contributions. The core
reviewer's role is complex, and having a great core team is crucial to the
success of any OpenStack project.

With great power comes great responsibility.

For this reason, we want to ensure that we have a suitably small team of
core reviewers, but that each core reviewer we have is active and engaged.
In order to do this, we changed the process for achieving core reviewer
status to ensure there was a good mix between a statistics-based and
nomination-based approach. This means a couple of things:

* The core team changes slightly faster than before, with inactive core
  team members being removed and new, active core team members being added
  on a more regular basis.
* Now, the existing core team can act faster on recognizing valuable team
  members.

The process is:

- Every month (usually on the 1st), the documentation PTL draws the top 12
  names using these reports:

  - http://russellbryant.net/openstack-stats/docs-reviewers-30.txt
  - http://russellbryant.net/openstack-stats/docs-reviewers-90.txt and
  - http://stackalytics.com/?module=openstack-manuals&metric=commits

- The PTL then consults the existing core team with a list of names to be
  removed and added from/to the core list. Once an agreement is reached, the
  changes are made and advertised to the main documentation mailing list.
  Cores who are being removed will be contacted personally before removal.
- Existing core team members can nominate a new core member at any time,
  with a justification sent to the existing core team:
  openstack-doc-core@lists.launchpad.net. Three +1 votes from other existing
  core team members must be achieved for approval.

How to review a documentation patch
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Before you proceed with reviewing patches, make sure to read carefully the
`Review Guidelines`_ for documentation and `Code Review Guidelines`_. Once
done, follow the steps below to submit a patch review.

#. Go to the `Documentation Program Dashboard`_.
#. Click a patch set.
#. Click a file that was uploaded to view the changes side by side.
#. If you see some inconsistencies or have questions to the patch owner,
   double click the line in question for a *Comment* field to appear.
   Click *Save* button once you write a draft of your comment.
#. In the *Jenkins check* section, click the Jenkins *checkbuild* gate
   link (for the openstack-manuals, it is called
   *gate-openstack-manuals-tox-doc-publish-checkbuild*) and review the
   built manuals to see how the change will look on the web page. For a new
   patch, it takes some time before Jenkins checks appear on the Gerrit
   page. You can also `build the patch locally`_ if necessary.
#. Click *Review* to vote and enter any comments about your review,
   then click *Publish Comments*.

.. note:: The patch with WorkInProgress (WIP) status needs additional work
          before it gets merged. Therefore, you may skip such a patch and
          review once it is ready. For more information, see
          `Work In Progress`_.

.. seealso:: `Peer Review`_

.. _`build the patch locally`:

How to build an existing patch locally
--------------------------------------

Before proceeding, make sure you have all the necessary
:ref:`tools <setting_up_for_contribution>` installed and
set up for contribution.

To build a patch locally:

#. In terminal, switch to a necessary directory. For example::

    cd openstack-manuals

#. Run the below command to create a local branch with the patch in question::

    git review -d <nnnn>

   where the value of <nnnn> is a Gerrit commit number. For example, 226632
   is the commit number of the patch https://review.openstack.org/#/c/226632.

#. Build all the books that are affected by changes in the patch set::

     sudo tox -e checkbuild

#. Find the build result in :file:`openstack-manuals/publish-docs/index.html`.

#. Review the source and the output. You are also welcomed to edit and update
   the patch:

   #. Ensure that your edits adhere to the
      :ref:`Writing Style <stg_writing_style>` for OpenStack documentation
      and uses standard US English.
   #. Once the build and new output are good to commit, run::

        git commit -a --amend

   #. When the editor opens, update the commit message if necessary. But do
      not add information on what your specific patch set changes. A reviewer
      can use the Gerrit interface to see the difference between patches.
   #. Save the changes if any and exit the editor. If your editor is vi,
      use the :command:`:wq` command to save the file and exit vi.
   #. Send your patch to the existing review::

       git review

   #. Leave a comment in Gerrit explaining the reason for your patch set.

.. TODO: make a seealso and add a links to the below pages once converted to
   .RST:
    - https://wiki.openstack.org/wiki/Documentation/HowTo#Building_Output_Locally
    - https://wiki.openstack.org/wiki/Documentation/HowTo#Using_Tox_to_check_builds

.. _`Documentation Program Dashboard`: http://is.gd/openstackdocsreview
.. _`Code Review`: http://docs.openstack.org/infra/manual/developers.html#code-review
.. _`Review Guidelines`: https://wiki.openstack.org/wiki/Documentation/ReviewGuidelines
.. _`Code Review Guidelines`: http://docs.openstack.org/infra/manual/developers.html#code-review
.. _`Peer Review`: http://docs.openstack.org/infra/manual/developers.html#peer-review
.. _`Work In Progress`: http://docs.openstack.org/infra/manual/core.html#work-in-progress
