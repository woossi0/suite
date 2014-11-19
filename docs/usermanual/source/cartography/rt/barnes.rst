.. _cartography.rt.barnes:


Barnes Surface
==============

The Barnes Surface rendering transformation is a **Vector-to-Raster** transformation which computes a interpolated surface across a set of irregular observation points.  It is commonly used as an interpolation technique for weather maps and other meteorological datasets.  The surface is generated dynamically from the dataset, so it can be used to visualize changing data.  The surface view is created by configuring a layer
with an SLD style which invokes the Barnes Surface rendering transformation.

.. figure:: img/barnes_surface.png

   *Barnes Surface rendering transformation used to render a maximum temperature surface*

The map image shows the generated Barnes Surface, the original input data points (drawn by another style), as well as a base map layer.

Description
-----------

The Barnes Surface algorithm operates on a regular grid of cells covering a specified extent in the input data space.  It computes an initial pass to produce an interpolated value for each grid cell.  The value of a cell is determined by its proximity to the input observation points, using a summation of exponential (Gaussian) decay functions for each observation point.  Refinement passes may be used to improve the estimate, by reducing the error between the computed surface and the observations.

The rendering transformation uses the Barnes Surface algorithm to compute a surface over a set of irregular data points,
providing a raster surface as output.
The input is a dataset of **points**,
with an attribute providing an **observed value** for each point.
The radius of influence of each observation point is controlled by the **length scale**.
A number of **refinement passes** can be performed to improve the surface estimate,
with the degree of refinement controlled by the **convergence factor**.

Usage
-----

As with all rendering transformations, the transformation is invoked by adding a transform to a feature type style. The style can then be applied to any layer which is backed by a suitable dataset (featuretype).

.. only:: enterprise

   The transformation is specified with a function ``gs:BarnesSurface"`` element, with arguments which supply the transformation parameters.

   The transformation parameters are as follows.  The order of parameters is not significant.

   .. tabularcolumns:: |p{5cm}|p{1.5cm}|p{8.5cm}|
   .. list-table::
      :widths: 25 10 65
      :header-rows: 1

      * - Name
        - Required?
        - Description
      * - ``valueAttr``
        - Yes
        - Name of the value attribute.
      * - ``dataLimit``
        - No
        - Limits the number of input points which are processed.
      * - ``scale``
        - Yes
        - Length Scale for the interpolation.  In units of the input data CRS.
      * - ``convergence``
        - No
        - Convergence factor for refinement.  Between 0 and 1 (values below 0.4 are safest).  (Default = 0.3)
      * - ``passes``
        - No
        - Number of passes to compute.  Value can be 1 or greater. (Default = 2)
      * - ``minObservations``
        - No
        - Minimum number of observations required to support a grid cell. (Default = 2)
      * - ``maxObservationDistance``
        - No
        - Maximum distance to an observation for it to support a grid cell.
          0 means all observations are used.
          In units of the input data CRS.  (Default = 0)
      * - ``noDataValue``
        - No
        - The NO_DATA value to use for unsupported grid cells in the output.
      * - ``pixelsPerCell``
        - No
        - Resolution of the computed grid. Larger values improve performance, but may degrade appearance if too large. (Default = 1)
      * - ``queryBuffer``
        - No
        - Distance to expand the query envelope by. Larger values provide a more stable surface. In units of the input data CRS.  (Default = 0)
      * - ``outputBBOX``
        - Yes
        - Georeferenced bounding box of the output
      * - ``outputWidth``
        - Yes
        - Output image width
      * - ``outputHeight``
        - Yes
        - Output image height

.. only:: basic
   
   The transformation is specified with a ``<ogc:Function name="gs:BarnesSurface">`` element, with arguments which supply the transformation parameters.  

   The transformation parameters are as follows.  The order of parameters is not significant.

   .. tabularcolumns:: |p{5cm}|p{1.5cm}|p{8.5cm}|
   .. list-table::
      :widths: 25 10 65
      :header-rows: 1

      * - Name
        - Required?
        - Description
      * - ``data``
        - Yes
        - Input FeatureCollection containing the features to map.
      * - ``valueAttr``
        - Yes
        - Name of the value attribute.
      * - ``dataLimit``
        - No
        - Limits the number of input points which are processed.
      * - ``scale``
        - Yes
        - Length Scale for the interpolation.  In units of the input data CRS.
      * - ``convergence``
        - No
        - Convergence factor for refinement.  Between 0 and 1 (values below 0.4 are safest).  (Default = 0.3)
      * - ``passes``
        - No
        - Number of passes to compute.  Value can be 1 or greater. (Default = 2)
      * - ``minObservations``
        - No
        - Minimum number of observations required to support a grid cell. (Default = 2)
      * - ``maxObservationDistance``
        - No
        - Maximum distance to an observation for it to support a grid cell.
          0 means all observations are used.
          In units of the input data CRS.  (Default = 0)
      * - ``noDataValue``
        - No
        - The NO_DATA value to use for unsupported grid cells in the output.
      * - ``pixelsPerCell``
        - No
        - Resolution of the computed grid. Larger values improve performance, but may degrade appearance if too large. (Default = 1)
      * - ``queryBuffer``
        - No
        - Distance to expand the query envelope by. Larger values provide a more stable surface. In units of the input data CRS.  (Default = 0)
      * - ``outputBBOX``
        - Yes
        - Georeferenced bounding box of the output
      * - ``outputWidth``
        - Yes
        - Output image width
      * - ``outputHeight``
        - Yes
        - Output image height

   The arguments are specified using the special function ``<ogc:Function name='parameter'>``.
   Each function has as arguments:

   * an ``<ogc:Literal>`` giving the name of the parameter
   * one or more literals containing the value(s) of the parameter.

The transformation has required parameters which specify the output image dimensions.  The values of these parameters are obtained from environment variables accessed via the function ``env``.  The environment variable values are determined from the WMS request which initiated the rendering process.  The parameters and corresponding environment variables are:

* ``outputBBOX`` use env variable ``wms_bbox`` to obtain the surface extent
   
   .. only:: basic
   
      .. code-block:: xml
   
         <ogc:Function name="parameter">
           <ogc:Literal>outputBBOX</ogc:Literal>
           <ogc:Function name="env"><ogc:Literal>wms_bbox</ogc:Literal></ogc:Function>
         </ogc:Function>

   .. only:: enterprise
   
      .. code-block:: yaml
   
         outputBBOX: ${env(wms_bbox)}
        
* ``outputWidth`` use env variable ``wms_width`` to obtain the output raster width

   .. only:: basic
   
      .. code-block:: xml
   
         <ogc:Function name="parameter">
           <ogc:Literal>outputWidth</ogc:Literal>
           <ogc:Function name="env"><ogc:Literal>wms_width</ogc:Literal></ogc:Function>
         </ogc:Function>

   .. only:: enterprise
   
      .. code-block:: yaml
   
         outputWidth: ${env(wms_width)}

* ``outputHeight`` use env variable ``wms_height`` to obtain the output raster height

   .. only:: basic
   
      .. code-block:: xml
   
         <ogc:Function name="parameter">
           <ogc:Literal>outputHeight</ogc:Literal>
           <ogc:Function name="env"><ogc:Literal>wms_height</ogc:Literal></ogc:Function>
         </ogc:Function>

   .. only:: enterprise
   
      .. code-block:: yaml
   
         outputHeight: ${env(wms_height)}

Input
-----

The Barnes Surface rendering transformation is applied to a **vector** input dataset containing features with point geometry.
The dataset is supplied in the ``data`` parameter.  The observation value for features is supplied in the attribute named in the ``valueAttr`` parameter.

To prevent extrapolation into areas unsupported by observations the influence of observation points can be limited using the ``minObservations`` and ``maxObservationDistance`` parameters.
This also increases performance by reducing the observations evaluated for each grid cell.  Uncomputed grid cells are given the value ``noDataValue``.

To ensure the computed surface is stable under panning and zooming the extent for the input data can be expanded by a user-specified distance (``queryBuffer``).  This ensures enough data points are included to avoid edge effects on the computed surface.  The expansion distance depends on the length scale, convergence factor, and data spacing in a complex way, so must be manually determined (a good heuristic is to set the distance at least as large as the length scale.)

To prevent excessive CPU consumption the number of data points processed can be limited using the ``dataLimit`` parameter.  If the limit is exceeded an output is still produced using the maximum number of points.

To improve performance the surface grid can be computed at lower resolution than the output raster, using the ``pixelsPerCell`` parameter.  The computed grid is upsampled to the output raster size using *Bilinear Interpolation with Edge Smoothing* to maintain quality.  There is minimal impact on appearance for small cell sizes (10 pixels or less).

The surface is computed in the CRS (coordinate reference system) of the output.  If the output CRS is different to the input CRS the data points are transformed into the output CRS.  Likewise, the distance-based parameters ``scale`` and ``maxObservationDistance`` are converted into the units of the output CRS.


Output
------

The output of the transformation is a single-band **raster**.  Each pixel has a floating-point value in the range [0..1] measuring the density of the pixel relative to the rest of the surface.  The raster can be styled using a raster symbolizer>.

.. only:: basic
   
   In order for the SLD to be correctly validated, the RasterSymbolizer ``<Geometry>`` element must be present to specify the name of the input geometry attribute (using ``<Geometry><ogc:PropertyName>...</ogc:PropertyName></Geometry>``)

.. only:: enterprise

   Example
   -------

   The map image above shows a temperature surface interpolated across a set of data points with a attribute giving the maximum daily temperature on a given day. The surface layer in the image is produced by the following style. You can adapt this style to your own data by adjusting the transformation parameters, and by choosing a color map definition that provides an appropriate styling.


   .. code-block:: YAML
      :linenos:
      :emphasize-lines: 7,9-19,23-24,28-29

      name: Default Styler
      title: Barnes Surface
      abstract: A style that produces a Barnes surface using a rendering transformation
      feature-styles:
      - name: name
        transform:
          name: gs:BarnesSurface
          params:
            valueAttr: value
            scale: 15.0
            convergence: 0.2
            passes: 3
            minObservations: 1
            maxObservationDistance: 10
            pixelsPerCell: 10
            queryBuffer: 40
            outputBBOX: ${env('wms_bbox')}
            outputWidth: ${env('wms_width')}
            outputHeight: ${env('wms_height')}
        rules:
        - symbolizers:
          - raster:
              geometry: ${point}
              opacity: 0.8
              color-map:
                type: ramp
                entries:
                - ('#FFFFFF',0,-990,nodata)
                - ('#2E4AC9',,-9,nodata)
                - ('#41A0FC',,-6,values)
                - ('#58CCFB',,-3,values)
                - ('#76F9FC',,0,values)
                - ('#6AC597',,3,values)
                - ('#479364',,6,values)
                - ('#2E6000',,9,values)
                - ('#579102',,12,values)
                - ('#9AF20C',,15,values)
                - ('#B7F318',,18,values)
                - ('#DBF525',,21,values)
                - ('#FAF833',,24,values)
                - ('#F9C933',,27,values)
                - ('#F19C33',,30,values)
                - ('#ED7233',,33,values)
                - ('#EA3F33',,36,values)
                - ('#BB3026',,999,values)

   In the YSLD example defines the Barnes surface rendering transformation,
   giving values for the transformation parameters which are appropriate for the input dataset.
   Parameter **valueAttr** specifies the name of the observation value attribute.
   Parameter **scale** sets a length scale of 15 degrees.
   Parameter **convergence** sets the convergence factor to be 0.2.
   Parameter **passes** requests that 3 passes be performed (one for the initial estimate, and two refinement passes).
   Parameter **minObervations** specifies that the minimum number of observations required to support an estimated cell is 1
   (which means every observation point will be represented in the output).
   Parameter **maxObservations** specifies the maximum distance from a computed grid cell to an observation point is 10 degrees.
   Parameter **pixelsPerCell** defines the resolution of computation to be 10 pixels per cell,
   which provides efficient rendering time while still providing output of reasonable visual quality.
   Parameter **queryBuffer** specifies the query buffer to be 40 degrees, which is chosen to be
   at least double the length scale for stability.
   Parameter **outputBBOX**, **outputWidth**, **outputHeight** define the output parameters, which are
   obtained from internal environment variables set during rendering, as described above.

   The **raster** symbolizer used to style the raster computed by the transformation.
   Parameter **geometry** defines the geometry property of the input dataset, which is required for SLD validation purposes.
   Parameter **opacity** specifies an overall opacity of 0.8 for the rendered layer.
   Parameter **color-map** defines a color map with which to symbolize the output raster.
   In this case the color map uses a **type** of ``ramp``, which produces a smooth
   transition between colors.  The type could also be ``intervals``,
   which produces a contour effect with discrete transition between colors
   (as shown in the image below).
   The first color map tuple specifies that the NO_DATA value of -990 and -9 should be displayed with a fully transparent color of white (making uncomputed pixels invisible).
   
.. only:: basic

   SLD Example
   -----------

   The map image above shows a temperature surface interpolated across a set of data points with a attribute giving the maximum daily temperature on a given day. You can adapt this SLD to your own data by adjusting the transformation parameters, and by choosing a color map definition that provides an appropriate styling.

      .. literalinclude:: artifact/barnes_example.sld
         :linenos:
         :emphasize-lines: 15,17,20,24,28,32,36,40,44,48,52,58,64,74,75,77,78

   In the SLD, **Lines 15-71** define the Barnes surface rendering transformation,
   giving values for the transformation parameters which are appropriate for the input dataset.
   **Line 17 data** specifies the input dataset parameter name.
   **Line 20 valueAttr** specifies the name of the observation value attribute.
   **Line 26 scale** sets a length scale of 15 degrees.
   **Line 28 convergence** sets the convergence factor to be 0.2.
   **Line 32 passes** requests that 3 passes be performed (one for the initial estimate, and two refinement passes).
   **Line 36 minObervations** specifies that the minimum number of observations required to support an estimated cell is 1
   (which means every observation point will be represented in the output).
   **Line 40 maxObservations** specifies the maximum distance from a computed grid cell to an observation point is 10 degrees.
   **Line 44 pixelsPerCell** defines the resolution of computation to be 10 pixels per cell,
   which provides efficient rendering time while still providing output of reasonable visual quality.
   **Line 48 queryBuffer** specifies the query buffer to be 40 degrees, which is chosen to be
   at least double the length scale for stability.
   **Lines 52-69** define the output parameters, which are
   obtained from internal environment variables set during rendering, as described above.

   **Lines 72** define the symbolizer used to style the raster computed by the transformation.
   **Line 74 geometry** defines the geometry property of the input dataset, which is required for SLD validation purposes.
   **Line 75 opacity** specifies an overall opacity of 0.8 for the rendered layer.
   **Lines 78-94** define a color map with which to symbolize the output raster.
   In this case the color map uses a **type** of ``ramp``, which produces a smooth
   transition between colors.  The type could also be ``intervals``,
   which produces a contour effect with discrete transition between colors
   (as shown in the image below).
   **Line 77** specifies that the NO_DATA value of -990 and -9 should be displayed with a fully transparent color of white (making uncomputed pixels invisible).

.. figure:: img/barnes_surface_intervals.png

   *Barnes surface using intervals color map*

