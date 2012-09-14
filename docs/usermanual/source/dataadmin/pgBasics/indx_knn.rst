.. _dataadmin.pgBasics.indx_knn:

.. warning:: Document Status: **Draft**

Nearest Neighbor Searches
=========================

Nearest neighbor index searching

* KNN = K Nearest Neighbor
* Index-based tree search
* Restricted to index keys 
(a.k.a. bounding boxes)
* Points: exact answer
* Others: box-based answer

Very large tables with irregular densities, this can be a huge performance boost

Example

So, here’s an example I put together, loading all 
the USA named geographic points, 2M of them.
Find one point, in this case Reedy Creek.

Indexed KNN
SELECT id, name, state, kind 
FROM geonames 
ORDER BY
    geom <->
    (SELECT geom FROM geonames
      WHERE id = 4781416) 
LIMIT 10

How to find the 10 nearest names to Reedy Creek

Note the use of the funny arrow-like 
operator in the ORDER BY clause and the LIMIT. 
You have to use ORDER BY and you have to LIMIT.


Time to return 10 ntroes out of 2m - 9 ms

Because KNN searches the index, and the index is 
bounding box based, the operators work on box 
distances. There are two ways to measure 
distance between two boxes: the distance 
between the box centers (the arrow operator), and 
the distance between the nearest box edges (the 
box operator).

* Calculate ordering distance between 
box centers

* Calculate ordering distance between 
box edges


ORDER BY geom <-> [geometry literal]
* LIMIT [#]
* If you have a geometry index defined this 
will work!

As long as you have a geometry index deﬁned, 
and PostgreSQL >= 9.0 this will work!



