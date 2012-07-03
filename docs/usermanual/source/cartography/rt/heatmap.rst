.. _cartography.rt.heatmap:


Heatmap
=======

The Heatmap rendering transformation is a **Vector-to-Raster** transformation which displays a dataset as a heatmap surface (also known as a "density surface").  The heatmap surface is generated dynamically, so it can be used to visualize dynamic data.  It can be applied to very large datasets with good performance.

The heatmap view is created by configuring a layer with an SLD style which invokes the Heatmap rendering transformation.  

.. figure:: img/heatmap_urban_us_east.png

   *Heatmap rendering transformation*

Usage
-----

As with all rendering transformations, the transformation is invoked by adding a ``<Transformation>`` element to a ``<FeatureTypeStyle>`` in an SLD style. The SLD can then be applied to any layer which is backed by a suitable dataset (featuretype).  The dataset may have a weight attribute, whose name is supplied to the process via the ``weightAttr`` process parameter.

The transformation is specified with a ``<ogc:Function name="gs:Heatmap">`` element, with arguments which supply the transformation parameters.   
The arguments are specified using the special function ``<ogc:Function name='parameter'>``.  Each function has as arguments:

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


The transformation has required parameters which specify the input data extent and the output image dimensions.  The values of these parameters are obtained from environment variables accessed via the function ``<ogc:Function name="env">``.  The environment variable values are determined from the WMS request which initiated the rendering process.  The parameters and corresponding environment variables are:

* ``outputBBOX`` uses variable ``wms_bbox`` to obtain the surface extent
* ``outputWidth`` uses variable ``wms_width`` to obtain the output raster width
* ``outputHeight`` uses variable ``wms_height`` to obtain the output raster height

Input
-----

The Heatmap rendering transformation is applied to an input dataset containing features with **vector** geometry.  The geometry may be of any type.  Point geometries are used directly, while non-point geometry types are converted to points using the centroid of the geometry.  The dataset is supplied in the ``data`` parameter.

Optionally, features can be weighted by supplying an weight attribute name using the ``weightAttr`` parameter.  The value of the attribute is used to weight the influence of each point feature.  


Output 
------

The output of the transformation is a single-band **raster**.  Each pixel has a floating-point value in the range [0..1] measuring the density of the pixel relative to the rest of the surface.  The raster can be styled using a ``<RasterSymbolizer>``.

In order for the SLD to be correctly validated, the RasterSymbolizer ``<Geometry>`` element must be present to specify the name of the input geometry attribute (using ``<Geometry><ogc:PropertyName>...</ogc:PropertyName></Geometry>``)

Example
-------

The heatmap surface in the map image above is produced by the following SLD.  (The map image also shows the original input data points styled by another SLD, as well as a base map layer.)  You can adapt this SLD to your data with minimal effort by adjusting the parameters.

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
          <Name>Heatmap</Name>
          <UserStyle>
            <Title>Heatmap</Title>
            <Abstract>A heatmap surface showing population density</Abstract>
            <FeatureTypeStyle>
              <Transformation>
                <ogc:Function name="gs:Heatmap">
                  <ogc:Function name="parameter">
                    <ogc:Literal>data</ogc:Literal>
                  </ogc:Function>
                  <ogc:Function name="parameter">
                    <ogc:Literal>weightAttr</ogc:Literal>
                    <ogc:Literal>pop2000</ogc:Literal>
                  </ogc:Function>
                  <ogc:Function name="parameter">
                    <ogc:Literal>radiusPixels</ogc:Literal>
                    <ogc:Function name="env">
                      <ogc:Literal>radius</ogc:Literal>
                      <ogc:Literal>100</ogc:Literal>
                    </ogc:Function>
                  </ogc:Function>
                  <ogc:Function name="parameter">
                    <ogc:Literal>pixelsPerCell</ogc:Literal>
                    <ogc:Literal>10</ogc:Literal>
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
               <RasterSymbolizer>
               <!-- specify geometry attribute of input to pass validation -->
                 <Geometry><ogc:PropertyName>the_geom</ogc:PropertyName></Geometry>
                 <Opacity>0.6</Opacity>
                 <ColorMap type="ramp" >
                   <ColorMapEntry color="#FFFFFF" quantity="0" label="nodata" opacity="0"/>
                   <ColorMapEntry color="#FFFFFF" quantity="0.02" label="nodata" opacity="0"/>
                   <ColorMapEntry color="#4444FF" quantity=".1" label="nodata"/>
                   <ColorMapEntry color="#FF0000" quantity=".5" label="values" />
                   <ColorMapEntry color="#FFFF00" quantity="1.0" label="values" />
                 </ColorMap>
               </RasterSymbolizer>
              </Rule>
            </FeatureTypeStyle>
          </UserStyle>
        </NamedLayer>
       </StyledLayerDescriptor>

