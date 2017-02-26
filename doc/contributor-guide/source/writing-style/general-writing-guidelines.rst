
.. _stg_gen_write_guidelines:

General writing guidelines
~~~~~~~~~~~~~~~~~~~~~~~~~~

Follow these guidelines to ensure readability and consistency of the
OpenStack documentation. In addition to these guidelines, the
`IBM Style Guide <http://www.redbooks.ibm.com/Redbooks.nsf/ibmpressisbn/9780132101301?Open>`_
is used. In case of conflicts between the IBM style guide and these
guidelines, these pages take precedence.

Use standard English
--------------------

Use standard United States (U.S.) English throughout all technical
publications.
When in doubt about the spelling of a word, consult the
`Merriam-Webster's Collegiate Dictionary` and the `IBM Style Guide
<http://www.redbooks.ibm.com/Redbooks.nsf/ibmpressisbn/9780132101301?Open>`_.

.. _write_in_active_voice:

Write in active voice
---------------------

In general, write in active voice rather than passive voice.
Active voice identifies the agent of action as the subject of the verb —
usually the user.
Passive voice identifies the recipient (not the source) of the action
as the subject of the verb.

Active-voice sentences clarify the performer of an action and are easier
to understand than passive-voice sentences. Passive voice is usually less
engaging and more complicated than active voice. When you use passive voice,
the actions and responses of the software can be difficult to distinguish
from those of the user. In addition, passive voice usually requires more
words than active voice.

**Example of usage**

+---------------------------------+------------------------------------+
| **Do not use**                  | **Use**                            |
+=================================+====================================+
| After the software has been     | After you install the software,    |
| installed, the computer can be  | start the computer.                |
| started.                        |                                    |
+---------------------------------+------------------------------------+
| The Configuration is saved when | Click **OK** to save the           |
| you click **OK**.               | configuration.                     |
+---------------------------------+------------------------------------+
| A server is created by you.     | Create a server.                   |
+---------------------------------+------------------------------------+


However, passive voice is acceptable in the following situations:

* Using active voice sounds like you are blaming the user. For example, you
  can use passive voice in an error message or troubleshooting content when
  the active subject is the user.

  **Example of usage**

  +---------------------------------+------------------------------------+
  | **Do not use**                  | **Use**                            |
  +=================================+====================================+
  | If the build fails, you probably| If the build fails, the flavor     |
  | omitted the flavor.             | might have been omitted.           |
  +---------------------------------+------------------------------------+


* The agent of action is unknown, or you want to de-emphasize the agent of
  action and emphasize the object on which the action is performed.

  **Example of usage**

  +---------------------------------+------------------------------------+
  | **Do not use**                  | **Use**                            |
  +=================================+====================================+
  | The product, OS, or database    | The messages are returned [by the  |
  | returns the messages.           | database].                         |
  +---------------------------------+------------------------------------+


* Recasting the sentence in active voice is wordy or awkward.

  **Example of usage**

  +---------------------------------+------------------------------------+
  | **Do not use**                  | **Use**                            |
  +=================================+====================================+
  | In 2009, engineers developed a  | A software that simplifies the     |
  | software that simplifies the    | installation was developed in 2009.|
  | installation.                   |                                    |
  +---------------------------------+------------------------------------+

Use the present simple tense
----------------------------

Users read documentation to perform tasks or gather information. For users,
these activities take place in their present, so the present tense is
appropriate in most cases. Additionally, the present tense is easier to read
than the past or future tense.

Use the future tense only when you need to emphasize that something will occur
later (from the users' perspective).

**Example of usage**

+------------------------------------+---------------------------------------+
| **Do not use**                     | **Use**                               |
+====================================+=======================================+
| The product will prompt you to     | The product prompts you to verify     |
| verify the deletion. After you log | the deletion. After you log in, your  |
| in, your account will then begin   | account begins the verification       |
| the verification process.          | process.                              |
+------------------------------------+---------------------------------------+

Write in second person
----------------------

Users are more engaged with documentation when you use second person (that is,
you address the user as "you").

Writing in second person has the following advantages:

* Second person promotes a friendly tone by addressing users directly.
* Using second person with the imperative mood (in which the subject you
  is understood) and active voice helps to eliminate wordiness and confusion
  about who or what initiates an action, especially in procedural steps.
* Using second person also avoids the use of gender-specific, third-person
  pronouns such as he, she, his, and hers. If you must use third person, use
  the pronouns they and their, but ensure that the pronoun matches the
  referenced noun in number.

Use first person plural pronouns (we, our) judiciously. These pronouns
emphasize the writer or OpenStack rather than the user, so before you use
them, consider whether second person or imperative mood is more
"user-friendly." However, use "we recommend" rather than "it is recommended"
or "OpenStack recommends".

Also, you can use "we" in the place of OpenStack if necessary.

Do not use first person to avoid naming the product or to avoid using passive
voice. If the product is performing the action, use third person (the product
as an actor). If you want to de-emphasize the agent of action and emphasize the
object on which the action is performed, use passive voice.

The first-person singular pronoun "I" is acceptable in the question part of
FAQs and when authors of blogs or signed articles are describing their own
actions or opinions.

Do not switch person (point of view) in the same document.

**Example of usage**

+--------------------------------+-----------------------------------+
| **Do not use**                 | **Use**                           |
+================================+===================================+
| Creating a server involves     | To create a server, specify a     |
| specifying a name, flavor,     | name, a flavor, and image.        |
| and image.                     |                                   |
|                                |                                   |
| To create a server, the user   | To create a server, you specify a |
| specifies a name, flavor, and  | name, flavor, and image.          |
| image.                         |                                   |
+--------------------------------+-----------------------------------+

Use appropriate mood
--------------------

For procedures, use imperative mood.

**Example:**

Start the installation by pressing **Enter**.

For explanations, use indicative mood.

**Example:**

The script automatically provisions virtual machines with all required
settings.

Do not use subjunctive mood.

**Example of usage**

+-------------------------------------+------------------------------------+
| **Do not use**                      | **Use**                            |
+=====================================+====================================+
| If you were to deploy OpenStack...  | If you want to deploy OpenStack... |
| (Implied: but you are not)          |                                    |
+-------------------------------------+------------------------------------+

Keep sentences short
--------------------

Short and simple sentences are easier to read and understand.

Avoid ambiguous titles
----------------------

Each title should include a clear description of the page’s subject.

+-------------------------+------------------------+
| **Ambiguous**           | **Better**             |
+=========================+========================+
| Update metadata         | Update flavor metadata |
+-------------------------+------------------------+

Also, ensure that you follow the documentation guidelines for titles.
For more information, see `Titles
<https://docs.openstack.org/contributor-guide/rst-conv/titles.html>`_.

.. _be_clear_and_concise:

Be clear and concise
--------------------

Follow the principles of minimalism. If you can describe
an idea in one word, do not use two words.
Eliminate all redundant modifiers, such as adjectives and adverbs.

.. _write_objectively:

Write objectively
-----------------

Do not use humor, jargon, exclamation marks, idioms, metaphors, and
other colloquialisms.

Describe the most common use case first
---------------------------------------

Put the most common case in the main clause and at the beginning of a
paragraph or section. You can introduce additional
use cases by starting a sentence with "however" or "if".

Do not humanize inanimate objects
---------------------------------

Do not give human characteristics to non-human subjects or objects.

**Example of usage**

+-----------------------+---------------------+
| **Do not use**        | **Use**             |
+=======================+=====================+
| This guide assumes    | This guide describes|
+-----------------------+---------------------+

Write positively
----------------

Write in a positive tone. Positive sentences improve readability.
Try to avoid the following words as much as possible:

**Example of usage**

+------------------------+------------------------------------+
| **Do not use**         | **Use**                            |
+========================+====================================+
| damage                 | affect                             |
+------------------------+------------------------------------+
| catastrophic           | serious                            |
+------------------------+------------------------------------+
| bad                    | Use "serious" or add an explanation|
+------------------------+------------------------------------+
| fail                   | unable to                          |
+------------------------+------------------------------------+
| kill                   | cancel                             |
+------------------------+------------------------------------+
| fatal                  | serious                            |
+------------------------+------------------------------------+
| destroy                | remove                             |
+------------------------+------------------------------------+
| wrong                  | incorrect, inconsistent            |
+------------------------+------------------------------------+

Avoid prepositions at the end of sentences
------------------------------------------

As much as possible, avoid trailing prepositions in sentences by
avoiding phrasal verbs.

**Example of usage**

+------------------------+--------------------------+
| **Ambiguous**          | **Better**               |
+========================+==========================+
| The image registration | The image registration   |
| window will open up.   | window opens.            |
+------------------------+--------------------------+

To fix the verb-preposition constructions, replace them with active
verbs.

**Example of usage**

+-------------------------+------------------------+
| **Ambiguous**           | **Better**             |
+=========================+========================+
| written up              | composed               |
+-------------------------+------------------------+
| pop up                  | appear                 |
+-------------------------+------------------------+

Do no overuse this, that, these, and it
---------------------------------------

Use these pronouns sparingly. Overuse contributes to readers'
confusion. To fix the ambiguity, rephrase the sentence.

**Example of usage**

+-------------------------+-------------------------------+
| **Ambiguous**           | **Better**                    |
+=========================+===============================+
| The monitoring system   | The monitoring system performs|
| should perform regular  | regular checks to ensure the  |
| checks to verify that   | Ceph cluster is functioning   |
| the Ceph cluster is     | correctly. Use the            |
| healthy. This can be    | ``ceph health`` command to run|
| achieved using the      | a health check.               |
| Ceph health command.    |                               |
+-------------------------+-------------------------------+


You can also fix the ambiguity by placing a noun modifier immediately
after the pronoun.

Do not split infinitives
------------------------

Do not place modifiers between "to" and the verb. Typically, placing
an adverb or an adjective between "to" and a verb adds ambiguity to
a sentence.

However, in some cases it is acceptable.

**Example:**

To significantly improve...

Avoid personification
---------------------

Do not express your fears or feelings in technical writing. Avoid
the adverbs such as "probably", "hopefully", "basically", and so on.

.. _do_not_use_contractions:

Do not use contractions
-----------------------

Generally, do not contract the words.

**Example of usage**

+------------------------+--------------------+
| **Do not use**         | **Use**            |
+========================+====================+
| can't                  | cannot             |
+------------------------+--------------------+
| don't                  | do not             |
+------------------------+--------------------+

.. _eliminate_needless_politeness:

Eliminate needless politeness
-----------------------------

Do not use "please" and "thank you" in technical documentation.

.. _use_consistent_terminology:

Use consistent terminology
--------------------------

Use consistent terms across OpenStack content. Avoid multiple
variations or spellings to refer to the same service, function,
UI element, and so on.

**Example of usage**

+------------------------+----------------------------------+
| **Do not use**         | **Use**                          |
+========================+==================================+
| Firewall as a service  | Firewall-as-a-Service            |
+------------------------+----------------------------------+
| active-active          | active/active                    |
+------------------------+----------------------------------+
| module                 | service                          |
+------------------------+----------------------------------+

If you suspect the subject was previously described, search the
OpenStack documentation and look for a precedence.

Use spelling and grammar checking tools
---------------------------------------

Run text through spelling and grammar checking tools, if available.
Correcting mistakes, especially to larger sections of new content,
helps eliminate rework later.
