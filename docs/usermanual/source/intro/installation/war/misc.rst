.. _intro.installation.war.misc:

Working with OpenGeo Suite Web Archives
=======================================

Working with JNDI
-----------------

Applications such as GeoServer are in position to work with database connection pools set up by your application server. The Java Naming and Directory Interface (JNDI) can be used to create a connection pool for a JDBC data source. The instructions to set up a JNDI connection pool in Tomcat, using a PostgreSQL data source follow: 

#. Copy the JDBC Driver for your database to :file:`TOMCAT_HOME/lib`. The JDBC driver can often be found on the website of your DBMS provider, or in the installed version of your database. 

   The PostgreSQL JDBC Driver can be found at the `PostgreSQL web site <http://jdbc.postgresql.org/>`_ or in the :file:`geoserver/WEB-INF/lib` directory.

#. Remove the JDBC Driver from the :file:`geoserver/WEB-INF/lib` folder. It should be named :file:`postgresql-X.X-XXX.jdbc3.jar`. 

#. Register the connection pool with the Tomcat Java Naming and Directory Interface (JNDI). This is done by adding a ``<Resource\>`` entry to the :file:`TOMCAT_HOME/conf/context.xml` configuration file. For more information about the possible parameters and their values refer to the `DBCP documentation <http://commons.apache.org/dbcp/configuration.html>`_. 
   
   For a PosgreSQL database named ``test``, with a username and password of ``admin`` the configuration is:

   .. code-block:: xml

      <Context>
       ...
        <Resource name="jdbc/postgres" auth="Container" type="javax.sql.DataSource"
                  driverClassName="org.postgresql.Driver"
                  url="jdbc:postgresql://localhost:5432/test"
                  username="admin" password="admin"
                  maxActive="20" maxIdle="10" maxWait="-1"/>
      </Context>

#. When adding a the Vector Store in GeoServer select the JNDI option. Fill in the **jndiReferenceName** used by the application server and **schema** used by the database. The **jndiReferenceName** will be ``java:comp/env/`` followed by the Resource ``name`` specified in the Tomcat JNDI configuration (Using the PostgreSQL configuration above, this would be ``java:comp/env/jdbc/postgres``).

For more information, including how to configure JNDI for Oracle and SQL Server data sources, see the `GeoServer user manual </geoserver/tutorials/tomcat-jndi/tomcat-jndi.html>`_.

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