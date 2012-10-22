.. _processing.processes.vector.bufferfc:

BufferFeatureCollection
=======================

.. todo:: Graphic needed.

Description
-----------

The ``gs:BufferFeatureCollection`` process takes a feature collection and applies a buffer to each feature. The buffer distance can be a fixed value for all features, supplied as a process input, or can be variable, with the values taken from an attribute in the feature collection. The two parameters can be used together as well, with the given fixed buffer distance added to an attribute-specified distance. 


Inputs and outputs
------------------

This process accepts :ref:`processing.processes.formats.fcin` and returns :ref:`processing.processes.formats.fcout`.

Inputs
^^^^^^

.. list-table::
   :header-rows: 1

   * - Name
     - Description
     - Type
     - Required
   * - ``features``
     - Input feature collection
     - SimpleFeatureCollection
     - Yes
   * - ``distance``
     - Fixed value to use for the buffer distance
     - Double
     - Yes
   * - ``attributeName``
     - Attribute containing a variable buffer distance value
     - String
     - No

Outputs
^^^^^^^

.. list-table::
   :header-rows: 1

   * - Name
     - Description
     - Type
   * - ``result``
     - Buffered feature collection
     - SimpleFeatureCollection

Notes on usage
--------------

* The buffer distance is in the units of the feature collection, so unexpected output may occur with data in geographic coordinates.
* The fixed ``distance`` parameter is required, so if using an attribute to specify a variable buffer distance, set it to 0.

