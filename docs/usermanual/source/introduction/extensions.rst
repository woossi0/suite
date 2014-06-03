.. _intro.extensions:

OpenGeo Suite extensions
========================

OpenGeo Suite comes with a number of optional extensions or "add-ons". These add functionality to OpenGeo Suite, but may not be needed by most users. We recommend that you choose only the extensions that you need.

These optional components can be selected during the :ref:`Windows installation process <installation.windows.install.components>` or by installing specific packages for :ref:`Ubuntu <installation.ubuntu.packages>` or :ref:`Red Hat-based <installation.redhat.packages>` systems). For users of OpenGeo Suite for Application Servers, please `contact Boundless <http://boundlessgeo.com/about-us/contact/>`_ to receive access to the extensions and how to install them.

.. figure:: ../installation/windows/img/components.png

   Component installation on Windows (extensions are in GeoServer Add-ons and PostGIS Add-ons)

.. note:: If you have already installed OpenGeo Suite on Windows, you can add extensions to your deployment by running the installer again and selecting just the desired extensions.


.. _intro.extensions.clustering:

Clustering
----------

The Clustering extension for GeoServer adds the ability to automatically set up multiple instances of GeoServer that can pool resources.

This extension consists of two parts:

* Database-backed configuration
* Server connection and communication

.. note::

   On Windows, this extension is known simply as "Clustering". However, on Linux, it is divided into two separate packages, both required:

   * ``geoserver-jdbcconfig``
   * ``geoserver-clustering``

For more information about Clustering, please see the :ref:`sysadmin.clustering` section.

Scripts for setting up clusters either on Amazon Web Services (AWS) or locally-hosted virtual machines are available to OpenGeo Suite Enterprise clients. Please `contact Boundless <http://boundlessgeo.com/about-us/contact/>`_ to access these scripts.


.. _intro.extensions.css:

CSS Styling
-----------

The CSS Styling extension adds functionality to GeoServer to be able to style layers using a syntax that is similar to CSS (Cascading Style Sheets). CSS can be preferable to the standard Styled Layer Descriptor (SLD) styling method, due to the compactness and widespread familiarity of CSS.

For more information about CSS styling in GeoServer, please see the `GeoServer CSS documentation <../geoserver/extensions/css/>`_.

.. warning:: The installation instructions in the GeoServer documentation do not apply to users of OpenGeo Suite. Users of OpenGeo Suite can install the extension in the standard way as indicated above.

.. todo:: NEED TO UPDATE COMMUNITY DOCS


.. _intro.extensions.csw:

CSW
---

The CSW extension adds the ability for GeoServer to publish information conforming to the Catalog Service for Web (CSW) protocol.

For more information about CSW in GeoServer, please see the `GeoServer CSW documentation <../geoserver/extensions/csw/>`_.

.. warning:: The installation instructions in the GeoServer documentation do not apply to users of OpenGeo Suite. Users of OpenGeo Suite can install the extension in the standard way as indicated above.

.. _intro.extensions.gdal:

GDAL Image Formats
------------------

The GDAL Image Formats extension adds the ability for GeoServer to publish data from extra raster data sources, through the use of `GDAL <http://www.gdal.org/>`_. These formats include, but are not limited to DTED, EHdr, AIG, and ENVIHdr.

The instructions for enabling these formats may require a few additional steps from the standard extension installation instructions as indicated above. Please see the section on :ref:`installing GDAL image formats <installation.gdal>` for more information.

.. _intro.extensions.geopackage:

GeoPackage
----------

The GeoPackage extension adds the ability for GeoServer to publish data from `GeoPackage <http://www.geopackage.org/>`_ sources (a data format based on SQLite).

.. todo:: Need more info here.


.. _intro.extensions.mapmeter:

Mapmeter
--------

The Mapmeter extension adds the ability to connect to Mapmeter. Mapmeter (http://mapmeter.com) is a cloud-based service that allows you to monitor and analyze your geospatial deployments in real-time. 

Mapmeter is available only to users of OpenGeo Suite.

.. todo:: For more information on using Mapmeter...

.. todo:: Add a section in sysadmin for Mapmeter


.. _intro.extensions.mongodb:

MongoDB
-------

The MongoDB extension adds the ability for GeoServer to publish data from `MongoDB <http://www.mongodb.org/>`_ sources.

.. todo:: Need more info here


.. _intro.extensions.wps:

WPS
---

The WPS extension adds the ability for GeoServer to support and publish the Web Processing Service (WPS). WPS is a protocol for hosting and executing geospatial processes, bringing geospatial anaysis to the client/server model.

For more information of WPS in OpenGeo Suite, please see the :ref:`processing` section.


.. _intro.extensions.pointcloud:

Point Cloud
-----------

The Point Cloud extension adds support for the PostGIS Point Cloud functionality.

.. todo:: Need to add something useful here.
