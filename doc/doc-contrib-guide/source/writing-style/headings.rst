.. _headings:

========
Headings
========

Readers use the table of contents or scan through the headings to find the
required content. Therefore, headings must reflect the information that the
readers search. The OpenStack documentation includes the following types of
headings:

* Section titles
* Topic titles
* Figure and table titles

General guidelines
~~~~~~~~~~~~~~~~~~

Use the following guidelines for all types of headings:

* Use sentence-style capitalization.
* Make headings brief but descriptive.
* Use articles in titles, but do not start the title with an article.
* Avoid using uncommon abbreviations.
* Do not end a title with a period or colon.
* Add some introductory text between two headings that go directly after each
  other.

For details on RST formatting, see :ref:`cg_titles`.

Section titles
~~~~~~~~~~~~~~

Write the section title in gerund where possible.

**Examples:**

* Monitoring performance
* Managing resources

Subsection titles
~~~~~~~~~~~~~~~~~

If a subsection contains a sub-subsection, start the title of the subsection
with a verb in gerund or a noun.

**Example:**

* Testing the OpenStack environment

  * Testing Ceph and OpenStack interoperability

    * Test Ceph and Glance
    * Test Ceph and Cinder
    * Test Ceph and Rados GW
    * Test Ceph and Swift

Start the subsection or sub-subsection with a noun or an adjective if it is a
concept or a reference topic.

**Example:**

* Maintaining your environment

  * General considerations

Topic titles
~~~~~~~~~~~~

Start the task topic title with an imperative verb.

**Examples:**

* Add a node
* Remove a node

.. _figure_table_titles:

Figure and table titles
~~~~~~~~~~~~~~~~~~~~~~~

Follow these guidelines for figure and table titles:

* When introducing a table, figure, or diagram, add a short descriptive title.
* Do not add the word *Table*, *Diagram*, or *Figure* to the title.
* Do not number tables, figures, or diagrams.
* Place the title *above* tables, figures, or diagrams.
* Make the title font bold.
* Screenshots do not require titles.

For details on RST formatting, see :ref:`rst_tables` and :ref:`rst_figures`.
