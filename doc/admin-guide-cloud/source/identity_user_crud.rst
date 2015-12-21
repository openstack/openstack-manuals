=========
User CRUD
=========

Identity provides a user CRUD (Create, Read, Update, and Delete) filter that
can be added to the ``public_api`` pipeline. The user CRUD filter enables users
to use a HTTP PATCH to change their own password. To enable this extension you
should define a ``user_crud_extension`` filter, insert it after the ``*_body``
middleware and before the ``public_service`` application in the ``public_api``
WSGI pipeline in ``keystone-paste.ini``. For example:

.. code-block:: ini

   [filter:user_crud_extension]
   paste.filter_factory = keystone.contrib.user_crud:CrudExtension.factory

   [pipeline:public_api]
   pipeline = sizelimit url_normalize request_id build_auth_context token_auth admin_token_auth json_body ec2_extension user_crud_extension public_service

Each user can then change their own password with a HTTP PATCH.

.. code-block:: console

   $ curl -X PATCH http://localhost:5000/v2.0/OS-KSCRUD/users/USERID -H "Content-type: application/json"  \
     -H "X_Auth_Token: AUTHTOKENID" -d '{"user": {"password": "ABCD", "original_password": "DCBA"}}'

In addition to changing their password, all current tokens for the user
are invalidated.

.. note::

    Only use a KVS back end for tokens when testing.
