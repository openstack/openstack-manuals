.. _json_conv:

================
JSON conventions
================

OpenStack uses JSON format. Use the following JSON formatting conventions:

* Format JSON files to be human readable.
* Use four spaces for indentation (matching OpenStack conventions used in
  Python and shell scripts). Do not use tab characters in the code, always
  use spaces.
* Use one space after the name-separator (colon).
* Obey the formal JSON format; in particular, wrap strings in double
  (not single) quotes.
* Sample files may have their keys ordered if that makes the file easier
  to understand. Automatic reformatting tools preserve the order of keys.

Example:

.. code-block:: json

   {
       "uuid": "d8e02d56-2648-49a3-bf97-6be8f1204f38",
       "availability_zone": "nova",
       "hostname": "test.novalocal",
       "launch_index": 0,
       "array0": [],
       "array1": [
           "low"
       ],
       "array3": [
           "low",
           "high",
           "mid"
       ],
       "object0": {},
       "object1": {
           "value": "low",
           "role": "some"
       },
       "name": "test"
   }
