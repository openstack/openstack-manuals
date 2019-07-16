.. _openstack_API_quick_guide:

==============
OpenStack APIs
==============

To authenticate access to OpenStack services, you must first issue an
authentication request with a payload of credentials to OpenStack Identity to
get an authentication token.

Credentials are usually a combination of your user name and password,
and optionally, the name or ID of the project of your cloud.
Ask your cloud administrator for your user name, password, and project so
that you can generate authentication tokens. Alternatively, you can
supply a token rather than a user name and password.

When you send API requests, you include the token in the ``X-Auth-Token``
header. If you access multiple OpenStack services, you must get a token for
each service. A token is valid for a limited time before it expires. A token
can also become invalid for other reasons. For example, if the roles for a
user change, existing tokens for that user are no longer valid.

Authentication and API request workflow
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Request an authentication token from the Identity endpoint that your
   cloud administrator gave you. Send a payload of credentials in the
   request as shown in :ref:`authenticate`. If the request succeeds, the server
   returns an authentication token.

#. Send API requests and include the token in the ``X-Auth-Token``
   header. Continue to send API requests with that token until the service
   completes the request or the Unauthorized (401) error occurs.

#. If the Unauthorized (401) error occurs, request another token.

The examples in this section use cURL commands. For information about cURL,
see http://curl.haxx.se/. For information about the OpenStack APIs, see
:ref:`current_api_versions`.


.. _authenticate:

Authenticate
~~~~~~~~~~~~

The payload of credentials to authenticate contains these parameters:

+-----------------------+----------------+--------------------------------------+
| Parameter             | Type           | Description                          |
+=======================+================+======================================+
| *User Domain*         |     string     | The Domain of the user.              |
| (required)            |                |                                      |
+-----------------------+----------------+--------------------------------------+
| username (required)   |     string     | The user name. If you do not provide |
|                       |                | a user name and password, you must   |
|                       |                | provide a token.                     |
+-----------------------+----------------+--------------------------------------+
| password (required)   |     string     | The password for the user.           |
+-----------------------+----------------+--------------------------------------+
| *Project Domain*      |     string     | The Domain of the project. This is a |
| (optional)            |                | required part of the scope object.   |
+-----------------------+----------------+--------------------------------------+
| *Project Name*        |     string     | The project name. Both the           |
| (optional)            |                | *Project ID* and *Project Name*      |
|                       |                | are optional.                        |
+-----------------------+----------------+--------------------------------------+
| *Project ID*          |     string     | The project ID. Both the *project ID*|
| (optional)            |                | and *Project Name* are optional. But |
|                       |                | one of them is required along with   |
|                       |                | the *Project Domain*. They are       |
|                       |                | wrapped under a scope object.        |
|                       |                | If you do not know the project name  |
|                       |                | or ID, send a request without any    |
|                       |                | scope object.                        |
+-----------------------+----------------+--------------------------------------+


In a typical OpenStack deployment that runs Identity, you can specify your
project name, and user name and password credentials to authenticate.

First, export your project name to the ``OS_PROJECT_NAME`` environment variable,
your project domain name to the ``OS_PROJECT_DOMAIN_NAME`` environment variable,
your user name to the ``OS_USERNAME`` environment variable, your password to the
``OS_PASSWORD`` environment variable and your user domain name to the
``OS_USER_DOMAIN_NAME`` environment variable.

The example below uses an endpoint from an installation of Ocata by following
the installation guide. However, you can also use ``$OS_AUTH_URL`` as an
environment variable as needed to change the URL.

Then, run this cURL command to request a token:

.. code-block:: console

  $ curl -v -s -X POST $OS_AUTH_URL/auth/tokens?nocatalog   -H "Content-Type: application/json"   -d '{ "auth": { "identity": { "methods": ["password"],"password": {"user": {"domain": {"name": "'"$OS_USER_DOMAIN_NAME"'"},"name": "'"$OS_USERNAME"'", "password": "'"$OS_PASSWORD"'"} } }, "scope": { "project": { "domain": { "name": "'"$OS_PROJECT_DOMAIN_NAME"'" }, "name":  "'"$OS_PROJECT_NAME"'" } } }}' \
  | python -m json.tool

If the request succeeds, it returns the ``Created (201)`` response code
along with the token as a value in the ``X-Subject-Token`` response header.
The header is followed by a response body that has an object of type
``token`` which has the token expiration date and time in the form
``"expires_at":"datetime"`` along with other attributes.

The following example shows a successful response:

.. code-block:: console

    *   Trying 192.168.56.101...
    * Connected to controller (192.168.56.101) port 5000 (#0)
    > POST /v3/auth/tokens?nocatalog HTTP/1.1
    > Host: controller:5000
    > User-Agent: curl/7.47.0
    > Accept: */*
    > Content-Type: application/json
    > Content-Length: 226
    >
    } [226 bytes data]
    * upload completely sent off: 226 out of 226 bytes
    < HTTP/1.1 201 Created
    < Date: Fri, 26 May 2017 06:48:58 GMT
    < Server: Apache/2.4.18 (Ubuntu)
    < X-Subject-Token: gAAAAABZJ8_a7aiq1SnOhbNw8vFb5WZChcvWdzzUAFzhiB99BHrjdSGai--_-JstU3WazsFXmRHNbD07qOQKTp5Sen2R_b9csaDkU49VXqSaJ0jh2nAlwJkys8aazz2oa3xSeUVe3Ndv_HRiW23-iWTr6jquK_AXdhRX7nvM4lmVTrxXFpelnJQ
    < Vary: X-Auth-Token
    < X-Distribution: Ubuntu
    < x-openstack-request-id: req-0e9239ec-104b-40e0-a337-dca91fb24387
    < Content-Length: 521
    < Content-Type: application/json
    <
    { [521 bytes data]
    * Connection #0 to host controller left intact
    {
        "token": {
            "audit_ids": [
                "HOGlhnMFT52xY7PjbuJZlA"
            ],
            "expires_at": "2017-05-26T07:48:58.000000Z",
            "is_domain": false,
            "issued_at": "2017-05-26T06:48:58.000000Z",
            "methods": [
                "password"
            ],
            "project": {
                "domain": {
                    "id": "default",
                    "name": "Default"
                },
                "id": "05ef0bf2a79c42b2b8155873b6404061",
                "name": "demo"
            },
            "roles": [
                {
                    "id": "b18239b7026042ef8695c3c4cf10607b",
                    "name": "user"
                }
            ],
            "user": {
                "domain": {
                    "id": "default",
                    "name": "Default"
                },
                "id": "12846256e60c42f88d0e1ba9711a57f5",
                "name": "demo",
                "password_expires_at": null
            }
        }
    }


.. note::
   In the above request, the query string ``nocatalog`` is used as you
   just want to get a token and do not want the service catalog
   (if it is available for the user) cluttering the output.
   If a user wants to get the service catalog, this query string need
   not be appended to the URL.

Send API requests
~~~~~~~~~~~~~~~~~

This section shows how to make some basic Compute API calls. For a complete
list of Compute API calls, see
`Compute API <https://developer.openstack.org/api-ref/compute/>`__.

Export the token ID to the ``OS_TOKEN`` environment variable. For example:

.. code-block:: console

   export OS_TOKEN=gAAAAABZJ8_a7aiq1SnOhbNw8vFb5WZChcvWdzzUAFzhiB99BHrjdSGai--_-JstU3WazsFXmRHNbD07qOQKTp5Sen2R_b9csaDkU49VXqSaJ0jh2nAlwJkys8aazz2oa3xSeUVe3Ndv_HRiW23-iWTr6jquK_AXdhRX7nvM4lmVTrxXFpelnJQ

The token expires every hour by default,
though it can be configured differently - see
the `expiration <https://docs.openstack.org/keystone/latest/configuration/config-options.html#token.expiration>`__ option in the
the *Identity Service Configuration Guide*.

Export the project name to the ``OS_PROJECT_NAME`` environment variable. For example:

.. code-block:: console

   export OS_PROJECT_NAME=demo

Then, use the Compute API to list flavors, substituting the Compute API endpoint with
one containing your project ID below:

.. code-block:: console

   $ curl -s -H "X-Auth-Token: $OS_TOKEN" \
     $OS_COMPUTE_API/flavors \
     | python -m json.tool

.. code-block:: json

   {
       "flavors": [
           {
               "id": "1",
               "links": [
                   {
                       "href": "http://8.21.28.222:8774/v2/f9828a18c6484624b571e85728780ba8/flavors/1",
                       "rel": "self"
                   },
                   {
                       "href": "http://8.21.28.222:8774/f9828a18c6484624b571e85728780ba8/flavors/1",
                       "rel": "bookmark"
                   }
               ],
               "name": "m1.tiny"
           },
           {
               "id": "2",
               "links": [
                   {
                       "href": "http://8.21.28.222:8774/v2/f9828a18c6484624b571e85728780ba8/flavors/2",
                       "rel": "self"
                   },
                   {
                       "href": "http://8.21.28.222:8774/f9828a18c6484624b571e85728780ba8/flavors/2",
                       "rel": "bookmark"
                   }
               ],
               "name": "m1.small"
           },
           {
               "id": "3",
               "links": [
                   {
                       "href": "http://8.21.28.222:8774/v2/f9828a18c6484624b571e85728780ba8/flavors/3",
                       "rel": "self"
                   },
                   {
                       "href": "http://8.21.28.222:8774/f9828a18c6484624b571e85728780ba8/flavors/3",
                       "rel": "bookmark"
                   }
               ],
               "name": "m1.medium"
           },
           {
               "id": "4",
               "links": [
                   {
                       "href": "http://8.21.28.222:8774/v2/f9828a18c6484624b571e85728780ba8/flavors/4",
                       "rel": "self"
                   },
                   {
                       "href": "http://8.21.28.222:8774/f9828a18c6484624b571e85728780ba8/flavors/4",
                       "rel": "bookmark"
                   }
               ],
               "name": "m1.large"
           },
           {
               "id": "5",
               "links": [
                   {
                       "href": "http://8.21.28.222:8774/v2/f9828a18c6484624b571e85728780ba8/flavors/5",
                       "rel": "self"
                   },
                   {
                       "href": "http://8.21.28.222:8774/f9828a18c6484624b571e85728780ba8/flavors/5",
                       "rel": "bookmark"
                   }
               ],
               "name": "m1.xlarge"
           }
       ]
   }

Export the $OS_PROJECT_ID from the token call, and then
use the Compute API to list images:

.. code-block:: console

   $ curl -s -H "X-Auth-Token: $OS_TOKEN" \
     http://8.21.28.222:8774/v2/$OS_PROJECT_ID/images \
     | python -m json.tool

.. code-block:: json

   {
       "images": [
           {
               "id": "2dadcc7b-3690-4a1d-97ce-011c55426477",
               "links": [
                   {
                       "href": "http://8.21.28.222:8774/v2/f9828a18c6484624b571e85728780ba8/images/2dadcc7b-3690-4a1d-97ce-011c55426477",
                       "rel": "self"
                   },
                   {
                       "href": "http://8.21.28.222:8774/f9828a18c6484624b571e85728780ba8/images/2dadcc7b-3690-4a1d-97ce-011c55426477",
                       "rel": "bookmark"
                   },
                   {
                       "href": "http://8.21.28.222:9292/f9828a18c6484624b571e85728780ba8/images/2dadcc7b-3690-4a1d-97ce-011c55426477",
                       "type": "application/vnd.openstack.image",
                       "rel": "alternate"
                   }
               ],
               "name": "Fedora 21 x86_64"
           },
           {
               "id": "cfba3478-8645-4bc8-97e8-707b9f41b14e",
               "links": [
                   {
                       "href": "http://8.21.28.222:8774/v2/f9828a18c6484624b571e85728780ba8/images/cfba3478-8645-4bc8-97e8-707b9f41b14e",
                       "rel": "self"
                   },
                   {
                       "href": "http://8.21.28.222:8774/f9828a18c6484624b571e85728780ba8/images/cfba3478-8645-4bc8-97e8-707b9f41b14e",
                       "rel": "bookmark"
                   },
                   {
                       "href": "http://8.21.28.222:9292/f9828a18c6484624b571e85728780ba8/images/cfba3478-8645-4bc8-97e8-707b9f41b14e",
                       "type": "application/vnd.openstack.image",
                       "rel": "alternate"
                   }
               ],
               "name": "Ubuntu 14.04 amd64"
           },
           {
               "id": "2e4c08a9-0ecd-4541-8a45-838479a88552",
               "links": [
                   {
                       "href": "http://8.21.28.222:8774/v2/f9828a18c6484624b571e85728780ba8/images/2e4c08a9-0ecd-4541-8a45-838479a88552",
                       "rel": "self"
                   },
                   {
                       "href": "http://8.21.28.222:8774/f9828a18c6484624b571e85728780ba8/images/2e4c08a9-0ecd-4541-8a45-838479a88552",
                       "rel": "bookmark"
                   },
                   {
                       "href": "http://8.21.28.222:9292/f9828a18c6484624b571e85728780ba8/images/2e4c08a9-0ecd-4541-8a45-838479a88552",
                       "type": "application/vnd.openstack.image",
                       "rel": "alternate"
                   }
               ],
               "name": "CentOS 7 x86_64"
           },
           {
               "id": "c8dd9096-60c1-4e23-a486-82955481df9f",
               "links": [
                   {
                       "href": "http://8.21.28.222:8774/v2/f9828a18c6484624b571e85728780ba8/images/c8dd9096-60c1-4e23-a486-82955481df9f",
                       "rel": "self"
                   },
                   {
                       "href": "http://8.21.28.222:8774/f9828a18c6484624b571e85728780ba8/images/c8dd9096-60c1-4e23-a486-82955481df9f",
                       "rel": "bookmark"
                   },
                   {
                       "href": "http://8.21.28.222:9292/f9828a18c6484624b571e85728780ba8/images/c8dd9096-60c1-4e23-a486-82955481df9f",
                       "type": "application/vnd.openstack.image",
                       "rel": "alternate"
                   }
               ],
               "name": "CentOS 6.5 x86_64"
           },
           {
               "id": "f97b8d36-935e-4666-9c58-8a0afc6d3796",
               "links": [
                   {
                       "href": "http://8.21.28.222:8774/v2/f9828a18c6484624b571e85728780ba8/images/f97b8d36-935e-4666-9c58-8a0afc6d3796",
                       "rel": "self"
                   },
                   {
                       "href": "http://8.21.28.222:8774/f9828a18c6484624b571e85728780ba8/images/f97b8d36-935e-4666-9c58-8a0afc6d3796",
                       "rel": "bookmark"
                   },
                   {
                       "href": "http://8.21.28.222:9292/f9828a18c6484624b571e85728780ba8/images/f97b8d36-935e-4666-9c58-8a0afc6d3796",
                       "type": "application/vnd.openstack.image",
                       "rel": "alternate"
                   }
               ],
               "name": "Fedora 20 x86_64"
           }
       ]
   }

Export the $OS_PROJECT_ID from the token call, and then
use the Compute API to list servers:

.. code-block:: console

   $ curl -s -H "X-Auth-Token: $OS_TOKEN" \
     http://8.21.28.222:8774/v2/$OS_PROJECT_ID/servers \
     | python -m json.tool

.. code-block:: json

   {
       "servers": [
           {
               "id": "41551256-abd6-402c-835b-e87e559b2249",
               "links": [
                   {
                       "href": "http://8.21.28.222:8774/v2/f8828a18c6484624b571e85728780ba8/servers/41551256-abd6-402c-835b-e87e559b2249",
                       "rel": "self"
                   },
                   {
                       "href": "http://8.21.28.222:8774/f8828a18c6484624b571e85728780ba8/servers/41551256-abd6-402c-835b-e87e559b2249",
                       "rel": "bookmark"
                   }
               ],
               "name": "test-server"
           }
       ]
   }

.. _client-intro:

OpenStack command-line clients
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For scripting work and simple requests, you can use a command-line client like
the ``openstack-client`` client. This client enables you to use the Identity,
Compute, Block Storage, and Object Storage APIs through a command-line
interface. Also, each OpenStack project has a related client project that
includes Python API bindings and a command-line interface (CLI).

For information about the command-line clients, see `OpenStack
Command-Line Interface Reference <https://docs.openstack.org/cli-reference/>`__.

Install the clients
-------------------

Use ``pip`` to install the OpenStack clients on a Mac OS X or Linux system. It
is easy and ensures that you get the latest version of the client from the
`Python Package Index <https://pypi.org/>`__. Also, ``pip`` lets you
update or remove a package.

You must install the client for each project separately, but the
``python-openstackclient`` covers multiple projects.

Install or update a client package:

.. code-block:: console

   $ sudo pip install [--upgrade] python-PROJECTclient

Where *PROJECT* is the project name.

For example, install the ``openstack`` client:

.. code-block:: console

   $ sudo pip install python-openstackclient

To update the ``openstack`` client, run this command:

.. code-block:: console

   $ sudo pip install --upgrade python-openstackclient

To remove the ``openstack`` client, run this command:

.. code-block:: console

   $ sudo pip uninstall python-openstackclient

Before you can issue client commands, you must download and source the
``openrc`` file to set environment variables.

For complete information about the OpenStack clients, including how to source
the ``openrc`` file, see `OpenStack End User Guide <https://docs.openstack.org/user-guide/>`__,
`OpenStack Administrator Guide <https://docs.openstack.org/admin-guide/>`__,
and `OpenStack Command-Line Interface Reference <https://docs.openstack.org/cli-reference/>`__.

Launch an instance
------------------

To launch instances, you must choose a name, an image, and a flavor for
your instance.

To list available images, call the Compute API through the ``openstack``
client:

.. code-block:: console

   $ openstack image list

.. code-block:: console

   +--------------------------------------+------------------+
   | ID                                   | Name             |
   +--------------------------------------+------------------+
   | a5604931-af06-4512-8046-d43aabf272d3 | fedora-20.x86_64 |
   +--------------------------------------+------------------+

To list flavors, run this command:

.. code-block:: console

   $ openstack flavor list

.. code-block:: console

   +----+-----------+-----------+------+-----------+------+-------+-----------+
   | ID | Name      | Memory_MB | Disk | Ephemeral | Swap | VCPUs | Is_Public |
   +----+-----------+-----------+------+-----------+------+-------+-----------+
   | 1  | m1.tiny   | 512       | 0    | 0         |      | 1     | True      |
   | 2  | m1.small  | 2048      | 20   | 0         |      | 1     | True      |
   | 3  | m1.medium | 4096      | 40   | 0         |      | 2     | True      |
   | 4  | m1.large  | 8192      | 80   | 0         |      | 4     | True      |
   | 42 | m1.nano   | 64        | 0    | 0         |      | 1     | True      |
   | 5  | m1.xlarge | 16384     | 160  | 0         |      | 8     | True      |
   | 84 | m1.micro  | 128       | 0    | 0         |      | 1     | True      |
   +----+-----------+-----------+------+-----------+------+-------+-----------+

To launch an instance, note the IDs of your desired image and flavor.

To launch the ``my_instance`` instance, run the ``openstack server create``
command with the image and flavor IDs and the server name:

.. code-block:: console

   $ openstack server create --image a5604931-af06-4512-8046-d43aabf272d3 --flavor 1 my_instance

.. code-block:: console

   +--------------------------------------+---------------------------------------------------------+
   | Field                                | Value                                                   |
   +--------------------------------------+---------------------------------------------------------+
   | OS-DCF:diskConfig                    | MANUAL                                                  |
   | OS-EXT-AZ:availability_zone          | nova                                                    |
   | OS-EXT-STS:power_state               | 0                                                       |
   | OS-EXT-STS:task_state                | scheduling                                              |
   | OS-EXT-STS:vm_state                  | building                                                |
   | OS-SRV-USG:launched_at               | None                                                    |
   | OS-SRV-USG:terminated_at             | None                                                    |
   | accessIPv4                           |                                                         |
   | accessIPv6                           |                                                         |
   | addresses                            |                                                         |
   | adminPass                            | 3vgzpLzChoac                                            |
   | config_drive                         |                                                         |
   | created                              | 2015-08-27T03:02:27Z                                    |
   | flavor                               | m1.tiny (1)                                             |
   | hostId                               |                                                         |
   | id                                   | 1553694c-d711-4954-9b20-84b8cb4598c6                    |
   | image                                | fedora-20.x86_64 (a5604931-af06-4512-8046-d43aabf272d3) |
   | key_name                             | None                                                    |
   | name                                 | my_instance                                             |
   | os-extended-volumes:volumes_attached | []                                                      |
   | progress                             | 0                                                       |
   | project_id                           | 9f0e4aa4fd3d4b0ea3184c0fe7a32210                        |
   | properties                           |                                                         |
   | security_groups                      | [{u'name': u'default'}]                                 |
   | status                               | BUILD                                                   |
   | updated                              | 2015-08-27T03:02:28Z                                    |
   | user_id                              | b3ce0cfc170641e98ff5e42b1be9c85a                        |
   +--------------------------------------+---------------------------------------------------------+

.. note::
   For information about the default ports that the OpenStack components use,
   see `Firewalls and default ports <https://docs.openstack.org/install-guide/firewalls-default-ports.html>`_
   in the *OpenStack Installation Guide*.

