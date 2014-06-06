PostgreSQL PostGIS Geometry/Geography/Box Types
===============================================

box2d
A box composed of x min, ymin, xmax, ymax. Often used to return the 2d
enclosing box of a geometry.
Description
-----------

box2d is a spatial data type used to represent the enclosing box of a
geometry or set of geometries. ST\_Extent in earlier versions prior to
PostGIS 1.4 would return a box2d.

box3d
A box composed of x min, ymin, zmin, xmax, ymax, zmax. Often used to
return the 3d extent of a geometry or collection of geometries.
Description
-----------

box3d is a postgis spatial data type used to represent the enclosing box
of a geometry or set of geometries. ST\_3DExtent returns a box3d object.

Casting Behavior
----------------

This section lists the automatic as well as explicit casts allowed for
this data type

+------------+-------------+
| Cast To    | Behavior    |
+------------+-------------+
| box        | automatic   |
+------------+-------------+
| box2d      | automatic   |
+------------+-------------+
| geometry   | automatic   |
+------------+-------------+

geometry
Planar spatial data type.
Description
-----------

geometry is a fundamental postgis spatial data type used to represent a
feature in the Euclidean coordinate system.

Casting Behavior
----------------

This section lists the automatic as well as explicit casts allowed for
this data type

+-------------+-------------+
| Cast To     | Behavior    |
+-------------+-------------+
| box         | automatic   |
+-------------+-------------+
| box2d       | automatic   |
+-------------+-------------+
| box3d       | automatic   |
+-------------+-------------+
| bytea       | automatic   |
+-------------+-------------+
| geography   | automatic   |
+-------------+-------------+
| text        | automatic   |
+-------------+-------------+

See Also
--------

?

geometry\_dump
A spatial datatype with two fields - geom (holding a geometry object)
and path[] (a 1-d array holding the position of the geometry within the
dumped object.)
Description
-----------

geometry\_dump is a compound data type consisting of a geometry object
referenced by the .geom field and path[] a 1-dimensional integer array
(starting at 1 e.g. path[1] to get first element) array that defines the
navigation path within the dumped geometry to find this element. It is
used by the ST\_Dump\* family of functions as an output type to explode
a more complex geometry into its constituent parts and location of
parts.

See Also
--------

?

geography
Ellipsoidal spatial data type.
Description
-----------

geography is a spatial data type used to represent a feature in the
round-earth coordinate system.

Casting Behavior
----------------

This section lists the automatic as well as explicit casts allowed for
this data type

+------------+------------+
| Cast To    | Behavior   |
+------------+------------+
| geometry   | explicit   |
+------------+------------+

See Also
--------

?, ?
