.. _dg_files:

============================
Use recommended file formats
============================

Each diagram should include files in the following formats:

* Raster, always Portable Network Graphics (``.png``).
  The documentation build process uses these files.
* Vector, typically Scalable Vector Graphics (``.svg``).
  Most illustration tools support editing these files.
* Original, typically the native format of the tool.

At a minimum, each diagram must include a ``.png`` and ``.svg`` file.

Furthermore, any outside stencils or objects added to a diagram
should also be ``.svg`` files, so that reviewers can edit individual elements
of the diagram.

.. Note:: Using ``.svg`` files for individual elements may cause rendering
   issues when editing the diagram in a different tool than the one
   from which the diagram was originally created.

File names
~~~~~~~~~~

Contributors must create unique and meaningful file names to
differentiate between diagrams. An example of this is the name
``cg-workflow-digram.png``. ``cg`` indicates that this diagram belongs
in the contributor guidelines, the acronym created by taking
the first letters of the OpenStack book name.  ``workflow-diagram.png``
provides a description of what the diagram is about, as well as the
file type extension.

Other file guidelines
~~~~~~~~~~~~~~~~~~~~~

* Files must be saved with a transparent background.
* Files must be saved in a landscape document style.
* Diagram width and height should be no more than 900pt.
