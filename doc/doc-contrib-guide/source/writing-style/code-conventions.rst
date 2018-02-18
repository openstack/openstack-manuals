.. _code_conventions:

Code conventions
~~~~~~~~~~~~~~~~

Follow these guidelines:

* **Do not use "-y" for package install**

  When you describe package installation, do not use the ``-y`` option.
  Instead, use ``apt-get install package``, ``yum install package``, or
  ``zypper install package``.

* **Use "--option ARGUMENT"**

  The OpenStack CLI supports both ``--option ARGUMENT`` and
  ``--option=ARGUMENT``. In technical publications, use ``--option ARGUMENT``.

* **Use "." to source script files**

  When you have to source a script file, for example, a credentials file to
  gain access to user-only or admin-only CLI commands, use ``.`` instead of
  ``source``.

* **Use capital letters with underscores for parameters**

  When you write parameters in an example command,
  use capital letters for the parameters, with underscore as a delimiter.
  For example:

  .. code-block:: console

     $ openstack user create --project PROJECT_A --password PASSWORD USERNAME

  If necessary, describe the parameters immediately after the example
  command block. For example, for the ``PASSWORD`` parameter:

  .. code-block:: none

     Replace ``PASSWORD`` with a suitable password.

.. note::

   Nova exposes both its own API and an EC2-compatible API. Therefore, you can
   complete many tasks by using either the nova CLI or ``euca2ools``.

When documenting ``euca2ools``, limit the content to the following topics:

* Tasks required to get credentials to work with ``euca2ools``
* Explain the difference in operation between the Amazon EC2 and
  OpenStack endpoints when you access them through EC2.
