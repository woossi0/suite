.. _intro.installation.ubuntu.packages:

Ubuntu Linux packages
=====================

OpenGeo Suite for Ubuntu is broken up into a number of discrete packages. This section describes all of the available packages.

The packages are managed through the standard package management system for Ubuntu called `apt <https://help.ubuntu.com/community/AptGet/Howto>`_. All packages can be installed with the following command::

  sudo apt-get install <package>

where ``<package>`` is any one of the package names listed below.

Top-level packages
------------------

The following packages are considered "meta" packages that only depend on other upstream packages, and contain no libraries or binaries themselves.

.. tabularcolumns:: |p{3cm}|p{6cm}|p{6cm}|
.. list-table::
   :header-rows: 1
   :widths: 20 40 40
   :class: non-responsive

   * - Package
     - Description
     - Dependencies
   * - ``opengeo``
     - Top level package, installs everything
     - ``opengeo-server`` ``opengeo-client``
   * - ``opengeo-server``
     - All server packages
     - ``postgis21-postgresql93`` ``geoserver`` ``geowebcache`` ``geoexplorer`` ``opengeo-dashboard`` ``opengeo-docs`` ``opengeo-tomcat``
   * - ``opengeo-client``
     - All client packages
     - ``postgis21`` ``pgadmin3`` ``pdal``
   * - ``opengeo-webapp-sdk``
     - Boundless SDK
     -

Server packages
---------------

The following packages contain the server components of OpenGeo Suite. These packages are installed via the ``opengeo-server`` meta-package.

.. tabularcolumns:: |p{3cm}|p{6cm}|p{6cm}|
.. list-table::
   :header-rows: 1
   :widths: 20 40 40
   :class: non-responsive

   * - Package
     - Description
     - Dependencies
   * - ``postgresql-9.3-postgis-2.1``
     - PostGIS 2.1 extensions for PostgreSQL 9.3
     - ``postgis-2.1`` ``postgresql-9.3``
   * - ``postgresql-9.3-pointcloud``
     - Point cloud extensions for PostgreSQL 9.3
     - ``postgresql93`` ``libght``
   * - ``geoserver``
     - GeoServer geospatial data server
     -
   * - ``opengeo-jai``
     - Java Advanced Imaging, enhanced image rendering abilities
     -
   * - ``geowebcache``
     - GeoWebCache tile caching server
     -
   * - ``geoexplorer``
     - GeoExplorer map composing application
     -
   * - ``opengeo-dashboard``
     - OpenGeo Suite dashboard
     -
   * - ``opengeo-docs``
     - OpenGeo Suite documentation
     -
   * - ``opengeo-tomcat7``
     - OpenGeo Suite webapps for Tomcat 7
     - ``tomcat7``

Client/library packages
-----------------------

The following packages contain the client components of OpenGeo Suite. These packages are installed via the ``opengeo-client`` meta-package.

.. tabularcolumns:: |p{3cm}|p{6cm}|p{6cm}|
.. list-table::
   :header-rows: 1
   :widths: 20 40 40
   :class: non-responsive

   * - Package
     - Description
     - Dependencies
   * - ``postgis-2.1``
     - PostGIS 2.1 userland binaries and libraries
     - ``libpq5`` ``geos`` ``proj`` ``libgdal``
   * - ``pgadmin3``
     - pgAdmin database manager for PostgreSQL
     - ``wxGTK``
   * - ``libght``
     - GeoHash Tree library for point cloud data
     -
   * - ``pdal``
     - Point Cloud format library
     - ``libgeotiff`` ``laszip`` ``libgdal`` ``geos`` ``postgresql93-libs``
   * - ``libgdal``
     - GDAL/OGR format library
     - ``proj`` ``geos`` ``postgresql93-libs``
   * - ``libgeos``
     - GEOS geometry engine
     -
   * - ``laszip``
     - LiDAR compression utility
     -
   * - ``libgeotiff``
     - GeoTIFF library
     -
   * - ``proj``
     - Cartographic projection library
     -

GeoServer extensions
--------------------

The following packages add additional functionality to GeoServer. After installing any of these packages, you will need to restart Tomcat:

.. code-block:: console

   sudo service tomcat7 restart

For more information, please see the section on :ref:`GeoServer extensions <intro.extensions>`.

The following packages are available:

.. list-table::
   :header-rows: 1
   :widths: 20 40 40
   :class: non-responsive

   * - Package
     - Description
     - Availability
   * - ``geoserver-arcsde``
     - ArcSDE middleware extension for GeoServer
     - OpenGeo Suite Enterprise only
   * - ``geoserver-app-schema``
     - Application Schema support
     - OpenGeo Suite Enterprise only
   * - ``geoserver-cluster``
     - Clustering extension for GeoServer. Use with ``geoserver-jdbcconfig``.
     - OpenGeo Suite Enterprise only
   * - ``geoserver-css``
     - CSS styling extension for GeoServer
     -
   * - ``geoserver-csw``
     - Catalogue Service for Web (CSW) extension for GeoServer
     - 
   * - ``geoserver-gdal``
     - GDAL extension for GeoServer
     - OpenGeo Suite Enterprise only
   * - ``geoserver-geopackage``
     - GeoPackage extension for GeoServer
     - 
   * - ``geoserver-db2``
     - DB2 database extension for GeoServer
     - OpenGeo Suite Enterprise only
   * - ``geoserver-jdbcconfig``
     - Database catalog and configuration extension for GeoServer. Use with ``geoserver-cluster``.
     - OpenGeo Suite Enterprise only
   * - ``geoserver-inspire``
     - Additional WMS and WFS metadata configuration for INSPIRE compliance
     - OpenGeo Suite Enterprise only
   * - ``geoserver-mapmeter``
     - Mapmeter extension for GeoServer
     - OpenGeo Suite Enterprise only
   * - ``geoserver-mongodb``
     - MongoDB data format extension for GeoServer
     - OpenGeo Suite Enterprise only
   * - ``geoserver-oracle``
     - Oracle database extension for GeoServer
     - OpenGeo Suite Enterprise only
   * - ``geoserver-script``
     - Scripting extension for GeoServer
     - OpenGeo Suite Enterprise only
   * - ``geoserver-sqlserver``
     - SQL Server database extension for GeoServer
     - OpenGeo Suite Enterprise only
   * - ``geoserver-wps``
     - Web Processing Service (WPS) extension for GeoServer
     - 
