.. _cartography.rt.pointstacker:


Point Stacker
=============

The Point Stacker rendering transformation is a **Vector-to-Vector** transformation which displays a data set of points with nearby points aggregated together.  This can produce a much more readable map in situations when there are many points displayed at once.  The stacking is performed dynamically, so it can be used to visualize changing data.  It can also be applied to very large datasets with good performance.

The stacked view is created by configuring a layer with an SLD style which invokes the PointStacker rendering transformation.  

.. figure:: img/pointstacker-volcanoes.png

   *Point Stacker rendering transformation*

Usage
-----

As with all rendering transformations, the transformation is invoked by adding a ``<Transformation>`` element to a ``<FeatureTypeStyle>`` in an SLD style. The SLD can then be applied to any layer which is backed by a suitable dataset (featuretype).

The transformation is specified with a ``<ogc:Function name="gs:PointStacker">`` element, with arguments which supply the transformation parameters.  The arguments are specified using the special function ``<ogc:Function name='parameter'>``.  Each function has as arguments:

* an ``<ogc:Literal>`` giving the name of the parameter
* one or more literals containing the value(s) of the parameter. 

The transformation parameters are as follows.  The order of parameters is not significant.

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

The transformation has required parameters which specify the input data extent and the output image dimensions.  The values of these parameters are obtained from environment variables accessed via the function ``<ogc:Function name="env">``.  The environment variable values are determined from the WMS request which initiated the rendering process.  The parameters and corresponding environment variables are:

* ``outputBBOX`` uses variable ``wms_bbox`` to obtain the surface extent
* ``outputWidth`` uses variable ``wms_width`` to obtain the output raster width
* ``outputHeight`` uses variable ``wms_height`` to obtain the output raster height

Input
-----

The PointStacker rendering transformation can be applied to datasets containing features with **vector** geometry.  The geometry may be of any type.  Point geometries are used directly, while non-point geometry types are converted to points using the centroid of the geometry.  The dataset is supplied in the ``data`` parameter.

.. note::

   Due to a bug in the current release of the RenderingTransformation functionality, the input dataset must contains attributes with the names ``count`` and ``countUnique``.  The contents of the fields is not significant.
   
    * If the input is a file store, the file must be altered to contain columns with these names.
    * If the input is a database store, one way to provide the required columns is to define a SQL View with a query which includes extra columns with dummy values.   


Output 
------

The output of the transformation is a **vector** featuretype containing point features.  Each feature has the following attributes:

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


The output can be styled as desired using a standard ``<PointSymbolizer>``.  

Example
-------

The map image above shows point stacking applied to a dataset of world volcanoes.    (The map image also shows a base map layer.)  The stacked points are symbolized by appropriate icons and labels.  It is produced by the following SLD.  You can adapt this SLD to your data with minimal effort by adjusting the parameters.


.. code-block:: xml
   :linenos:
   
     <?xml version="1.0" encoding="ISO-8859-1"?>
     <StyledLayerDescriptor version="1.0.0" 
      xsi:schemaLocation="http://www.opengis.net/sld StyledLayerDescriptor.xsd" 
      xmlns="http://www.opengis.net/sld" 
      xmlns:ogc="http://www.opengis.net/ogc" 
      xmlns:xlink="http://www.w3.org/1999/xlink" 
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
       <NamedLayer>
         <Name>vol_stacked_point</Name>
         <UserStyle>
         <!-- Styles can have names, titles and abstracts -->
           <Title>Stacked Point</Title>
           <Abstract>Volcanoes using stacked points</Abstract>
           <FeatureTypeStyle>
          <Transformation>
            <ogc:Function name="gs:PointStacker">
              <ogc:Function name="parameter">
                <ogc:Literal>data</ogc:Literal>
              </ogc:Function>
              <ogc:Function name="parameter">
                <ogc:Literal>cellSize</ogc:Literal>
                <ogc:Literal>30</ogc:Literal>
              </ogc:Function>
              <ogc:Function name="parameter">
                <ogc:Literal>outputBBOX</ogc:Literal>
                <ogc:Function name="env">
               <ogc:Literal>wms_bbox</ogc:Literal>
                </ogc:Function>
              </ogc:Function>
              <ogc:Function name="parameter">
                <ogc:Literal>outputWidth</ogc:Literal>
                <ogc:Function name="env">
               <ogc:Literal>wms_width</ogc:Literal>
                </ogc:Function>
              </ogc:Function>
              <ogc:Function name="parameter">
                <ogc:Literal>outputHeight</ogc:Literal>
                <ogc:Function name="env">
               <ogc:Literal>wms_height</ogc:Literal>
                </ogc:Function>
              </ogc:Function>
            </ogc:Function>
          </Transformation>
          <Rule>
            <Name>rule1</Name>
            <Title>Volcano</Title>
            <ogc:Filter>
           <ogc:PropertyIsLessThanOrEqualTo>
             <ogc:PropertyName>count</ogc:PropertyName>
             <ogc:Literal>1</ogc:Literal>
           </ogc:PropertyIsLessThanOrEqualTo>
            </ogc:Filter>
              <PointSymbolizer>
                <Graphic>
               <Mark>
                 <WellKnownName>triangle</WellKnownName>
                 <Fill>
                   <CssParameter name="fill">#FF0000</CssParameter>
                 </Fill>
               </Mark>
                <Size>8</Size>
              </Graphic>
            </PointSymbolizer>
          </Rule>
          <Rule>
            <Name>rule29</Name>
            <Title>2-9 Volcanoes</Title>
            <ogc:Filter>
           <ogc:PropertyIsBetween>
            <ogc:PropertyName>count</ogc:PropertyName>
            <ogc:LowerBoundary>
             <ogc:Literal>2</ogc:Literal>
            </ogc:LowerBoundary>
            <ogc:UpperBoundary>
             <ogc:Literal>9</ogc:Literal>
            </ogc:UpperBoundary>
           </ogc:PropertyIsBetween>
            </ogc:Filter>
              <PointSymbolizer>
                <Graphic>
               <Mark>
                 <WellKnownName>circle</WellKnownName>
                 <Fill>
                   <CssParameter name="fill">#AA0000</CssParameter>
                 </Fill>
               </Mark>
                <Size>14</Size>
              </Graphic>
            </PointSymbolizer>
            <TextSymbolizer>
              <Label>
               <ogc:PropertyName>count</ogc:PropertyName>
              </Label>
              <Font>
                <CssParameter name="font-family">Arial</CssParameter>
                <CssParameter name="font-size">12</CssParameter>
                <CssParameter name="font-weight">bold</CssParameter>
              </Font> 
              <LabelPlacement>
                <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.8</AnchorPointY>
                </AnchorPoint>
                 </PointPlacement>
              </LabelPlacement>
              <Stroke>
                <CssParameter name="stroke">#FFFFFF</CssParameter>
              </Stroke>
             <Halo>
                <Radius>2</Radius>
                <Fill> 
               <CssParameter name="fill">#AA0000</CssParameter> 
               <CssParameter name="fill-opacity">0.9</CssParameter> 
                </Fill> 
            </Halo>
            <Fill>
              <CssParameter name="fill">#FFFFFF</CssParameter>
              <CssParameter name="fill-opacity">1.0</CssParameter>
            </Fill>
            </TextSymbolizer>
          </Rule>
          <Rule>
            <Name>rule10</Name>
            <Title>> 10 Volcanoes</Title>
            <ogc:Filter>
           <ogc:PropertyIsGreaterThan>
             <ogc:PropertyName>count</ogc:PropertyName>
             <ogc:Literal>9</ogc:Literal>
           </ogc:PropertyIsGreaterThan>
            </ogc:Filter>
              <PointSymbolizer>
                <Graphic>
               <Mark>
                 <WellKnownName>circle</WellKnownName>
                 <Fill>
                   <CssParameter name="fill">#AA0000</CssParameter>
                 </Fill>
               </Mark>
                <Size>22</Size>
              </Graphic>
            </PointSymbolizer>
            <TextSymbolizer>
              <Label>
               <ogc:PropertyName>count</ogc:PropertyName>
              </Label>
              <Font>
                <CssParameter name="font-family">Arial</CssParameter>
                <CssParameter name="font-size">12</CssParameter>
                <CssParameter name="font-weight">bold</CssParameter>
              </Font> 
              <LabelPlacement>
                <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.8</AnchorPointY>
                </AnchorPoint>
                 </PointPlacement>
              </LabelPlacement>
              <Stroke>
                <CssParameter name="stroke">#ffffff</CssParameter>
              </Stroke>
             <Halo>
                <Radius>2</Radius>
                <Fill> 
               <CssParameter name="fill">#AA0000</CssParameter> 
               <CssParameter name="fill-opacity">0.9</CssParameter> 
                </Fill> 
            </Halo>
            <Fill>
              <CssParameter name="fill">#FFFFFF</CssParameter>
              <CssParameter name="fill-opacity">1.0</CssParameter>
            </Fill>
            </TextSymbolizer>
          </Rule>
           </FeatureTypeStyle>
         </UserStyle>
       </NamedLayer>
     </StyledLayerDescriptor>

