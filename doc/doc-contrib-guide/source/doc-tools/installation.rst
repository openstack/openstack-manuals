.. _doc-toolsd-installation:

=====================================
Install OpenStack documentation tools
=====================================

To install the documentation toolkit:

#. Verify that you have installed
   the `prerequisites <https://github.com/openstack/openstack-doc-tools/blob/master/README.rst>`_.

#. Install the ``openstack-doc-tools`` package:

   .. code-block:: console

      $ pip install openstack-doc-tools

   If you have ``virtualenvwrapper`` installed, run:

   .. code::

      $ mkvirtualenv openstack-doc-tools
      $ pip install openstack-doc-tools

#. To use ``openstack-doc-tools``, import the tools to a project:

   .. code-block:: console

      import os_doc_tools
