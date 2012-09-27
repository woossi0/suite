.. _glossary:

Glossary
========

.. glossary::
   :sorted:

   API
     Application Programming Interface. A set of routines, procedures, protocols, and tools for building software applications.

   CRS
     Coordinate reference system. The combination of a geographic coordinate system and a projected coordinate system.

   GDAL
     `Geospatial Data Abstraction Library <http://gdal.org>`_, pronounced "GOO-duhl", an open source raster access library with support for a large number of formats, used widely in both open source and proprietary software.

   Geographic Markup Language
     `Geography Markup Language <http://www.opengeospatial.org/standards/gml>`_ (GML) is the :term:`Open Geospatial Consortium` standard XML format for representing spatial feature information.

   GeoJSON
     Javascript Object Notation. A text format that is very fast to parse in Javascript virtual machines. In spatial, the extended specification for `GeoJSON <http://geojson.org>`_ is commonly used.
    
   GIS
     `Geographic information system <http://en.wikipedia.org/wiki/Geographic_information_system>`_ or geographical information system captures, stores, analyzes, manages, and presents data that is linked to location.
    
   GML
     See :term:`Geographic Markup Language`.

   JSON
     Javascript Object Notation. A text format that is very fast to parse in Javascript virtual machines. In spatial, the extended specification for `GeoJSON <http://geojson.org>`_ is commonly used.

   JSP
     JavaServer Pages. A scripting system for Java server applications that allows the interleaving of markup and Java procedural code.

   JSTL
     JavaServer Page Template Library. A tag library for :term:`JSP` that encapsulates many of the standard functions handled in JSP (database queries, iteration, conditionals) into a terse syntax.

   KML
     Keyhole Markup Language. This is the spatial :term:`XML` format used by Google Earth. Google Earth was originally written by a company named "Keyhole", hence the (now obscure) reference in the name.

   OGC
     See :term:`Open Geospatial Consortium`.

   Open Geospatial Consortium
     The Open Geospatial Consortium (OGC) <http://opengeospatial.org/> is a standards organization that develops specifications for geospatial services.

   OSGeo
     The Open Source Geospatial Foundation (OSGeo) <http://osgeo.org> is a non-profit foundation dedicated to the promotion and support of open source geospatial software.

   Scalable Vector Graphics
     This is a family of specifications of an XML-based file format for describing two-dimensional vector graphics, both static and dynamic (i.e. interactive or animated). See http://en.wikipedia.org/wiki/Scalable_Vector_Graphics.

   SFSQL
     The `Simple Features for SQL <http://www.opengeospatial.org/standards/sfs>`_ (SFSQL) specification from the :term:`Open Geospatial Consortium` defines the types and functions that make up a standard spatial database.

   SLD
     The `Styled Layer Descriptor <http://www.opengeospatial.org/standards/sld>`_ (SLD) specification from the :term:`Open Geospatial Consortium` defines an format for describing cartographic rendering of vector features.

   SQL
     Structured query language. This is the standard programming language for querying relational databases. See http://en.wikipedia.org/wiki/SQL.

   SQL/MM
     `SQL Multimedia <http://www.fer.hr/_download/repository/SQLMM_Spatial-_The_Standard_to_Manage_Spatial_Data_in_Relational_Database_Systems.pdf>`_; includes several sections on extended types, including a substantial section on spatial types.

   SRID
     Spatial reference ID. This a unique number assigned to a particular "coordinate reference system". The PostGIS table **spatial_ref_sys** contains a large collection of well-known srid values and text representations of the coordinate reference systems.

   SVG
     See :term:`Scalable Vector Graphics`.

   REST
     REpresentational State Transfer. An open, resource-oriented model for implementing Web services.

   WCS
     See :term:`Web Coverage Service`.

   Web Coverage Service
     The `Web Coverage Service <http://www.opengeospatial.org/standards/wcs>`_ (WCS) specification from the :term:`Open Geospatial Consortium` defines an interface for reading and writing geospatial data as "coverages" across the web.

   Web Feature Service
     The `Web Feature Service <http://www.opengeospatial.org/standards/wfs>`_ (WFS) specification from the :term:`Open Geospatial Consortium` defines an interface for reading and writing geographic features across the web.

   Web Map Service
     The `Web Map Service <http://www.opengeospatial.org/standards/wms>`_ (WMS) specification from the :term:`Open Geospatial Consortium` defines an interface for requesting rendered map images across the web.

   Web Processing Service
     The `Web Processing Service <http://www.opengeospatial.org/standards/wps>`_ (WPS) specification from the :term:`Open Geospatial Consortium` provides rules for standardizing inputs and outputs (requests and responses) for geospatial processing services.

   Well-Known Binary
     This refers to the binary representation of geometries described in the Simple Features for SQL specification (:term:`SFSQL`).

   Well-Known Text
     This refers either to the text representation of geometries, with strings starting "POINT", "LINESTRING", "POLYGON", and so on, or the text representation of a :term:`CRS`, with strings starting "PROJCS", "GEOGCS", and so on. Well-known text representations are :term:`OGC` standards, but do not have their own specification documents. The first descriptions of WKT (for geometries and for CRS) appeared in the :term:`SFSQL` 1.0 specification.

   WFS
     See :term:`Web Feature Service`.

   WKB
     See :term:`Well-Known Binary`.

   WKT
     See :term:`Well-Known Text`.

   WMS
     See :term:`Web Map Service`.

   WPS
     See :term:`Web Processing Service`.

   XML
     eXtensible Markup Language. A document encoding markup language, designed for data transport and storage.
  