.. _whatsnew:

What's new in |version|
=======================

Each new version of OpenGeo Suite includes numerous fixes and component upgrades.

In addition, OpenGeo Suite |version| has been updated features, including:

   **Composer**

   :ref:`Composer <webmaps.composer>` is a new integrated tool for easily making maps and styling layers in GeoServer. It includes the all-new :ref:`YSLD <cartography.ysld>` markup language which vastly simplifies map styling.

   Composer is available for OpenGeo Suite Enterprise only.

**OpenLayers 3.4.0**

The latest version of OpenLayers 3 is included, offering new visualization options for modern browsers including `integration with Cesium <http://openlayers.org/ol3-cesium/>`_ for visualizing data on a globe.

**Java 7**

Java 7 is now required for OpenGeo Suite on all platforms. OpenGeo Suite is tested with both Oracle JRE and OpenJDK.

**PostGIS 2.1.7**

PostGIS has been upgraded to version 2.1.7. This contains the following improvements.

   * Substantial disk space savings for users with large tables.

   * Fixed critical bug in GeoJSON ingestion

**GeoServer 2.7**

The latest branch of GeoServer, version 2.7, is included. This contains the following improvements.

   * Color composition and blending allows for greater control over how overlapping layers are styled

   * Relative time support in WMS/WCS

   * Web Processing Service (WPS) improvements for clustering, limits, security, and dismiss

   * Improved WFS Cascade with support for republishing stored queries

 In **GeoServer for OpenGeo Suite Enterprise**

   * Clustering Extension improvements related to UI performance with large catalogs and JDBCConfig

   * :ref:`Composer <webmaps.composer>`, for writing GeoServer styles in :ref:`YSLD <cartography.ysld>`, has been updated with an OpenLayers 3 export option, asynchronous database import improvements and bug fixes. Composer is available from GeoServer Admin (left sidebar bottom link).

