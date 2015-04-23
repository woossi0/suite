.. _intro.installation.mac.components:

Components
==========

The following is a list of components available for OpenGeo Suite on Mac OS X. These are accessible from the OpenGeo Suite disk image.

Adding or removing components to OpenGeo Suite can be accomplished by :ref:`installing <intro.installation.mac.install>` or :ref:`uninstalling <intro.installation.mac.uninstall>` the appropriate component. Extensions can only be uninstalled by deleting the files for that extension from your :file:`geoserver/WEB-INF/lib` directory.

.. figure:: img/apps.png

      OpenGeo Suite components

GeoServer
---------

.. list-table::
   :stub-columns: 1
   :header-rows: 1
   :class: non-responsive

   * - Component
     - Description
     - Availability
   * - GeoServer
     - Server implementing OGC compliant map and feature services
     - 
   * - Composer
     - Map styling and composition application
     - OpenGeo Suite Enterprise only
   * - GeoExplorer
     - Map viewing and editing application
     - 
   * - GeoWebCache
     - Tile caching server
     -

PostGIS
-------

.. list-table::
   :stub-columns: 1
   :header-rows: 1
   :class: non-responsive

   * - Component
     - Description
     - Availability
   * - PostGIS
     - PostgreSQL/PostGIS spatial database
     -

GeoServer Extensions
--------------------
 
.. list-table::
   :stub-columns: 1
   :header-rows: 1
   :class: non-responsive

   * - Component
     - Description
     - Availability
   * - ArcSDE
     - ArcSDE database support.
     - OpenGeo Suite Enterprise only
   * - AppSchema
     - Application Schema support.
     - OpenGeo Suite Enterprise only
   * - Clustering
     - :ref:`Clustering <sysadmin.clustering>` plug-ins.
     - OpenGeo Suite Enterprise only
   * - CSS Styling
     - CSS map styling support.
     - 
   * - CSW
     - Catalogue Service for Web (CSW) support.
     - 
   * - DB2
     - DB2 database support.
     - OpenGeo Suite Enterprise only
   * - GDAL Image Formats
     - Additional raster formats support as part of GDAL integration.
     - OpenGeo Suite Enterprise only
   * - GeoPackage
     - GeoPackage data source support.
     - 
   * - GeoScript
     - Scripting extension for GeoServer.
     - OpenGeo Suite Enterprise only
   * - INSPIRE
     - Additional WMS and WFS metadata configuration for INSPIRE compliance
     - OpenGeo Suite Enterprise only
   * - Mapmeter
     - :ref:`Mapmeter <sysadmin.mapmeter>` monitoring service.
     - OpenGeo Suite Enterprise only
   * - MongoDB
     - :ref:`MongoDB <dataadmin.mongodb>` database support.
     - OpenGeo Suite Enterprise only
   * - Oracle
     - :ref:`Oracle <dataadmin.oracle>` database support.
     - OpenGeo Suite Enterprise only
   * - SQL Server
     - SQL Server database support.
     - OpenGeo Suite Enterprise only
   * - WPS
     - :ref:`Web Processing Service (WPS) <processing>` support.
     - 

PostGIS Utilities
-----------------

.. list-table::
   :stub-columns: 1
   :header-rows: 1
   :class: non-responsive

   * - Component
     - Description
     - Availability
   * - pgAdmin3
     - Graphical PostGIS/PostgreSQL database manager.
     -
   * - pgShapeLoader
     - Graphical utility for loading data into PostGIS.
     -

CLI Tools
---------

.. list-table::
   :stub-columns: 1
   :header-rows: 1
   :class: non-responsive

   * - Component
     - Description
     - Availability
   * - Boundless SDK
     - Toolkit for building web map applications.
     -
   * - PostGIS Client Tools
     - PostGIS command line data loading utilities such as ``shp2pgsql``. 
     -
   * - PostgreSQL Client Tools
     - PostgreSQL command line data loading utilities such as ``psql``. 
     -
   * - GDAL
     - Spatial data manipulation utilities such as ``gdal_translate`` and ``ogr2ogr``.
     -
   * - PROJ.4
     - Cartographic Projections Library.
     -
   * - GEOS
     - Geometry Engine, Open Source.
     -
   * - LIBTIFF
     - TIFF Library and Utilities.
     -
   * - GEOTIFF
     - LIBTIFF extension for reading and writing GeoTIFF information tags.
     -
   * - LASZIP
     - Free and lossless LiDAR compression library.
     -
   * - PDAL
     - Point Data Abstraction Library.
     -
   * - ANT
     - Apache Ant build tool, used by Boundless SDK.
     -