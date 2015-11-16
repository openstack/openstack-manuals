.. _launch-instance-heat:

Orchestration
~~~~~~~~~~~~~

Create a template
-----------------

The Orchestration service uses templates to describe stacks.
To learn about the template language, see `the Template Guide
<http://docs.openstack.org/developer/heat/template_guide/index.html>`__
in the `Heat developer documentation
<http://docs.openstack.org/developer/heat/index.html>`__.

* Create the ``demo-template.yml`` file with the following content:

  .. code-block:: yaml

     heat_template_version: 2015-10-15
     description: Launch a basic instance using the ``m1.tiny`` flavor and one network.

     parameters:
       ImageID:
         type: string
         description: Image to use for the instance.
       NetID:
         type: string
         description: Network ID to use for the instance.

     resources:
       server:
         type: OS::Nova::Server
         properties:
           image: { get_param: ImageID }
           flavor: m1.tiny
           networks:
           - network: { get_param: NetID }

     outputs:
       instance_name:
         description: Name of the instance.
         value: { get_attr: [ server, name ] }
       instance_ip:
         description: IP address of the instance.
         value: { get_attr: [ server, first_address ] }

Create a stack
--------------

Create a stack using the ``demo-template.yml`` template.

#. Source the ``demo`` credentials to perform
   the following steps as a non-administrative project:

   .. code-block:: console

      $ source demo-openrc.sh

#. Determine available networks.

   .. code-block:: console

      $ neutron net-list
      +--------------------------------------+---------+-----------------------------------------------------+
      | id                                   | name    | subnets                                             |
      +--------------------------------------+---------+-----------------------------------------------------+
      | 9c13da20-4c4f-486f-a4e9-692e9ea397f1 | public  | 85140549-1f54-4bc6-a2c5-f08428de3f7a 203.0.113.0/24 |
      | 303a9aaf-40fd-4fc8-9213-39bff933467b | private | ddeba0b1-21eb-471a-8f31-10f0e290cc36 172.16.1.0/24  |
      +--------------------------------------+---------+-----------------------------------------------------+

   .. note::

      This output may differ from your environment.

#. Set the ``NET_ID`` environment variable to reflect the ID of a network.
   For example, using the ``public`` network:

   .. code-block:: console

      $ export NET_ID=$(neutron net-list | awk '/ public / { print $2 }')

#. Create a stack of one CirrOS instance on the public network:

   .. code-block:: console

      $ heat stack-create -f demo-template.yml -P "ImageID=cirros;NetID=$NET_ID" stack
      +--------------------------------------+------------+--------------------+---------------------+--------------+
      | id                                   | stack_name | stack_status       | creation_time       | updated_time |
      +--------------------------------------+------------+--------------------+---------------------+--------------+
      | dbf46d1b-0b97-4d45-a0b3-9662a1eb6cf3 | stack      | CREATE_IN_PROGRESS | 2015-10-13T15:27:20 | None         |
      +--------------------------------------+------------+--------------------+---------------------+--------------+

#. After a short time, verify successful creation of the stack:

   .. code-block:: console

      $ heat stack-list
      +--------------------------------------+------------+-----------------+---------------------+--------------+
      | id                                   | stack_name | stack_status    | creation_time       | updated_time |
      +--------------------------------------+------------+-----------------+---------------------+--------------+
      | dbf46d1b-0b97-4d45-a0b3-9662a1eb6cf3 | stack      | CREATE_COMPLETE | 2015-10-13T15:27:20 | None         |
      +--------------------------------------+------------+-----------------+---------------------+--------------+

#. Show the name and IP address of the instance and compare with the output
   of the ``nova`` command:

   .. code-block:: console

      $ heat output-show --all stack
      [
        {
          "output_value": "stack-server-3nzfyfofu6d4",
          "description": "Name of the instance.",
          "output_key": "instance_name"
        },
        {
          "output_value": "10.4.31.106",
          "description": "IP address of the instance.",
          "output_key": "instance_ip"
        }
      ]

      $ nova list
      +--------------------------------------+---------------------------+--------+------------+-------------+---------------------------------+
      | ID                                   | Name                      | Status | Task State | Power State | Networks                        |
      +--------------------------------------+---------------------------+--------+------------+-------------+---------------------------------+
      | 0fc2af0c-ae79-4d22-8f36-9e860c257da5 | stack-server-3nzfyfofu6d4 | ACTIVE | -          | Running     | public=10.4.31.106              |
      +--------------------------------------+---------------------------+--------+------------+-------------+---------------------------------+

#. Delete the stack.

   .. code-block:: console

      $ heat stack-delete stack
