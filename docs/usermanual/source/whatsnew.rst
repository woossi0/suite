.. _whatsnew:

What's new in |version|
=======================

Each new version of OpenGeo Suite includes numerous fixes and component upgrades.

In addition, OpenGeo Suite |version| has been updated with all-new features, including:

**Composer**

:ref:`Composer <webmaps.composer>` is a new integrated tool for easily making maps and styling layers in GeoServer. It includes the all-new :ref:`YSLD <cartography.ysld>` markup language which vastly simplifies map styling.

Composer is available for OpenGeo Suite Enterprise only.

**OpenLayers 3**

The latest version of OpenLayers 3 is included, offering new visualization options for modern browsers including `integration with Cesium <http://openlayers.org/ol3-cesium/>`_ for visualizing data on the globe.

If you are new to OpenLayers 3 be sure to check out the :ref:`Boundless SDK <webapps.sdk>`, which has web application templates that utilize OpenLayers 3.

**Java 7**

Java 7 is now required for OpenGeo Suite on all platforms. OpenGeo Suite is tested with both Oracle JRE and OpenJDK.

**GeoServer 2.6**

The latest branch of GeoServer, version 2.6, is included. This contains the following improvements.

* New graphic options including "windbarbs" and custom WKT graphics

* Oracle SDO users can now enjoy support for curves

* Coverage views to dynamically recombine bands into a multi-band coverage

* Can now define an image mosaic "no data" area using a vector footprint

* All new implementation of cascading (external) WFS data store 

* WFS Transactions (WFS-T, for read-write actions) now turned off by default for improved security.

* CSS styles may now be managed in the GeoServer admin interface like any other style

* :ref:`YSLD <cartography.ysld>` styles—those used by :ref:`Composer <webmaps.composer>`—may also be managed in the GeoServer admin interface like any other style.
