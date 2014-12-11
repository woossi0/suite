.. _intro.installation.mac.install:

Installing
==========

.. only:: basic

   This section describes how to perform a new installation of **OpenGeo Suite** |version| on Mac OS X. These instructions should only be followed if your system does not have OpenGeo Suite installed.

.. only:: enterprise

   This section describes how to perform a new installation of **OpenGeo Suite Enterprise** |version| on Mac OS X. These instructions should be only followed if your system does not have OpenGeo Suite installed.

.. note:: 

   If upgrading from a previous **major** version see the :ref:`Update <intro.installation.mac.update>` section. If updating from a previous **minor** version, please continue below.

Prerequisites
-------------

OpenGeo Suite has the following system requirements:

* **Operating System**: 10.7 or newer
* **Memory**: 1GB minimum (2GB recommended)
* **Disk space**: 1GB minimum (plus extra space for any loaded data)
* **Browser**: Any modern web browser is supported
* **Permissions**: Administrative rights

Installation
------------

The Mac installer for OpenGeo Suite is as an image made up several components that are installed separately. 

.. only:: basic

   .. figure:: img/apps-basic.png

      OpenGeo Suite for Mac OS X

.. only:: enterprise

   .. figure:: img/apps-ee.png

      OpenGeo Suite for Mac OS X

PostGIS.app
^^^^^^^^^^^

PostGIS ships as a self-contained application. Start by double-clicking :guilabel:`PostGIS.app``. You will see a "Welcome" window the first time the application is launched.

.. figure:: img/pgwelcome.png

   PostGIS Welcome dialog

.. note:: 

   If you get the message "PostGIS can't be opened because it is from an unidentified developer"

   #. Open **System Preferences**

   #. Select **Security & Privacy**

   #. Under **Allow apps downloaded from:** select **Anywhere**

You can check the PostgreSQL server status and perform other tasks from the PostGIS icon in the OS X menu bar.

.. figure:: img/pgmenu.png

   PostGIS menu

.. note:: While it is possible to run the PostGIS application directly from the installer disk image it is recommended you copy it to :file:`/Applications` and run from there.

GeoServer.app
^^^^^^^^^^^^^

GeoServer also ships as a self-contained application. Start by double-clicking :guilabel:`GeoServer.app`. You will see a "Welcome" window the first time the application is launched.

.. figure:: img/gsstarting.png

   GeoServer Welcome dialog

.. note:: 

   If you get the message "GeoServer can't be opened because it is from an unidentified developer"

   #. Open **System Preferences**

   #. Select **Security & Privacy**

   #. Under **Allow apps downloaded from:** select **Anywhere**

.. note:: The GeoServer application runs a Jetty web server that also contains GeoWebCache, GeoExplorer, and the OpenGeo Dashboard.

You can check the server status and perform other tasks from the GeoServer icon in the OSX menu bar.

.. figure:: img/gsmenu.png

   GeoServer menu

Once the server has fully started up a web browser will open and display the OpenGeo dashboard. 

.. todo:: Update Dashboard graphic

.. note:: While it is possible to run the GeoServer application directly from the installer disk image it is recommended you copy it to :file:`/Applications` and run from there. 

.. _intro.installation.mac.install.extensions:

GeoServer extensions
^^^^^^^^^^^^^^^^^^^^

Extensions to GeoServer are available in a folder called :guilabel:`GeoServer Extensions`.

Double-click to open this folder and you will see individual folders for each extension.

   .. only:: basic

      .. figure:: img/ext_folders-basic.png

         GeoServer extension folders

   .. only:: enterprise

      .. figure:: img/ext_folders-ee.png

         GeoServer extension folders

To install an extension:

#. Select :guilabel:`Open Webapps Directory` from the GeoServer menu.

   .. note: GeoServer must be running to see this menu.

   .. figure:: img/ext_webappsmenu.png

      Opening the webapps directory from the GeoServer menu

#. In the Finder window that appears, navigate to :file:`geoserver/WEB-INF/lib`.

#. For a given extension, copy the contents of that folder (not the folder itself) into :file:`geoserver/WEB-INF/lib`.

   .. figure:: img/ext_copy1.png

      Selecting the files for the WPS extension...

   .. figure:: img/ext_copy2.png

      ...and copying the files to :file:`geoserver/WEB-INF/lib`

#. Quit and re-open GeoServer.

   .. figure:: img/ext_quit.png

      Quitting GeoServer

.. note:: Read more about :ref:`GeoServer extensions <intro.extensions>`.

.. _intro.installation.mac.install.cli:

CLI tools
^^^^^^^^^

The CLI tools package contains all the command line tools for OpenGeo Suite:

* :ref:`Boundless SDK <webapps.sdk.install>`
* PostGIS data conversion utilities such as ``shp2pgsql``
* `GDAL/OGR <http://www.gdal.org/>`_ format translation utilities
* `PDAL <http://www.pointcloud.org/>`_ tools for working with LIDAR point cloud data

.. note:: Boundless SDK requires that a `Java Development Kit (JDK) <http://www.oracle.com/technetwork/java/javase/downloads/index.html>`_ is installed on your system in order to run.

To install the CLI Tools:

#. Double-click the :guilabel:`OpenGeo CLI Tools.pkg` file. 

   .. figure:: img/clitools.png

      OpenGeo Suite Command Line Tools Installer

#. Work through the installer dialogs accepting the defaults. 

#. The CLI Tools package installs everything into :file:`/usr/local/opengeo`. This directory must be added to the ``PATH``. Add the following line to your ``.profile``::

     export PATH=/usr/local/opengeo/bin:$PATH

   .. note:: Alternatively you can run the :file:`/usr/local/opengeo/bin/opengeo-clitools-doctor` utility which will create symlinks for all the tools into :file:`/usr/local/bin`. Use this method with caution as it may conflict with different versions of the same tools already installed on the system.

PostGIS Utilities
^^^^^^^^^^^^^^^^^

The PostGIS Utilities package contains utility applications for working with 
PostGIS and PostgreSQL:

* **pgAdmin** - A database manager for PostgreSQL
* **pgShapeLoader** - A graphical Shapefile loader/dumper

Double-click to run the applications. 

.. figure:: img/pgadmin.png

   pgAdmin PostgreSQL Manager

.. figure:: img/pgshapeloader.png

   PostGIS Shapefile Loader

.. note:: As with the other applications of OpenGeo Suite, it is recommended that you copy them to :file:`/Applications` for subsequent usage.

After installation
------------------

Installation is now complete. After installation, please see the section on :ref:`intro.installation.mac.misc`.
