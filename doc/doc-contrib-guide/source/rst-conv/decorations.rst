===========
Decorations
===========

Sometimes, the documentation build does not look perfect. To improve
readability and, therefore, understanding of the content, you can use
some visual decorations.

This section contains a number of bells and whistles that are neither
conventions nor even recommendations, but extra features of RST markup
syntax for general educational purposes.

Adding a horizontal line
~~~~~~~~~~~~~~~~~~~~~~~~

You can create a horizontal line to visually separate content elements
by typing four ``-`` (hyphen) in a row adding blank lines before and after.

**Input**

.. code-block:: none

   Paragraph 1

   ----

   Paragraph 2

**Output**

Paragraph 1

----

Paragraph 2

Starting a new line
~~~~~~~~~~~~~~~~~~~

Use ``|`` (vertical bar) followed by a single white space to start a new line.

**Input**

.. code-block:: none

   | The first line of text.
   | The second line of text (new line).
   | ...

**Output**

| The first line of text.
| The second line of text (new line).
| ...

Adding extra space between two content elements
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use ``|`` (vertical bar) adding blank lines before and after it to add extra
space between two content elements.

**Input**

.. code-block:: none

   Paragraph 1

   |

   Paragraph 2

**Output**

Paragraph 1

|

Paragraph 2
