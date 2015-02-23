============
Authenticate
============

When using the SDK, you must authenticate against an OpenStack endpoint
before you can use OpenStack services. Each project uses a slightly
different syntax for authentication.

You must typically authenticate against a specific version of a service.
For example, a client might need to authenticate against Identity v2.0.

Python scripts that use the OpenStack SDK must have access to the
credentials contained in the OpenStack RC file. Because credentials are
sensitive information, do not include them in your scripts. This guide
assumes that users source the PROJECT-openrc.sh file and access the
credentials by using the environment variables in the Python scripts.

