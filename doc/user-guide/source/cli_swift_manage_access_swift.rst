=============
Manage access
=============

-  Users have roles on accounts. For example, a user with the admin role
   has full access to all containers and objects in an account. You can
   set access control lists (ACLs) at the container level and support
   lists for read and write access, which you set with the
   ``X-Container-Read`` and ``X-Container-Write`` headers.

   To give a user read access, use the :command:`swift post` command with the
   `-r` parameter. To give a user write access, use the
   `-w` parameter.

   The following example enables the ``testuser`` user to read objects
   in the container:

   .. code-block:: console

      $ swift post -r 'testuser'

   You can also use this command with a list of users.

-  If you use StaticWeb middleware to enable Object Storage to serve
   public web content, use ``.r:``, followed by a list of allowed
   referrers.

   The following command gives object access to all referring domains:

   .. code-block:: console

      $ swift post -r '.r:*'
