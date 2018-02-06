.. _topic_structure:

===============
Topic structure
===============

The OpenStack community welcomes all contributors to documentation. This
section provides ideas on how to structure the content for an OpenStack
project by using the principles of topic-based authoring.

Topic-based authoring is a method of content creation in which information
is structured in small chunks of a particular type. In contrast to
book content, where information has a linear structure, in topic-based
authoring you presume that a user can begin reading documentation from
any topic. Therefore, each topic represents an independent piece of
information. Each topic states prerequisites and dependencies, if any, as
well as providing information about the next steps.

In topic-based authoring, a chunk of information is called a `topic`.

Structure the information around the following topics:

**Concept**
  A concept topic explains a particular functionality. It does not
  provide a sequence of steps or information on how to use the
  functionality.

  Example of a concept topic title: *Introduction to the OpenStack components
  and services*.

  A concept topic includes:

  * Title
  * Description
  * Related links
  * (optional) Diagrams
  * (optional) Examples

**Task**
  A task topic provides a sequence of steps (a procedure) detailing how to
  achieve a particular outcome, such as configuring a network. If you have
  conceptual information related to the task, put it into an overview before
  the procedure. Make the steps in the procedure concise. Start each step in
  a procedure with a verb. If the step includes a command example, end the
  introductory sentence with a colon (:).

  Examples of concept topic titles:

  * Section topic title: *Monitoring performance*.
  * Task topic title: *Delete a node*, *Recover from a failure*.

  A task topic includes:

  * Title
  * Short description (overview)
  * Procedure (a sequence of steps)
  * Result
  * Related links (See also)
  * (optional) Examples

**Reference**
  A reference topic provides additional information about a functionality.
  Typically, information in a reference topic is presented in lists or tables.

  Example of a reference topic title: *Supported operating systems*.
