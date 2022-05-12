.. _first_timers:

============
First timers
============

One of the best ways to start contributing to OpenStack documentation
is to walk through the Installation Guide and complete it by hand.
Keep notes as you go, and offer suggestions for improvement by filing
documentation bugs at Launchpad.

.. _setting_up_for_contribution:

Setting up for contribution
~~~~~~~~~~~~~~~~~~~~~~~~~~~

To get started, first `set up your OpenStack account
<https://docs.openstack.org/contributors/common/accounts.html>`_ and
then `set up Gerrit
<https://docs.openstack.org/contributors/common/setup-gerrit.html>`_.

To set up your environment for contributions, proceed with the
subsections below.

Set up a text editor
--------------------

Use any text editor of your choice to work with the documentation. It is a
good idea to choose an editor that supports spell checking and syntax
highlighting for RST. For example:

* `Gedit GNOME Wiki <https://wiki.gnome.org/Apps/Gedit>`_
* `Atom <https://atom.io/>`_
* `Vim <http://www.vim.org/>`_
* `Editors(reST) <https://wiki.typo3.org/Editors_%28reST%29#Open_source_.28.3D_free_of_cost.29>`_

To keep the documents clean and easy to compare, all of the OpenStack
projects require that text is wrapped at `79 characters maximum`_,
with no white spaces at the end of the line.

You can configure the text editor to do that automatically.

For example, in the :file:`.vimrc`:

.. code-block:: vim

   set list
   set listchars=tab:>-,trail:-,extends:#,nbsp:-
   set modeline
   set tw=78
   set tabstop=8 expandtab shiftwidth=4 softtabstop=4


.. _git_setup:

Set up git and git-review
-------------------------

#. Install ``git``. See `GitHub help`_ for details.

   If you use Windows to contribute to OpenStack, install
   `Git for Windows <http://gitforwindows.org/>`_.
   In the subsequent procedures, run commands from the Git Bash console.

#. Install ``git-review`` so that you are able to submit patches.
   See `Installing git-review`_ for details.

   .. note::

      If you use Windows to contribute to OpenStack, install
      `Python <https://docs.python.org/3/using/windows.html>`_
      as prerequisites. As part of the Python installation,
      be sure to install setuptools and pip as instructed.

Set up SSH
----------

#. On the computer which you commit from, generate an SSH key:

   .. code-block:: console

      $ ssh-keygen –t rsa

#. Optionally, enter a password. If you enter one, remember it because
   you must enter it every time you commit.

#. View and copy your SSH key:

   **Linux/Mac**

   .. code-block:: console

      $ less ~/.ssh/id_rsa.pub

   **Windows**

   .. code-block:: console

      $ notepad ~/.ssh/id_rsa.pub

#. Sign into gerrit at https://review.opendev.org/.

#. In the upper right, click your username. Click the `Settings > SSH Public
   Keys`_ page. Click ``Add Key``. Paste the key in the ``Add SSH Public Key``
   web form and click ``Add``.

Set up a repository
-------------------

For the instructions on how to set up a repository so that you can work
on it locally, refer to the `Starting Work on a New Project`_
of the Infrastructure manual.

See :ref:`troubleshoot_setup` if you have difficulty with a repository
setup.

Finding a bug
~~~~~~~~~~~~~

After setting up your environment for contribution, it is time to find
something to work on:

#. Go to the bug lists at `Bugs:openstack-manuals <https://bugs.launchpad.net/openstack-manuals/+bugs>`_
   for documentation bugs related to the openstack-manuals repository.

   For project-specific documentation bugs, go to
   https://bugs.launchpad.net/<projectname>.

#. Find a bug that has been confirmed by another contributor and assign it
   to yourself.

For more information on documentation bugs, see :doc:`../doc-bugs`.

Committing a change
~~~~~~~~~~~~~~~~~~~

#. Update the repository and create a new topic branch as described in
   the `Starting a Change`_ section of the Infrastructure manual.

#. Fix the bug in the docs.

   Read :doc:`../writing-style`, also pay attention to :doc:`../rst-conv`.

#. Create your commit message. See `Committing a change`_ for details.

#. Create a patch for review.opendev.org following the `Submitting a Change
   for Review`_ instructions.

#. Follow the URL returned from ``git-review`` to check your commit::

     https://review.opendev.org/<COMMIT-NUMBER>

#. In Gerrit, wait for the automatic Zuul checks to succeed.

Celebrate and wait for reviews!

.. seealso:: * :ref:`troubleshoot_setup`
             * :doc:`../docs-builds`

Responding to requests
~~~~~~~~~~~~~~~~~~~~~~

After you submit a patch, reviewers may ask you to make changes before
they approve the patch.

To submit changes to your patch, proceed with the following steps:

#. Copy the commit number from the review.opendev.org URL.

#. At the command line, change into your local copy of the repository.

#. Check out the patch:

   .. code-block:: console

      $ git review -d <COMMIT-NUMBER>

#. Make your edits.

#. Commit the changes using the `amend` flag:

   .. code-block:: console

      $ git commit -a --amend

   Ensure that the Change-ID line remains intact in your commit message. This
   prevents Gerrit from creating a new patch.

#. Push the changes to review as described in the `Updating a Change`_ section
   of the Infrastructure manual.

Wait for more reviews.


.. _troubleshoot_setup:

Troubleshooting your setup
~~~~~~~~~~~~~~~~~~~~~~~~~~

git and git review
------------------

* Authenticity error

  The first time that you run :command:`git review`, you might see this error::

    The authenticity of host '[review.opendev.org]:29418 ([104.130.246.32]:29418) can't be established.

  Type *yes* (all three letters) at the prompt.

* Gerrit connection error

  When you connect to gerrit for the first time, you might see this error:

  .. code-block:: console

     Could not connect to gerrit.
     Enter your gerrit username:

  Enter the user name that matches the user name in the :guilabel:`Settings`
  page at review.opendev.org.

* Not a git repository error

  If you see this error::

    fatal: Not a git repository (or any of the parent directories): .git
    You are not in a directory that is a git repository: A .git file was not found.

  Change into your local copy of the repository and re-run the command.

* Gerrit location unknown error

  If you see this error::

    We don't know where your gerrit is. Please manually create a remote named "gerrit" and try again.

  You need to make a git remote that maps to the review.opendev.org SSH port
  for your repository. For example, for a user with the ``username_example``
  user name and the openstack-manuals repository, you should run this command::

    git remote add gerrit ssh://username_example@review.opendev.org:29418/openstack/openstack-manuals.git

* Remote rejected error

  If you see this error::

    ! [remote rejected] HEAD -> refs/publish/master/addopenstackdocstheme (missing Change-Id in commit message footer)

  The first time you set up a gerrit remote and try to create a patch for
  review.opendev.org, you may see this message because the tool needs one
  more edit of your commit message in order to automatically insert
  the *Change-Id*. When this happens, run :command:`git commit -a --amend`,
  save the commit message and run :command:`git review -v` again.

* Permission denied error

  If you see this error:

  .. code-block:: console

     Permission denied (publickey).

  Double check the :guilabel:`Settings` page at
  https://review.opendev.org/
  to make sure your public key on the computer
  or virtual server has been copied to SSH public keys on
  `SSH Public Keys <https://review.opendev.org/#/settings/ssh-keys>`_.
  If you have not adjusted
  your ``.ssh`` configuration, your system may not be connecting using
  the correct key for gerrit.

  List your local public key on Mac or Linux with:

  .. code-block:: console

     less ~/.ssh/id_rsa.pub

  On Windows, look for it in the same location.

  If you still received a ``Permission denied (publickey)`` message,
  you might need to check if you hit ``no mutual signature algorithm``.
  Any given system running OpenSSH 8.8 or newer as this release disables RSA
  signatures using the SHA-1 hash algorithm by default.
  Try to run the following command:

  .. code-block:: console

     ssh -vv -p 29418 {username}@review.opendev.org

  If you saw ``no mutual signature algorithm``,
  you need to consider using another algorithm instead of RSA.
  For example, use ``ed25519`` to generate your key and upload ``id_ed25519.pub``.

  .. code-block:: console

     ssh-keygen -t ed25519 -C "your_email@example.com"

* Merge conflict, rebase required

  Sometimes your change creates a merge conflict with another patch.
  In this case, you need to rebase your commit on top of the current
  state of the repository. In many cases, this can be achieved by pressing
  the ``Rebase`` button in the gerrit interface. If this fails, you must
  `rebase manually
  <https://docs.opendev.org/opendev/infra-manual/latest/developers.html#understanding-changes-and-patch-sets>`_.

  For a basic introduction to solving merge conflicts, see the GitHub article
  `Resolving merge conflicts after a git rebase
  <https://help.github.com/articles/resolving-merge-conflicts-after-a-git-rebase/>`_.

* ``FAILURE`` in the ``Zuul check`` section of your commit in Gerrit

  #. Click the link next to the ``FAILURE`` test.
  #. Verify the output of the :file:`console.html`:

     * If it contains errors or warnings related to your commit with
       a problematic file name and line in question, fix the issues and
       push the new changes on review.
     * If the issue is not related to your commit, re-run the gate jobs by
       leaving the word *recheck* in the comments section of your
       Gerrit review.

  .. seealso:: * `Automated Testing <https://docs.opendev.org/opendev/infra-manual/latest/developers.html#automated-testing>`_
               * :ref:`build_jobs`

Network
-------

If your network connection is weak, you might see this error:

.. code-block:: console

   Read from socket failed: Connection reset by peer

Try again when your network connection improves.

**Accessing gerrit over HTTP/HTTPS**

If you suspect that SSH over non-standards ports might be blocked or need to
access the web using http/https, you can configure git-review to
`use an https endpoint instead of ssh
<https://docs.opendev.org/opendev/infra-manual/latest/developers.html#accessing-gerrit-over-https>`_
as explained in the Infrastructure Manual.

Python
------

If you see this error:

.. code-block:: console

   /usr/bin/env: python: No such file or directory

Your Python environment is not set up correctly. See the Python documentation
for your operating system.

i18n
----

If you see this error:

.. code-block:: console

   $ git review -s
   Problems encountered installing commit-msg hook
   The following command failed with exit code 1
      "scp  :hooks/commit-msg .git/hooks/commit-msg"
   -----------------------
   .git/hooks/commit-msg: No such file or directory
   -----------------------

You may have a LANGUAGE variable setup to something else than C. Try using
instead:

.. code-block:: console

   $ LANG=C LANGUAGE=C git review -s



.. Links

.. _`Sign the appropriate Individual Contributor License Agreement`: https://docs.openstack.org/contributors/common/setup-gerrit.html#individual-contributor-license-agreement
.. _`Installing git-review`: https://docs.opendev.org/opendev/infra-manual/latest/gettingstarted.html#install-the-git-review-utility
.. _`OpenStack Documentation Bug Team`: https://launchpad.net/~openstack-doc-bugs
.. _`Development Workflow`: https://docs.opendev.org/opendev/infra-manual/latest/developers.html#development-workflow
.. _`git`: http://msysgit.github.io
.. _`curl`: http://curl.haxx.se/
.. _`tar`: http://gnuwin32.sourceforge.net/packages/gtar.htm
.. _`7-zip`: http://sourceforge.net/projects/sevenzip/?source=recommended
.. _`Python 2.7 environment`: http://docs.python-guide.org/en/latest/starting/install/win/
.. _`79 characters maximum`: https://www.python.org/dev/peps/pep-0008/#maximum-line-length
.. _`GitHub help`: https://help.github.com/articles/set-up-git
.. _`Settings page on gerrit`: https://review.opendev.org/#/settings/
.. _`Settings > SSH Public Keys`: https://review.opendev.org/#/settings/ssh-keys
.. _`Starting Work on a New Project`: https://docs.opendev.org/opendev/infra-manual/latest/developers.html#starting-work-on-a-new-project
.. _`Starting a Change`: https://docs.opendev.org/opendev/infra-manual/latest/developers.html#starting-a-change
.. _`Committing a change`: https://docs.opendev.org/opendev/infra-manual/latest/developers.html#committing-a-change
.. _`Submitting a Change for Review`: https://docs.opendev.org/opendev/infra-manual/latest/developers.html#submitting-a-change-for-review
.. _`Updating a Change`: https://docs.opendev.org/opendev/infra-manual/latest/developers.html#updating-a-change

