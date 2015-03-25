.. _cartography.rt.heatmap:

Heatmap
=======

The Heatmap rendering transformation is a **Vector-to-Raster** transformation which displays a dataset as a heatmap surface (also known as a "density surface"). The heatmap surface is generated dynamically, so it can be used to visualize dynamic data. It can be applied to very large datasets with good performance.

The heatmap view is created by configuring a layer with a style which invokes the Heatmap rendering transformation.

.. figure:: img/heatmap_urban_us_east.png

   Heatmap rendering transformation

The map image shows the heatmap transformation, as well as the original input data points (drawn by another style) and a base map layer.

This tutorial will show how to create a dynamic heatmap using rendering transformations.

Usage
-----

As with all rendering transformations, the transformation is invoked by inserting a transform into a style. The style can then be applied to any layer which is backed by a suitable dataset. The dataset may have a weight attribute, whose name is supplied to the process via the ``weightAttr`` process parameter.

The transformation function is called ``gs:Heatmap``. Note that this is the same as the WPS process, as these functions can be invoked as either a WPS process or a rendering transformation.

The transformation parameters are as follows. The order of parameters is not significant.

.. list-table::
   :header-rows: 1
   :class: non-responsive

   * - Name
     - Required?
     - Description
   * - ``data``
     - Yes
     - Input FeatureCollection containing the features to transform.
   * - ``radiusPixels``
     - Yes
     - Radius of the density kernel (in pixels)
   * - ``weightAttr``
     - No
     - Name of the weight attribute (default = 1)
   * - ``pixelsPerCell``
     - No
     - Resolution of the computed grid (default = 1). Larger values improve performance, but may degrade appearance if too large.
   * - ``outputBBOX``
     - Yes
     - Georeferenced bounding box of the output
   * - ``outputWidth``
     - Yes
     - Output image width
   * - ``outputHeight``
     - Yes
     - Output image height

Environment variables as values
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

It is a common situation that the output image dimensions be determined by the client at rendering time, to allow for variable window sizes.

In these cases, it is possible to read in special environment variables to the rendering transformation.

The three environment variables that will be useful to us here are:

* ``wms_bbox``: WMS request extent
* ``wms_width``: Width of resulting image
* ``wms_height``: Height of resulting image

These variables can be used as values respectively for the inputs for the following input parameters for this transformation:

* ``outputBBOX``
* ``outputWidth``
* ``outputHeight``

YSLD syntax for employing environment variables:

.. code-block:: yaml

  outputBBOX: ${env(wms_bbox)}
  outputWidth: ${env(wms_width)}
  outputHeight: ${env(wms_height)}

SLD syntax for employing environment variables:

.. code-block:: xml

  <ogc:Function name="parameter">
    <ogc:Literal>outputBBOX</ogc:Literal>
    <ogc:Function name="env"><ogc:Literal>wms_bbox</ogc:Literal></ogc:Function>
  </ogc:Function>

  <ogc:Function name="parameter">
    <ogc:Literal>outputWidth</ogc:Literal>
    <ogc:Function name="env"><ogc:Literal>wms_width</ogc:Literal></ogc:Function>
  </ogc:Function>

  <ogc:Function name="parameter">
    <ogc:Literal>outputHeight</ogc:Literal>
    <ogc:Function name="env"><ogc:Literal>wms_height</ogc:Literal></ogc:Function>
  </ogc:Function>


Input
-----

The Heatmap rendering transformation is applied to an input dataset containing **vector** features. The features may be of any type, though point geometries are typically expected. If non-point geometries are used, the centroids of the features will be used. The dataset is supplied in the ``data`` parameter.

In addition, features can optionally be weighted by supplying a attribute name in the ``weightAttr`` parameter. The value of the attribute is used to weight the influence of each point feature.

Output
------

The output of the transformation is a single-band **raster**. Each pixel has a floating-point value in the range [0..1] measuring the density of the pixel relative to the rest of the surface. The generated raster can be styled using a standard raster symbolizer.

In order for the style to be correctly validated, the input geometry element must be declared in the raster symbolizer:

YSLD:

.. code-block:: yaml

   geometry: ${...}

SLD:

.. code-block:: xml

   <Geometry>
     <ogc:PropertyName>...</ogc:PropertyName>
   </Geometry>

Examples
--------

The source data used in this example is the ``world_cities`` layer (available in the :file:`world.zip` file on the :ref:`intro.sampledata` page).

Below are two examples showing how to perform this rendering transformation in both :ref:`YSLD <cartography.ysld>` and SLD.

YSLD
^^^^

The heatmap surface, as seen in the image above, can be produced by the following YSLD:

.. literalinclude:: artifact/heatmap_example.ysld
   :linenos:
   :emphasize-lines: 6-11,20-24
 
This example defines the heatmap rendering transformation giving values for the transformation parameters which are appropriate for the input dataset.

* Parameter **weightAttr** specifies the dataset attribute which provides a weighting for the input points.
* Parameter **radiusPixels** specifies a kernel density radius of 100 pixels.
* Parameter **pixelsPerCell** defines the resolution of computation to be 10 pixels per cell, which provides efficient rendering time while still providing output of reasonable visual quality.
* Parameters **outputBBOX**, **outputWidth**, and **outputHeight** define the output parameters, which are obtained from internal environment variables set during rendering, as described above.

The **raster** symbolizer is used to style the raster generated by the transformation.

* Parameter **geometry** defines the geometry property of the input dataset, which is required for validation purposes.
* Parameter **opacity** specifies an overall opacity of 0.6 for the rendered layer.
* Parameter **color-map** defines a color map with which to symbolize the output raster. The color map uses a **type** of ``ramp``, which produces a smooth transition between colors. The **entries** between 0.0 and 0.02 are displayed with a fully transparent color of white, which makes areas where there no influence from data points invisible.

You can adapt this example to your data with minimal effort by adjusting the parameters.

.. note:: :download:`Download the YSLD for this example <artifact/heatmap_example.ysld>`

SLD
^^^

The heatmap surface, as seen in the image above, can be produced by the following SLD:

   .. literalinclude:: artifact/heatmap_example.sld
      :linenos:
      :emphasize-lines: 17,21,27,32,57,58,59-65,60-61

In the SLD **lines 14-53** define the Heatmap rendering transformation, giving values for the transformation parameters which are appropriate for the input dataset.

* **Line 17** specifies the input dataset parameter name.
* **Line 21** specifies the dataset attribute which provides a weighting for the input points.
* **Line 27** specifies a kernel density radius of 100 pixels.
* **Line 32** defines the resolution of computation to be 10 pixels per cell, which provides efficient rendering time while still providing output of reasonable visual quality.
* **Lines 34-52** define the output parameters, which are obtained from internal environment variables set during rendering, as described above.
* **Lines 55-66** define the symbolizer used to style the raster computed by the transformation.
* **Line 57** defines the geometry property of the input dataset, which is required for SLD validation purposes.
* **Line 58** specifies an overall opacity of 0.6 for the rendered layer.
* **Lines 59-65** define a color map with which to symbolize the output raster. The color map uses a **type** of ``ramp``, which produces a smooth transition between colors. **Lines 60-61** specify that raster values of between 0 and 0.02 should be displayed with a fully transparent color of white, which makes areas where there no influence from data points invisible.

You can adapt this example to your data with minimal effort by adjusting the parameters.

.. note:: :download:`Download the SLD for this example <artifact/heatmap_example.sld>`

