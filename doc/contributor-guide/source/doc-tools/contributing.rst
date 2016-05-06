============
Contributing
============

If you would like to contribute to the development of the
``openstack-doc-tools``, follow the steps in the `Developers Guide
<http://docs.openstack.org/infra/manual/developers.html>`_.

Once those steps have been completed, changes to OpenStack
should be submitted for review via the Gerrit tool, following
the `gerrit workflow
<http://docs.openstack.org/infra/manual/developers.html#development-workflow>`_

Pull requests submitted through GitHub will be ignored.

Bugs should be filed on `Launchpad
<https://bugs.launchpad.net/openstack-manuals>`_, not GitHub.

.. note::

   To be able to run ``"tox -e py27"`` successfully locally, add
   ``jinja2`` and ``markupsafe`` to your local ``test-requirements.txt``
   file so the two get installed in your local virtual environment.


Style commandments
~~~~~~~~~~~~~~~~~~

Read the `OpenStack Style Commandments
<http://docs.openstack.org/developer/hacking/>`_.


Running tests
~~~~~~~~~~~~~

So far these tools are tested with only basic flake8 and bashate tests. A test
suite would be welcome!

Since the ``openstack-doc-test`` tool is used for gating of the OpenStack
documentation repositories, test building of these repositories with
any changes done here.

Testing can be done with simply a local install of
``openstack-doc-tools``, then checking out the gated repositories and
running: ``tox`` inside of each.

The repositories gated by ``openstack-doc-tools`` are:

* api-site
* openstack-manuals
