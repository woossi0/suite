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
      
   .. note:: During the installation process the installer may ask permission to uninstall prior versions of Java.

3. Wait while Java installs.

   .. figure:: img/java_wait.png
      :scale: 50%
      
      Java Installation
   
   During installation Java may detect any prior versions and offer to uninstall.
   
4. When complete java is available in :file:`C:\\Program Files (x86)\\Java`. This location will be referred to as ``JRE_HOME`` in subsequent documentation.

   .. figure:: img/java_done.png
      :scale: 50%
      
      Java Installation