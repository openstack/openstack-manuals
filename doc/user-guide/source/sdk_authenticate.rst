.. _sdk_authenticate:

============
Authenticate
============

When using the SDK, you must authenticate against an OpenStack endpoint
before you can use OpenStack services. Because all projects use Keystone
for authentication, the process is the same no matter which service
or library you have decided to use. Each library also has more advanced
and complicated ways to do things, should those be needed.

There are two basic ways to deal with your cloud config and credentials:

- Environment variables via an openrc.sh file
- clouds.yaml config file

The environment variables have been around the longest and are the form
you are most likely to receive from your cloud provider. If you have one
and only one cloud account, they are the most convenient way.

``clouds.yaml`` is a bit newer and was designed to help folks who have
more than one OpenStack cloud that they are using.
