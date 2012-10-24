.. _builtindemos:

.. warning:: Document Status: **Ready for copyedit review**

Built-In Demos
==============

The OpenGeo Suite comes with some preloaded sample map layers that may be viewed and restyled as required.
 
Medford
-------

The city of Medford, in the US state of Oregon, has generously shared some of their municipal data. The following layers are available with the OpenGeo Suite.

.. list-table::
   :widths: 10 20 10 10
   :header-rows: 1
   
   * - Layer Name
     - Abstract
     - Last Update
     - Type
   * - :guilabel:`bikelanes`
     - Bike lanes in Jackson County
     - Dec 2008
     - MultiLineString
   * - :guilabel:`buildings`
     - Building outlines for Medford
     - Mar 2009
     - MultiPolygon
   * - :guilabel:`citylimits`
     - Local jurisdiction of Medford
     - Jul 2009
     - MultiPolygon
   * - :guilabel:`firestations`       
     - Location of fire stations in Jackson County
     - Apr 2009 
     - Point
   * - :guilabel:`hospitals`     
     - Location of hospitals in Jackson County
     - Oct 2006 
     - Point
   * - :guilabel:`hydro`   
     - US Fish & Wildlife National Wetlands Inventory of wetland linear features
     - Oct 2000
     - MultiLineString
   * - :guilabel:`libraries`     
     - Location of libraries in Jackson County
     - Aug 2006  
     - Point
   * - :guilabel:`parks`         
     - Open parks within Medford
     - Unknown
     - MultiPolygon
   * - :guilabel:`police`       
     - Location of police stations in Jackson County
     - Apr 2009
     - Point
   * - :guilabel:`schools`       
     - Location of Jackson County schools
     - Mar 2009
     - Point
   * - :guilabel:`stormdrains`        
     - Storm drains within Medford
     - Unknown
     - MultiLineString 
   * - :guilabel:`streets`  
     - All public streets within Jackson County  
     - Sept 2009 
     - MultiLineString 
   * - :guilabel:`wetlands`             
     - US Fish & Wildlife National Wetlands Inventory of Jackson County
     - Oct 2009 
     - MultiPolygon
   * - :guilabel:`zoning`             
     - City Zones from the Jackson County City Planning    
     - Apr 2008
     - MultiPolygon 
   * - :guilabel:`taxlots`             
     -    
     - 
     - MultiPolygon
   * - :guilabel:`elevation`             
     - 50 Meters USGS 30 Meter Digital Elevation Model color shaded relief of Medford                
     - Jan 2001 
     - GeoTIFF

   
.. note:: All datasets have a declared :term:`SRS` (the projection GeoServer publishes the layer with) of EPSG:4326 and bounding boxes within the range ``-122.904, 42.231, -123.042, 42.438``. The data is available in the public domain.

You can use GeoExplorer to view the sample layers. To open GeoExplorer, click :guilabel:`Launch` next to  :guilabel:`GeoExplorer` on the OpenGeo Suite Dashboard. For more information on adding layers to GeoExplorer, see the :ref:`webmaps.basic` tutorial or the GeoExplorer `reference documentation <../geoexplorer/>`_.

.. figure:: img/medford.png

   *Zoning data for Medford as seen through GeoExplorer*


Base Map
--------

Also included is the MapQuest OpenStreetMap base map, a general map of the world. This layer is available by default when GeoExplorer is started. Select :guilabel:`GeoExplorer` from the Dashboard to view this base map.


