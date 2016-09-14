.. _whatsnew:

What's new in |version|
=======================

Each new version of Boundless Suite includes numerous fixes and component upgrades.

In addition, Boundless Suite |version| includes the following new features:

* A new name! OpenGeo Suite is now **Boundless Suite**.


* New deployment option: **Boundless Suite virtual machine** containing all components configured and ready to use. Available for all OSs, this replaces the installers previous available for Windows and OS X.

* New **QuickView** application for previewing layers. Application is built using the new WebSDK. This replaces the GeoExplorer application.

* **Composer** is now its own web application (it was previously part of GeoServer).

* **Java 8** and **Tomcat 8** are now required.

* New **GeoServer Detailed Status Page**, useful for troubleshooting and determining module status. Available directly at ``http://<SERVER>/rest/about/status`` (example: ``http://localhost:8080/geoserver/rest/about/status``)

* **GeoServer UI now displays layer Title**, making layer retrieval more efficient. 

* New **REST endpoint for uploading and configuring resources** such as fonts and icons.

* **Security updates**: remote execution fixes to reduce the risk of unauthorized activity on your system.


**New data stores**

* **JDBCStore** for efficient sharing of configuration in a clustered deployment of GeoServer. Works with **JDBCConfig**. Available via an extension.

* **NetCDF** and **GRIB**. Available via extensions. Also available is NetCDF 1-4 as a **WMS output format**.

* **JPEG 2000** for more efficient storage of raster data. Available via an extension.

* **MBTiles** for storing millions of tiles in a single SQLite database. Available via an extension.

**Other changes**

* As part of a product realignment, **Boundless Suite now focuses on server components**, and as such will not include desktop utilities such as pgAdmin. Users wanting pgAdmin from Boundless should use Boundless Desktop.


**Components included**

* GeoServer 2.9
* GeoTools 15
* GeoWebCache 1.9
* PostgreSQL 9.3
* GDAL 1.11.2

