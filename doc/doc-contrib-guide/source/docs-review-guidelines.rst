=================
Review guidelines
=================

This section provides guidelines to improve the quality and speed of
the documentation review process.

Critique categories
~~~~~~~~~~~~~~~~~~~

Below is a list of the categories you will critique as the reviewer.

Objective
---------

* `Commit message <https://wiki.openstack.org/wiki/GitCommitMessages>`_

  * Content
  * Conventions
  * Bug number or blueprint

* Patch

  * Content
  * Grammar
  * :doc:`Style, phrasing, wording, and capitalization <writing-style>`
  * Spelling
  * :doc:`RST formatting <rst-conv>`
  * Accuracy of the selected location

Subjective
----------

* Commit message

  * Grammar
  * Spelling
  * Style, phrasing, and wording

* Patch

  * Grammar
  * Style, phrasing, and wording
  * Technical accuracy
  * Other suggestions

Scope
~~~~~

Try to keep reviews limited to the contents of the bug, contents of
the commit message, and changes made by the patch.
In other words, if the patch solves the stated problem, but there are
other improvements that could result from the patch, approve the patch
and file a subsequent bug, rather than -1'ing the patch with a comment
about improvements. This is why it is a good idea to write commit
messages that clearly define the scope of the patch.

Additional comments within the objective and subjective aims of a patch,
that would result in a -1, are appropriate.
Remember to consider if the change is related to the scope.

Consistency
~~~~~~~~~~~

* Mark all instances of an issue if one appears in a patch.

  * If the author uploads a patch correcting your objective issue and
    you find another instance that you didn't mark, comment on it and
    score with a -1. Preferably, upload a patch to fix it.

  * If the author uploads a patch correcting your subjective issue and
    you find another instance that you didn't mark, comment on it and
    score with a 0.

  * If the author uploads a patch correcting your objective and/or
    subjective issue and you find another objective issue, comment on
    it and score with a -1. Preferably, upload a patch to fix it.

  * If the author uploads a patch correcting your objective and/or
    subjective issue and you find another subjective issue, comment on
    it and score with a 0.

* If an issue appears that could affect other portions of a book,
  provide appropriate comments, score the patch with a -1, and consider
  mentioning your issue on the mailing list or in a meeting.

  Example: A new service uses "key = value" in the configuration file
  and all other services use "key=value" in their configuration files.
  Both methods work, but the book should maintain consistency.

* If a patch has already received a -1, do not be discouraged from
  checking on it, and add additional comments. This way, there will
  be fewer patch sets and comments building up under one review.

Tagging additional reviewers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In some cases, you should tag one or more people with interest in or
experience with the content of your patch to review it.

Q: How long should an author wait for reviews by these people?

A: For extremely busy projects with backlogs of over 400 patches,
wait two weeks at least. If you have difficulty getting a reviewer
for a particular project, use the `Cross Project Documentation Liaisons
<https://wiki.openstack.org/wiki/CrossProjectLiaisons#Documentation>`_
page to contact the documentation liaison for the project to get a reviewer.
The Documentation PTL can also assist in getting reviewers attention.

The waiting game
~~~~~~~~~~~~~~~~

After the first review with a -1 or 0 score, the author should update
the patch. Authors do not need to wait for a lengthy period of time.
Expect to leave some time for reviewers to check on a patch, however.
Consider that some reviewers are located in different timezones.

Core reviewers will in general review a patch within a few days.
If no review happens, feel free to ask on the #openstack-doc IRC channel.

Review scoring and approvals
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Scores available to contributors: -1, 0, +1
* Scores available to core reviewers: -2, -1, 0, +1, +2
* Approvals

A core reviewer can +2 score a patch with a +2 score from another core
reviewer and approve it.
If the change contains important or critical information,
the core reviewer should not approve it immediately, but provide a few days
for wider community audience to express their opinion, and suggest posting
to the documentation mailing list.

.. note::

   If you find an issue with a patch that already has a +2 score from
   another core reviewer, consider commenting on the issue and scoring the
   patch with a 0 rather than scoring it with a -1.

Setting WorkInProgress (WIP) during review
------------------------------------------

The WIP tag tells potential reviewers to expect additional updates to
a patch before reviewing. Both the change's owner and any core reviewer
can set the WIP status:

* A change owner and core reviewers can set this tag on their own review
  to mark that additional changes are still being made, and to avoid
  unnecessary reviews while that happens.

This can be a great convenience to fellow reviewers. It allows the core
reviewer to politely send the message that the change needs additional
work while simultaneously removing it from the list of ready changes
until that happens.

To add the WIP tag:

#. Select a patch set.
#. Click the :guilabel:`Reply...` button.
#. Choose :guilabel:`-1 (Work In Progress)` from the :guilabel:`Workflow`
   options.
#. Optional: enter comments.
#. Click :guilabel:`Post`.

This sets a ``-1`` and informs everyone that the patch is Work In Progress.

Abandoning patches
------------------

Core reviewers may abandon patches that receive a -2 review or
lack activity for at least four weeks to freshen the patch review queue.
The owner of a patch can also abandon it.
The owner and core reviewers can restore it again.

Patches by OpenStack Proposal Bot
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

There are a few proposal jobs set up that are run regularly:

* ``Imported Translations from Zanata``: Import of translated files from
  the translation infrastructure.
  This is run once a day (06:00 UTC) for each repository.
* ``Updated from openstack-manuals``: Import of glossary files from
  openstack-manuals. This job is triggered whenever openstack-manuals has
  merged and will propose a change if something has changed.
* ``Updated from global requirements``: Import of requirements.txt and
  test-requirements.txt from the global requirements repository.

For all types of patches, any core can approve a patch if all the tests pass.
If the tests do not pass, vote ``-1`` on the patch, fix the problem and
wait for the next proposal run.
The proposal job will update the patch with the next run.
If you cannot fix the problem, ask for help on the mailing lists:

* openstack-i18n@lists.openstack.org: translation failures
* openstack-discuss@lists.openstack.org: requirements failures, glossary sync
  failures, and common content sync failures.

Considerations for documentation aligned with release cycles
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Beginning with milestone releases, shift focus to objective issues,
especially with new services and existing services with significant changes.
Only patches with significant subjective issues should receive a -1 score.
Otherwise, comment on subjective issues and score with a 0.
Beginning with release candidates, focus almost entirely on content issues.
Only comment on subjective issues if the patch should receive a -1 score
for objective issues.
