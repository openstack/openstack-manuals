.. _topic_structure:

===============
Topic structure
===============

The OpenStack community welcomes all contributors to documentation. This
section provides recommendations on how to structure the content that you
submit to the ``openstack-manuals`` repository.

Organize technical information in topics. Use the principles of topic-based
authoring in all technical publications.

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
  A task topic provides a sequence of steps detailing how to achieve a
  certain task. A section (or chapter) is the high-level task topic.

  Typically, a section includes multiple sub-sections: task, concept, and
  reference topics. Start the title of a high-level task topic with a verb
  in gerund and the title of a subtask topic with a verb in imperative.

  Task topics are the most important topics in any technical documentation.
  Typically, the reader browses through the table of contents searching for
  information on how to configure the network, storage, or any other
  component of a system.

  Examples of concept topic titles:

  * Section topic title: *Monitoring performance*.
  * Task topic title: *Delete a node*, *Recover from a failure*.

  A task topic includes:

  * Title
  * Short description (intro)
  * Procedure (a sequence of steps)
  * Result
  * Related links (See also)
  * (optional) Examples

**Reference**
  A reference topic provides additional information about a functionality.
  Typically, information in a reference topic is presented in lists or tables.

  Example of a reference topic title: *Supported operating systems*.
