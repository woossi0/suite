.. _dataadmin.gdal:

Enabling GDAL image formats support
===================================

.. note:: This document only concerns the extra image formats that can be made available in GeoServer via GDAL. The GDAL binaries, such as :command:`gdalinfo` are installed separately.

The OpenGeo Suite comes with support for publishing data from many formats supported by the `Geospatial Data Abstraction Library <http://gdal.org>`_ (GDAL).  These formats include DTED, EHdr, AIG, ENVIHdr, and much more.

.. note:: See the :ref:`intro.installation` section for more information on the various ways to install OpenGeo Suite.

Installation
------------

Ubuntu
~~~~~~

#. Install the following package from the Boundless repository.  (See :ref:`intro.installation.ubuntu.install` for instructions on how to add the OpenGeo repository):

   .. code-block:: console

      apt-get install geoserver-gdal

   .. note:: You must run this command as root or use :command:`sudo`.

#. Once the package is installed, restart Tomcat to allow the changes to take effect:

   .. code-block:: console

      service tomcat7 restart

Continue reading at the :ref:`dataadmin.gdal.verify` section.

CentOS / Red Hat
~~~~~~~~~~~~~~~~

#. Install the following package from the Boundless repository.  (See :ref:`intro.installation.redhat.install` for instructions on how to add the Boundless repository):

   .. code-block:: console

      yum install geoserver-gdal

   .. note::  You must run this command as root or use :command:`sudo`.

#. Once the package is installed, restart Tomcat to allow the changes to take effect:

   .. code-block:: console

      service tomcat7 restart

Continue reading at the :ref:`dataadmin.gdal.verify` section.


Windows
~~~~~~~

.. note:: GDAL image formats are enabled by default when using the Windows installer, Mac OS X installer, or Linux packages. Extra configuration is required only if using **OpenGeo Suite for Application Servers** (WAR bundle).

#. Navigate to:  http://data.opengeo.org/gdal_support/ .

#. Download the file that matches the version of the OpenGeo Suite (e.g. :file:`gdal_win_30.zip` for version 3.0).

   .. note:: This file requires 32-bit Java/Tomcat.

#. Extract the file :file:`gdal-1.8.1.jar` from the archive into :file:`<TOMCAT_HOME>\\webapps\\geoserver\\WEB-INF\\lib\\`, where :file:`<TOMCAT_HOME>` is the location where Tomcat is installed (e.g.: :file:`C:\\Program Files\\Tomcat\\`).

#. If Tomcat is installed as a service:

   #. Extract the full contents of the archive to <TOMCAT_HOME>\bin\.

   #. Restart Tomcat.

#. If Tomcat is not installed as a service:

   #. Extract the full contents of the archive to any folder (such as :file:`C:\\Program Files\\GDAL\\`).

   #. Edit the file :file:`<TOMCAT_HOME>\\bin\\setenv.bat` and add the following line::

         set PATH='C:\Program Files\GDAL\;%PATH%'
 
      replacing :file:`C:\\Program Files\\GDAL\\` with the path where the archive was extracted.

   #. Restart Tomcat.

Continue reading at the :ref:`dataadmin.gdal.verify` section.

Mac OS X
~~~~~~~~

.. note:: GDAL image formats are enabled by default when using the Windows installer, Mac OS X installer, or Linux packages. Extra configuration is required only if using **OpenGeo Suite for Application Servers** (WAR bundle).

#. Navigate to:  http://data.opengeo.org/gdal_support/

#. Download the file that matches the version of the OpenGeo Suite (e.g. :file:`gdal_osx_30.zip` for version 3.0).

#. Extract the contents of the archive into :file:`/usr/local/lib/`.  The path may not exist, so it may need to be created first.

#. Create (or edit) a file called :file:`setenv.sh` located in $TOMCAT_HOME/bin, and add the following line::

      export DYLD_LIBRARY_PATH=/usr/local/lib:$DYLD_LIBRARY_PATH`

#. Restart Tomcat

Continue reading at the :ref:`dataadmin.gdal.verify` section.


.. _dataadmin.gdal.verify:

Verification
------------

#. To verify that the GDAL image formats were enabled properly, navigate to the GeoServer web admin interface and log in with administrator credentials.

   .. note:: Please see the GeoServer reference documentation for more information about the GeoServer web admin interface.
   
#. Click on :guilabel:`Stores` and then :guilabel:`Add new Store`.  There should be many raster image formats, such as DTED, EHdr, AIG, and ENVIHdr in the list of formats.

   .. figure:: img/gdal_verify.png
      
      Verifying that GDAL is an option in the Raster Data Sources

