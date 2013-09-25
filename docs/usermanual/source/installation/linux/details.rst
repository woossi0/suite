.. _installation.linux.suite.details:

Installation details
====================

This section discusses some helpful information about OpenGeo Suite Linux packages, as well as how to access the various components after installation.

Starting/Stopping OpenGeo Suite
-------------------------------

GeoServer, GeoExplorer, and all other web-based containers including the documentation are installed into the existing Tomcat instance on the machine, if applicable. Starting and stopping these applications are therefore accomplished by managing them through the standard Tomcat instance. Tomcat is installed as a service under the name of :command:`tomcat6` (or possibly :command:`tomcat5` or just :command:`tomcat`, depending on your system), and can be managed accordingly:

.. code-block:: bash

   service tomcat6 start
   service tomcat6 stop

PostGIS is also installed as a service, under the name of :command:`postgresql`, and can be managed in the same way as Tomcat:

.. code-block:: bash

   service postgresql start
   service postgresql stop

Both services are started and set to run automatically when OpenGeo Suite is installed.

Accessing web applications
--------------------------

The easiest way to launch the web-based applications contained in OpenGeo Suite is via the Dashboard. All web applications are linked from this application. The Dashboard is accessible via the following URL::

  http://localhost:8080/dashboard/

.. note:: This assumes Tomcat is running on port 8080. You will need to change the port number if your Tomcat installation is serving on a different port.

.. list-table::
   :widths: 30 70
   :header-rows: 1

   * - Application
     - URL
   * - OpenGeo Suite Dashboard
     - http://localhost:8080/dashboard/
   * - GeoServer
     - http://localhost:8080/geoserver/
   * - GeoExplorer
     - http://localhost:8080/geoexplorer/
   * - Documentation
     - http://localhost:8080/opengeo-docs/

Accessing PostGIS
-----------------

You can access PostGIS in one of two ways: though the terminal **psql** application, or via a graphical interface with **pgAdmin** (:command:`pgadmin3`). Both commands should be on the path and can be invoked from any shell/terminal window. pgAdmin should also be in the Applications menu, if it exists.

PostGIS is running on port 5432, with administrator user name and password **opengeo** / **opengeo**.

Packages
--------

The following is a list of OpenGeo Suite packages and their functions:

.. list-table::
   :widths: 20 80
   :header-rows: 1

   * - Package
     - Description
   * - ``opengeo``
     - Full installation of OpenGeo Suite (equivalent to ``opengeo-server`` plus ``opengeo-client``)
   * - ``opengeo-server``
     - All server tools including GeoServer and GeoWebCache
   * - ``opengeo-client``
     - All client tools including pgAdmin and pgShapeloader
   * - ``postgis``
     - PostGIS, a spatial database
   * - ``geoserver``
     - GeoServer, a web mapping server
   * - ``geoserver-mapmeter``
     - Mapmeter extension to GeoServer (see http://mapmeter.com)
   * - ``geoserver-clustering``
     - Clustering extension for GeoServer
   * - ``geoserver-css``
     - CSS styling extension for GeoServer
   * - ``geoserver-csw``
     - Catalogue Service for Web (CSW) extension for GeoServer
   * - ``geoserver-wps``
     - Web Processing Service (WPS) extension for GeoServer
   * - ``geowebcache``
     - GeoWebCache, a tile caching server
   * - ``geoexplorer``
     - GeoExplorer, a browser-based map viewing/editing tool

System requirements
-------------------

OpenGeo Suite has the following system requirements:

* Operating System: Ubuntu 10.04-12.04, CentOS 5-6, Fedora 18-19, Red Hat Enterprise Linux 5-6
* Memory: 512MB minimum (1GB recommended)
* Disk space: 750MB minimum (plus extra space for any loaded data)
* Browser: Any modern web browser is supported
* Permissions: Super user privileges are required for installation
