.. _shared_file_systems_services_manage.rst:

======================
Manage shares services
======================

The Shared File Systems service provides API that allows to manage running
share services (`Share services API
<https://developer.openstack.org/api-ref/shared-file-systems/>`_).
Using the :command:`manila service-list` command, it is possible to get a list
of all kinds of running services. To select only share services, you can pick
items that have field ``binary`` equal to ``manila-share``. Also, you can
enable or disable share services using raw API requests. Disabling means that
share services are excluded from the scheduler cycle and new shares will not
be placed on the disabled back end. However, shares from this service stay
available.
