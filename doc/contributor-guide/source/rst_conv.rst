
.. _rst_conv:

==========================
RST formatting conventions
==========================

Follow these guidelines for all the RST source files to keep the documentation
format consistent.


General guidelines
~~~~~~~~~~~~~~~~~~

Lines length
------------

Wrap source lines so that lines length does not exceed 79 characters.
This requirement matches PEP8 standards (from Python) and helps with
side-by-side diffs on reviews.

.. note::

   Exception to this rule is the content of code-block elements and links
   within the references.

When formatting a table that presupposes long lines of text, give
the preference to one of the following methods over the ``table`` directive:

* format a table using the ``list-table`` directive;
* format a table using the ``csv-table`` directive;
* format information as definition lists to avoid tables where possible.

Space and tab characters
------------------------

* Do not use tab characters within the code; use space characters instead.

* Do not place space characters at the end of lines. If used,
  the checkniceness test will fail because of the trailing whitespaces.


.. _cg_titles:

Titles
~~~~~~

Each RST source file has the tree structure. Define up to three heading
levels within one file using the following non-alphanumeric characters:

* **Heading 1** - underline and overline with equal signs;

  * **Heading 2** - underline with tildes;

    * **Heading 3** - underline with dashes.

**Input**

.. code::

   =========
   Heading 1
   =========

   Body of the first level section that includes general overview
   of the subject to be covered by the whole section.
   Can include several focused Heading-2-sections.

   Heading 2
   ~~~~~~~~~

   Body of the second level section that gives detailed explanation of one
   of the aspects of the subject. Can include several Heading-3-sections.

   Within user guides, it is mostly used to entitle a procedure with a set
   of actions targeted at a single task performance.
   For example, "Associate floating IP addresses".

   Heading 3
   ---------

   Body of the third level section.
   It includes very specific content; and occurs mainly in guides containing
   technical information for advanced users.

.. note::

   Under- and overlines should be of the same length
   as that of the heading text.

   Avoid using lower heading levels by information
   rewriting and reorganizing.


Specific information
~~~~~~~~~~~~~~~~~~~~

Use special markups to emphasize specific content within the text.
Depending on specific semantic meaning of the message, you can use:

* **note** - for a message of generic meaning.

* **warning** or **important** - includes details that can be easily missed,
  but should not be ignored by a user and are valuable before proceeding.

* **caution** - delivers information that prevents a user from mistakes
  and undesirable consequences when following the procedures.

* **tip** - wraps extra but helpful information.

Here is the example of the note directive usage; these can be applied to all
the admonition directives described above.

**Input**

.. code::

   .. note:: This is the text of a generic admonition.
             This line is the continuation of the first line.

             Note may contain bulleted or enumerated lists,
             as well as code blocks:

             * first option,
             * ...

**Output**

.. note:: This is the text of a note admonition.
          This line is the continuation of the first line.

          Note may contain bulleted or enumerated lists,
          as well as code blocks:

          * first option,
          * ...


Code samples
~~~~~~~~~~~~

Format code snippets as standalone literal blocks. There are several ways
to define a code-block within an RST file.

Standard literal block
----------------------

+------------------+---------------------------------------------------------+
| **Directive**    | ``::`` or ``code``                                      |
+------------------+---------------------------------------------------------+
| **Arguments**    | none                                                    |
+------------------+---------------------------------------------------------+
| **Options**      | none                                                    |
+------------------+---------------------------------------------------------+
| **Description**  | * Introduces a standard reST literal block.             |
|                  | * Preserves line breaks and whitespaces.                |
|                  | * Automatically highlights language (Python, by         |
|                  |   default)                                              |
+------------------+---------------------------------------------------------+

Use ``::`` or ``code`` directive if you provide the code snippets written
in one programming language within one file. By default, the code-block
formatted this way is shown in a Python highlighting mode.

To define another highlighting language, specify the ``highlight`` directive
at the top of the file. Use the ``linenothreshold`` option with it
to enumerate lines within the code-block.

Always switch on the enumeration for the code-blocks that include more
than 5 lines.

**Input**

.. code::

   .. highlight:: console
      :linenothreshold: 5

   This is the file body with the code snippet within:

   ::

     $ neutron ext-list -c alias -c name
     +-----------------+--------------------------+
     | alias           | name                     |
     +-----------------+--------------------------+
     | agent_scheduler | Agent Schedulers         |
     | binding         | Port Binding             |
     | quotas          | Quota management support |
     | ...             | ...                      |
     +-----------------+--------------------------+


Non-standard literal block
--------------------------

+------------------+---------------------------------------------------------+
| **Directive**    | ``code-block``                                          |
+------------------+---------------------------------------------------------+
| **Arguments**    | ``python`` (default), ``ruby``, ``c``, ``console``,     |
|                  | ``ini``, and others                                     |
+------------------+---------------------------------------------------------+
| **Options**      | ``linenos``, ``emphasize-lines``                        |
+------------------+---------------------------------------------------------+
| **Description**  | * Specifies the highlighting language directly.         |
|                  | * Preserves line breaks and whitespaces.                |
|                  | * Has special options to number lines and emphasize     |
|                  |   specific lines within the block.                      |
+------------------+---------------------------------------------------------+

To optimize the output of code for a specific programming language, specify
the corresponding argument with ``code-block``. Use ``ini`` for configuration
files, ``console`` for console inputs and outputs, and so on.

Specify ``linenos`` for automatic enumeration of the code-blocks that include
more than 5 lines.

If you need to draw a user's attention to the particular code lines, use
the ``emphasize-lines`` option followed by the numbers of the lines to
emphasize.

**Input**

.. code::

   .. code-block:: ini
      :emphasize-lines: 1, 4

      # Configuration for nova-rootwrap
      # This file should be owned by (and only-writeable by) the root user

      [DEFAULT]
      # List of directories to load filter definitions from (separated by ',').




References
~~~~~~~~~~

Cross-references
----------------

To cross-reference to arbitrary locations within one document,
use the ``ref`` role:

**Input**

.. code::

   .. _cg_titles:

   Titles
   ~~~~~~

   This is the section we want to reference to.

   ...

   The following - :ref:`cg_titles` - generates a link to the section with
   the defined label using this section heading as a link title.

   A link label and a reference can be defined in separate source files,
   but within one directory. Otherwise, use the external linking.

**Output**

...

The following - :ref:`cg_titles` - generates a link to the section with
the defined label using this section heading as a link title.

A link label and a reference can be defined in separate source files,
but within one directory. Otherwise, use the external linking.


External references
-------------------

To link to some external locations, format RST source as follows:

#. Do not apply any markups to specify a web link.
#. If you need a specific link title to appear in the output,
   format a web link as ``Link text <http://web-link.com>``
   wrapping it in backticks.
#. If a source file contains a big number of external references,
   you can separate a link from its definition for better readability
   while reviewing as shown in the example.

**Input**

.. code::

   Here is a link to the User guide: http://docs.openstack.org/user-guide/.

   Here is an external web link with a link title:
  `User guide <http://docs.openstack.org/user-guide/>`_.

   Here is an external web link separated from its definition:
   This paragraph contains the link to `User guide`_.

   ...

   .. format the link definition at the end of the file as follows:
   .. _`User guide`: http://docs.openstack.org/user-guide/


**Output**

Here is a link to the User guide: http://docs.openstack.org/user-guide/.

Here is an external web link with a link title:
`User guide <http://docs.openstack.org/user-guide/>`_.

Here is an external web link separated from its definition:
This paragraph contains the link to `User guide`_.

...

.. format the link definition at the end of the file as follows:
.. _`User guide`: http://docs.openstack.org/user-guide/

