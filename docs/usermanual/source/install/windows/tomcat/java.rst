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