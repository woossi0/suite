.. _dataadmin.pgGettingStarted.pgshapeloader:


Loading data into PostGIS with pgShapeloader
============================================

The ``pgShapeloader`` tool (also known as "PostGIS Shapefile Import/Export Manager" or "PostGIS Shapefile and DBF loader") provides another option for loading shapefiles into PostGIS database tables. It is the graphical user interface (GUI) equivalent of the command line :ref:`shp2pgsql <dataadmin.pgGettingStarted.shp2pgsql>` tool.

.. note::  On Linux systems, pgShapeloader is known as ``shp2pgsql-gui``.


How it works
------------

Like all graphical tools, ``pgShapeloader`` is designed for ease of use, while at the same time retaining most of the functionality of the more flexible command line tool. The ``pgShapeloader`` tool combines the two data loading stages, converting data into SQL commands and running those commands against the target database, into one operation.


Preparation
-----------

#. Select a shapefile to load—you will need all the files: ``.shp``, ``.shx``, and ``.dbf`` and so on.

#. Identify the SRID ("projection") of your data. If available, this information is easily accessed via the layer metadata in GeoServer. If the projection is unknown, use a service like `prj2epsg.org <http://prj2epsg.org>`_ to upload and convert the shapefile's ``.prj`` file to a SRID code.

#. Either identify the target database where you would like to load the data, or create a new database. The OpenGeo Suite comes with a default database that you may use. This database is usually named after the user who installed the OpenGeo Suite.


Loading data
------------

#. Make sure the OpenGeo Suite is running.

#. Open the PostGIS Shapefile Import/Export Manager tool using one of the following options: 

   #. Click :guilabel:`Import shapefiles` on the :ref:`dashboard` (not available on the web-based Dashboard).
   #. In pgAdmin click :menuselection:`Plugins --> PostGIS Shapefile and DBF loader` (if the plugin is installed).
   #. Run the command line :file:`shp2pgsql-gui` tool.

   .. figure:: img/pgshapeloader.png

      *pgShapeloader*

#. Click :guilabel:`View connection details` and enter the connection information in the :guilabel:`PostGIS Connection` section. This information will depend on how the OpenGeo Suite was installed, and whether ``pgShapeloader`` is running locally or remotely. For a default local installation, the following credentials may be used:

   .. list-table::
      :header-rows: 1

      * - Field
        - Windows/Mac
        - Linux
      * - **Username**
        - postgres
        - opengeo
      * - **Password**
        - [blank/any]
        - opengeo
      * - **Server Host**
        - localhost
        - localhost
      * - **Port**
        - **54321**
        - **5432**
      * - **Database**
        - [user name]
        - [user name]

   .. figure:: img/pgshp_connection.png

      *PostGIS connection options*

#. Click :guilabel:`OK` to return to the main application. The shapefile loader uses the supplied connection details to connect to the target database; the connection status is reported in the :guilabel:`Log Window`. If you see any errors, check your details and try again.

   .. figure:: img/pgshp_connectionsuccess.png

      *A successful PostGIS connection*

#. To select your source files, click :guilabel:`Add File` to open the :guilabel:`Select a Shape File` dialog box. Navigate to the location of your shapefile, select it and click :guilabel:`Open`. Multiple files can also be added in the same way.

   .. figure:: img/pgshp_select.png

      *Selecting a shapefile to import*

#. Edit the configuration information for each item in the :guilabel:`Import List` to provide ** the correct SRID** for each shapefile. 

   .. warning:: Do not omit this step, otherwise your data will not load properly.

   .. figure:: img/pgshp_srid.png

      *Changing the SRID*

#. Other import options are available to configure. Click :guilabel:`Options` to open the :guilabel:`Import Options` dialog box. 

   .. list-table::
      :header-rows: 1

      * - Option
        - Description
      * - DBF file character encoding
        - Specifies the character encoding of the shapefile's attribute columns. Default is **UTF-8**.
      * - Preserve case of column names
        - If this option is not selected, all column names will be lower case. Select this option to preserve mixed case.
      * - Do not create 'bigint' columns
        - Columns with type 'bigint' will not be created.
      * - Create spatial index automatically after load
        - Creates a spatial index automatically. Indexing is recommended for improved performance reasons, but if you wish to create the index manually or if you're sure you don't want one, clear the check box.
      * - Load only attribute (dbf) data
        - Strips the geometry column from the loading process, leaving just the attribute columns. Default is unselected.
      * - Load data using COPY rather than INSERT
        - This can sometimes make the load process a little faster.
      * - Load into GEOGRAPHY column
        - Will load the geospatial data as type GEOGRAPHY instead of the default of GEOMETRY.  Requires lat/lon data (often known as SRID 4326).
 
   .. figure:: img/pgshp_options.png

      *Additional options*

   .. note:: If you are not sure about the implications of making further changes, leave the default values as they are and click :guilabel:`OK` to return to the main dialog box.

#. Once all import options have been configured, click :guilabel:`OK` and click :guilabel:`Import` to start the conversion.

   .. figure:: img/pgshp_importing.png

      *Import in progress*

#. On successful completion, the shapefile has been imported as a table in your PostGIS database.

   .. figure:: img/pgshp_success.png

      *A successful import*

#.  You can verify this in ``pgAdmin`` by viewing the list of tables in the :guilabel:`Object browser`—your new table should be listed.

   .. figure:: img/pgshp_pgadminconfirm.png

      *Confirming import in pgAdmin*

#. You can also verify a successful import operation at the command line by typing:

   .. code-block:: console

      psql -p <PORT> -U <USERNAME> -d <DATABASE> -c "\d" -h localhost

   .. note::

    The specific command parameters will depend on your local configuration.
  
  .. code-block:: console

      Schema |         Name         |   Type   |  Owner
     --------+----------------------+----------+----------
      public | bc_2m_border         | table    | postgres
      public | bc_2m_border_gid_seq | sequence | postgres
      public | geography_columns    | view     | postgres
      public | geometry_columns     | view     | postgres
      public | raster_columns       | view     | postgres
      public | raster_overviews     | view     | postgres
      public | spatial_ref_sys      | table    | postgres

.. todo:: add section on export
