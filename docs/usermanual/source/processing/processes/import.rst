.. _processing.processes.import:

Import
======

.. todo:: Graphic needed.

Description
-----------

The ``gs:Import`` process takes a feature collection and adds it to the GeoServer catalog as a layer. It acts as a simple data loader; the contents of the feature collection are unchanged.

A few catalog parameters are added in addition to the feature collection. The desired workspace name, store name, :term:`CRS`, and CRS handling policy can all be input, but if omitted the server defaults will be used. The name of the layer can be specified, but if omitted it will be set to the name contained in the feature collection. The name of an existing style can be specified, but if omitted a default style will be chosen based on the geometry in the feature collection.

Inputs and outputs
------------------

This process accepts :ref:`processing.processes.formats.fcin` and returns a string containing the fully qualified layer name (with workspace prefix) only.
