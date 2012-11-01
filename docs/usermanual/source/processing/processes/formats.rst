.. _processing.processes.formats:


Process input and output formats
================================

:term:`WPS` processes in GeoServer support a range of input and output formats. These supported formats differ primarily by whether process expects the input or output to be a geometry, feature collection, or raster.

This section will discuss the various supported process input and output formats.

.. _processing.processes.formats.geomin:

Geometry inputs
---------------

When a process input expects a geometry, the following input types are supported:

Geographic markup (TEXT)
~~~~~~~~~~~~~~~~~~~~~~~~

Processes can support geographic markup posted as part of the request. The content can specifically be in one of the following formats:

* :term:`Well-Known Text` (WKT)
* :term:`Geographic Markup Language` (GML) 2.1.2
* :term:`Geographic Markup Language` (GML) 3.1.1

Example:

.. code-block:: xml

   <wps:Data>
     <wps:ComplexData mimeType="application/wkt"><![CDATA[POLYGON((0 0, 0 1 , 1 1, 1 0, 0 0))]]>
     </wps:ComplexData>
   </wps:Data>

In the WPS Request Builder in GeoServer, this is denoted as :guilabel:`TEXT`.


HTTP request (REFERENCE)
~~~~~~~~~~~~~~~~~~~~~~~~

Processes can also accept inputs from the result of an HTTP GET or POST request. This request (often a WFS GetFeature request or equivalent) should output GML or WKT.

Example:

.. code-block:: xml

   <wps:Reference mimeType="text/xml; subtype=gml/3.1.1"\
    xlink:href="http://example.com:8080/geoserver?myrequest" method="GET"/>

In the WPS Request Builder in GeoServer, this is denoted as :guilabel:`REFERENCE`.


Subprocess (SUBPROCESS)
~~~~~~~~~~~~~~~~~~~~~~~

Finally, as processes can be chained, the input can be the output of another process. In this case, an entire process execute request is generated as the input parameter.

In the WPS Request Builder in GeoServer, this is denoted as :guilabel:`SUBPROCESS`.

.. _processing.processes.formats.geomout:

Geometry outputs
----------------

When a process generates a geometry as its output, the following output types are supported:

* :term:`Well-Known Text` (WKT)
* :term:`Geographic Markup Language` (GML) 2.1.2
* :term:`Geographic Markup Language` (GML) 3.1.1


.. _processing.processes.formats.fcin:

Feature collection inputs
-------------------------

When a process expects a feature collection as an input, the following input types are supported:


Geographic markup (TEXT)
~~~~~~~~~~~~~~~~~~~~~~~~

Processes that accept feature collections as input can support geographic markup posted as part of the request. The content can specifically be in one of the following formats:

* :term:`WFS` collection
* :term:`JSON`
* Shapefile archive (ZIP)

In the WPS Request Builder in GeoServer, this is denoted as :guilabel:`TEXT`.


HTTP request (REFERENCE)
~~~~~~~~~~~~~~~~~~~~~~~~

Processes that accept feature collections as input can take the input from the result of an HTTP GET or POST request. This request (often a WFS GetFeature request or equivalent) should output either a WFS collection or JSON.

Example:

.. code-block:: xml

   <wps:Reference mimeType="text/xml; subtype=gml/3.1.1"\
    xlink:href="http://example.com:8080/geoserver?myrequest" method="GET"/>

In the WPS Request Builder in GeoServer, this is denoted as :guilabel:`REFERENCE`.

GeoServer layer (VECTOR_LAYER)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Specific to GeoServer, processes that accept feature collections as input can use actual GeoServer layers. This is a really a special case of the above HTTP request, as the request will just point to the local GeoServer HTTP endpoint.

Example:

.. code-block:: xml

   <wps:Reference mimeType="text/xml; subtype=wfs-collection/1.0"
    xlink:href="http://geoserver/wfs" method="POST">
     <wps:Body>
       <wfs:GetFeature service="WFS" version="1.0.0" outputFormat="GML2"
        xmlns:usa="http://usa.opengeo.org">
         <wfs:Query typeName="usa:states"/>
       </wfs:GetFeature>
     </wps:Body>
   </wps:Reference>

In the WPS Request Builder in GeoServer, this is denoted as :guilabel:`VECTOR_LAYER`.


Subprocess (SUBPROCESS)
~~~~~~~~~~~~~~~~~~~~~~~

Finally, as processes can be chained, the input can be the output of another process. In this case, an entire process execute request is generated as the input parameter.

In the WPS Request Builder in GeoServer, this is denoted as :guilabel:`SUBPROCESS`.


.. _processing.processes.formats.fcout:

Feature collection outputs
--------------------------

When a process generates a feature collection as its output, the following output types are supported:

* :term:`WFS` collection
* :term:`JSON`
* Shapefile archive (ZIP)


.. _processing.processes.formats.rasterin:



Raster inputs
-------------

When a process expects a raster (coverage) as an input, the following input types are supported:


Geographic markup (TEXT)
~~~~~~~~~~~~~~~~~~~~~~~~

Processes that accept raster data as input can support markup posted as part of the request. The content can specifically be in one of the following formats:

* TIFF
* ArcGrid

In the WPS Request Builder in GeoServer, this is denoted as :guilabel:`TEXT`.


HTTP request (REFERENCE)
~~~~~~~~~~~~~~~~~~~~~~~~

Processes that accept rasters as input can take the input from the result of an HTTP GET or POST request. This request (often a :term:`WCS` GetCoverage request or equivalent) should output either TIFF or ArcGrid image data.

Example:

.. code-block:: xml

   <wps:Reference mimeType="text/xml; subtype=gml/3.1.1"\
    xlink:href="http://example.com:8080/geoserver?myrequest" method="GET"/>

In the WPS Request Builder in GeoServer, this is denoted as :guilabel:`REFERENCE`.


GeoServer layer (RASTER_LAYER)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Specific to GeoServer, processes that accept feature collections as input can use actual GeoServer layers. This is a really a special case of the above HTTP request, as the request will just point to the local GeoServer HTTP endpoint.

Example:

.. code-block:: xml

   <wps:Reference mimeType="image/tiff" xlink:href="http://geoserver/wcs" method="POST">
     <wps:Body>
       <wcs:GetCoverage service="WCS" version="1.1.1">
         <ows:Identifier>medford:elevation</ows:Identifier>
         <wcs:DomainSubset>
           <gml:BoundingBox crs="http://www.opengis.net/gml/srs/epsg.xml#4326">
             <ows:LowerCorner>-123.047 42.231</ows:LowerCorner>
             <ows:UpperCorner>-122.499 42.755</ows:UpperCorner>
           </gml:BoundingBox>
         </wcs:DomainSubset>
         <wcs:Output format="image/tiff"/>
       </wcs:GetCoverage>
     </wps:Body>
   </wps:Reference>

In the WPS Request Builder in GeoServer, this is denoted as :guilabel:`RASTER_LAYER`.

Subprocess (SUBPROCESS)
~~~~~~~~~~~~~~~~~~~~~~~

Finally, as processes can be chained, the input can be the output of another process. In this case, an entire process execute request is generated as the input parameter.

In the WPS Request Builder in GeoServer, this is denoted as :guilabel:`SUBPROCESS`.


.. _processing.processes.formats.rasterout:

Raster outputs
--------------

When a process generates a raster as its output, the following output types are supported:

* TIFF image
* ArcGrid image
