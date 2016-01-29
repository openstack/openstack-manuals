.. _uierrormessages:

==========================
Follow UI alert guidelines
==========================

Alerts, or messages, are important to inform users about progress
that they make or problems that they encounter in the user interface.

Use the following alert types:

* Success
* Info
* Warning
* Danger (Error)

General alert guidelines
~~~~~~~~~~~~~~~~~~~~~~~~

When writing alerts, follow these rules:

* Be courteous and do not blame the user
* Use present tense to describe conditions that currently exist, or
  use past tense to describe a specific event that occurred in the
  past
* Keep sentences short but helpful
* Adhere to the guidelines in the :ref:`stg_writing_style` section

Alert structure for new danger (error) conditions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A danger alert, or error message, should help the user resolve the
problem quickly so that they can continue making progress. Do not
include an error if you can avoid publishing the alert by enhancing
the code.

#. State the problem clearly and briefly.
#. If appropriate, explain why the user encountered the error.
#. If possible, tell the user how to fix the problem. If further
   information is needed, consider whether the documentation should
   be enhanced.

.. note::

   API returns might not be specific enough to adhere to these
   structure guidelines. Be as explicit as you can in stating the
   problem and resolution.

Alert examples
~~~~~~~~~~~~~~

Success
 * Successfully created key pair %(name)s.
 * Image successfully updated.

Info
 * Updating volume snapshot "%s"
 * Creating volume "%s"

Warning
 * Policy check failed.
 * Insufficient privilege level exists to view user information.

Danger
 * Unable to create the volume.
 * Unable to retrieve the image.
