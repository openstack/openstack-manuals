=====================
Architecture Examples
=====================

To understand the possibilities that OpenStack offers, it's best to
start with basic architecture that has been tested in production
environments. We offer two examples with basic pivots on the base
operating system (Ubuntu and Red Hat Enterprise Linux) and the
networking architecture. There are other differences between these two
examples and this guide provides reasons for each choice made.

Because OpenStack is highly configurable, with many different back ends
and network configuration options, it is difficult to write
documentation that covers all possible OpenStack deployments. Therefore,
this guide defines examples of architecture to simplify the task of
documenting, as well as to provide the scope for this guide. Both of the
offered architecture examples are currently running in production and
serving users.

.. note::

   As always, refer to the :doc:`common/glossary` if you are unclear
   about any of the terminology mentioned in architecture examples.

.. toctree::
   :maxdepth: 2

   arch_example_nova_network.rst
   arch_example_neutron.rst
   arch_example_thoughts.rst
