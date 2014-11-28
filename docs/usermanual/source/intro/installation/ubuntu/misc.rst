.. _intro.installation.ubuntu.misc:

Working with OpenGeo Suite for Ubuntu Linux
===========================================

This document contains information about various tasks specific to OpenGeo Suite for Ubuntu Linux.

Starting and stopping OpenGeo services
--------------------------------------

OpenGeo Suite is comprised of two main services:

#. The `Tomcat <http://tomcat.apache.org/>`_ web server that contains all the OpenGeo web applications such as GeoServer, GeoWebCache, and GeoExplorer. 

#. The `PostgreSQL <http://www.postgresql.org/>`_ database server with the PostGIS spatial extensions. 

Controlling the Tomcat service
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To start/stop/restart the Tomcat service:

  .. code-block:: bash
 
     sudo service tomcat7 start|stop|restart

Other options in addition to the above are ``try-restart``, ``force-restart``, and ``status``.

Controlling the PostgreSQL service
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To start/stop/restart the PostgreSQL service:

  .. code-block:: bash
 
     sudo service postgresql start|stop|restart

Other options in addition to the above are ``reload``, ``force-reload``, and ``status``.

  .. note:: If you have multiple versions of PostgresSQL installed you can specify which version to control with a third argument. For example:

     .. code-block:: bash

         sudo service postgresql start 9.3 

Service port configuration
--------------------------

The Tomcat and PostgreSQL services run on ports **8080** and **5432** respectively. These ports can often conflict with existing services on the systemk, in which case the ports must be changed. 

Changing the Tomcat port
^^^^^^^^^^^^^^^^^^^^^^^^

To change the Tomcat port:

#. Edit the file :file:`/etc/tomcat7/server.xml`. 

#. Search for ``8080`` (around line 71) and change the ``port`` attribute to the desired value.

#. Restart Tomcat. 

Changing the PostgreSQL port
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To change the PostgreSQL port:

#. Edit the file :file:`/etc/postgresql/9.3/main/postgresql.conf`.

#. Search or the ``port`` property (around line 63) and change it to the desired value.

#. Restart PostgreSQL.

Working with Tomcat
-------------------

Changing the Tomcat Java
^^^^^^^^^^^^^^^^^^^^^^^^

If you wish to use the Oracle Java 7 JRE (rather than the OpenJDK 7 installed by default):

#. Download and install Oracle Java 7 JRE.

#. Open :file:`/etc/default/tomcat7` and update the JAVA_HOME environment variable.

Use Suite Packages with custom Tomcat
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Suite packages can be used to manage the contents :file:`/usr/share/opengeo` components while making use of your own Tomcat Application Server. This is an alternative to deploying suite using web archives into the :file:`webapps` directory.

#. Install suite packages

#. Stop your Tomcat service

#. Navigate to :file:`/etc/tomcat7/Catalina/localhost/`

#. Create the :file:`geoserver.xml` with the following content:
   
   .. code-block:: xml
   
      <Context displayName="geoserver"
               docBase="/usr/share/opengeo/geoserver"
               path="/geoserver"/>

#. Create the :file:`geowebcache.xml` with the following content:
   
   .. code-block:: xml
   
      <Context displayName="geowebcache"
               docBase="/usr/share/opengeo/geowebcache"
               path="/geowebcache"/>

#. Create the :file:`dashboard.xml` with the following content:
   
   .. code-block:: xml
   
      <Context displayName="dashboard"
               docBase="/usr/share/opengeo/dashboard"
               path="/dashboard"/>

#. Create the :file:`geoexplorer.xml` with the following content:
   
   .. code-block:: xml
   
      <Context displayName="geoexplorer"
               docBase="/usr/share/opengeo/geoexplorer"
               path="/geoexplorer"/>

#. Create the :file:`docs.xml` with the following content:
   
   .. code-block:: xml
   
      <Context displayName="docs"
               docBase="/usr/share/opengeo/docs"
               path="/docs"/>

#. Create the :file:`recipes.xml` with the following content:
   
   .. code-block:: xml
   
      <Context displayName="docs"
               docBase="/usr/share/opengeo/recipes"
               path="/recipes"/>
               
#. Restart Tomcat

.. _intro.installation.ubuntu.misc.geoserver:

Working with GeoServer
----------------------

GeoServer Data Directory
^^^^^^^^^^^^^^^^^^^^^^^^

The **GeoServer Data Directory** is the location on the file system where GeoServer stores all of its configuration, and (optionally) file-based data. By default, this directory is located at: :file:`/var/lib/opengeo/geoserver`. 

To point GeoServer to an alternate location:

#. Edit the file :file:`/usr/share/opengeo/geoserver/WEB-INF/web.xml`.

#. Search for ``GEOSERVER_DATA_DIR`` section, uncomment, and change its value accordingly.
   
   .. code-block:: xml
      
       <context-param>
          <param-name>GEOSERVER_DATA_DIR</param-name>
           <param-value>/var/lib/opengeo/geoserver</param-value>
       </context-param> 

#. Restart Tomcat.

Compatibility Settings
^^^^^^^^^^^^^^^^^^^^^^

To adjust GeoServer compatibility settings:

#. A fix is available for spatial reference systems measured in imperial units. This setting is recommended for all users, and strongly recommended for those working with US State Plane projections measured in feet.

   To enable this fix add the following parameter to :file:`/etc/tomcat7/server.xml`:
   
   .. code-block:: bash
      
      -Dorg.geotoools.render.lite.scale.unitCompensation=true
   
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

#. Restart Tomcat::
   
      sudo service tomcat7 restart

.. _intro.installation.ubuntu.misc.pgconfig:

PostgreSQL Configuration
------------------------

PostgreSQL configuration is controlled within the ``postgresql.conf`` file. This file is located at :file:`/etc/postgresql/9.3/main/postgresql.conf`. 

You will want to ensure you can connect to the database, and that you have a user to 
work with. Please see the section on :ref:`dataadmin.pgGettingStarted.firstconnect`.
