.. _whatsnew:

What's new in |version|
=======================

This version contains numerous component upgrades and bug fixes. Highlights include:

* The **WebSDK** is now released, available now from `npm <https://www.npmjs.com/package/boundless-sdk>`_ and `GitHub <https://github.com/boundlessgeo/sdk>`_.

* **New GeoServer style editor**, which comes with a `live preview function <geoserver/styling/webadmin/index.html>`_.

* Added **support for MBstyle** `markup language <geoserver/styling/mbstyle/index.html>`_.

* **Layer groups have a new mode** called `"opaque container" mode <geoserver/data/webadmin/layergroups.html>`_ for preventing component layers from showing up in the root level, as well as **enhanced integration with the existing security subsystem**.

* **GeoServer catalog optimizations** for faster startup, faster runtime, and better scalability for servers with large numbers of layers.

* New **module status page** for showing information and status about installed extensions. Find it at ``http://[GEOSERVER_URL]/rest/about/status/``.


**Components included:**

* GeoServer 2.11
* GeoWebCache 1.11
* GeoTools 17
* PostgreSQL 9.6
* PostGIS 2.3
* GDAL - 1.11.5
