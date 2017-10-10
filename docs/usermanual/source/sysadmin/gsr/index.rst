.. _sysadmin.gsr:

GeoServices REST API
====================

The GeoServices REST API extension allows limited compatiblity with ArcGIS clients.

Installation
------------

The GeoServices REST API is not installed by default and is installed similarly to most
:ref:`Boundless Suite Extensions <intro.extensions>`.

Usage
-----
Currently basic FeatureServer and MapServer functionality work. Each GeoServer workspace is considered a "service" for the purposes of the API. GeoServices URLs look like this in GeoServer:

http://localhost:8080/geoserver/gsr/services/topp/MapServer/
http://localhost:8080/geoserver/gsr/services/topp/FeatureServer/

Where topp is the workspace name.

Compatible
----------

- MapServer: export, identify, generateKml, layerOrTable, legend
- FeatureServer: query, feature, identify

Incompatible
------------
Notable features currently unsupported:

- Non-geospatial filters
- Identify feature
- Dynamic layer definitions
