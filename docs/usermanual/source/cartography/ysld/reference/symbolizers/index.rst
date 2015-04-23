.. _cartography.ysld.reference.symbolizers:

Symbolizers
===========

The basic unit of visualization is the symbolizer. There are five types of symbolizers: **Point**, **Line**, **Polygon**, **Raster**, and **Text**.

Symbolizers are contained inside :ref:`rules <cartography.ysld.reference.rules>`. A rule can contain one or many symbolizers. 

.. toctree::
   :maxdepth: 1

   line
   polygon
   point
   raster
   text

.. note:: The most common use case for multiple symbolizers is a geometry (point/line/polygon) symbolizer to draw the features plus a text symbolizer for labeling these features.

   .. figure:: img/symbolizers.svg
      
      Use of Multiple Symbolizers


Matching symbolizers and geometries
-----------------------------------

It is common to match the symbolizer with the type of geometries contained in the layer, but this is not required. The following table illustrates what will happen when a geometry symbolizer is matched up with another type of geometry.

.. list-table::
   :class: non-responsive
   :header-rows: 1
   :stub-columns: 1

   * - 
     - Points
     - Lines
     - Polygon
     - Raster
   * - Point Symbolizer
     - **Points**
     - Midpoint of the lines
     - Centroid of the polygons
     - Centroid of the raster
   * - Line Symbolizer
     - Small horizontal line
     - **Lines**
     - Outline (stroke) of the polygons
     - Outline (stroke) of the raster
   * - Polygon Symbolizer
     - Will "square" the point and style as a polygon
     - Will "close" the line and style as a polygon 
     - **Polygons**
     - Will "outline" the raster and style as a polygon
   * - Raster Symbolizer
     - n/a
     - n/a
     - n/a
     - Transform raster values to color channels for display
   * - Text Symbolizer
     - label at point location
     - label at midpoint of lines
     - label at centroid of polygons
     - label at centroid of raster outline

Drawing order
-------------

The order of symbolizers significant, and also the order of your data.

For each feature the rules are evaluated resulting in a list of symbolizers that will be used to draw that feature. The symbolizers are drawn in the order provided.

Consider the following two symbolizers::

   symbolizers:
   - point:
     - shape: square
   - point:
     - shape: triangle
     
When drawing three points these symbolizers will be applied in order:

#. Feature 1 is drawn as a square, followed by a triangle
#. Feature 2 is drawn as a square, followed by a triangle. Notice the slight overlap with Feature 1.
#. Feature 3 is drawn as a square, followed by a triangle

In the final image Feature 1 and Feature 2 have a slight overlap. This overlap is determined by data order which we have no control over. If you need to control the overlap review the feature-styles section on managing z-order.

Syntax
------

The following is the basic syntax of a feature style. Note that the contents of the block are not all expanded here.

::

   geometry: <cql>
   uom: <text>
   ..
   x-composite: <text>
   x-composite-base: <boolean>

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
   * - ``geometry``
     - No
     - Geometry attribute to draw, the default geometry will be used if not provided
     - Blank
   * - ``uom``
     - No
     - Unit of measure used for width calculations, default is pixel
     - Blank

The following properties are equivalent to SLD "vendor options".

.. list-table::
   :class: non-responsive
   :header-rows: 1
   :stub-columns: 1
   :widths: 20 10 50 20

   * - Property
     - Required?
     - Description
     - Default value
   * - ``x-composite``
     - No
     - Allows for both alpha compositing and color blending options between symbolizers.
     - N/A
   * - ``x-composite-base``
     - No
     - Allows the rendering engine to use symbolizer to define a "base" buffer for subsequent ''x-composite'' compositing and blending.
     - ``false``
     
Composition and blending are handled in the same manner as described in :ref:`see feature-styles <cartography.ysld.reference.featurestyles.composite>`.
