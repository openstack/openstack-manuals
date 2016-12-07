==============================
Provide user data to instances
==============================

A user data file is a special key in the metadata service that holds a
file that cloud-aware applications in the guest instance can access. For
example, one application that uses :term:`user data` is the
`cloud-init <https://help.ubuntu.com/community/CloudInit>`__ system,
which is an open-source package from Ubuntu that is available on various
Linux distributions and which handles early initialization of a cloud
instance.

You can place user data in a local file and pass it through the
``--user-data <user-data-file>`` parameter at instance creation.

.. code-block:: console

   $ openstack server create --image ubuntu-cloudimage --flavor 1 \
     --user-data mydata.file VM_INSTANCE
