.. _install.windows.tomcat.java:

Java Installation
=================

Install Java on your system:

1. Boundless Suite on Windows requires a 32-bit Java Runtime Environment, available from the `Oracle Java download page <https://java.com/en/download/manual.jsp>`__ .
   
   .. figure:: img/java_download.png
      
      Java 32-bit Windows Download
   
   .. note:: Boundless Suite requires Java 8, and is no longer compatible with Java 7.
   
   .. warning:: Use of GDAL and NetCDF binaries requires Java 32-bit download.

2. Run the installer, agreeing to the license terms provided to install.

   .. figure:: img/java_install.png
      :scale: 50%
      
      Java Installation

3. Wait while Java installs

   .. figure:: img/java_wait.png
      :scale: 50%
      
      Java Installation
   
   During installation Java may detect any prior versions and offer to uninstall.
   
4. When complete java is available in :file:`C:\\Program Files (x86)\\Java`. This location will be referred to as ``JRE_HOME`` in subsequent documentation.

   .. figure:: img/java_done.png
      :scale: 50%
      
      Java Installation


Java Cryptography Extension
---------------------------

We recommend installing the Java Cryptography Extension Unlimited Strength Jurisdiction Policy File files.

1. Download the :guilabel:`Java Cryptography Extension Unlimited Strength Jurisdiction Policy Files` listed under :guilabel:`Additional Resources` on the `download page <http://www.oracle.com/technetwork/java/javase/downloads/index.html>`__ .
   
   .. figure:: img/java_cryptography.png
      :scale: 75%
      
      Java Cryptography Extension (JCE) Policy Files
   
2. Unzip the two jar files :file:`local_policy.jar` and :file:`US_export_policy.jar` file into your ``JRE_HOME`` :file:`lib` directory.  For Java 1.8.0 the file:`lib\\security` directory is located in :file:`C:\\Program Files (x86)\\Java\\jre1.8.0_101\\lib\\security`.
   
   .. figure:: img/java_cryptography_install.png
      :scale: 50%
      
      Installation of local_policy.jar and US_export_policy.jar
      
Marlin Rasterizer Extension
---------------------------

We recommend making use of the Marlin Rasterizer for improved WMS performance:

1. From the :file:`BoundlessSuite-ext` download open the :file:`marlin` folder.
2. Copy the :file:`marlin-0.7.3-Unsafe.jar` to your Tomcat :file:`bin` folder. The file will be located in:
   
   * :file:`C:\Program Files (x86)\Apache Software Foundation\Tomcat 8\bin\marlin-0.7.3-Unsafe.jar`
   
   .. figure:: img/marlin_install.png
      :scale: 80%
      
      Marlin Install
      
3. Return to :guilabel:`Apache Tomcat Properties`, the :guilabel:`Java` tab, to add the following additional :guilabel:`Java Options`::
     
     -Xbootclasspath/a:C:\Program Files (x86)\Apache Software Foundation\Tomcat 8\bin\marlin-0.7.3-Unsafe.jar
     -Dsun.java2d.renderer=org.marlin.pisces.PiscesRenderingEngine
     -Dsun.java2d.renderer.useThreadLocal=false
  
  Press :guilabel:`Apply`.

4. From the :guilabel:`General` tab and restart the service using :guilabel:`Stop` and :guilabel:`Start` buttons.

5. After Tomcat has restarted login to the GeoServer application and visit the :guilabel:`Server Status` page to confirm the use of the Marlin Rasterizer. The :guilabel:`Java Rendering Engine` should be listed as ``org.marlin.pisces.PiscesRenderingEngine``.

   .. figure:: img/geoserver_marlin.png
      
      Server Status Marlin rendering Engine