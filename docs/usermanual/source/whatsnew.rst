.. _whatsnew:

.. _whatsnew.1.1.x:

What's new in |version|
=======================

This version is a bugfix release, and primarily fixes some issues with MapBox Vector tiles:

* Fixes an issue with vector tiles that would cause point features to jump around when zooming in.
* Adds support for the ``application/vnd.mapbox-vector-tile`` Mapbox Vector Tiles mime type. The legacy mime type of ``application/x-protobuf;type=mapbox-vector`` is still supported for backwards compatibility

If you are using OpenLayers to render the vector tiles returned from GeoServer we recommend using the latest version of OpenLayers. Old versions (e.g. OpenLayers 3) may show rendering errors with this Boundless Server version.

There are also various other bugfixes included.

What's new in 1.1.0
-------------------

This version contains numerous enhancements, component upgrades and bug fixes. Highlights include:

* Packages for Ubuntu 16 and CentOS 7 are now available.

* The version of Tomcat has been upgraded to 8.5 from 8.0.

* The Mapbox styling module has been updated to `support expressions <geoserver/styling/mbstyle/index.html>`_.

* GeoWebCache now has an expanded number of `REST management endpoints <geowebcache/rest/index.html>`_.

* The `backup/restore community module <geoserver/community/backuprestore/index.html>`_ has a number of updates to support dealing with store passwords and URLs.

* A minor version update for Spring to fix security vulnerabilities.

* The :ref:`GeoServices REST API <intro.extensions.gsr>` extension has many improvements in compatibility with the 
  latest official client API, including better support for filtered feature queries.

**Components included:**

* GeoServer 2.13
* GeoWebCache 1.13
* GeoTools 19
* PostgreSQL 9.6
* PostGIS 2.3
* GDAL 1.11.5

.. _whatsnew.1.0.x:

What's new in 1.0.2
-------------------

This version fixes an issue with cancelling GeoWebCache tasks through the web interface.

What's new in 1.0.1
-------------------

This version is a bugfix release, and includes various fixes for GeoWebCache and GeoServer:

* Fixed errors in the GWC Seed endpoints.

* GWC FullWMS mode works again.

* The :ref:`GeoServices REST API <intro.extensions.gsr>` extension has many improvements in compatibility with the latest official client API

* Several rendering errors in the `MBStyle <geoserver/styling/mbstyle/index.html>`_ extension have been fixed.

* And more!

What's new in 1.0.0
-------------------

This version contains numerous component upgrades and bug fixes. Highlights include:

* **Boundless Suite** has been renamed to **Boundless Server**, and the version has been reset to 1.0.0. This follows from **Boundless Suite 4.10.0**.

* The GeoServer REST API has been updated, and includes improved `documentation <geoserver/rest/index.html>`_. The updated API should still be backwards-compatible.

* The :ref:`WPS <processing.intro.wps>` and :ref:`MBTiles <dataadmin.mbtiles>` extensions have been removed, and are instead included by default.

* The :ref:`GeoServices REST API <intro.extensions.gsr>` extension has been added. It adds a REST API which allows limited compatiblity with ArcGIS clients.

* The :ref:`Printing <intro.extensions.printng>` extension has been added. It provides a REST API for rendering documents as images or PDFs.

* Improved **support for MBstyle** `markup language <geoserver/styling/mbstyle/index.html>`_, including a new :ref:`tutorial <cartography.mbstyle.tutorial>`.

* **Layer groups have a new entry type** called `style group <geoserver/data/webadmin/layergroups.html>`_ for defining a layer group based on the contents of a style document.

**Components included:**

* GeoServer 2.12
* GeoWebCache 1.12
* GeoTools 18
* PostgreSQL 9.6
* PostGIS 2.3
* GDAL 1.11.5
