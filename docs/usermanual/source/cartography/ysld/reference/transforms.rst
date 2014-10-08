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

.. note:: Be aware that the transform happens *outside* of the :ref:`rules <cartography.ysld.reference.rules>` and :ref:`symbolizers <cartography.ysld.reference.symbolizers>`, but inside the :ref:`feature styles <cartography.ysld.reference.featurestyles>`.
