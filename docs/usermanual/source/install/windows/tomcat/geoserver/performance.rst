.. _install.windows.tomcat.geoserver.performance:

GeoServer Performance
=====================

The following extensions make changes to the GeoServer execution environment unlocking new capabilities and performance.

These extensions are strongly recommended.

Java Cryptography Extension
---------------------------

We recommend installing the Java Cryptography Extension Unlimited Strength Jurisdiction Policy File files.

1. Download the :guilabel:`Java Cryptography Extension Unlimited Strength Jurisdiction Policy Files` listed under :guilabel:`Additional Resources` on the `download page <http://www.oracle.com/technetwork/java/javase/downloads/index.html>`__ .
   
   .. figure:: ../img/java_cryptography.png
      :scale: 75%
      
      Java Cryptography Extension (JCE) Policy Files
   
2. Unzip the two jar files :file:`local_policy.jar` and :file:`US_export_policy.jar` file into your ``JRE_HOME`` :file:`lib` directory.  For Java 1.8.0 the file:`lib\\security` directory is located in :file:`C:\\Program Files (x86)\\Java\\jre1.8.0_101\\lib\\security`.
   
   .. figure:: ../img/java_cryptography_install.png
      :scale: 50%
      
      Installation of local_policy.jar and US_export_policy.jar
      
Marlin Rasterizer Extension
---------------------------

We recommend making use of the Marlin Rasterizer for improved WMS performance:

1. From the :file:`BoundlessSuite-ext` download open the :file:`marlin` folder.
2. Copy the :file:`marlin-0.7.3-Unsafe.jar` to your Tomcat :file:`bin` folder. The file will be located in:
   
   * :file:`C:\Program Files (x86)\Apache Software Foundation\Tomcat 8\bin\marlin-0.7.3-Unsafe.jar`
   
   .. figure:: ../img/marlin_install.png
      :scale: 80%
      
      Marlin Install
      
3. Return to :guilabel:`Apache Tomcat Properties`, the :guilabel:`Java` tab, to add the following additional :guilabel:`Java Options`::
     
     -Xbootclasspath/a:C:\Program Files (x86)\Apache Software Foundation\Tomcat 8\bin\marlin-0.7.3-Unsafe.jar
     -Dsun.java2d.renderer=org.marlin.pisces.PiscesRenderingEngine
     -Dsun.java2d.renderer.useThreadLocal=false
  
  Press :guilabel:`Apply`.
  
.. note:: Once GeoServer is installed visit the :guilabel:`Server Status` page to confirm the use of the Marlin Rasterizer. The :guilabel:`Java Rendering Engine` should be listed as ``org.marlin.pisces.PiscesRenderingEngine``.

   .. figure:: ../img/geoserver_marlin.png
      
      Server Status Marlin rendering Engine