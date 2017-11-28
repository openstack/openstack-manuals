.. _redirects:

=========================
Redirecting documentation
=========================

As of the Pike release, redirection of links became imperative as a direct
result of the `doc-migration`_ that saw a large majority of the documentation
living in the `openstack-manuals` repository moved out to the respective
project repositories. This content move, however, did break a lot of external
(and internal) links.

Adding a .htaccess file to your repo
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The first step is to add the ``.htaccess`` configuration file that Apache
requires to know what the redirect rules are. `openstack-manuals` has a global
file in the `openstack-manuals` repository but we have also configured Apache
to allow a ``.htaccess`` file in each project's documentation.

If including a ``.htaccess`` file in the project, then Sphinx needs to be told
to include the file in the build output by adding it to the list of `extra`
files. `This patch`__ for nova shows how that is done by editing
``doc/source/conf.py`` to set ``html_extra_path``.  If the path is set to
``_extra``, then the patch should also create ``doc/source/_extra/.htaccess``
containing the redirects needed. The contents of that file can be written by
hand, or :ref:`computed with a command <git-redirect-generation>`.

.. note::
   If you want to take advantage of the :ref:`whereto tool <whereto-tool>`
   as part of the build-openstack-sphinx-docs job in the gate, you *must*
   put your ``.htaccess`` file in ``_extra``.  (This isn't a Sphinx
   requirement, it's a requirement of how the gate job is set up.)

While this file is a real ``.htaccess`` file, it is expected that the file will
only contain redirects using the ``Redirect`` and ``RedirectMatch`` rules. For
example, the below shows a number of redirects for the nova project reflecting
files moved between the Ocata and Pike releases:

.. code-block:: apache

   redirectmatch 301 ^/nova/([^/]+)/aggregates.html$ /nova/$1/user/aggregates.html
   redirectmatch 301 ^/nova/([^/]+)/architecture.html$ /nova/$1/user/architecture.html
   redirectmatch 301 ^/nova/([^/]+)/block_device_mapping.html$ /nova/$1/user/block-device-mapping.html
   redirectmatch 301 ^/nova/([^/]+)/cells.html$ /nova/$1/user/cells.html
   redirectmatch 301 ^/nova/([^/]+)/conductor.html$ /nova/$1/user/conductor.html
   redirectmatch 301 ^/nova/([^/]+)/feature_classification.html$ /nova/$1/user/feature-classification.html
   redirectmatch 301 ^/nova/([^/]+)/filter_scheduler.html$ /nova/$1/user/filter-scheduler.html
   redirectmatch 301 ^/nova/([^/]+)/placement.html$ /nova/$1/user/placement.html

This file will ensure redirects are in place for paths such as
``/nova/latest/aggregates.html`` to ``/nova/latest/user/aggregates.html``, and
``/nova/latest/cells.html`` to ``/nova/latest/user/cells.html``.

__ https://review.openstack.org/#/c/487932/5/doc/source/conf.py

Enable detailed redirects for your project
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As of the Pike release and the doc-migration, everything that was under
``/developer/$project/`` was moved to ``/$project/latest/`` (with similar moves
for other versions). By default, any page under ``/developer/$project/`` is now
being redirected to ``/$project/latest/``. This gives the user a table of
contents to find the new page.

After a local ``.htaccess`` file is added to a project's documentation,
``/developer/$project/(.*)`` can be redirected to ``/$project/latest/$1``,
which will then redirect *again* to the new home of the file.

To turn that feature on for your repository, set the ``has_in_tree_htaccess``
flag for the repo by modifying ``www/project-data/latest.yaml`` in the
`openstack-manuals` repository. See :doc:`/doc-tools/template-generator` for
details about the other flags you can set to control how your project appears
on ``docs.openstack.org``.

After the ``has_in_tree_htaccess`` flag change lands, links to URLs like
``docs.openstack.org/developer/nova/cells.html`` should (with two redirects)
end up at the new home ``docs.openstack.org/nova/latest/user/cells.html``.

.. _whereto-tool:

Testing your redirects
~~~~~~~~~~~~~~~~~~~~~~

Your redirects can be tested using the `whereto`_ tool.  Because you'll
obviously want them to be tested, the build-openstack-sphinx-docs job
is already set up to use **whereto** in the gate, and will run **whereto**
on docs build jobs automatically whenever **whereto** is present in the
dependency list for a project.  Thus to enable redirect testing, all you need
to do is add **whereto** to your repository's ``doc/requirements.txt`` or
``test-requirements.txt`` file.

To get the job to pass, however, you'll have to make sure that the
build-openstack-sphinx-docs job can find the input files that **whereto**
expects.  These files are:

* The Apache redirect file.  The build job expects this file to be named
  ``.htaccess`` and to be located in the ``doc/source/_extra`` directory.

* The test file.  The build job expects this file to be named
  ``test-redirects.txt`` and to be located in the ``doc/test`` directory.

As a convenience for developers running the build locally, you can add an
explicit call to **whereto** in your project's ``tox.ini`` file.  (This
`glance-specs patch`_ provides an example.)

.. _whereto: https://docs.openstack.org/whereto/latest/
.. _glance-specs patch: https://review.openstack.org/#/c/523472/2/tox.ini

.. _git-redirect-generation:

Optional: Generating .htaccess files from Git
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If creating an initial ``.htaccess``, you can use some Git-fu to automatically
generate a file containing redirects between the last release and the current
one. For example, to generate a list of redirects for the nova project for
files moved between Ocata (`stable/ocata`) and the current `HEAD` (presumed to
be Pike), run:

.. code-block:: console

   $ git log --follow --name-status \
     --format='%H' origin/stable/ocata.. \
     -- doc/source | \
         grep ^R | \
         grep .rst | \
         cut -f2- | \
         sed -e 's|doc/source/|^/nova/([^/]+)/|' \
             -e 's|doc/source/|/nova/$1/|' \
                 -e 's/.rst/.html$/' \
                 -e 's/.rst/.html/' \
                 -e 's/^/redirectmatch 301 /'

The output will look as follows:

.. code-block:: apache

   redirectmatch 301 ^/nova/([^/]+)/aggregates.html$ /nova/$1/user/aggregates.html
   redirectmatch 301 ^/nova/([^/]+)/architecture.html$ /nova/$1/user/architecture.html
   redirectmatch 301 ^/nova/([^/]+)/block_device_mapping.html$ /nova/$1/user/block-device-mapping.html
   redirectmatch 301 ^/nova/([^/]+)/cells.html$ /nova/$1/user/cells.html
   redirectmatch 301 ^/nova/([^/]+)/conductor.html$ /nova/$1/user/conductor.html
   redirectmatch 301 ^/nova/([^/]+)/feature_classification.html$ /nova/$1/user/feature-classification.html
   redirectmatch 301 ^/nova/([^/]+)/filter_scheduler.html$ /nova/$1/user/filter-scheduler.html
   redirectmatch 301 ^/nova/([^/]+)/placement.html$ /nova/$1/user/placement.html

For those curious enough, this script works like so:

#. The `git log` command traverses the Git history of master since the
   `stable/ocata` branch was cut, following files under `doc/source` as they are
   renamed, and shows the hash of the change and names and status of changed
   files. The output looks like:

   .. code-block:: console

      2f36a355f29cb9f23beb2b80399e59f02d3c17a3
      M       doc/source/_extra/.htaccess
      M       doc/source/index.rst
      R100    doc/source/user/cellsv2_layout.rst      doc/source/user/cellsv2-layout.rst
      M       doc/source/user/index.rst

#. The `grep` command filters for lines starting with ``R`` (indicating that
   the file was renamed) and for files ending in ``.rst`` (to limit to
   documentation files). The output looks like:

   .. code-block:: console

      R100    doc/source/user/cellsv2_layout.rst      doc/source/user/cellsv2-layout.rst

#. The `cut` command takes field 2 to the end, giving the old filename and the
   new filename:

   .. code-block:: console

      doc/source/user/cellsv2_layout.rst      doc/source/user/cellsv2-layout.rst

#. Finally, the `sed` command replaces the `doc/source` parts of the paths with
   the project name and a pattern that will match the series portion of the
   URL. It converts the `.rst` extension to `.html` and inserts the
   ``redirectmatch`` directive at the front of the line, giving:

   .. code-block:: console

      redirectmatch 301 ^/nova/([^/]+)/user/cellsv2_layout.html$	/nova/$1/user/cellsv2-layout.html

.. _doc-migration: https://specs.openstack.org/openstack/docs-specs/specs/pike/os-manuals-migration.html
