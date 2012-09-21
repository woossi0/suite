.. _processing.common: 

Common WPS processes
====================

This section will highlight some common and useful WPS processes stored in the OpenGeo Suite.  It is not a comprehensive listing of all processes, nor is it a detailed account of every facet of these process.  Rather, it is designed to get a feel for how these particular processes operate.

.. todo:: For more information, go where?

UnionFeatureCollection
----------------------

.. todo:: Graphic needed.

This process works like a merge.  It takes as input two feature collections and outputs a single feature collection.  This is useful for combining similar sets of features, such as layers that cover different geographic area, but otherwise contain the same type in information.

Inputs can be:

* XML or JSON feature collection supplied in the body of the request
* Reference to an external feature collection via a GET/POST request
* An existing vector layer in GeoServer

Output can be:

* XML or JSON feature collection
* Shapefile ZIP

The attributes list in the output will be a union of the input attributes.  If one of the input features doesn't have a particular attribute present in the other input, that value will be left blank.

Notes on usage:

* Both input feature collections must have the same default geometry.
* Make sure to match the CRS of each input geometry.
* Identical features in both input collections will both be preserved as individual features, not combined.

.. todo:: What happens with mixed CRSs?

While this process takes only two inputs, it is possible to chain this process together with itself in order to combine more than two feature collections.


IntersectionFeatureCollection
-----------------------------

.. todo:: Graphic needed.

.. todo:: Wasn't able to get this to work

This process allows two feature collections to be intersected in a number of ways, via spatial intersection and by attribute combination.  

Inputs can be:

* XML or JSON feature collection supplied in the body of the request
* Reference to an external feature collection via a GET/POST request
* An existing vector layer in GeoServer

Output can be:

* XML or JSON feature collection
* Shapefile ZIP

The geometries in the feature collections can be intersected (``intersectionMode``) by a straight spatial intersection (``INTERSECTION``) or the output can use the original geometries from one or the other inputs (``FIRST`` or ``SECOND``) without any spatial processing.

The attributes of the output feature collection are determined by a list of attributes from both of the input geometries.  Each one is specified individually as a list. If these parameters are left blank, all attributes will be used.

In addition, two more piece of information can be included in the output.  The first is the areas of each feature collection (``areasEnabled``), included as attributes ``areaA`` and ``areaB``. The second is the percentage of intersection (``percentagesEnabled``), also included as attributes ``percentageA`` and ``percentageB``.

.. todo:: What's a good use case for this?

The names of the output attributes will be altered.  The new attribute names will have the originating feature collection, an underscore, and then be followed with the name of the original attribute. The maximum length of attribute name is ten characters, so if the input feature collection was ``usa:states``, the ``STATE_NAME`` attribute would be ``states_STA`` in the output feature collection.

.. todo:: This 10 character limit is lame. What if the layer name is greater than 10 characters?  Would all attributes be the same?

Notes on usage:

* The first input feature collection must not consist of point geometries.

.. todo:: What about different CRSs?


BufferFeatureCollection
-----------------------

.. todo:: Graphic needed.

This process takes a feature collection and applies a buffer to each feature. The buffer length can be a fixed value for all features supplied as a process input, or can be variable, the value taken from an attribute in the feature collection. The two parameters can be used together as well, with a certain static buffer added to as variable buffer. 

Input can be:

* XML or JSON feature collection supplied in the body of the request
* Reference to an external feature collection via a GET/POST request
* An existing vector layer in GeoServer

Output can be:

* XML or JSON feature collection
* Shapefile ZIP

The output feature collection will return the exact same attributes and values as the input, but with each geometry buffered.

Notes on usage:

* The buffer length will be in the same units of the feature collection, so unexpected output may occur with geographic representations.
* The static length parameter is required, so if using an attribute for determining the buffer length, set this to 0.


Clip
----

.. todo:: Graphic needed.

This process will clip a feature collection by a given geometry, typically a polygon or multipolygon.  Attributes names and values are not affected by this process.

Input can be:

* XML or JSON feature collection supplied in the body of the request
* Reference to an external feature collection via a GET/POST request
* An existing vector layer in GeoServer

Geometry input can be:

* GML (2.1 or 3.2)
* WKT

Output can be:

* XML or JSON feature collection
* Shapefile ZIP

In the output geometry, all features that partially intersect with the clipping geometry will return with their geometries cropped, while all features that do not intersect with the clipping geometry at all will be eliminated entirely.

Notes on usage:

* The clipping geometry will be in the same units as the feature collection.
* The clipping geometry can be a point or line, but this is uncommon.



Transform
---------

.. todo:: Graphic needed.

This highly flexible process is used to transform a feature collection using a series of expressions. It can be thought of as a direct equivalent of the ``SELECT ... FROM`` clause in SQL. It lets you define a new feature collection with attributes computed from the original ones (which in effect allows renaming and removal). The new attributes are computed via ECQL expressions, which can process geometry as well as scalar data.

.. todo:: Definitely going to need some examples here.

The transform string is a collection of expressions of the form ``attribute=expression``.

Input can be:

* XML or JSON feature collection supplied in the body of the request
* Reference to an external feature collection via a GET/POST request
* An existing vector layer in GeoServer

Output can be:

* XML or JSON feature collection
* Shapefile ZIP


Centroid
--------

.. todo:: Graphic needed.

This process takes a feature collection and returns a point feature collection.  For lines, points are generated at the line midpoint, and for polygons, points are generated at the polygon centroid.  Attributes names and values are not affected by this process.

Input can be:

* XML or JSON feature collection supplied in the body of the request
* Reference to an external feature collection via a GET/POST request
* An existing vector layer in GeoServer

Output can be:

* XML or JSON feature collection
* Shapefile ZIP

The output feature collection will always be a point collection.

Notes on usage:

* If a feature collection consisting of point geometries are supplied, the output will be identical to the input.


Simplify
--------

.. todo:: Graphic needed.

This process takes an feature collection and reduces the number of vertices in each feature, thus simplifying the geometries.

The method used to do the simplification is known as the `Douglas-Peucker algorithm <http://en.wikipedia.org/wiki/Douglas-Peucker_algorithm>`_.  It uses as input a ``distance`` value, which determines how the geometries are to be simplified.  Higher values denote more intense simplification.

.. todo:: Will need a better definition of the distance, and verification that the above is correct.

Also, a flag can be set (``preserveTopology``) on whether the simplification should preserve the topology of the features.

Input can be:

* XML or JSON feature collection supplied in the body of the request
* Reference to an external feature collection via a GET/POST request
* An existing vector layer in GeoServer

Output can be:

* XML or JSON feature collection
* Shapefile ZIP

Notes on usage:

* The distance value will be in the same units as the feature collection.


Import
------

.. todo:: Graphic needed.

This process takes a feature collection and adds it to the GeoServer catalog as a layer.  It acts as a simple data loader using WPS; the contents of the feature collection are unchanged.

A few catalog parameters are added in addition to the feature collection.  The desired workspace name, store name, coordinate reference system, and SRS handling policy can all be input, but if omitted the server defaults will be used.  The name of the layer can be specified, but if omitted it will be set to the name contained in the feature collection.  The name of an existing style can be specified, but if omitted a default style will be chosen based on the geometry in the feature collection.

Input can be:

* XML or JSON feature collection supplied in the body of the request
* Reference to an external feature collection via a GET/POST request
* An existing vector layer in GeoServer

The output of this process is the fully qualified layer name (with workspace prefix) only.
 