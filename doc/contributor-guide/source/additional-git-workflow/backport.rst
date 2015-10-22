
.. _backport:

Backport a change
~~~~~~~~~~~~~~~~~

When committing to the master branch, add the ``backport`` line to your
commit message for potential backport patches (Installation Guide,
Configuration Reference, and common directory). For example:

* To backport to a single branch:

  .. code-block:: console

     backport: icehouse

* To backport to multiple branches:

  .. code-block:: console

     backport: icehouse kilo

* If no backporting is needed:

  .. code-block:: console

     backport: none
