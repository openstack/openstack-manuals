=================
ovf-metadata.json
=================

The ``ovf-metadata.json`` file specifies the OVF properties of interest
for the OVF processing task. Configure this to extract metadata from an
OVF and create corresponding properties on an image for the Image service.
Currently, the task supports only the extraction of properties
from the ``CIM_ProcessorAllocationSettingData`` namespace,
`CIM schema <http://schemas.dmtf.org/wbem/wscim/1/cim-schema/2/>`_.

.. remote-code-block:: json

   https://git.openstack.org/cgit/openstack/glance/plain/etc/ovf-metadata.json.sample?h=mitaka-eol
