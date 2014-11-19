.. _cartography.rt.heatmap:


Heatmap
=======

The Heatmap rendering transformation is a **Vector-to-Raster** transformation which displays a dataset as a heatmap surface (also known as a "density surface").  The heatmap surface is generated dynamically, so it can be used to visualize dynamic data.  It can be applied to very large datasets with good performance.

The heatmap view is created by configuring a layer with a style which invokes the Heatmap rendering transformation.

.. figure:: img/heatmap_urban_us_east.png

   *Heatmap rendering transformation*

The map image shows the heatmap transformation, the original input data points (drawn by another style), as well as a base map layer.

Usage
-----

As with all rendering transformations, the transformation is invoked by adding a transform to a feature type style. The style can then be applied to any layer which is backed by a suitable dataset (featuretype).  The dataset may have a weight attribute, whose name is supplied to the process via the ``weightAttr`` process parameter.

.. only:: basic

   The transformation is specified with a ``<ogc:Function name="gs:Heatmap">`` element, with arguments which supply the transformation parameters.

   The transformation parameters are as follows.  The order of parameters is not significant.

   .. tabularcolumns:: |p{4cm}|p{1.5cm}|p{9.5cm}|
   .. list-table::
      :widths: 40, 15, 45
      :header-rows: 1

      * - Name
        - Required?
        - Description
      * - ``data``
        - Yes
        - Input FeatureCollection containing the features to map.
      * - ``radiusPixels``
        - Yes
        - Radius of the density kernel (in pixels).
      * - ``weightAttr``
        - No
        - Name of the weight attribute. (default = 1)
      * - ``pixelsPerCell``
        - No
        - Resolution of the computed grid. Larger values improve performance, but may degrade appearance if too large. (default = 1)
      * - ``outputBBOX``
        - Yes
        - Georeferenced bounding box of the output.
      * - ``outputWidth``
        - Yes
        - Output image width.
      * - ``outputHeight``
        - Yes
        - Output image height.
   
   The arguments are specified using the special function ``<ogc:Function name='parameter'>``.  Each function has as arguments:

   * an ``<ogc:Literal>`` giving the name of the parameter
   * one or more literals containing the value(s) of the parameter.

.. only:: enterprise
   
   The transformation is specified with a the function ``gs:Heatmap``, with arguments which supply the transformation parameters.
   
   The transformation parameters are as follows.  The order of parameters is not significant.

   .. tabularcolumns:: |p{4cm}|p{1.5cm}|p{9.5cm}|
   .. list-table::
      :widths: 40, 15, 45
      :header-rows: 1

      * - Name
        - Required?
        - Description
      * - ``radiusPixels``
        - Yes
        - Radius of the density kernel (in pixels).
      * - ``weightAttr``
        - No
        - Name of the weight attribute. (default = 1)
      * - ``pixelsPerCell``
        - No
        - Resolution of the computed grid. Larger values improve performance, but may degrade appearance if too large. (default = 1)
      * - ``outputBBOX``
        - Yes
        - Georeferenced bounding box of the output.
      * - ``outputWidth``
        - Yes
        - Output image width.
      * - ``outputHeight``
        - Yes
        - Output image height.

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

The Heatmap rendering transformation is applied to an input dataset containing features with **vector** geometry.  The geometry may be of any type.  Point geometries are used directly, while non-point geometry types are converted to points using the centroid of the geometry.  The dataset is supplied in the ``data`` parameter.

Optionally, features can be weighted by supplying an weight attribute name using the ``weightAttr`` parameter.  The value of the attribute is used to weight the influence of each point feature.


Output
------

The output of the transformation is a single-band **raster**.  Each pixel has a floating-point value in the range [0..1] measuring the density of the pixel relative to the rest of the surface.  The generated raster can be styled using a raster symbolizer.

.. only:: basic

   In order for the SLD to be correctly validated, the RasterSymbolizer ``<Geometry>`` element must be present to specify the name of the input geometry attribute (using ``<Geometry><ogc:PropertyName>...</ogc:PropertyName></Geometry>``)

.. only:: enterprise

   In order for the YSLD to be correctly validated, the raster symbolizer ``geometry`` element must be present to specify the name of the input geometry attribute (using ``geometry: ${...}``)

.. only:: enterprise

   YSLD Example
   ------------

   The heatmap surface in the map image above is produced by the following YSLD. You can adapt this YSLD example to your data with minimal effort by adjusting the parameters.

   .. code-block:: YAML
      :linenos:
      :emphasize-lines: 6-11,20-24
 
      title: Heatmap
      feature-styles:
      - transform:
          name: gs:Heatmap
          params:
            weightAttr: pop2000
            radiusPixels: 100
            pixelsPerCell: 10
            outputBBOX: ${env('wms_bbox')}
            outputWidth: ${env('wms_width')}
            outputHeight: ${env('wms_height')}
        rules:
        - symbolizers:
          - raster:
              geometry: the_geom
              opacity: 0.6
              color-map:
                type: ramp
                entries:
                - ('#FFFFFF',0,0.0,'nodata')
                - ('#4444FF',0,0.02,'nodata')
                - ('#FF0000',1,0.1,'nodata')
                - ('#FFFF00',1,0.5,'values')
                - ('#FFFF00',1,1.0,'values')

   The YSLD example defines the Heatmap rendering transformation giving values for the transformation parameters which are appropriate for the input dataset.
   Parameter **weightAttr** specifies the dataset attribute which provides a weighting for the input points.
   Parameter **radiusPixels** specifies a kernel density radius of 100 pixels.
   Parameter **pixelsPerCell** defines the resolution of computation to be 10 pixels per cell,
   which provides efficient rendering time while still providing output of reasonable visual quality.
   Parameters **outputBBOX**, **outputWidth**, **outputHeight** define the output parameters, which are
   obtained from internal environment variables set during rendering, as described above.

   The **raster** symbolizer is used to style the raster generated by the transformation.
   Parameter **geometry** defines the geometry property of the input dataset, which is required for validation purposes.
   Parameter **opacity** specifies an overall opacity of 0.6 for the rendered layer.
   Parameter **color-map** define a color map with which to symbolize the output raster.

   The color map uses a **type** of ``ramp``, which produces a smooth transition between colors. The **entries* between 0.0 and 0.02 are displayed with a fully transparent color of white, which makes areas where there no influence from data points invisible.

.. only:: basic

   SLD Example
   -----------

   The heatmap surface in the map image above is produced by the following :download:`heatmap_example.sld <artifact/heatmap_example.sld>`. You can adapt heatmap_example.sld to your data with minimal effort by adjusting the parameters.

   .. literalinclude:: artifact/heatmap_example.sld
      :linenos:
      :emphasize-lines: 17,21,27,32,57,58,59-65,60-61

   In the SLD **lines 14-53** define the Heatmap rendering transformation,
   giving values for the transformation parameters which are appropriate for the input dataset.
   **Line 17** specifies the input dataset parameter name.
   **Line 21** specifies the dataset attribute which provides a weighting for the input points.
   **Line 27** specifies a kernel density radius of 100 pixels.
   **Line 32** defines the resolution of computation to be 10 pixels per cell,
   which provides efficient rendering time while still providing output of reasonable visual quality.
   **Lines 34-52** define the output parameters, which are
   obtained from internal environment variables set during rendering, as described above.

   **Lines 55-66** define the symbolizer used to style the raster computed by the transformation.
   **Line 57** defines the geometry property of the input dataset, which is required for SLD validation purposes.
   **Line 58** specifies an overall opacity of 0.6 for the rendered layer.
   **Lines 59-65** define a color map with which to symbolize the output raster.

   The color map uses a **type** of ``ramp``, which produces a smooth
   transition between colors.
   **Line 60-61** specifies that raster values of 0.02 or less should be displayed with a fully transparent color of white,
   which makes areas where there no influence from data points invisible.




