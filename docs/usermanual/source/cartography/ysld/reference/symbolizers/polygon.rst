.. _cartography.ysld.reference.symbolizers.polygon:

Polygon symbolizer
==================

The polygon symbolizer styles polygon (2-dimensional) features. It contains facilities for the stroke (outline) of a feature, as well as the fill (inside) of a feature. 

The full syntax of a polygon symbolizer is::

  symbolizers:
  - polygon:
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
      offset: <expression>
      displacement: <expression>
      geometry: <expression>

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
   * - ``offset``
     - No
     - Value in pixels for moving the drawn line relative to the location of the feature. 
     - ``0``
   * - ``displacement``
     - No
     - Specifies a distance to which to move the symbol relative to the feature. Value is an ``(x,y)`` tuple with values expressed in pixels, so (10,5) will displace the symbol 10 pixels to the right, and 5 pixels down.
     - ``(0,0)``
   * - ``geometry``
     - No
     - Specifies which attribute to use as the geometry.
     - First geometry attribute found (often ``geom`` or ``the_geom``)

.. include:: include/graphic.txt
