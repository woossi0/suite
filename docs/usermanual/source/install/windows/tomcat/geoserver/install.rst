.. _install.windows.tomcat.geoserver.install:

GeoServer WAR Install
=====================

1. Use :menuselection:`Start --> Apache Tomcat --> Configure Tomcat` to open :guilabel:`Apache Tomcat Properties`. Switch to the :guilabel:`General` tab and click :guilabel:`Stop` to stop the service
   
   .. figure:: ../img/tomcat_stop.png
      
      Stop Tomcat Service
      
2. Switch to the :guilabel:`Java` tab and add the following to the :guilabel:`Java Options`:
  
   .. literalinclude:: ../include/java_opts.txt
      :language: bash
      :start-after: # geoserver
      :end-before: # geoserver end
     
   Then press :guilabel:`Apply`.

   .. figure:: ../img/geoserver_system_properties.png
   
      Java system properties

#. Use :menuselection:`Start --> Apache Tomcat --> Tomcat Program Directory` to open the program directory.  You can also use :guilabel:`Windows Explorer` to open the Tomcat Program Directory :file:`C:\\Program Files (x86)\\Apache Software Foundation\\Tomcat 8.5`
   
   .. figure:: ../img/tomcat_program_directory.png
   
      Tomcat Program Directory

3. Use :guilabel:`Windows Explorer` to open the :file:`conf\\Catalina\\localhost\\` directory, and create a :download:`geoserver.xml <../include/geoserver_WINDOWS.xml>` with the following content:
   
   .. literalinclude:: ../include/geoserver_WINDOWS.xml
      :language: xml
   
   .. note:: When upgrading from OpenGeo Suite make use of your existing ``GEOSERVER_DATA_DIRECTORY`` location.
   
      .. literalinclude:: ../include/geoserver_upgrade.xml
         :language: xml

4. Create the folder :file:`C:\\ProgramData\\Boundless\\geoserver\\tilecache` referenced above.

     .. image:: ../img/geoserver_maindir.png


5. Use :menuselection:`Start --> Apache Tomcat --> Tomcat Program Directory` to open the program directory, then open the :file:`webapps` directory.
   
   Copy the :file:`geoserver.war` into the :file:`webapps` folder to deploy.

   .. figure:: ../img/geoserver_deploy.png
       
      Deploy of geoserver.war
   
   .. note:: The :file:`geoserver.war` is included in the *BoundlessSuite War Bundle* downloaded previously (see :ref:`install.windows.tomcat.bundle`).

6. Change to the :guilabel:`General` tab and start the service using the :guilabel:`Start` button.
   
   .. figure:: ../img/tomcat_start.png
      
      Start Tomcat Service
      
7. Tomcat will deploy the :file:`geoserver.war` into a :guilabel:`geoserver` folder visible in the :file:`webapps` folder.

  .. note:: It will take a moment for Tomcat to notice the web application and make it available.

8. Using your browser navigate to `localhost:8080/geoserver <http://localhost:8080/geoserver>`__. At the top of the screen fill in the default geoserver credentials:

   * :guilabel:`Username`: ``admin``
   * :guilabel:`Password`: ``geoserver``

   .. figure:: ../img/geoserver_login.png
       
      Login to GeoServer application
      
9. Using the right hand side page navigation, visit the :guilabel:`Server Status` page.

   .. figure:: ../img/geoserver_status.png
       
      Page Navigation

10. Confirm that the :guilabel:`Data directory` (``GEOSERVER_DATA_DIRECTORY``) is correct.

   .. figure:: ../img/geoserver_status_page.png
      :scale: 75%
      
      Server Status Data directory
      
   .. note:: If the data directory is incorrectly located in :file:`webapps/geoserver/data` the ``GEOSERVER_DATA_DIR`` setting has not taken effect. Double check the :file:`geoserver.xml` file, and confirm that the service has restarted.

11. Go to the `Geoserver Imbedded GeoWebCache Main Page <http://localhost:8080/geoserver/gwc>`__ to ensure the tile cache directory is correctly set.

   .. image:: ../img/imbedded_gwc.png

