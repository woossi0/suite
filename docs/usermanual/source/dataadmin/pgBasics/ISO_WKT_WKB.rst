.. _dataadmin.pgBasics.ISO_WKT_WKB:


ISO WKT and WKB
===============

Re-written for PostGIS 2.0 - now with support for ISO SQL/MM versions of WKT and WKB

   :term:`WKT`

ISO forms support 3d and 4d geometry - St_AsText() now emits those dimensions.

ST_GeomFromText and other consumers will accept any of the forms (OGC, WKT, EWKT or ISO WKT)

ISO SQL/MM also defined new type numbers and support for 3d and 4d geometry

ST_AsBinary emits iso WLB

