.. _processing.contour.dynamic:

Creating a dynamic contour map
==============================

The same contour map can be created dynamically with SLD and :ref:`cartography.rt`. The goal is to apply a style to the raster layer such that the contour lines are generated directly, without the need to create a separate vector layer.

Design
------

The data has already been loaded, so all that needs to be done is to craft a style for the raster layer that employs a rendering transformation. The style created in the :ref:`previous section <processing.contour.static>` can be used here.

Adding a rendering transformation is done with the ``<Transformation>`` tag. The transformation name is ``gs:Contour``, the name of the WPS process. From there, the other arguments to the process are supplied exactly as was done through the WPS Request Builder, except that no output format is required.

.. list-table::
   :header-rows: 1

   * - Field
     - Value
     - Example
   * - data
     - Name of the raster layer or the source of the data
     - ``opengeo:rainier``
   * - band
     - Name of the band used for the contour values
     - ``GRAY_INDEX``
   * - interval
     - Interval between contour lines
     - ``100``
   * - simplify
     - Whether to reduce the vertices in the output
     - ``true``

Add this to the SLD, and then the style can be applied directly to the raster layer.

.. literalinclude:: contour.sld
   :language: xml
   :lines: 14-28

Here is the full SLD, including the rendering transformation:

.. literalinclude:: contour.sld
   :language: xml

Viewing
-------

The process for applying this SLD is the same as in the :ref:`previous section <processing.contour.static>`

Load the SLD into GeoServer via the :guilabel:`Styles` menu and selecting :guilabel:`Add new style`. Once that is done, associate this style with the original layer by going to the :guilabel:`Layers` menu, clicking on the layer name (*the original raster layer* this time), clicking on the :guilabel:`Publishing` tab, and selecting the style from the drop-down menu called :guilabel:`Default style`. Click :guilabel:`Save` when done.

Once these changes are saved, go to the :guilabel:`Layer Preview` and view the layer. You can also view the layer in GeoExplorer.

.. figure:: img/dynamic_geoexplorer.png

   *Dynamic contour map displayed in GeoExplorer*

This map looks identical to the statically generated one. The advantage here is that a secondary vector layer was never created. This map is generated dynamically based on the source raster data, the built-in contour process, and styling.

:download:`Download <contour.sld>` the SLD used in this tutorial.

