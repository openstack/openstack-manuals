=========================
Identity service overview
=========================

The OpenStack :term:`Identity service` provides a single point of
integration for managing authentication, authorization, and service catalog
services. Other OpenStack services use the Identity service as a common
unified API. Additionally, services that provide information about users
but that are not included in OpenStack (such as LDAP services) can be
integrated into a pre-existing infrastructure.

In order to benefit from the Identity service, other OpenStack services need to
collaborate with it. When an OpenStack service receives a request from a user,
it checks with the Identity service whether the user is authorized to make the
request.

The Identity service contains these components:

Server
    A centralized server provides authentication and authorization
    services using a RESTful interface.

Drivers
    Drivers or a service back end are integrated to the centralized
    server. They are used for accessing identity information in
    repositories external to OpenStack, and may already exist in
    the infrastructure where OpenStack is deployed (for example, SQL
    databases or LDAP servers).

Modules
    Middleware modules run in the address space of the OpenStack
    component that is using the Identity service. These modules
    intercept service requests, extract user credentials, and send them
    to the centralized server for authorization. The integration between
    the middleware modules and OpenStack components uses the Python Web
    Server Gateway Interface.

When installing OpenStack Identity service, you must register each
service in your OpenStack installation. Identity service can then track
which OpenStack services are installed, and where they are located on
the network.
