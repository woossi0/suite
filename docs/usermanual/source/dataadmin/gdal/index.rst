.. _dataadmin.gdal:

Enabling GDAL image formats support
===================================

.. note:: This document only concerns the extra image formats that can be made available in GeoServer via GDAL. The GDAL binaries, such as :command:`gdalinfo` are installed separately.

Boundless Suite comes with support for publishing data from many formats supported by the `Geospatial Data Abstraction Library <http://gdal.org>`_ (GDAL).  These formats include DTED, EHdr, AIG, ENVIHdr, and much more.

.. note:: See the :ref:`intro.installation` section for more information on the various ways to install Boundless Suite.

Installation
------------

Ubuntu packages
~~~~~~~~~~~~~~~

.. note:: GDAL image formats are only available on Linux using Boundless packages. Installing with Boundless Suite for Application Servers (via a WAR bundle) is not supported.

#. Install the following package from the Boundless repository.  (See :ref:`intro.installation.ubuntu.packages` for instructions on how to add the Boundless repository):

   .. code-block:: console

      apt-get install geoserver-gdal

   .. note:: You must run this command as root or use :command:`sudo`.

#. Once the package is installed, restart Tomcat to allow the changes to take effect:

   .. code-block:: console

      service tomcat7 restart

Continue reading at the :ref:`dataadmin.gdal.verify` section.

CentOS / Red Hat
~~~~~~~~~~~~~~~~

.. note:: GDAL image formats are only available on Linux using Boundless packages. Installing with Boundless Suite for Application Servers (via a WAR bundle) is not supported.

#. Install the following package from the Boundless repository.  (See :ref:`intro.installation.redhat.packages` for instructions on how to add the Boundless repository):

   .. code-block:: console

      yum install geoserver-gdal

   .. note::  You must run this command as root or use :command:`sudo`.

#. Once the package is installed, restart Tomcat to allow the changes to take effect:

   .. code-block:: console

      service tomcat7 restart

Continue reading at the :ref:`dataadmin.gdal.verify` section.

Windows application server
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. note:: This section is for installing GDAL image formats on a Windows-based installation of Boundless Suite for Application Servers (WAR bundle).

.. warning:: Boundless Suite for Windows requires `.NET Framework 4.5 <https://www.microsoft.com/en-us/download/details.aspx?id=30653>`_. Installation will fail if not present.

#. Download and install the `Visual C++ Redistributable for Visual Studio 2012 Update 4 <https://www.microsoft.com/en-ca/download/details.aspx?id=30679>`_. 

#. Navigate to http://data.boundlessgeo.com/gdal_support/.

#. Download the file with a version number that most closely matches the version of Boundless Suite.

   .. note:: This file requires a 32-bit Java/Tomcat.

#. Extract the file :file:`gdal-A.B.C.jar` (where A.B.C is a version number) from the archive. Copy into :file:`<TOMCAT_HOME>\\webapps\\geoserver\\WEB-INF\\lib\\`, where :file:`<TOMCAT_HOME>` is the location where Tomcat is installed (such as :file:`C:\\Program Files\\Tomcat\\`).

#. If Tomcat is installed as a service:

   #. Extract the full contents of the archive to :file:`<TOMCAT_HOME>\\bin\\`.

   #. Restart Tomcat.

#. If Tomcat is not installed as a service:

   #. Extract the full contents of the archive to any folder (such as :file:`C:\\Program Files\\GDAL\\`).

   #. Edit the file :file:`<TOMCAT_HOME>\\bin\\setenv.bat` and add the following line::

         set "PATH=C:\Program Files\GDAL\;%PATH%"
 
      replacing :file:`C:\\Program Files\\GDAL\\` with the path where the archive was extracted.

   #. Restart Tomcat.

Continue reading at the :ref:`dataadmin.gdal.verify` section.

OS X application server
~~~~~~~~~~~~~~~~~~~~~~~

.. note:: This section is for installing GDAL image formats on an OS X-based installation of Boundless Suite for Application Servers (WAR bundle).

#. Navigate to:  http://data.boundlessgeo.com/gdal_support/

#. Download the file with a version number that most closely matches the version of Boundless Suite. For example, the file :file:`gdal_osx_suite_40.zip` would be appropriate for Boundless Suite 4.x.

#. Extract the contents of the archive to a location of your choosing.

#. Create (or edit) a file called :file:`setenv.sh` located in $TOMCAT_HOME/bin, and add the following line:

   .. code-block:: console

      export DYLD_LIBRARY_PATH=<GDAL_PATH>:$DYLD_LIBRARY_PATH

   replacing <GDAL_PATH> with the directory the archive was extracted to in the previous step.

#. Extract the file :file:`gdal-A.B.C.jar` (where A.B.C is a version number) from the archive. Copy into :file:`<TOMCAT_HOME>\\webapps\\geoserver\\WEB-INF\\lib\\`, where :file:`<TOMCAT_HOME>` is the location where Tomcat is installed (such as :file:`/opt/tomcat/`).

#. Restart Tomcat.

Continue reading at the :ref:`dataadmin.gdal.verify` section.


.. _dataadmin.gdal.verify:

Verification
------------

#. To verify that the GDAL image formats were enabled properly, navigate to the GeoServer web admin interface and log in with administrator credentials.

   .. note:: Please see the GeoServer reference documentation for more information about the GeoServer web admin interface.
   
#. Click on :guilabel:`Stores` and then :guilabel:`Add new Store`.  There should be many raster image formats, such as DTED, EHdr, AIG, and ENVIHdr in the list of formats.

   .. figure:: img/gdal_verify.png
      
      Verifying that GDAL image formats are available
