.. _dataadmin.pgBasics.spatialrelationships:

.. warning:: Document status: **Requires Technical Review (PR)**

Spatial relationships
=====================

Spatial databases can not only store geometry, they also provide the capabilities to compare *relationships between geometries*. Answering questions such as "Which are the closet bike racks to a park?" or "Where are the intersections of subway lines and streets?" is only possible by comparing geometries representing the bike racks, streets, and subway lines.

The next sections describe the various geometry comparison functions available with PostGIS.

ST_Equals
---------
 
:command:`ST_Equals(geometry A, geometry B)` tests the spatial equality of two geometries. 
:command:`ST_Equals` returns TRUE if two geometries of the same type have identical x,y coordinate values, that is if the secondary shape is equal (identical) to the first shape.

.. figure:: img/st_equals.png

   *ST_Equals*


The following example returns the representation of a point.

.. code-block:: sql

  SELECT name, the_geom, ST_AsText(the_geom)
  FROM nyc_subway_stations 
  WHERE name = 'Broad St';             

::

     name   |                      the_geom                      |      st_astext
  ----------+----------------------------------------------------+-----------------------
   Broad St | 0101000020266900000EEBD4CF27CF2141BC17D69516315141 | POINT(583571 4506714)
 
This representation of the geometry may in turn be used to perform a test of equality. In the next example, the name of the subway station whose geometry matches this representation is identified.

.. code-block:: sql

  SELECT name 
  FROM nyc_subway_stations 
  WHERE ST_Equals(the_geom, '0101000020266900000EEBD4CF27CF2141BC17D69516315141');

::

   Broad St

.. note::

  Although the representation of the point (``0101000020266900000EEBD4CF27CF2141BC17D69516315141``) is not  easy to read, it is an exact representation of the coordinate values. For a test like equality, the exact coordinates are required  For further information, please refer to :ref:`Equality <dataadmin.pgBasics.equality>`.


Intersections
-------------

:command:`ST_Intersects`, :command:`ST_Crosses`, and :command:`ST_Overlaps` test whether the interiors of the geometries intersect. 

:command:`ST_Intersects(geometry A, geometry B)` returns TRUE if the intersection any part of geometry A touches or overlaps with geometry B. 

.. figure:: img/st_intersects.png

   *ST_Intersects*

The opposite of :command:`ST_Intersects` is :command:`ST_Disjoint(geometry A , geometry B)`. If two geometries are disjoint, they do not intersect, and vice-versa.

.. figure:: img/st_disjoint.png

   *ST_Disjoint*


.. note:: It is usually more efficient to test "not intersects" than to test "disjoint" because the intersects tests can be spatially indexed, while the disjoint test cannot.

For multipoint/polygon, multipoint/linestring, linestring/linestring, linestring/polygon, and linestring/multipolygon comparisons, :command:`ST_Crosses(geometry A, geometry B)` returns TRUE if the intersection results in a geometry whose dimension is one less than the maximum dimension of the two source geometries. The intersection set must also be interior to both source geometries.

.. figure:: img/st_crosses.png  

   *ST_Crosses*


:command:`ST_Overlaps(geometry A, geometry B)` compares two geometries of the same dimension and returns TRUE if the intersection set results in a geometry different from both but of the same dimension.

.. figure:: img/st_overlaps.png

   *ST_Overlaps*


For example, again using the New York City subways and neighborhoods as an example, it is possible to determine a subway station's neighborhood using the :command:`ST_Intersects` function.

.. code-block:: sql

  SELECT name, ST_AsText(the_geom)
  FROM nyc_subway_stations 
  WHERE name = 'Broad St';               

::

  POINT(583571 4506714)

.. code-block:: sql   

  SELECT name, boroname 
  FROM nyc_neighborhoods
  WHERE ST_Intersects(the_geom, ST_GeomFromText('POINT(583571 4506714)',26918));

::

          name        | boroname  
  --------------------+-----------
   Financial District | Manhattan



Touching
--------

:command:`ST_Touches(geometry A, geometry B)` tests whether two geometries touch at their boundaries, but do not intersect in their interiors. :command:`ST_Touches` will return TRUE if either of the geometries' boundaries intersect, or if only one of the geometry's interiors intersects the other's boundary.

.. figure:: img/st_touches.png

   *ST_Touches*


Containing
----------

Although :command:`ST_Within` and :command:`ST_Contains` both test whether one geometry is fully within the other, :command:`ST_Within` tests for the exact opposite result of :command:`ST_Contains`. 

:command:`ST_Within(geometry A, geometry B)` returns TRUE if the first geometry is completely **within** the second geometry. :command:`ST_Contains(geometry A, geometry B)` returns TRUE if the second geometry is completely **contained** by the first geometry. 

.. figure:: img/st_within.png

   *ST_Within*
    

Distance
--------

Identifying features that are within a certain distance of other features is a common requirement in spatial analysis. The :command:`ST_Distance(geometry A, geometry B)` calculates the (shortest) distance between two geometries and returns the answer as a number (float). This is useful for actually reporting back the distance between objects.

.. code-block:: sql

  SELECT ST_Distance(
    ST_GeometryFromText('POINT(0 5)'),
    ST_GeometryFromText('LINESTRING(-2 2, 2 2)'));

::

  3

To test whether two objects are within a distance of one another, the :command:`ST_DWithin` function provides an spatial index-accelerated TRUE/FALSE test. This will help answer questions such as "how many trees are within a 500 meter buffer of the road?". You don't have to calculate an actual buffer, you just have to test the distance relationship.

.. figure:: img/st_dwithin.png

     *ST_DWithin*
    
The following example will identify the streets within 10 meters of a given subway stop:

.. code-block:: sql

  SELECT name 
  FROM nyc_streets 
  WHERE ST_DWithin(
          the_geom, 
          ST_GeomFromText('POINT(583571 4506714)',26918), 
          10
        );

:: 

       name     
  --------------
     Wall St
     Broad St
     Nassau St


For more information about geometry functions in PostGIS, please refer to the `PostGIS Reference <../../../postgis/postgis/html/reference.html>`_