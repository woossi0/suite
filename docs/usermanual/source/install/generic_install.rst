
Overview of installing Suite with Tomcat
========================================

.. note:: Suite requires Java 1.8 and Tomcat 8

1. If you have an existing Suite or Geoserver install, backup your configuration (:guilabel:`GEOSERVER_DATA_DIR`) and data.  Uninstall Suite 4.8 or earlier.

2. Install Java 1.8 - we recommend downloading from `Oracle <https://java.com/en/download/manual.jsp>`__

3. Install `Tomcat 8 <http://tomcat.apache.org/download-80.cgi>`__ 

  .. note:: Ensure tomcat is using the Java 8 runtime.

4. Setup basic Tomcat with the following options;
     
       a) :guilabel:`-Xms256m`   
       b) :guilabel:`-Xmx756m`  (higher if you have more available memory)
       c) :guilabel:`-XX:SoftRefLRUPolicyMSPerMB=36000`
       d) :guilabel:`-XX:-UsePerfData`
       e) :guilabel:`-Dorg.geotools.referencing.forceXY=true`
       f) :guilabel:`-Dorg.geotoools.render.lite.scale.unitCompensation=true`

5. If you do **not** have an existing :guilabel:`GEOSERVER_DATA_DIR`, you can create one using the :file:`suite-data-dir.zip` inside :file:`BoundlessSuite-4.9.0-war.zip`.  Your :guilabel:`GEOSERVER_DATA_DIR` will be :file:`/var/opt/boundless/suite/geoserver/data`

      .. code-block:: python

          mkdir -p /var/opt/boundless/suite/geoserver/data
          unzip suite-data-dir.zip -d /var/opt/boundless/suite/geoserver/data

6. Add a Geoserver Context file (geoserver.xml) to :file:`$CATALINA_HOME/conf/Catalina/localhost/` with the following content;

    .. code-block:: xml
    
	<Context docBase="geoserver.war">
	  <!-- The location of the GeoServer configuration directory -->
	  <Parameter name="GEOSERVER_DATA_DIR"
	             value="/var/opt/boundless/suite/geoserver/data"
	             override="false"/> 
	
	  <!-- The default location of the GWC tile cache -->
	  <Parameter name="GEOWEBCACHE_CACHE_DIR"
	             value="var/opt/boundless/suite/geoserver/tilecache"
	             override="false"/>
	</Context>

   .. note:: Make sure the :guilabel:`GEOWEBCACHE_CACHE_DIR` exists, and the :guilabel:`GEOSERVER_DATA_DIR` points to your data directory location.


 7. Copy geoserver.war to :file:`$CATALINA_HOME/webapps`

 8. Start Tomcat, go to the `Geoserver Homepage <http://localhost:8080/geoserver>`__ and verify the :guilabel:`GEOSERVER_DATA_DIR` is correct, and you are using the expected Java JRE

 9. Go to the `GWC Main Page <http://localhost:8080/geoserver/gwc>`__ and verify the Local Storage (GEOWEBCACHE_CACHE_DIR) is correct.

 10. It is strongly recommened to change your geoserver's master password - see Managing the master password 


Recommended Performance Extensions
==================================

Java Crytography 
----------------

1. Download the :guilabel:`Java Cryptography Extension (JCE) Unlimited Strength Jurisdiction Policy Files for JDK/JRE 8` from `Oracle <http://www.oracle.com/technetwork/java/javase/downloads/index.html>`__.   
2. Inside this .zip file are two files - :file:`local_policy.jar` and :file:`US_export_policy.jar`.  Put these in your :file:`$JRE_HOME/lib/security` directory (overwriting the existing files)
3. Restart Tomcat, and log-on to the geoserver home, and verify that it says :guilabel:`Strong cryptography available`

Marlin Renderer
---------------

1. Find the :file:`marlin-0.7.3-Unsafe.jar` inside the :file:`marlin` directory in the :file:`BoundlessSuite-4.9.0-ext. zip` file (available from Boundless Connect) and move to your Tomcat :file:`lib` directory (:file:`$CATALINA_HOME/lib`)
2. Add the following options to tomcat
    a) :guilabel:`-Xbootclasspath/a:/usr/share/tomcat8/lib/marlin-0.7.3-Unsafe.jar` (your location maybe slightly different)
    b) :guilabel:`-Dsun.java2d.renderer=org.marlin.pisces.PiscesRenderingEngine`
    c) :guilabel:`-Dsun.java2d.renderer.useThreadLocal=false`
3. Restart tomcat, logon to the Geoserver mainpage, and natigate to :guilabel:`Server Status`
4. Verify that, under :guilabel:`Java Rendering Engine`, it says :guilabel:`org.marlin.pisces.PiscesRenderingEngine`

LibJPEGTurbo
------------

1. Install the :file:`libjpeg-turbo-official` package (version 1.4.2) from the Boundless Third Party Repository.

 .. note:: Alternatively, download version 1.4.2 from `LibJPEGTurbo <https://sourceforge.net/projects/libjpeg-turbo/files/1.4.2/>`__ and install it.

2. In Tomcat's config either create or add to the :guilabel:`-Djava.library.path` variable to point to libjpeg-turbo's lib directory (usually :file:`/opt/libjpeg-turbo/lib64`)

3. Restart Tomcat, logon to Geoserver, and navigate to the `Geoserver Rest Status Page <http:://localhost:8080/geoserver/rest/about/status>`__

4. Search for "libjpeg" on the page and verify it is enabled and available.

   .. image:: /install/include/ext/img/libjpeg.png


Installing Native-library Extensions
====================================

GDAL
----

NetCDF4-Output
--------------

