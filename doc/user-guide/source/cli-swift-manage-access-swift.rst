=============
Manage access
=============

-  Users have roles on accounts. For example, a user with the admin role
   has full access to all containers and objects in an account. You can
   set access control lists (ACLs) at the container level and support
   lists for read and write access, which you set with the
   ``X-Container-Read`` and ``X-Container-Write`` headers.

   To give a user read access, use the :command:`swift post` command with the
   ``-r`` parameter. To give a user write access, use the
   ``-w`` parameter.

-  The following are examples of `read` ACLs for containers:

   A request with any HTTP referer header can read container contents:

   .. code-block:: console

      $ swift post CONTAINER -r ".r:*"

   A request with any HTTP referer header can read and list container
   contents:

   .. code-block:: console

      $ swift post CONTAINER -r ".r:*,.rlistings"

   A list of specific HTTP referer headers permitted to read container
   contents:

   .. code-block:: console

      $ swift post CONTAINER -r \
        ".r:openstack.example.com,.r:swift.example.com,.r:storage.example.com"

   A list of specific HTTP referer headers denied read access:

   .. code-block:: console

      $ swift post CONTAINER -r \
        ".r:*,.r:-openstack.example.com,.r:-swift.example.com,.r:-storage.example.com"

   All users residing in project1 can read container contents:

   .. code-block:: console

      $ swift post CONTAINER -r "project1:*"

   User1 from project1 can read container contents:

   .. code-block:: console

      $ swift post CONTAINER -r "project1:user1"

   A list of specific users and projects permitted to read container contents:

   .. code-block:: console

      $ swift post CONTAINER -r \
        "project1:user1,project1:user2,project3:*,project4:user1"

-  The following are examples of `write` ACLs for containers:

   All users residing in project1 can write to the container:

   .. code-block:: console

      $ swift post CONTAINER -w "project1:*"

   User1 from project1 can write to the container:

   .. code-block:: console

      $ swift post CONTAINER -w "project1:user1"

   A list of specific users and projects permitted to write to the container:

   .. code-block:: console

      $ swift post CONTAINER -w \
        "project1:user1,project1:user2,project3:*,project4:user1"

.. note::

   To successfully write to a container, a user must have read privileges
   (in addition to write) on the container. For all aforementioned
   read/write ACL examples, one can replace the project/user name with
   project/user UUID, i.e. ``<project_uuid>:<user_uuid>``. If using multiple
   keystone domains, UUID format is required.
