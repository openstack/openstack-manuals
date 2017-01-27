==========
References
==========

Cross-references
~~~~~~~~~~~~~~~~

To cross-reference to arbitrary locations within one document,
use the ``ref`` role:

**Input**

.. code-block:: none

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

To link to some external locations, format the RST source as follows:

* Do not apply any markups to specify a web link.

* If you need a specific link title to appear in the output,
  format a web link as ``Link text <http://web-link.com>``
  wrapping it in backticks.

* Do not separate the link name from the link itself by defining the link in
  another place in your document. It prevents translated documents from using
  different links, for example, corresponding links to translated versions.

**Input**

.. code-block:: none

   Here is a link to the User guide: https://docs.openstack.org/user-guide/.

   Here is an external web link with a link title:
  `User guide <https://docs.openstack.org/user-guide/>`_.

**Output**

Here is a link to the User guide: https://docs.openstack.org/user-guide/.

Here is an external web link with a link title:
`User guide <https://docs.openstack.org/user-guide/>`_.
