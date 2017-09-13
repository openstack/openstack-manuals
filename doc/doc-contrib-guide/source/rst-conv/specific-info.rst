===========================
Specific information blocks
===========================

Use special markups to emphasize specific information within your document.
Depending on specific semantic meaning of the message, you can use:

* **note** - for a message of generic meaning.

* **warning** or **important** - includes details that can be easily missed,
  but should not be ignored by a user and are valuable before proceeding.

* **caution** - delivers information that prevents a user from mistakes
  and undesirable consequences when following the procedures.

* **tip** or **seealso** - wraps extra but helpful information.

Here is the example of the note directive usage; these can be applied to all
the admonition directives described above.

**Input**

.. code-block:: none

   .. note::

      This is the text of a generic admonition.
      This line is the continuation of the first line.

      A note may contain bulleted or enumerated lists,
      as well as code blocks:

      * First option,
      * ...

**Output**

.. note::

   This is the text of a note admonition.
   This line is the continuation of the first line.

   A note may contain bulleted or enumerated lists,
   as well as code blocks:

   * First option,
   * ...
