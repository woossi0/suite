.. _processing.processes.bufferfc:

BufferFeatureCollection
=======================

.. todo:: Graphic needed.

Description
-----------

The ``gs:BufferFeatureCollection`` process takes a feature collection and applies a buffer to each feature. The buffer length can be a fixed value for all features supplied as a process input, or can be variable, the value taken from an attribute in the feature collection. The two parameters can be used together as well, with a certain static buffer added to as variable buffer. 

Inputs and outputs
------------------

This process accepts :ref:`processing.processes.formats.fcin` and returns :ref:`processing.processes.formats.fcout`.

Notes on usage
--------------

* The buffer length will be in the same units of the feature collection, so unexpected output may occur with geographic representations.
* The static length parameter is required, so if using an attribute for determining the buffer length, set this to 0.

