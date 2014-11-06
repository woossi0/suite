.. _cartography.ysld.reference.symbolizers.line:

Line symbolizer
===============

The line symbolizer is used to style linear (1-dimensional) features. It is in some ways the simplest of the symbolizers because it only contains facilities for the stroke (outline) of a feature.

Syntax
------

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
      stroke-graphic: 
        <graphic_options>
      stroke-graphic-fill: 
        <graphic_options>
      offset: <expression>
      geometry: <expression>

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
     - First geometry attribute found (often ``geom`` or ``the_geom``)

Examples
--------

Basic line with styled ends
~~~~~~~~~~~~~~~~~~~~~~~~~~~

The ``linejoin`` and ``linecap`` properties can be used to style the joins and ends of any stroke.
This example draws lines with transparent black lines with rounded ends and sharp (mitred) corners::

  feature-styles:
  - rules:
    - symbolizers:
      - line:
          stroke-color: 000000
          stroke-width: 8
          stroke-opacity: 0.5
          stroke-linejoin: mitre
          stroke-linecap: round

.. todo:: Add figure

Railroad pattern
~~~~~~~~~~~~~~~~

.. todo:: Fix this example

Many maps use a hatched pattern to represent railroads. This can be accomplished by using two line symbolizers, one solid and one dashed. Specifically, the ``stroke-dasharray`` property is used to create a dashed line of length 1 every 24 pixels::

  name: railroad
  feature-styles:
  - name: name
    rules:
    - symbolizers:
      - line:
          stroke-color: 000000
          stroke-width: 1
      - line:
          stroke-color: 000000
          stroke-width: 12
          stroke-dasharray: '1 24'

.. figure:: img/line_railroad.png

   Railroad pattern


Specifying sizes in units
~~~~~~~~~~~~~~~~~~~~~~~~~

The units for ``stroke-width``, ``size``, and other similar attributes default to pixels, meaning that graphics remain a constant size at different zoom levels. Alternately, units (feet or meters) can be specified for values, so graphics will scale as you zoom in or out. This example draws roads with a fixed width of 8 meters::

  feature-styles:
  - rules:
    - symbolizers:
      - line:
          stroke-color: 000000
          stroke-width: '8 m'

.. todo:: Add figure