.. This file is manually generated, unlike many of the other chapters.

=============================================================================
Software Development Lifecycle Automation service (solum) command-line client
=============================================================================

The solum client is the command-line interface (CLI) for
the Software Development Lifecycle Automation service (solum) API and its
extensions.

This chapter documents :command:`solum` version ``2.3.0``.

.. _solum_command_usage:

solum usage
~~~~~~~~~~~

``solum help``
  Show this help message.

``solum info``
  Show Solum endpoint and API release version.

``solum --version``
  Show current Solum client version and exit.

``solum lp help``
  Show a help message specific to languagepack commands.

``solum lp create <NAME> <GIT_REPO_URL>``
  Create a new language pack from a git repo.

``solum lp list``
  Print and index of all available language packs.

``solum lp show <NAME|UUID>``
  Print the details of a language pack.

``solum lp delete <NAME|UUID>``
  Destroy a language pack.

``solum lp logs <NAME|UUID>``
  Show logs for a language pack.

``solum app help``
  Show a help message specific to app commands.

``solum app list``
  Print an index of all deployed applications.

``solum app show <NAME|UUID>``
  Print detailed information about one application.

``solum app create``
  Register a new application with Solum.

  .. code-block:: console

     solum app create [--app-file <AppFile>] [--git-url <GIT_URL>]
                      [--lp <LANGUAGEPACK>]
                      [--param-file <PARAMFILE>]
                      [--setup-trigger]
                      [--trigger-workflow <CUSTOM-WORKFLOW>]
                      <CUSTOM-WORKFLOW>=(unittest | build | unittest+build)

  Without the ``--trigger-workflow`` flag, the workflow ``unittest+build+deploy``
  is triggered (this is the default workflow).

``solum app deploy <NAME|UUID>``
  Deploy an application, building any applicable artifacts first.
  du-id is optional flag. It can be used to pass in ID of a previously
  created deployment unit. If passed, this command will deploy the du
  referenced by the provided ``du-id`` instead of building one first.

``solum app delete <NAME|UUID>``
  Delete an application and all related artifacts.

``solum app logs <NAME|UUID> [--wf-id <wf-id>]``
  Show the logs of an application for all the workflows.
  ``wf-id`` is optional flag which can be used to pass in ID of one of
  the existing workflows. If provided, the logs only for that workflow
  are displayed.

``solum app scale <APP_NAME|UUID> <target>``

``solum workflow list <APP_NAME|UUID>``
  List all application workflows.

``solum workflow show <APP_NAME|UUID> <WORKFLOW_ID|UUID>``
  Print the details of a workflow.

``solum workflow logs <APP_NAME|UUID> <WORKFLOW_ID|UUID>``
  List all the logs of a given workflow.

**SOON TO BE DEPRECATED:**

``solum oldapp create``
  Register a new application with Solum.

  .. code-block:: console

     solum oldapp create [--plan-file <PLANFILE>] [--git-url <GIT_URL>]
                         [--lp <LANGUAGEPACK>] [--run-cmd <RUN_CMD>]
                         [--unittest-cmd <UNITTEST_CMD>]
                         [--name <NAME>] [--port <PORT>]
                         [--param-file <PARAMFILE>]
                         [--desc <DESCRIPTION>]
                         [--setup-trigger]
                         [--private-repo]
                         [--trigger-workflow <WORKFLOW>]
