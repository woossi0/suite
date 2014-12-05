.. _intro.installation.windows.components:

Components
==========

The following is a list of components available for OpenGeo Suite on Windows. These are accessible from the **Components** page of the installer.

Adding or removing components to OpenGeo Suite can be accomplished by running the installer again and selecting or deselecting the appropriate component.

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
       - :ref:`Web Processing Service (WPS) <processing>` support.
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
       - :ref:`Web Processing Service (WPS) <processing>` support.
     * - GeoPackage
       - GeoPackage data source support.
     * - CSW
       - Catalogue Service for Web (CSW) support.
     * - Mapmeter
       - :ref:`Mapmeter <sysadmin.mapmeter>` monitoring service.
     * - CSS Styling
       - CSS map styling support.
     * - MongoDB
       - :ref:`MongoDB <dataadmin.mongodb>` database support.
     * - Clustering
       - :ref:`Clustering <sysadmin.clustering>` plug-ins.
     * - GDAL Image Formats
       - Additional raster formats support as part of GDAL integration.
     * - Oracle
       - :ref:`Oracle <dataadmin.oracle>` database support.
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
     - PostGIS command line data loading utilities such as ``psql`` and ``shp2pgsql``. 
   * - pgAdmin
     - Graphical PostGIS/PostgreSQL database manager. Also includes **pgShapeloader** a graphical utility for loading data into PostGIS
   * - GDAL/OGR
     - Spatial data manipulation utilities such as ``gdal_translate`` and ``ogr2ogr``.

Dev Tools
---------

.. only:: basic

	.. list-table::
	   :widths: 20 80
	   :stub-columns: 1
	   :class: table-leftwise
	   
	   * - Boundless SDK
	     - Toolkit for building web map applications.
	
.. only:: enterprise

	.. list-table::
	   :widths: 20 80
	   :stub-columns: 1
	   :class: table-leftwise
	   
	   * - Boundless SDK
	     - Toolkit for building web map applications.
	   * - GeoScript
	     - Scripting extension for GeoServer.
