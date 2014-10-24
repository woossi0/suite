.. _cartography.ysld.reference.symbolizers.point:

Point symbolizer
================

The point symbolizer is used to style point features or centroids of non-point features.

The full syntax of a point symbolizer is::

  symbolizers:
  - point:
      symbols:
      - external:
          url: <text>
          format: <text>
      - mark:
          shape: <shape>
          fill-color: <color>
          fill-opacity: <expression>
          fill-graphic: 
            <graphic_options>
          stroke-color: <color>
          stroke-width: <expression>
          stroke-opacity: <expression>
          stroke-linejoin: <expression>
          stroke-linecap: <expression>
          stroke-dasharray: <float list>
          stroke-dashoffset: <expression>
          stroke-graphic-fill: 
            <graphic_options>
          stroke-graphic-stroke: 
            <graphic_options>
      size: <expression>
      anchor: <tuple>
      displacement: <tuple>
      opacity: <expression>
      rotation: <expression>
      geometry: <expression>




.. warning:: VERIFY THIS

where:

.. include:: include/stroke.txt

.. include:: include/fill.txt

.. list-table::
   :class: non-responsive
   :header-rows: 1
   :stub-columns: 1
   :widths: 20 10 50 20

   * - Property
     - Required?
     - Description
     - Default value
   * - ``shape``
     - No
     - Shape of the mark. Options are ``square``, ``circle``, ``triangle``, ``cross``, ``x``, and ``star``. 
     - ``square``
   * - ``size``
     - No
     - Size of the mark in pixels. If the aspect ratio of the mark is not 1:1 (square), will apply to the *height* of the graphic only, with the width scaled proportionally.
     - 16
   * - ``anchor``
     - No
     - Specify the center of the symbol relative to the feature location. Value is an ``(x,y)`` tuple with decimal values from 0-1, with ``(0,0)`` meaning that the symbol is anchored to the top left, and ``(1,1)`` meaning anchored to bottom right. 
     - ``(0.5,0.5)``
   * - ``displacement``
     - No
     - Specifies a distance to which to move the symbol relative to the feature. Value is an ``(x,y)`` tuple with values expressed in pixels, so (10,5) will displace the symbol 10 pixels to the right and 5 pixels down.
     - ``(0,0)``
   * - ``opacity``
     - No
     - Specifies the level of transparency. Value of ``0`` means entirely transparent, while ``1`` means entirely opaque.
     - ``1``
   * - ``rotation``
     - No
     - Value (in degrees) or rotation of the mark. Larger values increase counter-clockwise rotation. A value of ``180`` will make the mark upside-down.
     - ``0``
   * - ``geometry``
     - No
     - Specifies which attribute to use as the geometry.
     - First geometry attribute found

.. warning:: VERIFY OTHER SHAPES, ANCHOR, DISPLACEMENT


.. include:: include/graphic.txt
