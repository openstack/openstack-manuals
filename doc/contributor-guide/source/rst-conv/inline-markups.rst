.. _inline_elements_rst:

===============
Inline elements
===============

Sphinx enables specific pieces of inline text. This is emphasized by
semantic markups that format text in a different style.

Use the markups included in this section as consistent with their semantic
meaning.

.. note::

   An inline semantic markup has no effect when applied to a piece of text
   within a code-block element.

To insert a semantic markup into your document, use the syntax below.

**Syntax**

.. code-block:: rst

  :markup:`inline text`

Application
~~~~~~~~~~~

A software application within a line of text.

+------------------------+---------------------------------------------------+
| **Markup**             | `````` (double backticks)                         |
+------------------------+---------------------------------------------------+
| **Syntax**             | ````RabbitMQ````                                  |
+------------------------+---------------------------------------------------+
| **Example of output**  | Configure ``RabbitMQ``.                           |
+------------------------+---------------------------------------------------+

Code
~~~~

A fragment of code within a line of text.

+------------------------+---------------------------------------------------+
| **Markup**             | `````` (double backticks)                         |
+------------------------+---------------------------------------------------+
| **Syntax**             | `` ``m1.small`` ``                                |
+------------------------+---------------------------------------------------+
| **Example of output**  | The following command launches an instance with   |
|                        | the ``m1.small`` flavor.                          |
+------------------------+---------------------------------------------------+

Command
~~~~~~~

An inline sub-command for the command-line interfaces and inline command for
different operating systems.

+------------------------+---------------------------------------------------+
| **Markup**             | ``:command:``                                     |
+------------------------+---------------------------------------------------+
| **Syntax**             | ``:command:`nova boot```                          |
+------------------------+---------------------------------------------------+
| **Example of output**  | Run the :command:`nova boot` command to launch    |
|                        | an instance.                                      |
+------------------------+---------------------------------------------------+

File name and path
~~~~~~~~~~~~~~~~~~

Any part of a path specification, including device name, directory, file
name, and extension.

+------------------------+---------------------------------------------------+
| **Markup**             | `````` (double backticks)                         |
+------------------------+---------------------------------------------------+
| **Syntax**             | ````nova.conf````                                 |
+------------------------+---------------------------------------------------+
| **Example of output**  | By default, the ``nova.conf`` configuration       |
|                        | file is installed in the ``/etc/nova`` folder.    |
+------------------------+---------------------------------------------------+

Glossary entry
~~~~~~~~~~~~~~

A term that appears in the glossary.

+------------------------+---------------------------------------------------+
| **Markup**             | ``:term:``                                        |
+------------------------+---------------------------------------------------+
| **Syntax**             | ``:term:`neutron```                               |
|                        | or ``:term:`services <service>```                 |
+------------------------+---------------------------------------------------+
| **Example of output**  | OpenStack :term:`neutron` provides                |
|                        | network-related :term:`services <service>`.       |
+------------------------+---------------------------------------------------+

.. _gui_element:

GUI element
~~~~~~~~~~~

Any part of interactive user interface.

+------------------------+---------------------------------------------------+
| **Markup**             | ``:guilabel:``                                    |
+------------------------+---------------------------------------------------+
| **Syntax**             | ``:guilabel:`Project```                           |
+------------------------+---------------------------------------------------+
| **Example of output**  | From the :guilabel:`Project` tab you can view and |
|                        | manage the resources in a selected project.       |
+------------------------+---------------------------------------------------+

Keyboard key combination
~~~~~~~~~~~~~~~~~~~~~~~~

A sequence of two or more keystrokes or mouse actions.

+------------------------+---------------------------------------------------+
| **Markup**             | `````` (double backticks)                         |
+------------------------+---------------------------------------------------+
| **Syntax**             | ````Ctrl+A````                                    |
+------------------------+---------------------------------------------------+
| **Example of output**  | Press ``Ctrl+A`` to switch between services.      |
+------------------------+---------------------------------------------------+

Menu sequence
~~~~~~~~~~~~~

An action of navigating a menu to select an item one or more levels down.

+------------------------+---------------------------------------------------+
| **Markup**             | ``:menuselection:``                               |
+------------------------+---------------------------------------------------+
| **Syntax**             | ``:menuselection:`Project > Compute```            |
+------------------------+---------------------------------------------------+
| **Example of output**  | Go to the :menuselection:`Project > Compute` tab. |
+------------------------+---------------------------------------------------+

Parameter
~~~~~~~~~

Any parameter for sub-commands for the command-line interfaces.

+------------------------+---------------------------------------------------+
| **Markup**             | `````` (double backticks)                         |
+------------------------+---------------------------------------------------+
| **Syntax**             | `` ``--template-url```` or ````back end````       |
+------------------------+---------------------------------------------------+
| **Example of output**  | * You can specify the URL with the                |
|                        |   ``--template-url`` parameter.                   |
|                        | * Set the ``back end`` parameter.                 |
+------------------------+---------------------------------------------------+

Option
~~~~~~

Any option for sub-commands for the command-line interfaces or configuration
option.

+------------------------+---------------------------------------------------+
| **Markup**             | `````` (double backticks)                         |
+------------------------+---------------------------------------------------+
| **Syntax**             | `` ``--parent````,                                |
|                        | ````force_dhcp_release = True````                 |
+------------------------+---------------------------------------------------+
| **Example of output**  | * The ``--parent`` stands for the parent of       |
|                        |   the project (name or ID).                       |
|                        | * The ``force_dhcp_release = True`` option sends  |
|                        |   a dhcp release on instance termination.         |
+------------------------+---------------------------------------------------+

.. note::

   When documenting Boolean configuration options:

   * Explicitly include the truth value
   * Add spaces around the equal sign (``=``)

   **Correct usage**

   .. code-block:: ini

     force_dhcp_release = True
     use_ipv6 = False

Variable
~~~~~~~~

A literal text with a *variable* part in it wrapped in curly braces.

+------------------------+---------------------------------------------------+
| **Markup**             | ``:samp:`` to mark variables with curly braces.   |
|                        | Do not add any additional formatting              |
|                        | to the replaceable text.                          |
+------------------------+---------------------------------------------------+
| **Syntax**             | ``:samp:`--flavor {FLAVOR}```                     |
+------------------------+---------------------------------------------------+
| **Example of output**  | Use the :samp:`--flavor {FLAVOR}` parameter to    |
|                        | specify the ID or name of the flavor.             |
+------------------------+---------------------------------------------------+
