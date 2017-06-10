=======================================
Governance tag documentation guidelines
=======================================

The ``docs:follows-policy`` tag indicates that the OpenStack Documentation team
and the project team associated with the tagged deliverable verify that the
project's documentation in the `openstack-manuals
<https://review.openstack.org/#/admin/projects/openstack/openstack-manuals>`_
repository is accurate and current.

Definition
~~~~~~~~~~

This tag indicates that a deliverable’s documentation set is prepared
in coordination with the OpenStack Documentation team following their
defined practices and policies for review and verification. It does not
indicate that the documentation team has taken ownership of producing the
documentation for the deliverable.

To maintain the ``docs:follows-policy`` tag, the documentation
cross-project liaison (CPL) or project technical lead (PTL) must have read
the documentation relevant to their project and opened any
appropriate `bug reports <https://bugs.launchpad.net/openstack-manuals>`_,
providing information to the docs team on how to document these issues.

For details, see `docs:follows-policy
<https://governance.openstack.org/tc/reference/tags/docs_follows-policy.html>`_.

Guidelines
~~~~~~~~~~

The documentation review deadline coincides with feature freeze. See the
`OpenStack release schedule <https://releases.openstack.org/>`_.

**6 weeks before release**

The liaison has made the docs team aware of all major new features and bug
fixes up till this point.

The project team either:

* provides sufficient information to the documentation team in a `bug
  report <https://bugs.launchpad.net/openstack-manuals>`_ to ensure the
  bug or enhancement is documented appropriately

*or*

* provides a fix to the `openstack-manuals
  <https://review.openstack.org/#/admin/projects/openstack/openstack-manuals>`_
  repo. If patch is submitted, this action would require an additional +1 by
  the relevant project team for such issues before approval.

**4 weeks before release**

The project team ensures that the liaison has reviewed the documentation for
the team project and either:

* provides sufficient information to the documentation team in a `bug report
  <https://bugs.launchpad.net/openstack-manuals>`_ to ensure the bug or
  enhancement is documented appropriately

*or*

* provides a fix to the `openstack-manuals
  <https://review.openstack.org/#/admin/projects/openstack/openstack-manuals>`_
  repo. If patch is submitted, this action would require an additional +1 by
  the relevant project team for such issues before approval.

**2 weeks before release**

The CPL works alongside the documentation release team to test installation
instructions and complete the release testing matrix (for example, see the
`Ocata release testing matrix
<https://wiki.openstack.org/wiki/Documentation/OcataDocTesting>`_). It is
recommended that the liaison tests the instructions for at least one
distribution.
