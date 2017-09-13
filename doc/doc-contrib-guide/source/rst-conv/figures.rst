.. _rst_figures:

=======
Figures
=======

Use the ``figure`` directive to include an image, figure, or screenshot into
the documentation.

The PNG image format is preferred over other image formats for all image
files. If available the source files (SVG, OmniGraffle, ..) of generated
image files should be provided. Formats editable by open sources tools are
preferred.

**Syntax**

.. code-block:: none

  .. figure:: file_name.file_extension
     :option: option_value

The figure directive supports the following options:

* alt
* height
* figwidth
* scale
* align
* target
* figclass

For descriptions of the options and their possible values, refer to the
`Docutils documentation <http://docutils.sourceforge.net/docs/ref/rst/directives.html#figure>`_.

.. seealso::

   For the style guidelines on figure titles, see :ref:`figure_table_titles`.
