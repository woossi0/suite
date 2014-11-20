.. _whatsnew:

What's new in |version|
=======================

Each new version of OpenGeo Suite includes numerous fixes and component upgrades.

In addition, OpenGeo Suite |version| has been updated with all-new features, including:

.. only:: enterprise

   **Composer**

   We are very happy to introduce Composer as a fast, efficient and interactive approach to mapping.

   Composer is included as a beta for our enterprise customers and is tightly integrated with our GeoServer engine for map publication.

**OpenLayers 3**

The latest OpenLayers3 is included, offering amazing new visualization options for modern browsers including ol3-cesium globe support.

If you are new to OpenLayers 3 be sure to check out the :ref:`Boundless SDK <webapps.sdk>` templates offering a viewing application as well as an editing application.

**Java 7**

Java 7 is now required for OpenGeo Suite on all platforms. OpenGeo Suite is tested with both Oracle JRE and OpenJDK.

**GeoServer**

The latest GeoServer 2.6 is included with key benefits for our OpenGeo Suite customers.

* New graphic options including wind barbs and custom WKT graphics

* Oracle SDO users can now enjoy curve support

* Coverage views to dynamically recombine bands into a multi-band coverage

* pluggable style support is used to integrate the CSS extension with GeoServer style editing

.. only:: enterprise

   * pluggable style support is used to integrate new new YSLD styles used by Composer

* Easily define an image mosaic "no data" using a vector footprint

* All new implementation of WFS Cascade

If you are installing OpenGeo Suite for the first time please be aware new installations are configured to support WFS Basic functionality by default. If you wish to open up your data for read-write WFS-T can be turned on during initial configuration. 