=========
DocImpact
=========

When adding code that affects documentation (for example, to add a new
parameter), the developer adds a DocImpact flag.

Using the DocImpact flag in a commit message
--------------------------------------------

In any OpenStack project, you can add a ``DocImpact`` flag in a commit message
to help identify any bugs that require documentation to be written
in the OpenStack manuals project.

This method offers notification and tracking of the possible impact to
documentation due to the patch. If your commit has an impact on
documentation, for example an added, altered, or removed command line option,
a deprecated or new feature, a caveat or if you have written docs in the patch,
add "DocImpact" to a line in your commit message.

This creates a Launchpad bug for the project indicated in the
``gerrit/projects.yaml`` file in the ``openstack/project-config`` repository.
This does not guarantee documentation will be written, but offers visibility of
the change and tracking. You can also use it as a reminder to yourself to write
docs for the feature later, or remind yourself to find a writer to write for
you.

If you are a doc contributor, these are the steps we take once a DocImpact
notification comes to the list.

#. Create a new doc bug in either ``openstack-manuals`` or
   ``openstack-api-site``.
   In the bug:

   #. In the title, put ``newton`` or ``ocata`` depending on the release the
      patch affects.
   #. Copy and paste the `<review.openstack.org>`_ link in the bug description.
   #. Describe the documentation that is affected if the code patch lands in
      the bug description.
   #. Keep the doc bug set to ``New`` until the code patch is merged.

#. Continue to check on the patch and change the status to ``Confirmed`` once
   merged.

#. Use the information in the Doc bug triaging :ref:`guidelines` section to set
   priority once it lands.

Writing good commit messages for DocImpact
------------------------------------------

Because the entire commit message is included in the logged bug, try to put
as much information as you can into the commit message about which doc audience
is affected by the change or enhancement, what the change is and why it
matters.
Answer the following questions when writing the commit message:

* Who would use the feature?

* Why use the feature?

* What is the exact usage for the feature? If it's an API change,
  give example requests and responses.

* Does the feature also have permissions/policies attached? If so, what are
  the requirements?

If it is a configuration option change, our automation will pick it up.
However, we do request for individually filed bugs outside of the automated
generation.

If it is a CLI change, we also have automation that picks up the help text,
but extra usage information is useful.

Third-Party DocImpact settings
------------------------------

By default, the DocImpact tag creates bugs using the repository name as project
in Launchpad. To change this behaviour, the ``docimpact-group`` option in
``projects.yaml`` can be used. For example, if you set project like this:

.. code-block: yaml

   - project: stackforge/project-name
     description: Latest and greatest cloud stuff.
     upstream: git://github.com/awesumsauce/project-name.git
     docimpact-group: Project
