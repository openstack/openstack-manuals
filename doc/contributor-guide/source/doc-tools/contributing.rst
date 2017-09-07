===========================================
Contribute to OpenStack documentation tools
===========================================

If you would like to contribute to OpenStack documentation tools, you are
welcome to submit a patch or file a bug against the toolkit.

Contribute to the tool development
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To contribute to the development of ``openstack-doc-tools``, proceed with
the following steps:

#. Complete the procedures described
   in the `Developers Guide <https://docs.openstack.org/infra/manual/developers.html>`_.

#. Follow  `OpenStack Style Commandments <https://docs.openstack.org/hacking/latest/>`_
   while developing improvements for the tool.

#. Run tests before you submit your change request.

   For now, the documentation toolkit is tested with basic ``flake8``
   and ``bashate`` tests. A test suite would be welcome.

#. Submit your change for review through the Gerrit tool as described
   in the `gerrit workflow <https://docs.openstack.org/infra/manual/developers.html#development-workflow>`_.

   .. warning::

      Pull requests submitted through GitHub will be ignored.

.. note::

   To be able to run ``"tox -e py27"`` successfully locally, add
   ``jinja2`` and ``markupsafe`` to your local ``test-requirements.txt``
   file to have them installed in your local virtual environment.


File a bug against the tools
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If you experience an issue while using the tools,
file a bug on Launchpad in the `openstack-doc-tools project
<https://bugs.launchpad.net/openstack-doc-tools>`_. Do not file issues on
GitHub.
