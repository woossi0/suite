.. _intro.extensions:

Extensions and plugins
======================

OpenGeo Suite comes with the option to select a number of optional "add-ons". These add functionality to OpenGeo Suite, but may not be needed by most users.

Add-ons can be selected during the installation process (for Windows) or by installing specific packages (for Ubuntu or Red Hat-based systems).

This section will discuss the various Add-ons available to GeoServer.



..   clustering
..   css
..   csw
..   gdal
..   geopackage
..   mapmeter
..   mongodb
..   wps

   

Clustering
==========

The Clustering Add-on for GeoServer allows a quick way to set up multiple instances of GeoServer that can talk to each other and pool resources.

This extension consists of two parts:

* Database-backed configuration (JDBCConfig)
* Hazelcast auto-connect functionality 

.. note:: On Windows, this extension is known as "Clustering", while on Ubuntu and Red Hat-based Linux packages, it is divided into two separate packages: ``geoserver-jdbcconfig`` and ``geoserver-clustering``. LINKS

FIGURE?

For more information about how Clustering works in GeoServer, please see the GeoServer documentation (LINK).

Scripts for setting up clusters on Amazon Web Services (AWS) and also locally-hosted virtual machines are available to OpenGeo Suite Enterprise Clients. CONTACT US to access these scripts.

Using scripts
-------------

CONTENT HERE






CSS Styling
===========

The CSS Styling Add-on for GeoServer allows for styling layers using a syntax that is similar to CSS (Cascading Style Sheets) most often used when styling web pages.

CSS styling can be preferable to the standard SLD styling methods, due to CSS's compactness and widespread use.

IMAGE?

For more information about CSS styling in GeoServer, please see the GeoServer documentation (LINK).

.. warning:: Note that the installation instructions in the GeoServer documentation do not apply to users of OpenGeo Suite.

NEED TO UPDATE COMMUNITY DOCS




CSW
===

The CSW Add-on for GeoServer allows GeoServer to publish information conforming to the Catalog Service for Web (CSW) protocol.

For more information about CSW in GeoServer, please see the GeoServer documentation (LINK).



GDAL Image Formats
==================

The GDAL image formats add-on for GeoServer allows for new raster data sources (formats) to be able to be published through GeoServer. These include but are not limited to DTED, EHdr, AIG, and ENVIHdr.

The instructions for enabling these formats is a bit more complicated than with the other Add-ons. Please see the section on installing GDAL image formats for more information. LINK


GeoPackage
==========

The GeoPackage add-on for GeoServer add support for the GeoPackage data format (a data format based on SQLite) to be published by GeoServer. LINK

Once installed, there will a new option when adding a new store to GeoServer (IMAGE?).

Read more about the GeoPackage format LINK


Mapmeter
========

The Mapmeter add-on for GeoServer adds connectivity with Mapmeter. Mapmeter (http://mapmeter.com) is a cloud-based service that allows you to monitor and analyze your geospatial deployments in real-time. It is a service that is only available to users of OpenGeo Suite.

IMAGE?

For more information on using Mapmeter, please see the section on Using Mapmeter (in sysadmin)


MongoDB
=======

The MongoDB add-on for GeoServer adds support for publishing data from MongoDB through GeoServer.

For more about 
Read more about MongoDB.

 



WPS
===
