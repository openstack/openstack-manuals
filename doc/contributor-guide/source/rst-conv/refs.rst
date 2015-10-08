==========
References
==========

Cross-references
~~~~~~~~~~~~~~~~

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
~~~~~~~~~~~~~~~~~~~

To link to some external locations, format RST source as follows:

* Do not apply any markups to specify a web link.

* If you need a specific link title to appear in the output,
  format a web link as ``Link text <http://web-link.com>``
  wrapping it in backticks.

* If a source file contains a big number of external references,
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


