========================================
Configure Object Storage with the S3 API
========================================

The Swift3 middleware emulates the S3 REST API on top of Object Storage.

The following operations are currently supported:

- GET Service

- DELETE Bucket

- GET Bucket (List Objects)

- PUT Bucket

- DELETE Object

- GET Object

- HEAD Object

- PUT Object

- PUT Object (Copy)

To use this middleware, first download the latest version from its repository
to your proxy servers.

.. code-block:: console

    $ git clone https://git.openstack.org/openstack/swift3

Then, install it using standard python mechanisms, such as:

.. code-block:: console

    # python setup.py install

Alternatively, if you have configured the Ubuntu Cloud Archive, you may use:

.. code-block:: console

    # apt-get install swift-plugin-s3

To add this middleware to your configuration, add the swift3 middleware in
front of the swauth middleware, and before any other middleware that looks at
Object Storage requests (like rate limiting).

Ensure that your ``proxy-server.conf`` file contains swift3 in the pipeline and
the ``[filter:swift3]`` section, as shown below:

.. code-block:: ini

    [pipeline:main]
    pipeline = catch_errors healthcheck cache swift3 swauth proxy-server

    [filter:swift3]
    use = egg:swift3#swift3

Next, configure the tool that you use to connect to the S3 API. For S3curl, for
example, you must add your host IP information by adding your host IP to the
``@endpoints`` array (line 33 in ``s3curl.pl``):

.. code-block:: perl

    my @endpoints = ( '1.2.3.4');

Now you can send commands to the endpoint, such as:

.. code-block:: console

    $ ./s3curl.pl - 'a7811544507ebaf6c9a7a8804f47ea1c' \
      -key 'a7d8e981-e296-d2ba-cb3b-db7dd23159bd' \
      -get - -s -v http://1.2.3.4:8080

To set up your client, ensure you are using the ec2 credentials, which
can be downloaded from the API Endpoints tab of the dashboard. The host
should also point to the Object Storage node's hostname. It also will
have to use the old-style calling format, and not the hostname-based
container format. Here are two examples of client setup using both Python
boto_ library (version 2.45.0) and boto3_(version 1.4.4) library on a locally
installed all-in-one Object Storage installation.

.. code-block:: python

    # Connection using boto library
    connection = boto.s3.connection.S3Connection(
        aws_access_key_id='a7811544507ebaf6c9a7a8804f47ea1c',
        aws_secret_access_key='a7d8e981-e296-d2ba-cb3b-db7dd23159bd',
        port=8080,
        host='127.0.0.1',
        is_secure=False)

    # Connection using boto3 library

    # Create a low-level service client
    s3_client = boto3.client(
        's3',
        aws_access_key_id='a7811544507ebaf6c9a7a8804f47ea1c',
        aws_secret_access_key='a7d8e981-e296-d2ba-cb3b-db7dd23159bd',
        endpoint_url='http://127.0.0.1:8080'
    )

    #  Create a resource service client
    s3_resource = boto3.resource(
        's3',
        aws_access_key_id='a7811544507ebaf6c9a7a8804f47ea1c',
        aws_secret_access_key='a7d8e981-e296-d2ba-cb3b-db7dd23159bd',
        endpoint_url='http://127.0.0.1:8080'
    )

.. _boto: https://github.com/boto/boto

.. _boto3: https://github.com/boto/boto3/
