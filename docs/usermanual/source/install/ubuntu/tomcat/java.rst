.. _install.ubuntu.tomcat.java:

Java Installation
=================

Install Java on your system:

1. Boundless Suite requires a Java Runtime Environment, available from the `Oracle Java download page <https://java.com/en/download/manual.jsp>`__ .
   
   .. note:: Boundless Suite requires Java 8, and is no longer compatible with Java 7.
   
   .. note: Boundless Suite is compatible with OpenJDK provided by Ubuntu, however we recommend the use of Oracle JDK for performance.
   
      If you would like to install OpenJDK as an alternative::
      
         sudo apt-get install default-jdk

2. Do the thing...

3. And the other thing ...
      
4. When complete java is available in :file:`...`. This location will be referred to as ``JRE_HOME`` in subsequent documentation.

Java Cryptography Extension
---------------------------

We recommend installing the Java Cryptography Extension Unlimited Strength Jurisdiction Policy File files.

1. Download the :guilabel:`Java Cryptography Extension Unlimited Strength Jurisdiction Policy Files` listed under :guilabel:`Additional Resources` on the `download page <http://www.oracle.com/technetwork/java/javase/downloads/index.html>`__ .
   
2. Unzip the two jar files :file:`local_policy.jar` and :file:`US_export_policy.jar` file into your ``JRE_HOME`` :file:`lib` directory.

Marlin Rasterizer Extension
---------------------------

We recommend making use of the Marlin Rasterizer for improved WMS performance:

1. From the :file:`BoundlessSuite-ext` download open the :file:`marlin` folder.
2. Copy the :file:`marlin-0.7.3-Unsafe.jar` to your Tomcat :file:`bin` folder.::
      
      cp marlin-0.7.3-Unsafe.jar :file:`/usr/share/tomcat8/bin/marlin-0.7.3-Unsafe.jar`
   
3. Add the following additional :guilabel:`Java Options` to :file:`/etc/sysconfig/tomcat8`::
      
      .. literalinclude:: /include/marlin.txt

.. note:: 
   
   Once GeoServer is installed visit the :guilabel:`Server Status` page to confirm the use of the Marlin Rasterizer. The :guilabel:`Java Rendering Engine` should be listed as ``org.marlin.pisces.PiscesRenderingEngine``.