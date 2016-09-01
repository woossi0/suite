.. _install.windows.tomcat.geoserver.performance:

GeoServer Performance Extensions
================================

The following extensions make changes to the GeoServer execution environment unlocking new capabilities and performance.

These extensions are *strongly* recommended.

Java Cryptography Extension
---------------------------

We recommend installing the Java Cryptography Extension Unlimited Strength Jurisdiction Policy File files.

1. Download the :guilabel:`Java Cryptography Extension Unlimited Strength Jurisdiction Policy Files` listed under :guilabel:`Additional Resources` on the Oracle `download page <http://www.oracle.com/technetwork/java/javase/downloads/index.html>`__ .
   
   .. figure:: ../img/java_cryptography.png
      :scale: 75%
      
      Java Cryptography Extension (JCE) Policy Files
   
2. Extract the two jar files (:file:`local_policy.jar` and :file:`US_export_policy.jar`) from the downloaded zip into your ``JRE_HOME`` :file:`lib` directory.  For Java 1.8.0 the file:`lib\\security` directory is located in :file:`C:\\Program Files (x86)\\Java\\jre1.8.0_101\\lib\\security`.
   
   These files will overwrite the existing policy files.
   
   .. figure:: ../img/java_cryptography_install.png
      :scale: 50%
      
      Installation of local_policy.jar and US_export_policy.jar
  
  .. note:: You may find it easier to cut-and-paste the two files into the correct folder.

3. Using the Tomcat Manager, start and stop the Tomcat service.  Log into into the  (`Geoserver web application <http://localhost:8080/geoserver>`__ ) - you will see a ``"Strong cryptography available`` message.

Marlin Rasterizer Extension
---------------------------

We recommend making use of the Marlin Rasterizer for improved WMS performance:

1. From the :file:`BoundlessSuite-ext` download open the :file:`marlin` folder.
2. Copy the :file:`marlin-0.7.3-Unsafe.jar` to your Tomcat :file:`bin` folder. The file will be located in:
   
   * :file:`C:\\Program Files (x86)\\Apache Software Foundation\\Tomcat 8\\bin\\marlin-0.7.3-Unsafe.jar`
   
   .. figure:: ../img/marlin_install.png
      :scale: 50%
      
      Marlin Install
      
3. Return to :guilabel:`Apache Tomcat Properties`, switch to the :guilabel:`Java` tab, and add the following additional :guilabel:`Java Options`:
   
   .. warning:: Please adjust the example below to match the location of your version of tomcat (i.e. Tomcat 8.5)
   
   .. literalinclude:: ../include/java_opts.txt
      :language: bash
      :start-after: # marlin
      :end-before: # marlin end
  
  Press :guilabel:`Apply`.
  
4. Once GeoServer is restarted, visit the :guilabel:`Server Status` page to confirm the use of the Marlin Rasterizer. The :guilabel:`Java Rendering Engine` will be listed as ``org.marlin.pisces.PiscesRenderingEngine``.

   .. figure:: ../img/geoserver_marlin.png
      
      Server Status Marlin rendering Engine

LibJPEGTurbo Extension
----------------------

The LibJPEGTurbo Extension greatly speeds up the creation of JPG images.

1. From the :file:`BoundlessSuite-ext` download open the :file:`windows` folder.
2. Double click on the :file:`libjpeg-turbo-1.4.2-vc.exe` installer
3. Install LibJPEGTurbo in the default location (:file:`c:\\libjpeg-turbo`).
4. Add this directory to the system PATH

   On Windows 2012 Server

       #. Open the Start menu and type "system environment"
       #. Select "Edit the system environment variables"
       #. Click "Environment Variables"
       #. In the **System Variables** section, select "Path"
       #. Press "Edit..."
       #. Add :file:`c:\libjpeg-turbo` to the variable
       #. Press "OK" and then "OK" again
       
   On Windows 10     
   
       #. Open the Start menu and type "system environment"
       #. Select "Edit the system environment variables"
       #. Click "Environment Variables"
       #. In the **System Variables** section, select "Path"
       #. Press "Edit..."
       #. Press "New"
       #. Type in :file:`c:\libjpeg-turbo`
       #. Press "OK" and then "OK" again

5. Stop and Start the Tomcat Service using the Tomcat icon in the System Tray
6. Go to the Geoserver main page and logon
7. Got to the  `Geoserver Detailed Status page <http://localhost:8080/geoserver/rest/about/status>`__
8. Search for Libjpeg on the page and verify it is enable
       .. figure:: ../../../include/ext/img/libjpeg.png
