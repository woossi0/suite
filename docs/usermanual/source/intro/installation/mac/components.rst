.. _intro.installation.mac.components:

Components
==========

The following is a list of components available for OpenGeo Suite on Mac OS X. These are accessible from the OpenGeo Suite disk image.

Adding or removing components to OpenGeo Suite can be accomplished by :ref:`installing <intro.installation.mac.install>` or :ref:`uninstalling <intro.installation.mac.uninstall>` the appropriate component. Extensions can only be uninstalled by deleting the files for that extension from your :file:`geoserver/WEB-INF/lib` directory.

.. only:: basic

   .. figure:: img/apps-basic.png

      OpenGeo Suite Components

.. only:: enterprise

   .. figure:: img/apps-ee.png

      OpenGeo Suite Components

GeoServer
---------

.. only:: basic

  .. list-table::
     :widths: 20 80
     :stub-columns: 1
     :class: table-leftwise

     * - GeoServer
       - Server implementing OGC compliant map and feature services.
     * - GeoExplorer
       - Map viewing and editing application.
     * - GeoWebCache
       - Tile caching server.

.. only:: enterprise

  .. list-table::
     :widths: 20 80
     :stub-columns: 1
     :class: table-leftwise     

     * - GeoServer
       - Server implementing OGC compliant map and feature services.
     * - Composer
       - Map styling application.
     * - GeoExplorer
       - Map viewing and editing application.
     * - GeoWebCache
       - Tile caching server.

PostGIS
-------

.. list-table::
   :widths: 20 80
   :stub-columns: 1
   :class: table-leftwise

   * - PostGIS
     - The PostgreSQL/PostGIS spatial database.

GeoServer Extensions
--------------------

.. only:: basic

  .. list-table::
     :widths: 20 80
     :stub-columns: 1
     :class: table-leftwise
     
     * - CSW
       - Catalogue Service for Web (CSW) support.
     * - GeoPackage
       - GeoPackage data source support.
     * - WPS
       - :ref:`Web Processing Service (WPS) <processing>` support.
     
.. only:: enterprise

  .. list-table::
     :widths: 20 80
     :stub-columns: 1
     :class: table-leftwise
     
     * - ArcSDE
       - ArcSDE database support.
     * - Clustering
       - :ref:`Clustering <sysadmin.clustering>` plug-ins.
     * - CSS Styling
       - CSS map styling support.
     * - CSW
       - Catalogue Service for Web (CSW) support.
     * - DB2
       - DB2 database support.
     * - GDAL Image Formats
       - Additional raster formats support as part of GDAL integration.
     * - GeoPackage
       - GeoPackage data source support.
     * - GeoScript
       - Scripting extension for GeoServer.
     * - Mapmeter
       - :ref:`Mapmeter <sysadmin.mapmeter>` monitoring service.
     * - MongoDB
       - :ref:`MongoDB <dataadmin.mongodb>` database support.
     * - Oracle
       - :ref:`Oracle <dataadmin.oracle>` database support.
     * - SQL Server
       - SQL Server database support.
     * - WPS
       - :ref:`Web Processing Service (WPS) <processing>` support.

PostGIS Utilities
-----------------

.. list-table::
   :widths: 20 80
   :stub-columns: 1
   :class: table-leftwise

   * - pgAdmin3
     - Graphical PostGIS/PostgreSQL database manager. 
   * - pgShapeLoader
     - Graphical utility for loading data into PostGIS.

CLI Tools
---------

.. list-table::
   :widths: 20 80
   :stub-columns: 1
   :class: table-leftwise
	   
   * - Boundless SDK
     - Toolkit for building web map applications.
   * - PostGIS Client Tools
     - PostGIS command line data loading utilities such as ``shp2pgsql``. 
   * - PostgreSQL Client Tools
     - PostgreSQL command line data loading utilities such as ``psql``. 
   * - GDAL
     - Spatial data manipulation utilities such as ``gdal_translate`` and ``ogr2ogr``.
   * - PROJ.4
     - Cartographic Projections Library.
   * - GEOS
     - Geometry Engine, Open Source.
   * - LIBTIFF
     - TIFF Library and Utilities.
   * - GEOTIFF
     - LIBTIFF extension for reading and writing GeoTIFF information tags.
   * - LASZIP
     - Free and lossless LiDAR compression library.
   * - PDAL
     - Point Data Abstraction Library.
   * - ANT
     - Apache Ant build tool, used by Boundless SDK.
