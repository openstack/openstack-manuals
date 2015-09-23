.. _shared_file_systems_services_manage.rst:

======================
Manage shares services
======================

The Shared File Systems service provides API allows to Cloud Administrator
manage running share services (`Share services API
<http://developer.openstack.org/api-ref-share-v2.html#share-services>`_).
It hasn't exposed in CLI client yet. Using raw API calls, it is possible
to get list of running services all kinds. To select only share services,
you can pick items only have field ``binary`` equals to ``manila-share``.
Aslo, you can enable and disable share services. Disabling means that share
service excludes from scheduler cycle  and new shares will not be placed on
disabled back end, but shares from this service stay available.
