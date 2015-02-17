HOT Reference
=============

This documentation is mostly generated from the heat source code, and files in
the ``generated/`` directory should not be edited manually. To make changes to
these files, modify the heat docstrings, then regenerate the files (see the
next section).


How to generate the content
===========================

* Clone the heat source code:

::

    git clone git://git.openstack.org/openstack/heat

* Run the ``tools/generate-hot-reference.sh`` script:

::

    pip install 'openstack-doc-tools>=0.18'
    tools/generate-hot-reference.sh path/to/heat/clone

* Check the build:

::

    mvn clean generate-sources
    # or
    tox
