.. _intro.installation.windows.components:

Components
==========

The following is a list of components available for OpenGeo Suite on Windows. These are accessible from the **Components** page of the installer.

Adding or removing components to OpenGeo Suite can be accomplished by running the installer again and selecting or deselecting the appropriate component.

.. todo:: More details on adding components?

Top level
---------
.. tabularcolumns:: |p{4cm}|p{11cm}|
.. list-table::
   :widths: 20 80
   :stub-columns: 1
   :class: table-leftwise

   * - PostGIS
     - The PostgreSQL/PostGIS spatial database.
   * - GeoServer
     - Server implementing OGC compliant map and feature services.
   * - GeoWebCache
     - Tile caching server.
   * - GeoExplorer
     - Map viewing and editing application.

GeoServer Extensions
--------------------

.. only:: basic

  .. list-table::
     :widths: 20 80
     :stub-columns: 1
     :class: table-leftwise
     
     * - WPS
       - Web Processing Service (WPS) support.
     * - GeoPackage
       - GeoPackage data source support.
     * - CSW
       - Catalogue Service for Web (CSW) support.
     
.. only:: enterprise

  .. list-table::
     :widths: 20 80
     :stub-columns: 1
     :class: table-leftwise
     
     * - WPS
       - Web Processing Service (WPS) support.
     * - GeoPackage
       - GeoPackage data source support.
     * - CSW
       - Catalogue Service for Web (CSW) support.
     * - Mapmeter
       - Mapmeter monitoring service.
     * - CSS Styling
       - CSS map styling support.
     * - MongoDB
       - MongoDB database support.
     * - Clustering
       - Clustering plug-ins.
     * - GDAL Image Formats
       - Additional raster formats support as part of GDAL integration.
     * - Oracle
       - Oracle database support.
     * - ArcSDE
       - ArcSDE database support.
     * - DB2
       - DB2 database support.
     * - SQL Server
       - SQL Server database support.
     
Client Tools
------------

.. list-table::
   :widths: 20 80
   :stub-columns: 1
   :class: table-leftwise

   * - PostGIS
     - PostGIS command line data loading utilities.
   * - pgAdmin
     - Graphical PostGIS/PostgreSQL database manager.
   * - GDAL/OGR
     - Spatial data manipulation utilities.

Dev Tools
---------

.. list-table::
   :widths: 20 80
   :stub-columns: 1
   :class: table-leftwise

   * - Boundless SDK
     - Toolkit for building web map applications.
   * - GeoScript
     - Scripting extension for GeoServer.