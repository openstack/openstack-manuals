
.. _docs-structure:

=======================
Documentation structure
=======================

.. _filename-conv:

File naming conventions
~~~~~~~~~~~~~~~~~~~~~~~

To indicate the hierarchical type of files for XML filenames use
the following prefixes:

* ``bk_`` for book,
* ``ch_`` for chapter,
* ``section_`` for section
* ``app_`` for appendix.

For RST filenames:

* follow page-based, topical approach to file naming and do not apply
  any special prefixes,

* use hyphen as a space delimiter.

When migrating XML to RST, use the ``xml:id`` attribute value from a source
file as a filename for a converted file. For example, if the source XML file
contains ``xml:id="technical_considerations_multi_site"``, name the newly
created RST file as follows::

  technical-considerations-multi-site.rst


Directory structure
~~~~~~~~~~~~~~~~~~~

For better organization, use subdirectories to organize the files
by a particular grouping such as project or topic.

Common practices include:

* Figure subdirectory includes images (both PNG and SVG source files).
* Sample subdirectory contains samples of source code and configuration files.
* Chapter subdirectory stores all sections included in one chapter with the
  parent file located in the top-level directory.


Structure checklist
~~~~~~~~~~~~~~~~~~~

Use the following checklist for a DocBook manual.

.. list-table:: **DocBook manual checklist**
   :widths: 10 30 5
   :header-rows: 1

   * - Task
     - Make sure that
     - Tick if done

   * - :file:`pom.xml` file
     - Your `pom.xml` file uses the latest (non-SNAPSHOT) cloud-doc plugin
       version and is configured correctly. To find the version number
       of the latest plugin, go to `Clouddocs Maven Plugin Release Notes`_.
     -

   * - TOC
     - Your :file:`pom.xml` file configures a TOC for your book.
     -

   * - Glossary
     - You embedded the shared glossary and marked terms with
       the ``<glossterm>`` tag in your document.
     -

   * - Preface
     - Your book has a preface.
     -

   * - Document history
     - The preface includes the document history. Also, make sure that you
       have included a revision entry for your latest change.
     -

   * - Titles
     - Titles correspond to the file content
     -

   * - Code samples
     - Code samples are in separate files and included in chapter,
       section, or appendix file.
     -

   * - Chunking
     - Chapters and appendices are in separate files and included in the book file.
     -

   * - Source filenames
     - Source filenames use :ref:`filename-conv`.
     -


.. _`Clouddocs Maven Plugin Release Notes`: https://github.com/rackerlabs/clouddocs-maven-plugin#release-notes

