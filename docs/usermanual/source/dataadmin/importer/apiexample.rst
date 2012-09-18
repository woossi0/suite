.. _dataadmin.importer.apiexample:

.. warning:: Document status: **Draft**

Importing data using the Layer Importer REST API
==================================================

The following examples use the `cURL <http://curl.haxx.se>`_ tool to illustrate the REST API layer import procedures. 

.. note:: REST uses HTTP primitives such as GET, DELETE, PUT, POST, and so on, to implement web services.


Uploading a single shapefile
----------------------------

The following example will upload a zipped shapefile ``roads.zip`` and create a new data store named ``roads`` in the ``opengeo`` workspace.

.. code-block:: console

   curl -u admin:geoserver -XPUT -H 'Content-type: application/zip' \
   --data-binary @roads.zip \
   http://localhost:8080/geoserver/rest/workspaces/opengeo/datastores/roads/file.shp

To confirm the successful upload of the shapefile, execute the following:

.. code-block:: console

   curl -u admin:geoserver -XGET http://localhost:8080/geoserver/rest/workspaces/opengeo/datastores/roads.xml

This will return the following as :term:`XML`:

.. code-block:: xml

  <dataStore>
   <name>roads</name>
   <workspace>
    <name>opengeo</name>
    <atom:link xmlns:atom="http://www.w3.org/2005/Atom" rel="alternate" href="http://localhost:8080/geoserver/rest/workspaces/opengeo.xml" type="application/xml"/>
   </workspace>
   <connectionParameters>
    <namespace>http://opengeo</namespace>
    <url>file:/Users/jsmith/devel/geoserver/1.7.x/data/minimal/data/roads/roads.shp</url>
   </connectionParameters>
   <featureTypes>
    <atom:link xmlns:atom="http://www.w3.org/2005/Atom" rel="alternate" href="http://localhost:8080/geoserver/rest/workspaces/opengeo/datastores/roads/featuretypes.xml" type="application/xml"/>
   </featureTypes>
  </dataStore>

By default when a shapefile is uploaded a feature type is automatically created. See GeoServer Layers documentation for details on how to control this behavior. The following retrieves the created feature type as XML:

.. code-block:: console

   curl -u admin:geoserver -XGET http://localhost:8080/geoserver/rest/workspaces/opengeo/datastores/roads/featuretypes/roads.xml


This will return the following as XML:

.. code-block:: xml

   <featureType>
    <name>roads</name>
    <nativeName>roads</nativeName>
    <namespace>
     <name>opengeo</name>
     <atom:link xmlns:atom="http://www.w3.org/2005/Atom" rel="alternate" href="http://localhost:8080/geoserver/rest/namespaces/opengeo.xml" type="application/xml"/>
    </namespace>
   ...
   </featureType>


Uploading multiple shapefiles
-----------------------------

To upload multiple shapefiles in one directory and create a new data store, execute the following:

.. code-block:: console
   
   curl -u admin:geoserver -XPUT -H 'Content-type: text/plain' \
   -d 'file:///data/shapefiles/' \
   "http://localhost:8080/geoserver/rest/workspaces/opengeo/datastores/roads/external.shp?configure=all"

Note the inclusion of the ``configure=all`` parameter.


