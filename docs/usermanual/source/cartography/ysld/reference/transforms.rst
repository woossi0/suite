.. _cartography.ysld.reference.transforms:

Transforms
==========

YSLD allows for the use of :ref:`rendering transformations <cartography.rt>`. Rendering transformations are processes on the server that are executed inside the rendering pipeline, to allow for dynamic data transformations. In OpenGeo Suite, rendering transformations are typically exposed as WPS processes.

For example, one could create a style that applies to a point layer, and applies a Heatmap process as a rendering transformation, making the output a (raster) heatmap.

Because rendering transformations can change the geometry type, it is important to make sure that the :ref:`symbolizer <cartography.ysld.reference.symbolizers>` used matches the *output* of the rendering transformation, not the input. In the above heatmap example, the appropriate symbolizer would be a raster symbolizer, as the output of a heatmap is a raster.

For more information, please see the sections on :ref:`cartography.rt` and :ref:`processing`.

Syntax
------

The full syntax for using a rendering transformation is::

  feature-styles
    ...
    transform:
      name: <text>
      params: <options>
    rules:
      ...

where:

.. list-table::
   :class: non-responsive
   :header-rows: 1
   :stub-columns: 1
   :widths: 20 10 50 20

   * - Property
     - Required?
     - Description
     - Default value
   * - ``name``
     - Yes
     - Full name of the rendering transform including any prefixes (such as ``gs:Heatmap``)
     - N/A
   * - ``params``
     - Yes
     - All input parameters for the rendering transformation. Content will vary greatly based on the amount and type of parameters needed.
     - N/A

The values in the ``params`` options typically include values, strings, or attributes. For example:

* ``width: 10``
* ``source: attribute``
* ``edgeCase: 'left'`` 

However, it can be useful with a transformation to include environment parameters that concern the position and size of the map when it is rendered. For example, the following are common reserved environment parameters:

.. list-table::
   :class: non-responsive
   :header-rows: 1
   :stub-columns: 1
   :widths: 20 80

   * - Environment parameter
     - Description
   * - ``env('wms_bbox')``
     - The bounding box of the request
   * - ``env('wms_width')``
     - The width of the request
   * - ``env('wms_height')``
     - The height of the request

.. note:: Be aware that the transform happens *outside* of the :ref:`rules <cartography.ysld.reference.rules>` and :ref:`symbolizers <cartography.ysld.reference.symbolizers>`, but inside the :ref:`feature styles <cartography.ysld.reference.featurestyles>`.

Examples
--------

Heatmap
~~~~~~~

The following uses the :ref:`cartography.rt.heatmap` process to convert a point layer to a heatmap raster::

  title: Heatmap
  feature-styles:
  - transform:
      name: gs:Heatmap
      params:
        weightAttr: pop2000
        radiusPixels: 100
        pixelsPerCell: 10
        outputBBOX: env('wms_bbox')
        outputWidth: env('wms_width')
        outputHeight: env('wms_height')
    rules:
    - symbolizers:
      - raster:
          opacity: 0.6
          color-map:
            type: ramp
            entries:
            - (ffffff,0,0.0,nodata)
            - (4444ff,1,0.1,nodata)
            - (ff0000,1,0.5,values)
            - (ffff00,1,1.0,values)
