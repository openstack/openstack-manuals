.. _git-rebase:

Resolving merge conflicts
~~~~~~~~~~~~~~~~~~~~~~~~~

If the change that you submitted has a merge conflict,
you need to manually resolve it using :command:`git rebase`.

Rebasing is used to integrate changes from one branch into another to
resolve conflicts when multiple commits happen on the same file.

.. warning::

   Never do a rebase on public (master) branches.

#. You submit a change.

#. Somebody else submits a change and that change merges.
   Now your change has a merge conflict.

#. Update your local repository:

   .. code-block:: console

      $ git remote update
      $ git pull --ff-only origin master

#. Download your change:

   .. code-block:: console

      $ git review -d $PARENT_CHANGE_NUMBER

#. Rebase your change:

   .. code-block:: console

      $ git rebase origin/master


#. Resolve conflicts manually:

   Conflicts are marked in a file with clear line breaks:

   .. code-block:: console

      <<<<<<< HEAD
      Second line.
      =======
      Third line.
      >>>>>>> feature/topic branch.

   <<<<<<<: Indicates the start of the lines that had a merge conflict.

   =======: Indicates separation of the two conflicting changes.

   >>>>>>>: Indicates the end of the lines that had a merge conflict.

   You need to resolve a conflict by manually editing the file.
   You also need to delete the '<<<<<<<', '=======', and'>>>>>>>'
   in the file.

#. Add the files to the stage:

   .. code-block:: console

      $ git add $FILENAME

#. Complete the rebase process:

   .. code-block:: console

      $ git rebase --continue

#. Send the rebased patch again for review:

   .. code-block:: console

      $ git review

