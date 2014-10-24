.. _cartography.ysld.reference.symbolizers.raster:

Raster symbolizer
=================

The raster symbolizer styles raster (coverage) layers. A raster is an array of information with each cell in the array containing one or more values, stored as "bands".

The full syntax of a raster symbolizer is::

  symbolizers:
  - raster:
      opacity: <expression>
      color-map:
        type: ramp
        entries: []
      contrast-enhancement: 
        mode: <normalize|histogram|none>
        gamma: <expression>

.. warning:: WHAT ELSE?

.. warning:: HOW TO PICK OUT BANDS?

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
   * - ``opacity``
     - No
     - Opacity of the display. Valid values are a decimal between ``0`` (completely transparent) and ``1`` (completely opaque).
     - ``1``
   * - ``color-map``
     - No
     - Creates a mapping of colors to grid values.
     - N/A
   * - ``type``
     - No
     - Type of color mapping. Options are ``ramp``, an interpolated list of values; ``interval``, a non-interpolated list of values; and ``values``, where values need to match exactly to be drawn.
     - ``ramp``
   * - ``entries``
     - No
     - Values for the color mapping. Syntax is a list of tuples, where each tuple contains ``(color, opacity, band_value, text_label)``
     - N/A
   * - ``contrast-enhancement``
     - No
     - Applies a multiplier to the band values drawn
     - N/A
   * - ``mode``
     - No
     - Type of contrast enhancement. Options are ``normalize``, ``histogram``, and ``none``
     - ???
   * - ``gamma``
     - No
     - ???
     - ???

.. warning:: VERIFY (PLANBOX) CONTRAST-ENHANCEMENT

Examples
~~~~~~~~

Color ramp from red to green to blue, with raster band values from 0-200::

  symbolizers:
  - raster:
      color-map:
        type: ramp
        entries:
        - (ff0000, 1, 0, red)
        - (00ff00, 1, 100, green)
        - (0000ff, 1, 200, blue)

.. warning:: VERIFY THIS
