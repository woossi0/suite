.. _install.windows.tomcat.war:

Suite Installation
==================

.. note:: During installation we will be editing text files that require Administrator access to modify. We recommend the :guilabel:`Notepad++` ( `notepad-plus-plus.org <https://notepad-plus-plus.org/>`__ ).

BoundlessSuite War Bundle
-------------------------

Unpacking an web application distribution into a suitable location:

#. Download :suite:`BoundlessSuite-war.zip <war-archive/BoundlessSuite-latest-war.zip>` to :file:`Downloads` folder

#. Open and :file:`Downloads` folder using :guilabel:`Windows Explorer`.

#. Right click :file:`BoundlessSuite-war.zip` and select :file :menuselection:`Extract All`.

   .. figure:: img/war_extract.png
      
      Extract all

#. Extract to the default :file:`Download` folder location.

   .. figure:: img/war_contents.png
      
      Boundless Suite WARs

GeoServer Install
-----------------

#. Use :menuselection:`Start --> Apache Tomcat --> Configure Tomcat` to open :guilabel:`Apache Tomcat Properties`.

#. Change to the :guilabel:`Java` tab and add the following :guilabel:`Java Options`:
  
   .. literalinclude:: include/java_opts.txt
      :language: bash
      :start-after: # geoserver
      :end-before: # geoserver end
     
   Press :guilabel:`Apply`.

   .. figure:: img/geoserver_system_properties.png
   
      Java system properties

#. Use :menuselection:`Start --> Apache Tomcat --> Tomcat Program Directory` to open the program directory.
   
   .. figure:: img/tomcat_program_directory.png
   
      Tomcat Program Directory

#. Use **Windows Directory** to open the :file:`conf\\Catalina\\localhost\\` directory, and create a :download:`geoserver.xml <include/geoserver.xml>`:
   
   .. literalinclude:: include/geoserver.xml
      :language: xml
   
#. Change to the :guilabel:`General` tab and restart the service using :guilabel:`Stop` and :guilabel:`Start` buttons.
   
   .. figure:: img/tomcat_start.png
      
      Start Tomcat Sercice
      
#. Use :menuselection:`Start --> Apache Tomcat --> Tomcat Program Directory` to open the program directory, open the :file:`webapps` directory.
   
   Copy the :file:`geoserver.war` into this folder to deploy.

   .. figure:: img/geoserver_deploy.png
       
       Deploy of geoserver.war

  .. note:: It will take a moment for Tomcat to notice the web application and make it available, there is no need to restart your application server.

#. The :file:`geoserver.war` is extracted into the running :guilabel:`geoserver` web application visible in the :file:`webapps` folder.

#. Using your browser navigate to `localhost:8080/geoserver <http://localhost:8080/geoserver>`__. At the top of the screen fill in the default credentials of:

   * :guilabel:`Username`: ``admin``
   * :guilabel:`Password`: ``geoserver``

   .. figure:: img/geoserver_login.png
       
      Login to GeoServer application
      
#. Using the right hand side page navigation, visit the :guilabel:`Server Status` page.

   .. figure:: img/geoserver_status.png
       
      Page Navigation

#. Confirm that the :guilabel:`Data directory` is listed correctly.

   .. figure:: img/geoserver_status_page.png
      :scale: 75%
      
      Server Status Data directory
      
   .. note:: If the data directory is incorrectly located in :file:`webapps/geoserver/data` the ``GEOSERVER_DATA_DIR`` setting has not taken effect. Double check the java options, and that the service has restarted to correct.

Suite Documentation Install
---------------------------

1. From :menuselection:`Start --> Apache Tomcat --> Tomcat Program Directory` navigate to the :file:`webapps` folder.

2. Copy the :file:`suite-docs.war` into :file:`webapps` to deploy.

  .. note:: It will take a moment for Tomcat to notice the web application and make it available, there is no need to restart your application server.

3. Use your browser to open the web application at `localhost:8080/suite-docs <http://localhost:8080/suite-docs/>`__.

   .. figure:: img/suite-docs.png
      
      Boundless Suite User Manual
      
Dashboard Install
-----------------

1. From :menuselection:`Start --> Apache Tomcat --> Tomcat Program Directory` navigate to the :file:`webapps` folder.

2. Copy the :file:`dashboard.war` into :file:`webapps` to deploy.

  .. note:: It will take a moment for Tomcat to notice the web application and make it available, there is no need to restart your application server.

3. Use your browser to open the web application at `localhost:8080/dashboard <http://localhost:8080/dashboard/>`__.
   
   .. figure:: /intro/img/dashboard.png
      
      Boundless Suite Dashboard

GeoWebCache Install
-------------------

.. note:: GeoServer includes an built-in copy of this application, installation of stand-alone GeoWebCache may be considered for for caching external WMS services. For more information see :ref:`sysadmin.deploy.strategies`.

1. From :menuselection:`Start --> Apache Tomcat --> Tomcat Program Directory` navigate to the :file:`webapps` folder.

2. Copy the :file:`geowebcache.war` into :file:`webapps` to deploy.

  .. note:: Remember to restart your application server

3. Use your browser to open the web application at `localhost:8080/geowebcache <http://localhost:8080/geowebcache/>`__.

   .. figure:: /img/gwc.png
      
      GeoWebCache