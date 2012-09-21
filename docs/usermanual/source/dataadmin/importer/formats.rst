.. _dataadmin.importer.formats:

.. warning:: Document status: **Draft**

Supported data formats
======================

Basic support
-------------

.. todo :: The supported formats via the GUI importer are limited to one vector type and one raster type - correct? 

The Layer Importer supports the following files:

* Shapefile
* GeoTIFF

The following databases are supported:

* PostGIS
* Oracle
* Microsoft SQL Server


.. todo:: Enabling support for Oracle and SQL Server (see also SUITE-1141)

    Oracle and SQL Server require extra drivers to be installed.  Some of these drivers are found as part of your database installation, and are not included as part of the OpenGeo Suite.

    * `Install instructions for Oracle <../../geoserver/data/database/oracle/>`_
    * `Install instructions for SQL Server <../../geoserver/data/database/sqlserver/>`_


REST API supported formats
--------------------------

The GeoServer Layer Importer REST API supports the following formats:

* Vector—Shapefiles, Java Property files, H2 Database, SpatiaLite

* Raster—Any single file raster format such as GeoTIFF, DTED (Digital Terrain Elevation Data), or JPEG 
