.. _cartography.ysld.reference.symbolizers.line:

Line symbolizer
===============

The line symbolizer is used to style linear features. It is in some ways the simplest of the symbolizers because it only contains facilities for the stroke (outline) of a feature, and not the fill (inside) of a feature.

The full syntax of a line symbolizer is:

::

  symbolizers:
  - line:
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
      geometry: <expression>

.. warning:: VERIFY STROKE-GRAPHIC-?, OFFSET

where:

.. include:: include/stroke.txt

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
   * - ``geometry``
     - No
     - Specifies which attribute to use as the geometry.
     - First geometry attribute found

.. include:: include/graphic.txt
