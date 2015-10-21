.. _cherry-pick:

Cherry pick a change
~~~~~~~~~~~~~~~~~~~~

If a docfix was submitted to the master openstack-manuals branch and you want
to reflect this change, for example, in the Kilo documentation, which is
closed, you can cherry pick the change and submit it.

Use the :guilabel:`Cherry Pick To` button in Gerrit Web UI from the original
master review page. If the :guilabel:`Cherry Pick To` button does not work, it
means that there are conflicts and you need to cherry pick the patch manually.

For example, you want to cherry pick bug/1506693 (review 235734) into Kilo:

#. Wait for the change to be merged into the master branch.

#. Make sure your repository is up to date:

   .. code-block:: console

      $ git fetch origin

#. Create a topic branch by branching from Kilo:

   .. code-block:: console

      $ git checkout -b kilo-bug/1506693 remotes/origin/stable/kilo

#. On the Gerrit web page that contains the review you want to backport,
   click :guilabel:`cherry-pick`. It is located under :guilabel:`Patch Set N`,
   in the :guilabel:`Download` row.

#. Copy the text, then paste it into your terminal. For example, for review
   235734, it looks like this:

   .. code-block:: console

      $ git fetch https://review.openstack.org/openstack/openstack-manuals \
        refs/changes/34/235734/1 && git cherry-pick -x FETCH_HEAD

   .. note::

      Use the -x option with the :command:`cherry-pick` command to preserve
      git history metadata in the cherry pick commit message.

#. Resolve conflicts if any, then run:

   .. code-block:: console

      $ git cherry-pick --continue

#. Run :command:`tox`, and then commit your change:

   .. code-block:: console

      $ git commit --amend

#. Make sure you retain the original Change-Id from the previous commit
   message. This facilitates tracking of backports into all affected branches.
   You may add "Cherry-pick from review.openstack.org/URL" to the commit
   message to make it easier for reviewers. Push the commit for review:

   .. code-block:: console

      $ git review
