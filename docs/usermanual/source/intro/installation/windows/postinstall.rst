.. _intro.installation.windows.postinstall:

After installation: Working with OpenGeo Suite for Windows
==========================================================

This document contains information about various tasks specific to OpenGeo Suite for Windows. 

.. |postgresql.conf| replace:: :file:`C:\\ProgramData\\Boundless\\OpenGeo\\pgsql\\9.3\\postgresql.conf`

.. todo:: Might want to make the PG version a global var.

Starting and stopping OpenGeo services
--------------------------------------

OpenGeo Suite is comprised of two services:

#. **OpenGeo Jetty** - The `Jetty <http://www.eclipse.org/jetty/>`_ web server that contains all the OpenGeo web applications such as GeoServer, GeoWebCache, and GeoExplorer. 

#. **OpenGeo PostgreSQL** - The `PostgreSQL <http://www.postgresql.org/>`_ database server with the PostGIS spatial extensions. 

The services can be started and stopped directly from the Start Menu by navigating to :menuselection:`All Programs --> OpenGeo Suite` and using the :guilabel:`Start` and :guilabel:`Stop` short cuts. They must be run with Adminstrator rights.

.. figure:: img/startstop_services.png

   Starting and stopping OpenGeo Suite services

Services can also be controlled from the Windows :guilabel:`Services` dialog available by navigating to :menuselection:`Administrative Tools --> Services` from the Windows :guilabel:`Control Panel`.

Service port configuration
--------------------------

The Jetty and PostgreSQL services run on ports **8080** and **5432** respectively. These ports can often conflict with existing services on the system, in which case the ports must be changed. 

Changing the Jetty port
^^^^^^^^^^^^^^^^^^^^^^^

To change the Jetty port:

#. Open the file :file:`C:\\Program Files\\Boundless\\OpenGeo\\jetty\\start.ini` in a text editor such as Notepad.

   .. note:: If you're running Windows 64 bit, the path will be :file:`C:\\Program Files (x86)\\Boundless\\OpenGeo\\jetty\\start.ini`.

#. Edit the property named ``jetty.port`` near the top of the file changing its value from ``8080`` to a number that that does not conflict with any existing services on the machine. 

.. note:: It is a common convention for Java services like Jetty to use port values greater than 8000. 

#. Optionally, change the ``STOP.PORT`` property in the same manner.

#. Restart OpenGeo Jetty service.

Changing the PostgreSQL port
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To change the PostgreSQL port:

#. Open the file :file:`C:\\Program Files\\Boundless\\OpenGeo\\pgsql\\postgresql.conf` in a text editor such as Notepad.

#. Search or the ``port`` property (around line 63), uncomment it and change its value from ``5432`` to a number that does not conflict with any existing services on the machine.

#. Restart OpenGeo PostgreSQL service.

.. _intro.installation.windows.postinstall.datadir:

GeoServer Data Directory
------------------------

The **GeoServer Data Directory** is the location on the file system where GeoServer stores all of its configuration, and (optionally) file-based data.

By default, this directory is located at :file:`C:\\ProgramData\\Boundless\\OpenGeo\\geoserver`. There exists a shortcut to this location in the Start Menu at :menuselection:`OpenGeo Suite --> GeoServer --> Data Directory`.

To point GeoServer to an alternate location:

#. Create a new **System** environment variable named ``GEOSERVER_DATA_DIR``.

#. Set the value to the desired directory.

   .. figure:: img/gs_data_dir.png

      Setting GeoServer Data Directory  

#. Restart the OpenGeo Jetty service.

.. note:: You may have to restart Windows itself for the environment variable change to be picked up.

.. _intro.installation.windows.postinstall.pgconfig:

PostgreSQL Configuration
------------------------

PostgreSQL configuration is controlled within the ``postgresql.conf`` file. This
file is located at:

|postgresql.conf|

.. note:: The :file:`ProgramData` directory is hidden, so it will not display in standard directory listings.

Installing libjpeg-turbo
------------------------

The libjpeg-turbo extension provides a significant performance enhancement for JPEG encoding in GeoServer WMS output.

It is installed and configured by default in OpenGeo Suite Enterprise installers. For OpenGeo Suite for Application Servers, the GeoServer extension is instlled by default, but the native libraries willl need to be installed manually.

To perform the installation of the libjpeg-turbo native libraries:

#. Download the `latest stable package for your platform <http://sourceforge.net/projects/libjpeg-turbo/files/>`_. Make sure to match the architecture (32 or 64 bit).
#. Perform the installation.
#. *(Windows only)* Make sure that the location where the DLL files were installed is added to your system's PATH environment variable.
#. *(Linux only)* Make sure that the location where the library files were installed is added to your system's LD_LIBRARY_PATH environment variable for the Java process. This may happen automatically.
#. Restart GeoServer.

.. note:: For more information, please see the `GeoServer documentation <../../../geoserver/extensions/libjpeg-turbo/>`_or the `libjpeg-turbo website <http://libjpeg-turbo.virtualgl.org/>`_.


