================
Verify operation
================

This section describes how to verify operation of the Orchestration
module (heat).

#. Source the ``admin`` tenant credentials:

   .. code-block:: console

      $ source admin-openrc.sh

#. The Orchestration module uses templates to describe stacks.
   To learn about the template language, see `the Template Guide
   <http://docs.openstack.org/developer/heat/template_guide/index.html>`__
   in the `Heat developer documentation
   <http://docs.openstack.org/developer/heat/index.html>`__.

   Create a test template in the ``test-stack.yml``
   file with the following content:

   .. code-block:: yaml

      heat_template_version: 2014-10-16
      description: A simple server.

      parameters:
        ImageID:
          type: string
          description: Image use to boot a server
        NetID:
          type: string
          description: Network ID for the server

      resources:
        server:
          type: OS::Nova::Server
          properties:
            image: { get_param: ImageID }
            flavor: m1.tiny
            networks:
            - network: { get_param: NetID }

      outputs:
        private_ip:
          description: IP address of the server in the private network
          value: { get_attr: [ server, first_address ] }</programlisting>

#. Use the :command:`heat stack-create` command to create a stack from the
   template:

   .. code-block:: console

      $ NET_ID=$(nova net-list | awk '/ demo-net / { print $2 }')
      $ heat stack-create -f test-stack.yml \
        -P "ImageID=cirros;NetID=$NET_ID" testStack
      +--------------------------------------+------------+--------------------+----------------------+
      | id                                   | stack_name | stack_status       | creation_time        |
      +--------------------------------------+------------+--------------------+----------------------+
      | 477d96b4-d547-4069-938d-32ee990834af | testStack  | CREATE_IN_PROGRESS | 2014-04-06T15:11:01Z |
      +--------------------------------------+------------+--------------------+----------------------+

#. Use the :command:`heat stack-list` command to verify
   successful creation of the stack:

   .. code-block:: console

      $ heat stack-list
      +--------------------------------------+------------+-----------------+----------------------+
      | id                                   | stack_name | stack_status    | creation_time        |
      +--------------------------------------+------------+-----------------+----------------------+
      | 477d96b4-d547-4069-938d-32ee990834af | testStack  | CREATE_COMPLETE | 2014-04-06T15:11:01Z |
      +--------------------------------------+------------+-----------------+----------------------+
