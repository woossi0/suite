.. _dataadmin.vectortiles:

Using the vector tiles output
=============================

GeoServer supports "vector tile" output in addition to the more standard image tile output. While the standard WMS output will generate a georeferenced map image, a vector tile contains georeferenced vector data, clipped into tiles for easy retrieval.

This tutorial will show how to use the GeoServer vector tile output.

.. note:: This tutorial will only show how to generate the output in GeoServer. Rendering the vector tile output requires a custom OpenLayers 3 application, and is not included.

.. note:: This requires that the Vector Tiles extension was installed, which requires **OpenGeo Suite Enterprise**.

Adding data
-----------

We will start with some simple data that will showcase the features and benefits of vector tiles.

#. Using ``psql`` or **pgAdmin**, create a new PostGIS database named :kbd:`vt`.

   .. note:: For more information, please see the section on :ref:`dataadmin.pgGettingStarted.createdb`.

#. Create a table inside this database called ``simple`` with the following details::

     CREATE TABLE simple (geom geometry, name text, id serial primary key);

#. Insert into the table a polygon with a jagged edge::

     INSERT INTO simple ( geom, name )
       VALUES ( ST_GeomFromText('POLYGON ((0 0, 0 20, 10 20, 10 10, 14 10, 15 15, 16 10,
       17 12, 18 10, 19 11, 20 10, 20 0, 0 0))', 4326), 'Polygon with jagged edge');

#. Load this table into GeoServer. You may wish to use :ref:`Composer <webmaps.composer>` or the :ref:`Layer Importer <dataadmin.importer>` for this.

   .. note:: The example below uses a layer name of ``vt:simple`` on a GeoServer hosted at ``http://localhost:8080/geoserver/``.

#. View a standard WMS GetMap output in PNG format::

     http://localhost:8080/geoserver/vt/ows?service=WMS&version=1.1.0&request=GetMap&layers=vt:simple&styles=&width=512&height=512&srs=EPSG:4326&format=image/png&srs=EPSG:4326&bbox=0.0,0.0,20.0,20.0

   .. figure:: img/vt-wms.png

      WMS PNG output

Setting the proper output format
--------------------------------

Typically, WMS output formats will be image formats such as PNG or JPEG, while WFS output formats will be serialized data formats such as GML or GeoJSON.

But with vector tiles, **GeoJSON is available as a WMS output format**. When invoked, some important differences between it and WFS GeoJSON will become clear.

#. Execute a **WFS** GetFeature request with GeoJSON output::

     http://localhost:8080/geoserver/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=vt:simple&outputFormat=application/json

#. View the output:

   .. code-block:: json

      {"type":"FeatureCollection","totalFeatures":1,"features":[{"type":"Feature",
       "id":"simple.1","geometry":{"type":"Polygon","coordinates":[[[0,0],[0,20],
       [10,20],[10,10],[14,10],[15,15],[16,10],[17,12],[18,10],[19,11],[20,10],
       [20,0],[0,0]]]},"geometry_name":"geom","properties":{"name":"Polygon with 
       jagged edge"}}],"crs":{"type":"name","properties":
       {"name":"urn:ogc:def:crs:EPSG::4326"}}}

#. Now in a new tab, execute a **WMS** GetMap request with GeoJSON output. **The output format for vector tiles is** ``FORMAT=application/json;type=geojson``::

     http://localhost:8080/geoserver/vt/ows?service=WMS&version=1.1.0&request=GetMap&layers=vt:simple&styles=&bbox=0.0,0.0,20.0,20.0&width=512&height=512&srs=EPSG:4326&format=application/json;type=geojson

#. Save this output (or leave it in its own browser tab):

   .. code-block:: json

      {"type":"FeatureCollection","totalFeatures":"unknown","features":[{"type":
       "Feature","id":"simple.1","geometry":{"type":"Polygon","coordinates":[[[0,0],
       [0,20],[10,20],[10,10],[14,10],[15,15],[16,10],[17,12],[18,10],[19,11],
       [20,10],[20,0],[0,0]]]},"geometry_name":"geom","properties":{"name":"Polygon 
       with jagged edge"}}]}

These two outputs are very similar. There are some metadata differences, but the geometries are identical.

Because of this, one might think that there is no reason not to just stick with WFS and have your client-side application consume GeoJSON that way. So to see ways that vector tiles offer an enhanced experience, let's make some changes to our request.

Vector clipping 
---------------

**In an image tile, a rendered feature can be clipped**, with some part of the feature going in one adjacent tile and some in another. When rendered, the image tiles are placed next to each other, and the eye won't notice that the display is coming from different sources.

**In a vector tile, the same clipping happens**. A feature that is split across two different tiles is clipped and split into two features, with one feature in each tile. When the two vector tiles are drawn next to each other, the two features can seamlessly be viewed as a single feature.

The reason why such a scheme requires a special output is that **WFS doesn't clip actual features; it will either fully include or not include them**.

Let's see this in action.

#. Alter the above WMS PNG output to include ``&srsName=EPSG:4326&bbox=-6,0,14,20``. This will exclude the area of the polygon with the jagged edge::

     http://localhost:8080/geoserver/vt/ows?service=WMS&version=1.1.0&request=GetMap&layers=vt:simple&styles=&width=512&height=512&format=image/png&srs=EPSG:4326&bbox=-6,0,14,20

   .. figure:: img/vt-wms-clip.png

      WMS output with clipped feature

#. Execute the equivalent WFS GeoJSON request::

     http://localhost:8080/geoserver/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=vt:simple&outputFormat=application/json&srsName=EPSG:4326&bbox=-6,0,14,20

#. View the output:

   .. code-block:: json

      {"type":"FeatureCollection","totalFeatures":1,"features":[{"type":"Feature",
       "id":"simple.1","geometry":{"type":"Polygon","coordinates":[[[0,0],[0,20],
       [10,20],[10,10],[14,10],[15,15],[16,10],[17,12],[18,10],[19,11],[20,10],
       [20,0],[0,0]]]},"geometry_name":"geom","properties":{"name":"Polygon with 
       jagged edge"}}],"crs":{"type":"name","properties":
       {"name":"urn:ogc:def:crs:EPSG::4326"}}}

   Notice that the output is identical to the WFS GeoJSON request in the previous section. This is expected, because the feature was partially contained in the bounding box, so the result included the entire feature.

#. Now execute the the WMS vector tiles format ``FORMAT=application/json;type=geojson`` with the new bounding box::

     http://localhost:8080/geoserver/vt/ows?service=WMS&version=1.1.0&request=GetMap&layers=vt:simple&styles=&width=512&height=512&format=application/json;type=geojson&srs=EPSG:4326&bbox=-6,0,14,20

#. View the output:

   .. code-block:: json

      {"type":"FeatureCollection","totalFeatures":"unknown","features":[{"type":
       "Feature","id":"simple.1","geometry":{"type":"Polygon","coordinates":[[[0,0],
       [0,20],[10,20],[10,10],[14,10],[14,0],[0,0]]]},"geometry_name":"geom",
       "properties":{"name":"Polygon with jagged edge"}}]}

  In this case, **the actual feature geometry was clipped**. (The attributes were untouched.) This means that if we were to execute another non-overlapping request showing the other piece of the feature, they could be seamlessly rendered together in the client, even though they were generated by separate requests.

.. note::

   To generate the other piece of the feature with a bounding box of the same dimensions, use ``bbox=14,0,24,20``::

     http://localhost:8080/geoserver/vt/ows?service=WMS&version=1.1.0&request=GetMap&layers=vt:simple&styles=&width=512&height=512&format=application/json;type=geojson&srs=EPSG:4326&bbox=14,0,24,20
    
Vector simplification
---------------------

When one "zooms out" on a web map, the features are rendered smaller and, by nature of images being of a fixed resolution, simplified. In other words, there is less detail.

With vector output, the infinite resolution of vectors means that all the complexity of the features are rendered at any scale, regardless of whether that detail is even visible.

**With vector tiles, the vectors may be simplified** (as in, reduced number of vertices) if the output doesn't support that much detail.

Let's see this in action.

#. Zoom out all the way to the full extent of the SRS, and reduce the "size" of the output. We can do this by setting the following parameters: ``&bbox=-180,-90,180,90&width=64&height=64`` Execute a WMS PNG request with these parameters::

     http://localhost:8080/geoserver/vt/ows?service=WMS&version=1.1.0&request=GetMap&layers=vt:simple&styles=&bbox=-180,-90,180,90&width=64&height=64&srs=EPSG:4326&format=image/png

   .. figure:: img/vt-wms-tiny.png

      WMS output zoomed out and tiny

   This output is effectively too small to have any detail shown. The image is necessarily simplified.

#. Now request the vector tiles equivalent of this request::

     http://localhost:8080/geoserver/vt/ows?service=WMS&version=1.1.0&request=GetMap&layers=vt:simple&styles=&bbox=-180,-90,180,90&width=64&height=64&srs=EPSG:4326&format=application/json;type=geojson

#. View the output:

   .. code-block:: json

      {"type":"FeatureCollection","totalFeatures":"unknown","features":[{"type":
       "Feature","id":"simple.1","geometry":{"type":"Polygon","coordinates":[[[0,0],
       [0,20],[10,20],[10,10],[14,10],[15,15],[16,10],[17,12],[20,10],[20,0],[0,0]]]
       },"geometry_name":"geom","properties":{"name":"Polygon with jagged edge"}}]}

#. Compare this to the original output from above:

   .. code-block:: json

      {"type":"FeatureCollection","totalFeatures":"unknown","features":[{"type":
       "Feature","id":"simple.1","geometry":{"type":"Polygon","coordinates":[[[0,0],
       [0,20],[10,20],[10,10],[14,10],[15,15],[16,10],[17,12],[18,10],[19,11],[20,10],
       [20,0],[0,0]]]},"geometry_name":"geom","properties":{"name":"Polygon with 
       jagged edge"}}]}

   Notice that two vertices, corresponding to the most jagged part of the jagged edge, have been simplified (removed), as shown in the following diagram:

   .. figure:: img/vt-simplified.png

      Original (blue) with simplified polygon (red)

   .. JTS Builder was used for the above
   .. Original: POLYGON ((0 0, 0 20, 10 20, 10 10, 14 10, 15 15, 16 10, 17 12, 18 10, 19 11, 20 10, 20 0, 0 0))
   .. Simplified: POLYGON ((0 0, 0 20, 10 20, 10 10, 14 10, 15 15, 16 10, 17 12, 20 10, 20 0, 0 0))
      

   With a more complex feature, the simplification could be even more pronounced.
