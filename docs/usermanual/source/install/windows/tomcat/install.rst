.. _install.windows.tomcat.war:

Suite Installation
==================

.. note:: During installation we will be editing text files that require Administrator access to modify. We recommend the :guilabel:`Notepad++`

Unpacking an web application distribution into a suitable locat ion (such as your :file:`Download` folder):

1. Open :file:`Downloads` folder using :guilabel:`Windows Explorer`.

2. Right click :file:`BoundlessSuite-war.zip` and select :file :menuselection:`Extract All`.

   .. figure:: img/war_extract.png
      
      Extract all

3. Extract to the default :file:`Download` folder location.

   .. figure:: img/war_contents.png
      
      Boundless Suite WARs

GeoServer Install
-----------------

1. Use :menuselection:`Start --> Apache Tomcat --> Configure Tomcat` to open :guilabel:`Apache Tomcat Properties`.

2. Change to the :guilabel:`Java` tab and add the following :guilabel:`Java Options`::
     
     -DGEOSERVER_DATA_DIR=C:\ProgramData\Boundless\geoserver\data
     -Dorg.geotools.referencing.forceXY=true
     -Dorg.geotoools.render.lite.scale.unitCompensation=true
      
   Press :guilabel:`Apply`.

   .. figure:: img/geoserver_system_properties.png
   
      Java system properties
      
3. Change to the :guilabel:`General` tab and restart the service using :guilabel:`Stop` and :guilabel:`Start` buttons.
   
   .. figure:: img/tomcat_start.png
      
      Start Tomcat Sercice
      
4. Use :menuselection:`Start --> Apache Tomcat --> Tomcat Program Directory` to open the program directory.
   
   .. figure:: img/tomcat_program_directory.png
   
      Tomcat Program Directory

5. Use **Windows Directory** to open the :file:`webapps` directory, copy the :file:`geoserver.war` into this folder to deploy.

   .. figure:: img/geoserver_deploy.png
       
       Deploy of geoserver.war
   
6. The :file:`geoserver.war` is extracted into the running :guilabel:`geoserver` web application visibile in the :file:`webapps` folder.

7. Using your browser navigate to `localhost:8080/geoserver <http://localhost:8080/geoserver>`__. At the top of the screen fill in the default credentials of:

   * :guilabel:`Username`: ``admin``
   * :guilabel:`Password`: ``geoserver``

   .. figure:: img/geoserver_login.png
       
      Login to GeoServer application
      
8. Using the right hand side page navigation, visit the :guilabel:`Server Status` page.

   .. figure:: img/geoserver_status.png
       
      Page Navigation

9. Confirm that the :guilabel:`Data directory` is listed correctly.

   .. figure:: img/geoserver_status_page.png
      
      Server Status Data directory
      
   .. note:: If the data directory is incorrectly located in :file:`webapps/geoserver/data` the ``GEOSERVER_DATA_DIR`` setting has not taken effect. Double check the java options, and that the service has restarted to correct.
   
Optional Marlin Rasterizer Install
''''''''''''''''''''''''''''''''''

We recommend making use of the Marlin Rasterizer for improved WMS performance:

1. Return to :guilabel:`Apache Tomcat Properties`, the :guilabel:`Java` tab, to add the following additional :guilabel:`Java Options`::
     
     -Xbootclasspath/a:C:\Program Files (x86)\Apache Software Foundation\Tomcat 8\webapps\geoserver\WEB-INF\lib\marlin-0.7.3-Unsafe.jar
     -Dsun.java2d.renderer=org.marlin.pisces.PiscesRenderingEngine
     -Dsun.java2d.renderer.useThreadLocal=false
  
  Press :guilabel:`Apply`.

3. From the :guilabel:`General` tab and restart the service using :guilabel:`Stop` and :guilabel:`Start` buttons.

4. After Tomcat has restarted login to the GeoServer application and visit the :guilabel:`Server Status` page to confirm the use of the Marlin Rasterizer. The :guilabel:`Java Rendering Engine` should be listed as ``org.marlin.pisces.PiscesRenderingEngine``.

   .. figure:: img/geoserver_marlin.png
      
      Server Status Marlin rendering Engine

Suite Documentation Install
---------------------------

1. From :menuselection:`Start --> Apache Tomcat --> Tomcat Program Directory` navigate to the :file:`webapps` folder.

2. Copy the :file:`suite-docs.war` into :file:`webapps` to deploy.

3. Use your browser to open the web application at `localhost:8080/suite-docs <http://localhost:8080/suite-docs/>`__.

   .. figure:: img/suite-docs.png
      
      Boundless Suite User Manual
