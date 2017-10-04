.. _sysadmin.gsr:

ArcGIS REST API
=================

The ArcGIS REST API extension allows limited compatiblity with ArcGIS clients.

Installation
------------

The ArcGIS REST API is not installed by default and is installed similarly to most
:ref:`Boundless Suite Extensions <intro.extensions>`.

Usage
------
Currently basic FeatureServer and MapServer functionality work. Each GeoServer workspace is considered an ArcGIS "service" for the purposes of the API. ArcGIS URLs look like this in GeoServer:

http://localhost:8080/geoserver/gsr/services/topp/MapServer/
http://localhost:8080/geoserver/gsr/services/topp/FeatureServer/

Where topp is the workspace name.

Compatibility
-------------

- MapServer: export, identify, generateKml, layerOrTable, legend
- FeatureServer: query, feature, identify

Incompatible
------------
Notable features currently unsupported:

- Non-geospatial filters
- Identify feature
- Dynamic layer definitions
