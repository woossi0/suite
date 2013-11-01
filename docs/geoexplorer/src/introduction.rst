.. _geoexplorer.introduction:


Introduction
============

This section provides a brief introduction to GeoExplorer. 

#. To launch GeoExplorer, locate the GeoExplorer component on the OpenGeo Suite Dashboard, and click the :guilabel:`Launch` link. 

   The GeoExplorer web application is usually available at ``http://localhost:8080/geoexplorer/composer``, although your local setup may differ.

   .. figure:: images/geoexplorer.png
   
      *GeoExplorer*

.. |addlayer| image:: images/button_addlayer.png
              :align: bottom

#. To add a new layer to the :guilabel:`Map Window`, click :guilabel:`Add Layers` |addlayer| on the :ref:`geoexplorer.workspace.layerspanel` toolbar and click :guilabel:`Add layers` to open the :guilabel:`Available Layers` panel.
    
   .. figure:: using/images/panel_availablelayers.png
       
      *Available layers*
    
#. In the :guilabel:`Available Layers` panel, click the layer you want to add to your map and click :guilabel:`Add layers` at the bottom of the :guilabel:`Available Layers` panel. 

   .. note:: To add multiple layers, hold down Ctrl while you click all the layers you want to add.

   .. figure:: using/images/panel_availablelayers.png
       
      *Adding layers to GeoExplorer*

   .. note:: You can also add a new layer by double-clicking a layer in the :guilabel:`Available Layers` panel.

#. To add a new :term:`WMS` server, in the :guilabel:`View available data from` list, click :guilabel:`Add A New Server`.
    
   .. figure:: using/images/add_newserver.png
   
      *Adding a new WMS server*

   An example of a WMS URL is: ``http://sampleserver1.arcgisonline.com/arcgis/services/Specialty/ESRI_StateCityHighway_USA/
   MapServer/WMSServer``
   
   .. figure:: using/images/add_newserver_addr.png
   
      *Adding the URL for a new WMS server*


#. Once you've added the URL for the new WMS server, click the :guilabel:`Add Server` button.

#. Click the :guilabel:`Done` button to return to the :ref:`geoexplorer.workspace.layerspanel`.
       
#. To rearrange the layers in your map, click and drag a layer up or down the list of layers in the :ref:`geoexplorer.workspace.layerspanel`.
    
   .. figure:: images/workspace_draglayers.png
   
      *Ordering layers*
       
#. You can also generate a map application, and the HTML code to embed into a web page, based on the layers in your :guilabel:`Map Window`. On the :guilabel:`GeoExplorer` toolbar, click :guilabel:`Map` and then click :guilabel:`Publish map` to open the :ref:`geoexplorer.using.publish` dialog box.

   .. figure:: using/images/button_publish.png
      
      *Publish map tool*


#. In the :guilabel:`Publish map` dialog box, select the map tools you want to include in your map application.

   .. figure:: using/images/dialog_publish_tools.png

      *Selecting the map tools*

#. Click :guilabel:`Preview` to create a preview of your map application.

   .. figure:: using/images/map_preview.png

      *Previewing a map*

#. Click :guilabel:`Next` to generate the HTML code.

   .. figure:: using/images/dialog_publish_html.png

      *Generating HTML code*


#. Copy and paste the HTML code into your own web page to view your map application.

For more information on working with GeoExplorer, please refer to :ref:`geoexplorer.using`.
