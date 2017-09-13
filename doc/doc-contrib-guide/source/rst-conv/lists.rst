=====
Lists
=====

Select the appropriate list type to present a sequence of items.

Enumerated lists
~~~~~~~~~~~~~~~~

Use the enumerated list formatting for a sequence of items whose order
matters.

**Input**

.. code-block:: none

   During the migration process the target host:

   #. Ensures that live migration is enabled.
   #. Installs the base VHD if it is not already present.

**Output**

During the migration process the target host:

#. Ensures that live migration is enabled.
#. Installs the base VHD if it is not already present.

Bulleted lists
~~~~~~~~~~~~~~

Use the bulleted list for a sequence of items that can happen in any order
or whose order does not matter.

**Input**

.. code-block:: none

  Valid formats include:

  * PNG
  * JPG
  * GIF
  * SVG

**Output**

Valid formats include:

* PNG
* JPG
* GIF
* SVG

Definition lists
~~~~~~~~~~~~~~~~

Use the definition list for an unordered list in which each item has a short
term. For example, key, option, or phrase, followed by its definition.

Consider using a variable list instead of:

* An itemized list when your list has a regular pattern of key/value or
  term/definition pairs.

* A two-column table where the first column lists items of a consistent type
  and the second column describes the items.

**Input**

.. code-block:: none

   Spellchecking
    Process of correcting spelling

   Pagebreaking
    Process of breaking pages

**Output**

Spellchecking
 Process of correcting spelling

Pagebreaking
 Process of breaking pages

Mixed lists
~~~~~~~~~~~

Use the mixed types of lists to nest lists of different types.

**Input**

.. code-block:: none

   #. The system exposes these components to users:

      Component A
       Description of A.

      Component B
       Description of B.

      Component C
       Description of C.  Note: C is available only for these OS's:

       * Linux
       * Mac OS X

   #. API libraries are available.

**Output**

#. The system exposes these components to users:

   Component A
    Description of A.

   Component B
    Description of B.

   Component C
    Description of C.  Note: C is available only for these OS's:

    * Linux
    * Mac OS X

#. API libraries are also available.
