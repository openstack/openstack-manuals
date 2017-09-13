.. _rst_tables:

======
Tables
======

This section describes several types of tables that you can use in the
OpenStack documentation. Each table must have a title. Name a table using
the ``table`` directive. See corresponding subsections for the title
formatting details.

.. seealso::

   For the style guidelines on table titles, see :ref:`figure_table_titles`.

Graphic tables
~~~~~~~~~~~~~~

Use the graphic table formatting for the content that presupposes short
lines of text and a small number of rows and columns.

.. note::

   As the graphic tables are rather difficult to create and maintain,
   give the preference to list and CSV tables over the graphic ones,
   or format the content as definition lists where possible.

**Input**

.. code-block:: none

   .. table:: **Default flavors**

    ============  =========  ===============  =============
     Flavor         VCPUs      Disk (in GB)     RAM (in MB)
    ============  =========  ===============  =============
     m1.tiny        1          1                512
     m1.small       1          20               2048
     m1.medium      2          40               4096
     m1.large       4          80               8192
     m1.xlarge      8          160              16384
    ============  =========  ===============  =============

**Output**

.. table:: **Default flavors**

 ============  =========  ===============  =============
  Flavor         VCPUs      Disk (in GB)     RAM (in MB)
 ============  =========  ===============  =============
  m1.tiny        1          1                1
  m1.small       1          20               2048
  m1.medium      2          40               4096
  m1.large       4          80               8192
  m1.xlarge      8          160              16384
 ============  =========  ===============  =============

List tables
~~~~~~~~~~~

Use the ``list-table`` directive to create a table that contains a large
number of rows and columns with the long lines within the cells.

**Input**

.. code-block:: none

   .. list-table:: **Quota descriptions**
      :widths: 10 25 10
      :header-rows: 1

      * - Quota Name
        - Defines the number of
        - Service
      * - Gigabytes
        - Volume gigabytes allowed for each project
        - Block Storage
      * - Instances
        - Instances allowed for each project.
        - Compute
      * - Injected File Content Bytes
        - Content bytes allowed for each injected file.
        - Compute

**Output**

.. list-table:: **Quota descriptions**
      :widths: 10 25 10
      :header-rows: 1

      * - Quota Name
        - Defines the number of
        - Service
      * - Gigabytes
        - Volume gigabytes allowed for each project
        - Block Storage
      * - Instances
        - Instances allowed for each project.
        - Compute
      * - Injected File Content Bytes
        - Content bytes allowed for each injected file.
        - Compute

CSV tables
~~~~~~~~~~

The ``csv-table`` directive enables creating a table from CSV
(comma-separated values) data. It also supports RST inline markups,
such as, emphasis, strong emphasis markups, code, command, and other
directives.

**Input**

.. code-block:: none

   .. csv-table:: **ipv6_ra_mode and ipv6_address_mode combinations**
      :header: ipv6 ra mode, ipv6 address mode, "radvd A,M,O", "External Router A,M,O", Description
      :widths: 2, 2, 2, 2, 4

      *N/S*, *N/S*, Off, Not Defined, Backwards compatibility with pre-Juno IPv6 behavior.
      *N/S*, slaac, Off, "1,0,0", Guest instance obtains IPv6 address from non-OpenStack
      *N/S*, dhcpv6-stateful, Off, "0,1,1", Not currently implemented in the reference implementation.

**Output**

.. csv-table:: **ipv6_ra_mode and ipv6_address_mode combinations**
   :header: ipv6 ra mode, ipv6 address mode, "radvd A,M,O", "External Router A,M,O", Description
   :widths: 2, 2, 2, 2, 4

   *N/S*, *N/S*, Off, Not Defined, Backwards compatibility with pre-Juno IPv6 behavior.
   *N/S*, slaac, Off, "1,0,0", Guest instance obtains IPv6 address from non-OpenStack
   *N/S*, dhcpv6-stateful, Off, "0,1,1", Not currently implemented in the reference implementation.

Useful links on table formatting
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* `Graphic tables formatting details
  <http://docutils.sourceforge.net/docs/user/rst/quickref.html#tables>`_
* `List tables formatting details
  <http://docutils.sourceforge.net/docs/ref/rst/directives.html#list-table>`_
* `CSV tables formatting details
  <http://docutils.sourceforge.net/docs/ref/rst/directives.html#id48>`_
