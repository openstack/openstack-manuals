.. _docs_builds:

======================
Building documentation
======================

Clone a repository first
~~~~~~~~~~~~~~~~~~~~~~~~

Before building documentation, you must first clone the repo where the files
reside:

  .. code-block:: console

     $ git clone git://git.openstack.org/openstack/openstack-manuals.git

Navigate to the ``openstack-manuals`` directory and create a branch from there
to do your work:

  .. code-block:: console

     $ cd openstack-manuals
     $ git checkout -b new-branch

The value of ``new-branch`` is any name you want to give to your branch.

To work on a file, use a text editor and open the ``.rst`` file from the same
navigational path as the path shown in the HTML URL. For example,
https://docs.openstack.org/contributor-guide/docs-builds.html, is found in the
folder: ``openstack-manuals/doc/contributor-guide/docs-builds.rst``.

Refer to :doc:`Writing documentation <writing-docs>` for details on how to
create content and contribute to the documentation.

Building output locally
~~~~~~~~~~~~~~~~~~~~~~~

The openstack-manuals project uses a `tox.ini
<https://git.openstack.org/cgit/openstack/openstack-manuals/tree/tox.ini>`_
file with specific sections that run jobs using the `Tox
<https://tox.readthedocs.org/en/latest/>`_ tool, a virtualenv-based
automation of test activities. You can use MacOS, Windows, or Linux to
build the Sphinx documentation everywhere in OpenStack.

.. _docs_dependencies:

Install dependencies for building documentation
-----------------------------------------------

OpenStack maintains a tool called ``bindep`` that maintains a list of
dependencies for Linux package managers. When you run the
:command:`tox -e bindep` command, read the error messages and install the
dependencies based on the error messages returned. Continue to run until
your local environment meets the requirements as listed in ``bindep.txt``
in the repository.

.. note::

   You cannot run :command:`tox -e bindep` on Mac OS X as it uses a Linux tool
   to parse the information. `Issue logged here
   <https://storyboard.openstack.org/#!/story/2000888>`_.

* On MacOS

Open a Terminal window. Make sure you have Python installed. Many contributors
use the `Homebrew tool instructions
<http://python-guide-pt-br.readthedocs.io/en/latest/starting/install/osx/>`_.

  .. code-block:: console

     $ brew install python
     $ pip install tox

* On Ubuntu or Debian:

  .. code-block:: console

     # apt-get install python-pip
     # pip install tox
     $ tox -e bindep
     # apt-get install <indicated missing package names>

* On RHEL or CentOS including Fedora:

  .. code-block:: console

     # yum install python-pip
     # pip install tox
     $ tox -e bindep
     # yum install <indicated missing package names>

* On openSUSE or SUSE Linux Enterprise:

  .. code-block:: console

     # zypper in python-pip
     # pip install tox
     $ tox -e bindep
     # zypper in <indicated missing package names>

.. note::

   This will install all required packages for building both RST and
   PDF files. If you do not build PDF files, you do not need to install
   the `texlive <https://www.tug.org/texlive/>`__ packages and
   `Liberation font family <https://fedorahosted.org/liberation-fonts/>`__.

* On Windows

To the doc build scripts as-is on Windows, first install `Git for Windows`_.
Make sure you have a working Python environment, and then use Git Bash to run
all :command:`tox` commands within the repository directory:

  .. code-block:: console

     $ pip install tox

.. _Git for Windows: https://git-for-windows.github.io/

Build workflow
--------------

Once Tox is installed and configured, execute :command:`tox -e <jobname>`
to run a particular job.

* To build all docs, open your local openstack-manuals project and run:

  .. code-block:: console

     $ tox -e checkbuild

* To build a specific guide, add the guide folder name to the
  :command:`tox -e build` command. For example:

  .. code-block:: console

     $ tox -e build -- image-guide

This runs the :command:`sphinx-build` command. When the build is finished,
it displays in the ``openstack-manuals/publish-docs`` directory.
You can open the ``.html`` file in a browser to view the resulting output.

If you do not want to use Tox, install the below prerequisites locally:

.. code-block:: console

   # pip install sphinx
   # pip install openstackdocstheme

To get the ``.html`` output locally, switch to the directory containing a
``conf.py`` and run:

.. code-block:: console

   $ sphinx-build /path/to/source/ path/to/build/

The RST source is built into HTML using Sphinx, so that it is displayed on
the *docs.openstack.org/<guide-name>*. For example:
https://docs.openstack.org/image-guide/.

Using Tox to check builds
-------------------------

As a part of the review process, the OpenStack CI system runs scripts
to check that the patch is fine. Locally, you can use the Tox tool to
ensure that a patch works. To check all books, run the following
command from the base directory of repository:

.. code-block:: console

   $ tox

The following individual checks are also available:

* :command:`tox -e checkniceness` - to run the niceness tests (for example,
  to see extra whitespaces)
* :command:`tox -e checklang` - to check all the translated manuals
* :command:`tox -e docs` - to build only RST-sourced manuals
* :command:`tox -e checkbuild` - to build all the manuals. This will also
  generate a directory ``publish-docs`` that contains the built files for
  inspection.

.. note::

   * The scripts are not written for Windows, but we encourage
     cross-platform work on our scripts.
   * If Tox stops working, try :command:`tox --recreate` to rebuild the
     environment.

.. _docs_builds_locally:

Generate PDF
------------

To build a specific guide with a PDF file, use the :command:`tox build`
command for the guide with the ``pdf`` option. For example:

.. code-block:: console

   $ tox -e build -- image-guide --pdf

PDF builds are accomplished using LaTeX as an intermediate format.
Currently, you can generate a PDF file for a limited number of guides.
The supported list is maintained in the `tools/build-all-rst.sh
<https://git.openstack.org/cgit/openstack/openstack-manuals/tree/tools/build-all-rst.sh#n24>`_
file.

.. note::

   * PDF builds need additional dependencies. For details, see
     :ref:`docs_dependencies` section.

Build an existing patch locally
-------------------------------

To build a patch locally:

#. Change to the directory containing the appropriate repository:

   * openstack-manuals
   * security-doc
   * api-site

   For example:

   .. code-block:: console

      $ cd openstack-manuals

#. Create a local branch that contains the particular patch.

   .. code-block:: console

      $ git review -d PATCH_ID

   Where the value of ``PATCH_ID`` is a Gerrit commit number.
   You can find this number on the patch link,
   ``https://review.openstack.org/#/c/PATCH_ID``.

#. Build all the books that are affected by changes in the patch set:

   .. code-block:: console

      $ tox -e checkbuild

#. Find the build result in ``publish-docs/index.html``.

.. _build_jobs:

Build jobs
~~~~~~~~~~

The build jobs for documentation are stored in the
`Project config <https://git.openstack.org/cgit/openstack-infra/project-config>`_
repository. The :file:`zuul/layout.yaml` file and the
``jenkins/jobs/manual-jobs.yaml`` or ``jenkins/jobs/api-jobs.yaml``
file(s) contain the build jobs that build to the docs.openstack.org
and developer.openstack.org sites, copying built files via FTP.

The release specific books are built for the currently supported branches
(current and previous releases), development happens on the master branch.
The continuously released books are only built on the master branch.

Like other projects, the documentation projects use a number of jobs
that do automatic testing of patches.

The current jobs are:

* gate-openstack-manuals-tox-checkniceness
* gate-openstack-manuals-tox-doc-publish-checkbuild
* gate-openstack-manuals-tox-checklang

Checklang job
-------------

We only gate on manual/language combinations that are translated
sufficiently. For example, in openstack-manuals this includes Japanese with
the Security Guide, HA Guide and Install Guides.

* If an import from Zanata fails, we do not approve the import.
* If any other patch fails, the failure might get ignored.
* In any case of failure, a bug gets reported against the `i18n project
  <https://bugs.launchpad.net/openstack-i18n>`_.

If you want to manually run this check on your local workstation you can use
the checklang environment (:command:`tox -e checklang`). To use this
environment, you first have to install the *xml2po* utility on your local
workstation. xml2po is part of the gnome-doc-utils and can be installed with
:command:`yum install gnome-doc-utils` (on RedHat-based distributions), or
:command:`zypper install xml2po` (on SUSE-based distributions).

.. _docs_builds_eol:

Building docs from end-of-life releases
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

OpenStack projects can follow different `release models
<https://releases.openstack.org/reference/release_models.html>`_. The
openstack-manuals repo follows two of these models, independent and
cycle-with-milestones.

.. note::

   The docs repo and the api-site follow the independent release model.

When a release reaches an end-of-life status and is no longer maintained by the
stable branch maintainers, the docs.openstack.org website redirects requests
for old content to the latest release. Read more about support phases and
stable branches in the `Project Team Guide
<https://docs.openstack.org/project-team-guide/stable-branches.html>`_.

To build documentation from a particular release locally, follow these steps.

#. Clone a copy of the stable branch content locally, if you do not already
   have a local copy:

   .. code-block:: console

      $ git clone git://git.openstack.org/openstack/openstack-manuals.git
      $ cd openstack-manuals

#. View the remote tags to see the tags for each release:

   .. code-block:: console

      $ git tag -l
      2012.1
      2012.2
      2013.1.rc1
      2013.1.rc2
      2013.2
      diablo-eol
      essex-eol
      folsom-eol
      grizzly-eol
      havana-eol
      icehouse-eol
      juno-eol
      kilo-eol
      liberty-eol

#. Look for the release name you want to build, such as Essex, and check out
   the corresponding tag:

   .. code-block:: console

      $ git checkout essex-eol

   Git checks out the files and when complete, shows you the reference point
   for your local files, such as, ``HEAD is now at e6b9f61... fix
   delay_auth_decision parameter``.

#. Read the :file:`README.rst` file available at that point in time for the
   prerequisites for building the documentation locally. For example, you may
   need to install Apache Maven in order to build old documents.
