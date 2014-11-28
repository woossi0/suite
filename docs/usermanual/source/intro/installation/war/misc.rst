.. _intro.installation.war.misc:

Working with OpenGeo Suite Web Archives
=======================================

Working with JNDI
-----------------

Applications such as GeoServer are in position to work with database connection pools set up by your application server.

* Remove JDBC Driver from geoserver/WEB-INF/lib folder and copy to application server.
* Register the connection pool with your application server Java Naming and Directory Interface (JNDI)
* When adding a the Vector Store in GeoServer select the JNDI option. Fill in the **jndiReferenceName** used by the application server

For more information see the GeoServer users manual.

Working with GeoServer
----------------------

Compatibility Settings
^^^^^^^^^^^^^^^^^^^^^^

To adjust GeoServer compatibility settings:

#. A fix is available for spatial reference systems measured in imperial units. This setting is recommended for all users, and strongly recommended for those working with US State Plane projections measured in feet.
   
   To enable this fix add the following system property to your application server::
   
     org.geotoools.render.lite.scale.unitCompensation=true
   
#. GeoServer GeoJSON output from WFS and WMS is now provided in x/y/z order as required by the specification.

   In addition GeoJSON crs information is now supported:
   
   .. code-block:: json

      "crs": {
         "type": "name",
         "properties": {
            "name": "urn:ogc:def:crs:EPSG::4326"
         }
      }
   
   .. warning:: Clients such as OL3 may need additional configuration to support this longer URN representation.
   
   .. note:: To restore the previous ``crs`` representation add the following context parameter to  :file:`/usr/share/opengeo/geoserver/WEB-INF/web.xml`:

      .. code-block:: xml
      
          <context-param>
              <param-name>GEOSERVER_GEOJSON_LEGACY_CRS</param-name>
              <param-value>true</param-value>
          </context-param>

      Previous representation:
   
      .. code-block:: json
   
         "crs": {
            "type": "EPSG",
            "properties": {
               "code": "4326"
            }
         }

#. Restart your Application Server for these changes to take effect