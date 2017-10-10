==================
General guidelines
==================

Lines length
~~~~~~~~~~~~

Wrap source lines so that lines length does not exceed 79 characters.
This requirement matches PEP8 standards (from Python) and helps with
side-by-side diffs on reviews.

.. note::

   An exception to this rule is the content of code-block elements and links
   within the references.

When formatting a table that presupposes long lines of text, give
preference to one of the following methods over the ``table`` directive:

* Format a table using the ``list-table`` directive.
* Format a table using the ``csv-table`` directive.
* Format information as definition lists to avoid tables where possible.

Space and tab characters
~~~~~~~~~~~~~~~~~~~~~~~~

* Do not use tab characters within the code, use space characters instead.

* Do not place space characters at the end of lines. If used,
  the linters test will fail because of trailing whitespaces.

Indentation
~~~~~~~~~~~

Use indentation very carefully and keep it consistent since it is significant
for content nesting. Any indentation that differs from the previous
one in length, terminates the current level of content either introducing
a new content sublevel, or shifting to an upper content level.

Use indentation to format the nested content within:

* Definition lists
* Admonitions (notes, warnings, and so on)
* Code blocks
* List and CSV tables

For more information on how to format elements from the list above,
see the related section of this chapter.
