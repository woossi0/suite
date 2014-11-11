Extensions
==========

Extensions are distributed as individual :file:`zip` files which can be unpacked into your GeoServer :file:`libs` folder.

Using the WPS extension as an example:

#. Locate your application server :file:`webapps` folder and navigate to :file:`webapps\geoserver\WEB-INF\libs`.

#. Unzip the :file:`opengeo-extension.zip` and locate the :file"`wps` folder.
   
   At the time of writing the wps-extension consisted of the following files.

   * gs-web-wps-2.6-SNAPSHOT.jar
   * gs-wps-core-2.6-SNAPSHOT.jar
   * gt-process-geometry-12-SNAPSHOT.jar
   * gt-xsd-wps-12-SNAPSHOT.jar
   * net.opengis.wps-12-SNAPSHOT.jar
   * serializer-2.7.1.jar
   
#. Copy these :file:`jar` files into the :file:`webapps\geoserver\WEB-INF\libs` directory.
   
   Windows: You may be warned when replacing files that are already present. This is expected as several extensions make use of the same :file:`jar` files resulting in duplication.
  
#. Restart GeoServer.

   * Restart your application server; or
   * From the application manager console you reload :guilabel:`geoserver`.
      
     .. figure:: img/reload.png
        
        Application Manager: Reload GeoServer

#. From the GeoServer Admin welcome page confirm that :guilabel:`WPS 1.0` is listed as a :guilabel:`Service Capability`.
      
     .. figure:: img/wps.png
        
        GeoServer WPS Service Capability