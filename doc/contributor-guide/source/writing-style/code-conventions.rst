.. _code_conventions:

Code conventions
~~~~~~~~~~~~~~~~

Follow these guidelines:

* **Do not use "-y" for package install**

  When you describe package installation, do not use the ``-y`` option.
  Instead, use ``apt-get install package``, ``yum install package``, or
  ``zypper install package``.

* **Use "--option ARGUMENT"**

  The OpenStack CLI commands such as ``keystone`` support both
  ``--option ARGUMENT`` and ``--option=ARGUMENT``. In technical publications,
  use ``--option ARGUMENT``.

.. note::

   Nova exposes both its own API and an EC2-compatible API. Therefore, you can
   complete many tasks by using either the nova CLI or ``euca2ools``.

When documenting ``euca2ools``, limit the content to the following topics:

* Tasks required to get credentials to work with ``euca2ools``
* Explain the difference in operation between the Amazon EC2 and
  OpenStack endpoints when you access them through EC2.
