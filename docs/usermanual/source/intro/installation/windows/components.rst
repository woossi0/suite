.. _intro.installation.windows.components:

Components
==========

The following is a list of components available for OpenGeo Suite on Windows. These are accessible from the **Components** page of the installer.

Adding or removing components to OpenGeo Suite can be accomplished by running the installer again and selecting or deselecting the appropriate component.

.. only:: basic

   .. figure:: img/fullcomponents.png

      Full list of available components

.. only:: enterprise

   .. figure:: img/fullcomponents-ent.png

      Full list of available components

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
   * - GeoExplorer
     - Map viewing and editing application.
   * - GeoWebCache
     - Tile caching server.

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

Client Tools
------------

.. list-table::
   :widths: 20 80
   :stub-columns: 1
   :class: table-leftwise

   * - GDAL/OGR
     - Spatial data manipulation utilities such as ``gdal_translate`` and ``ogr2ogr``.
   * - pgAdmin
     - Graphical PostGIS/PostgreSQL database manager. Also includes **pgShapeloader** a graphical utility for loading data into PostGIS
   * - PostGIS Utilities
     - PostGIS command line data loading utilities such as ``psql`` and ``shp2pgsql``. 

Dev Tools
---------

.. list-table::
   :widths: 20 80
   :stub-columns: 1
   :class: table-leftwise
	   
   * - Boundless SDK
     - Toolkit for building web map applications.
