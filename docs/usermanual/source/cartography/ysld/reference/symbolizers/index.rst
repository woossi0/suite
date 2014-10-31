.. _cartography.ysld.reference.symbolizers:

Symbolizers
===========

The basic unit of visualization is the symbolizer. There are five types of symbolizer:

* Point
* Line
* Polygon
* Raster
* Text

Symbolizers are contained inside :ref:`rules <cartography.ysld.reference.rules>`. A rule can contain one or many symbolizers. 

.. note:: The most common use case for multiple symbolizers is a geometry (point/line/polygon) symbolizer to draw the features, plus a text symbolizer for labeling these features.

.. todo:: ADD FIGURE

It is common to match the symbolizer with the type of geometries contained in the layer, but this is not required. The following table illustrates what will happen when a geometry symbolizer is matched up with another type of geometry.

**Matching symbolizers and geometries**

.. list-table::
   :class: non-responsive
   :header-rows: 1
   :stub-columns: 1

   * - 
     - Points
     - Lines
     - Polygon
   * - Point Symbolizer
     - **Points**
     - Centroid of the lines
     - Centroid of the polygons
   * - Line Symbolizer
     - No display
     - **Lines**
     - Outline (stroke) of the polygons
   * - Polygon Symbolizer
     - No display
     - Will "close" the line and style as a polygon 
     - **Polygons**

.. toctree::
   :maxdepth: 2

   line
   polygon
   point
   raster
   text
