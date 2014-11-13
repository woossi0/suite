.. _cartography.ysld.reference.symbolizers.point:

Point symbolizer
================

The point symbolizer is used to style point features or centroids of non-point features.

Syntax
------

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
          stroke-graphic: 
            <graphic_options>
          stroke-graphic-fill: 
            <graphic_options>
      size: <expression>
      anchor: <tuple>
      displacement: <tuple>
      opacity: <expression>
      rotation: <expression>
      geometry: <expression>
      x-labelObstacle: <boolean>

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
   * - ``external``
     - No
     - Specifies an image to use to style the point.
     - N/A
   * - ``url``
     - Yes
     - Location of the image. Can either be a URL or a file path location (relative to the path where the style file is saved)
     - N/A
   * - ``format``
     - Yes
     - Format of the image. Must be a valid MIME type (such as ``image/png`` for PNG, ``image/jpeg`` for JPG, ``image/svg+xml`` for SVG) 
     - N/A
   * - ``mark``
     - No
     - Specifies a regular shape to use to style the point.
     - N/A
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
     - Specifies the level of transparency. Value of ``0`` means entirely transparent, while ``1`` means entirely opaque. Only affects ``external`` symbols. The opacity of ``mark`` symbols is controled by the ``fill-opacity`` and ``stroke-opacity`` of the mark.
     - ``1``
   * - ``rotation``
     - No
     - Value (in degrees) or rotation of the mark. Larger values increase counter-clockwise rotation. A value of ``180`` will make the mark upside-down.
     - ``0``
   * - ``geometry``
     - No
     - Specifies which attribute to use as the geometry.
     - First geometry attribute found (often ``geom`` or ``the_geom``)

.. include:: include/misc.txt

Examples
--------

Basic point
~~~~~~~~~~~

A point symbolizer draws a point at the center of any geometry. It is defined by an external image or a symbol, either of which can be sized and rotated. A mark is a pre-defined symbol that can be drawn at the location of a point. Similar to polygons, marks have both a fill and a stroke. This example shows a point symbolizer that draws semi-transparent red diamonds with black outlines::

  feature-styles:
  - name: name
    rules:
    - title: red point
      symbolizers:
      - point:
          symbols:
          - mark:
              shape: square
              fill-color: ff0000
              fill-opacity: 0.75
              stroke-color: 000000
              stroke-width: 1.5
              stroke-opacity: 1
          size: 20
          rotation: 45

.. figure:: img/point_basic.png

   Basic point

External image
~~~~~~~~~~~~~~

Sometimes it may be useful to use an external image to represent certain points. This can be accomplished using the external symbol property, which requires a ``url`` and a ``format``. The ``url`` should be enclosed in single quotes. The ``format`` property is a `MIME type image <http://en.wikipedia.org/wiki/Internet_media_type#Type_image>`_. This example shows a point symbolizer that draws an external image at each point::

  name: point
  feature-styles:
  - name: name
    rules:
    - symbolizers:
        point
          symbols:
          - external:
              url: 'image.png'
                 format: image/png
          size: 16

.. figure:: img/point_graphic.png

   External image

