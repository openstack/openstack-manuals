.. _ui-terminology:

Standard UI terminology
~~~~~~~~~~~~~~~~~~~~~~~

The user interface (UI) term used in this section as a collective term and
refers to:

* Graphical user interface (GUI)
* Web user interface (WUI)
* Command-line interface (CLI)

This section provides general guidelines on how to describe UI elements
together with the preferred verbs and nouns.

Command-line interface guidelines
---------------------------------

When documenting actions that readers must perform in a command-line interface
(CLI), use the following guidelines:

* Use the related RST directives for the inline commands, file names,
  directories, options, and so on. See :ref:`inline_elements_rst` for details.

* Format code snippets as standalone literal blocks. See :ref:`source-code`
  for details.

* When you provide an output of a command, consider if a user needs to see all
  output or partial. If an output includes multiple lines, consider cutting
  the output. Use ellipses (...) to show that the page displays a portion of
  the output.

* Depending on whether you describe CLI actions in the running text or
  in procedures, consider the following usage:

  .. list-table:: **In running text**
     :widths: 10 10
     :header-rows: 1

     * - Do not use
       - Use
     * - You can use the :command:`ping` to verify the network connection
         between the two devices.
       - You can use the :command:`ping` command to verify the network
         connection between the two devices.
     * - You can use :command:`nova image-create` command to take a snapshot.
       - You can use the :command:`nova image-create` command to take
         a snapshot.

  |

  .. list-table:: **In procedures**
     :widths: 10 10
     :header-rows: 1

     * - Do not use
       - Use
     * - Switch off the VM by running the :command:`restart` command.
       - Switch off the VM by running :command:`restart`.
     * - Switch off the VM by running :command:`restart` command.
       - Switch off the VM by running :command:`restart`.

Graphical and web user interfaces guidelines
--------------------------------------------

When documenting GUI and WUI, use the following guidelines:

* Write the names of the UI elements exactly as they appear, including
  punctuation.

* Use :ref:`the :guilabel: RST markup <gui_element>` for all graphical
  and web UI elements.

  **Example:** Click :guilabel:`OK`.

* When describing a procedure in the GUI and WUI, start a step with
  the location in the UI. This helps the user unfamiliar with it
  to quickly find the required element.

  **Example:** In the :guilabel:`Nodes` tab, click :guilabel:`Add Nodes`.

* Use the following standard UI terminology when describing GUI and WUI:

  .. list-table:: **Standard UI terminology: Verbs**
     :widths: 10 30
     :header-rows: 1

     * - Term
       - Meaning
     * - Click
       - An act of pressing and releasing of a mouse button.
     * - Press
       - An action that requires pressing a button (physically) on your
         keyboard, a power button, and so on.
     * - Type
       - An act of pressing a key to type it into a text box, etc.

  |

  .. list-table:: **Standard UI terminology: Nouns**
     :widths: 10 30
     :header-rows: 1

     * - Term
       - Meaning
     * - Field
       - An area in the WUI or GUI where you need to enter information.
     * - Dialog
       - A pop-up window that appears after an action. Do not use `screen`.
     * - Panel
       - A toolbar or a control panel.
     * - Pane
       - An independent area in the WUI or GUI that you can scroll and resize.
     * - Button
       - A graphical or web element which executes an action when clicked.
     * - Icon
       - A graphical or web element that represents a shortcut to an action.
     * - Tab
       - A graphical or web element that groups a set of actions.
     * - Wizard
       - A dialog that walks a user through the sequence of steps to perform
         a particular task.

|

For more details, use the `IBM Terminology <https://www-01.ibm.com/software/globalization/terminology/>`_
as a reference.

