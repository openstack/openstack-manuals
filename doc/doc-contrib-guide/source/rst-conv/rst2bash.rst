=============
Parser syntax
=============

Installation guide is parsed directly into Bash code which will be using
training labs to deploy OpenStack cluster. This should allow us to have
higher agility for developing installation guides and to automatically
test changes to the guides.

There are many factors that could lead to execution errors on the install
guides, but one of the main potential sources of errors relies on the
limitations of the human eye. The problem becomes specially important
with the addition of project-specific installation guides.

Additionally, the parser is also enabled with linting capabilities which
should provide some sort of syntax niceness and validate if the document
is having the correct syntax for the scope of the parser to successfully
parse RST to Bash.

To help the parser to validate the document, consider the following
syntax format.

* The ``code-block`` tags should be closed with ``end``.

  .. code-block:: rst

      .. code-block:: console

          $ echo "Hello, World!"

* The ``code-block`` tags which rely on path should have ``path``
  tag one line above without a line break as shown below. May it
  be some code which has to be run from a specific folder or a
  configuration file, the parser should know about the path.

  * Example 1: Run a specific command from a given folder.

    .. code-block:: rst

      .. path /usr/local/
      .. code-block:: console

        $ echo "Run a command from a specific folder"
        $ chmod -R +rx bin

  * Example 2: Configure a configuration file.

    .. code-block:: rst

      .. path /etc/keystone/keystone.conf
      .. code-block:: ini

        [DEFAULT]
        ...
        debug = True

* The ``only`` tags should be closed with ``endonly``.

  .. code-block:: rst

    .. only:: ubuntu or debian

        All related content.

    .. endonly
