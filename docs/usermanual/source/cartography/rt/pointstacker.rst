.. _cartography.rt.pointstacker:

Point Stacker
=============

The Point Stacker rendering transformation is a **Vector-to-Vector** transformation which displays a dataset of points with those points that occur close together aggregated into a single point. This produces a more readable map in situations when there are many close points to display. As the stacking is performed dynamically, it can be used to visualize changing data, and does not incur a performance overhead even when applied to very large datasets.

The stacked view is created by configuring a layer with an style which invokes the PointStacker rendering transformation.

.. figure:: img/pointstacker-volcanoes.png

   *Point Stacker rendering transformation*

Usage
-----

As with all rendering transformations, the transformation is invoked by adding a transform element to a feature type style. The style can then be applied to any layer which is backed by a suitable dataset (featuretype).

.. only:: basic

   The transformation is specified with a ``<ogc:Function name="gs:PointStacker">`` element, with arguments which supply the transformation parameters.

   The transformation parameters are as follows. The order of parameters is not significant.

   .. tabularcolumns:: |p{3cm}|p{1.5cm}|p{10.5cm}|
   .. list-table::
      :widths: 25 10 65
      :header-rows: 1

      * - Name
        - Required?
        - Description
      * - ``data``
        - Yes
        - Input FeatureCollection containing the features to map
      * - ``cellSize``
        - No
        - Size of the cells in which to aggregate points (in pixels)   Default = 1
      * - ``outputBBOX``
        - Yes
        - Georeferenced bounding box of the output
      * - ``outputWidth``
        - Yes
        - Output image width
      * - ``outputHeight``
        - Yes
        - Output image height

   The arguments are specified using the special function ``<ogc:Function name='parameter'>``. Each function accepts the following arguments:

      * an ``<ogc:Literal>`` giving the name of the parameter
      * one or more literals containing the value(s) of the parameter

.. only:: enterprise

   The transformation is specified with the function ``gs:PointStacker`` element, with arguments which supply the transformation parameters.

   The transformation parameters are as follows. The order of parameters is not significant.

   .. tabularcolumns:: |p{3cm}|p{1.5cm}|p{10.5cm}|
   .. list-table::
      :widths: 25 10 65
      :header-rows: 1

      * - Name
        - Required?
        - Description
      * - ``cellSize``
        - No
        - Size of the cells in which to aggregate points (in pixels)   Default = 1
      * - ``outputBBOX``
        - Yes
        - Georeferenced bounding box of the output
      * - ``outputWidth``
        - Yes
        - Output image width
      * - ``outputHeight``
        - Yes
        - Output image height

The transformation has required parameters which specify the input data extent and the output image dimensions. The values of these parameters are obtained from environment variables accessed via the function ``env``. The environment variable values are determined from the WMS request which initiated the rendering process. The parameters and corresponding environment variables are:


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

The PointStacker rendering transformation can be applied to datasets containing features with **vector** geometry. The geometry may be of any type. Point geometries are used directly, while non-point geometry types are converted to points using the centroid of the geometry. The dataset is supplied in the ``data`` parameter.


Output
------

The output of the transformation is a **vector** featuretype containing point features. Each feature has the following attributes:

.. tabularcolumns:: |p{4cm}|p{1.5cm}|p{9.5cm}|
.. list-table::
   :widths: 20 15 65
   :header-rows: 1

   * - Name
     - Type
     - Description
   * - ``geom``
     - Point
     - Point geometry representing the group of input features
   * - ``count``
     - Integer
     - Count of all input features represented by this point
   * - ``countUnique``
     - Integer
     - Count of all different input points represented by this point


The output can be styled as required using a ``<PointSymbolizer>``.

.. only:: basic
   
   SLD Example
   -----------
   
   The map image above shows point stacking applied to a dataset of world volcanoes, displayed with a base map layer of continental topography. The stacked points are symbolized using appropriate icons and labels, configured with the following SLD. You can modify the parameters in this SLD to adapt it for your data.

   .. literalinclude:: artifact/pointstacker_example.sld
      :linenos:
      :emphasize-lines: 18,21,25,31,37,45,66,121
      
   In this SLD **lines 15-43** define the Point Stacker rendering transformation,
   providing values for the transformation parameters which are appropriate for the input dataset. **Line 18 data** specifies the input dataset parameter name. **Line 21 cellSize** specifies a cell size of 30 to aggregate the points by. **Lines 24-42** define the output parameters **outputBBOX**, **outputWith** and **outputHeight**, which are obtained from internal environment variables set during rendering, as described above.

   **Lines 44-169** define styling rules which are applied to the transformation
   output to produce the rendered layer. **Lines 44-64** define a rule **rule1** for depicting a single (unstacked) point using a red triangle symbol. **Lines 65-119** define a rule **rule29** for depicting a stacked point which has a count in the range 2 to 9. The points are styled as dark red circles of size 14 pixels, with a label showing the count inside them. **Lines 120-169** define a rule **rule10** for depicting a stacked point which has a count of 10 or greater. The points are styled as dark red circles of size 22 pixels, with a label that includes the point count.
   
.. only:: enterprise 

   Example
   -------

   The map image above shows point stacking applied to a dataset of world volcanoes, displayed with a base map layer of continental topography. The stacked points are symbolized using appropriate icons and labels, configured with the following style. You can modify the parameters in this style to adapt it for your data.

   .. code-block:: yaml
      :linenos:
      :emphasize-lines: 9-12,14,24,48

      name: Default Styler
      title: Stacked Point
      abstract: Styles volcanoes using stacked points
      feature-styles:
      - name: name
        transform:
          name: gs:PointStacker
          params:
            cellSize: 30
            outputBBOX: env('wms_bbox')
            outputWidth: env('wms_width')
            outputHeight: env('wms_height')
          rules:
          - name: rule1
            title: Volcano
            filter: count <= '1'
            symbolizers:
            - point:
                size: 8
                symbols:
                - mark:
                    shape: triangle
                    fill-color: FF0000
          - name: rule29
            title: 2-9 Volcanoes
            filter: count BETWEEN '2' AND '9'
            symbolizers:
            - point:
                size: 14
                symbols:
                - mark:
                    shape: circle
                    fill-color: AA0000
            - text:
                label: count
                fill-color: FFFFFF
                halo:
                  fill-color: AA0000
                  fill-opacity: 0.9
                  radius: 2
                font-family: Arial
                font-size: 12
                font-style: normal
                font-weight: bold
                placement:
                  type: point
                  anchor: (0.5,0.8)
          - name: rule10
            title: 10 Volcanoes
            filter: count > '9'
            symbolizers:
            - point:
                size: 22
                symbols:
                - mark:
                    shape: circle
                    fill-color: AA0000
            - text:
                label: count
                fill-color: FFFFFF
                halo:
                  fill-color: AA0000
                  fill-opacity: 0.9
                  radius: 2
                font-family: Arial
                font-size: 12
                font-style: normal
                font-weight: bold
                placement:
                  type: point
                  anchor: (0.5,0.8)


   This style defines the Point Stacker rendering transformation,
   providing values for the transformation parameters which are appropriate for the input dataset. Parameter **cellSize** specifies a cell size of 30 to aggregate the points by. The output parameters **outputBBOX**, **outputWith** and **outputHeight**, are obtained from internal environment variables set during rendering, as described above.

   Rules are applied to the transformation output to produce the rendered layer.Rule **rule1** depicts a single (unstacked) point using a red triangle symbol. Rule **rule29** depicts a stacked point which has a count in the range 2 to 9. The points are styled as dark red circles of size 14 pixels, with a label showing the count inside them. The rule **rule10** depicts a stacked point which has a count of 10 or greater. The points are styled as dark red circles of size 22 pixels, with a label that includes the point count.

