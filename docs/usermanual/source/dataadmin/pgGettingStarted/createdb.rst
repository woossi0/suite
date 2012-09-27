.. _dataadmin.pgGettingStarted.createdb:

.. warning:: Document status: **Requires copyedit review**

Creating a Spatial Database
===========================

PostgreSQL, the relational database underlying PostGIS, contains a **template database** for initializing new databases. Databases created from this template will always include a copy of everything in the template.

The OpenGeo Suite installation process automatically creates five databases:

* geoserver—Repository for data imported via GeoServer
* <username>—Default database for the user who installed the OpenGeo Suite
* medford—Sample data
* postgres—Default database for *postgres* user
* template_postgis—Spatially enabled database


.. note:: A spatially enabled database has been optimized to store and manipulate spatial data. Any new databases created from the ``template_postgis`` database are automatically spatially enabled.

.. note:: The GeoServer database is connected to the default PostGIS data store. Whenever data is imported in GeoServer, with the opengeo workspace selected as the target workspace, a table for the new layer's data will be created in the GeoServer database.

#. Expand the :guilabel:`Databases` item in the :guilabel:`Object browser` to reveal the available databases. 

#. Right-click :guilabel:`Databases` and select :guilabel:`New Database`.

   .. figure:: img/createdb_newdb.png

      *Creating a new database in pgAdmin*

   .. note:: If you receive an error indicating that the source database (``template_postgis``) is being accessed by other users, you probably have it selected. Right-click the :guilabel:`PostGIS (localhost: 54321)` item and select :guilabel:`Disconnect`. Double-click the same item to reconnect and try again.

#. Complete the :guilabel:`New database` form with the following information—**Name** = '<DatabaseName>', **Encoding** = 'UTF8', **Owner** = postgres, **Template** = template_postgis.
   
   .. figure:: img/createdb_newdbtemplate.png

      *Creating a new database in pgAdmin from template_postgis*

#. Double-click the new database item in the :guilabel:`Object browser` to display the contents. Inside the :guilabel:`public` schema, you will see one PostGIS-specific metadata table: :guilabel:`spatial_ref_sys` (for further information, see the section on :ref:`dataadmin.pgBasics.metatables`).

   .. figure:: img/createdb_metatables.png
   
      *Spatial metadata tables*

   .. warning:: If you don't see this table, your database was not created correctly.

   .. todo:: what should they do in this case? ref to troubleshooting
 
#. Either click :guilabel:`Execute arbitrary SQL queries` on the pgAdmin toolbar or click :menuselection:`Tools --> Query tool` to open the :guilabel:`Query` dialog box.


#. Enter the following query into the :guilabel:`SQL editor` input box.  

.. code-block:: sql

      SELECT postgis_full_version();

Click the :guilabel:`Execute query` button (or press **F5**) to run the query. `postgis_full_version() <../../../postgis/postgis/html/PostGIS_Full_Version.html>`_ is a management function that returns version and build configuration information.  If this command executes successfully, the database is spatially enabled and you will see output similar to the following:

::

   +-------------+--------+
   |postgis_full_version  |
   +======================+
   |POSTGIS="2.0.1 r9979" |   
   +-------------+--------+


Creating a spatial database from the command line
-------------------------------------------------

You can also create a PostGIS database from the command line using the ``createdb`` command.

.. code-block::  console

  createdb -p <PORT> -T template_postgis <DATABASENAME>


