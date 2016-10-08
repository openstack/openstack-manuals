.. _backport:

Backport a change
~~~~~~~~~~~~~~~~~

When committing to the master branch, add the ``backport`` line to your
commit message for potential backport patches (Installation Tutorials and
Guides, Configuration Reference, Networking Guide, and common directory).
For example:

* To backport to a single branch:

  .. code-block:: console

     backport: mitaka

* To backport to multiple branches:

  .. code-block:: console

     backport: mitaka liberty

* If no backporting is needed, do not add the ``backport`` line,
  or explicitly add:

  .. code-block:: console

     backport: none
