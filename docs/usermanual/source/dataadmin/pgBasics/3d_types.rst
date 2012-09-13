.. _dataadmin.pgBasics.3d_types:

.. sidebar:: Document Status: 

   **Draft - under development**

Working with 3-d and 4-d Geometries
===================================

The collection of 3D enabled functions has grown 
a great deal. Distance, length, nearest points, 
even intersects and within.

3d distance calculations on geometries

ST_Distance(
  'POINT Z (0 0 0)', 
  'POINT Z (0 3 4)'
)

ST_3dDistance(
  'POINT Z (0 0 0)', 
  'POINT Z (0 3 4)'
)

Support for higher dimensional indexes.

Creating a higher-dimension index looks almost 
exactly like creating a standard 2D one, the only 
di!erence is you have to specify your “opclass” as 
“gist_geometry_ops_nd”. You don’t have to 
specify opclass for 2D indexes, since the 2D 
opclass is the default, but it’s there under the 
covers.

&& and &&& functions

an index-enabled query:

SELECT *
FROM tbl
WHERE
  geom &&&
  ST_3DMakeBox(
    ‘POINT Z (0 0 0)’,
    ‘POINT Z (1 1 1))


3D types
--------


Triangle

TIN

Polyhedralsurface - 3D buildings


3D Formats
----------


* ST_AsX3D(geom)
* ST_AsGML(3, ...)
* Also...
* ST_AsText(geom)
* ST_AsBinary(geom)







