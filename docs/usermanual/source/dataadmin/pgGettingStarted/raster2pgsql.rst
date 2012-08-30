.. _dataadmin.thedatabase.data.raster2pgsql:


Loading raster data into PostGIS from the command line
======================================================

PostGIS comes with ``raster2pgsql`` tool for converting raster data sources into database tables. This section describes how to use this tool to load a single file or multiple files.


How It Works
------------

..todo:: http://postgis.refractions.net/documentation/manual-2.0/using_raster.xml.html#RT_Raster_Loader


..todo:: add example

An example session using the loader to create an input file and uploading it chunked in 100x100 tiles might look like this:

	
You can leave the schema name out e.g demelevation instead of public.demelevation and the raster table will be created in the default schema of the database or user

raster2pgsql -s 4236 -I -C -M *.tif -F -t 100x100 public.demelevation > elev.sql
psql -d gisdb -f elev.sql
A conversion and upload can be done all in one step using UNIX pipes:

raster2pgsql -s 4236 -I -C -M *.tif -F -t 100x100 public.demelevation | psql -d gisdb
Load rasters Massachusetts state plane meters aerial tiles into a schema called aerial and create a full view, 2 and 4 level overview tables, use copy mode for inserting (no intermediary file just straight to db), and -e don't force everything in a transaction (good if you want to see data in tables right away without waiting). Break up the rasters into 128x128 pixel tiles and apply raster constraints. Use copy mode instead of table insert. (-F) Include a field called filename to hold the name of the file the tiles were cut from.

raster2pgsql -I -C -e -Y -F -s 26986 -t 128x128  -l 2,4 bostonaerials2008/*.jpg aerials.boston | psql -U postgres -d gisdb -h localhost -p 5432
--get a list of raster types supported:
raster2pgsql -G


